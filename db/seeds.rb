# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
data_path = "#{Rails.root}/db/data"

# Create sample games
data = YAML.load(File.read("#{data_path}/games.yml"))
data.each do |n|
  Game.find_or_create_by(name: n[0], abbreviation: n[1], active: true)
end
data = nil

# Create sample roles
data = YAML.load(File.read("#{data_path}/roles.yml"))
data.values.each do |n|
  Role.find_or_create_by(name: n['name'], abbreviation: n['abbr'], active: true)
end
data = nil

leader_role = Role.leader
vice_leader_role = Role.vice_leader
member_role = Role.member

# Create GB sample data

gb_u = User.find_or_initialize_by(email: 'team@gamingbase.co', is_core: true)
gb_u.password = 'qwerty'
gb_u.confirmed_at = DateTime.now
gb_u.save(validate: false)

gb_g = gb_u.gamer || gb_u.build_gamer
gb_g.assign_attributes(username: 'Isamashii Tora', dedication: :hardcore, privacy: :anyone, sex: :male,
                        weekday_availability: :evening, weekend_availability: :always,
                        first_name: 'Vjatseslav', middle_name: 'Jurjevits', last_name: 'Gedrovits',
                        birth_date: Date.strptime('01/21/1987', '%m/%d/%Y'), age: 29)
# Add few language proficiencies
gb_g.language_proficiencies.find_or_initialize_by(language: 'en', understanding: :excellent, speaking: :good, writing: :average)
gb_g.language_proficiencies.find_or_initialize_by(language: 'ru', native: true, understanding: :excellent, speaking: :excellent, writing: :good)

gb_c = Community.find_or_create_by(name: 'Gaming Base', abbreviation: 'GB')
gb_t = Team.find_or_create_by(name: 'Gaming Base Team', abbreviation: 'GBT')

gb_g.memberships.find_or_initialize_by(type: :gamer_in_community,
                       community: gb_c, role: leader_role, status: :approved)
gb_g.memberships.find_or_initialize_by(type: :gamer_in_team,
                       team: gb_t, role: leader_role, status: :approved)
gb_t.memberships.find_or_initialize_by(type: :team_in_community,
                       community: gb_c, role: leader_role, status: :approved)
gb_g.save

# Create League of Legends sample data...

league_of_legends = Game.find_by_abbreviation('LoL')
data = YAML.load(File.read("#{data_path}/lol_communities.yml"))
data.take(3).each do |d|
  community = Community.find_or_create_by(name: d['community'][0], abbreviation: d['community'][1])
  community.description = "#{d['community'][0]} is the best community!"
  community.website = "http://www.#{d['community'][0].downcase}.#{d['community'][1].downcase}"
  community.games << league_of_legends unless community.games.include?(league_of_legends)
  community.save
  
  team = Team.find_or_create_by(name: d['community'][1])
  team.description = "#{d['community'][1]} is the best team!"
  team.games << league_of_legends unless team.games.include?(league_of_legends)
  team.memberships.build(type: :team_in_community,
                         community: community, role: leader_role, status: :approved, privacy: :team_or_community)
  team.save
  
  unless d['members'].blank?
    d['members'].each_with_index do |m, idx|
      user = User.find_or_initialize_by(email: "#{m[0].downcase}_#{community.abbreviation.downcase}@gamingbase.co")
      user.confirmed_at = Date.today
      user.password = 'qwerty'
      user.save(validate: false) # We don't want to send a lot of spam emails!!!
      
      gamer = user.gamer || user.build_gamer
      gamer.username    = m[0]
      gamer.description = "#{m[0]} is the best gamer!"
      gamer.sex = :male
      gamer.dedication  = :pro
      gamer.weekday_availability = :always
      gamer.weekend_availability = :always
      gamer.privacy = :team_or_community
      
      gamer.first_name  = m[1]
      gamer.last_name   = m[2]
      gamer.games << league_of_legends unless gamer.games.include?(league_of_legends)
      
      role = case idx
             when 0 then leader_role
             when 1 then vice_leader_role
             else
               member_role
             end
      
      gamer.memberships.find_or_initialize_by(type: :gamer_in_community,
                              community: community, role: role, status: :approved, privacy: :team_or_community)
      gamer.memberships.find_or_initialize_by(type: :gamer_in_team,
                              team: team, role: role, status: :approved, privacy: :team_or_community)
      gamer.save
    end
  end
end
data = nil
