class Membership < ApplicationRecord
  self.inheritance_column = :x
  
  include PrivacySupport
  
  enum status: [:pending, :approved, :declined, :banned, :left]
  enum type: [:unknown, :gamer_in_team, :gamer_in_community, :team_in_community]
  
  # Relations
  belongs_to :community, optional: true
  belongs_to :team, optional: true
  belongs_to :gamer, optional: true
  belongs_to :role
  
  # Scopes
  scope :for_communities, -> { where(type: [:gamer_in_community, :team_in_community]) }
  scope :for_community, ->(community) { where(community_id: community.id) }
  
  scope :for_teams, -> { where(type: [:gamer_in_team, :team_in_community]) }
  scope :for_team, ->(team) { where(team_id: team.id) }
  
  scope :for_gamers, -> { where(type: [:gamer_in_team, :gamer_in_community]) }
  scope :for_gamer, ->(gamer) { where(gamer_id: gamer.id) }
  
  # TODO: Improve this and extract to concern
  def self.privacy_filter(gamer_id = nil, team_ids = [], community_ids = [])
    where(arel_table[:privacy].eq(:anyone).
      or(arel_table[:privacy].eq(:me_only).
        and(arel_table[:gamer_id].eq(gamer_id))).
      or(arel_table[:privacy].in([:team_only, :team_or_community]).
        and(arel_table[:type].in([:gamer_in_team])).
        and(arel_table[:team_id].in(team_ids))).
      or(arel_table[:privacy].in([:community_only, :team_or_community]).
        and(arel_table[:type].in([:gamer_in_community, :team_in_community])).
        and(arel_table[:community_id].in(community_ids)))
    )
  end
end
