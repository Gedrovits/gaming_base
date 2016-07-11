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
Game.create(data.map{ |n| { name: n[0], abbreviation: n[1], active: true } })
data = nil

# Create sample roles
data = YAML.load(File.read("#{data_path}/roles.yml"))
Role.create(data.map{ |n| { name: n[0], abbreviation: n[1], active: true } })
data = nil

founder_role = Role.find_by_abbreviation('FNDR')
member_role = Role.find_by_abbreviation('MMBR')

# Create GB sample data

gb_u = User.create(email: 'team@gamingbase.co', password: 'qwerty', confirmed_at: DateTime.now, is_core: true)
gb_g = gb_u.build_gamer(username: 'Isamashii Tora', dedication: :hardcore, privacy: :anyone, sex: :male,
                        weekday_availability: :evening, weekend_availability: :always,
                        first_name: 'Vjatseslav', middle_name: 'Jurjevits', last_name: 'Gedrovits',
                        birth_date: Date.strptime('01/21/1987', '%m/%d/%Y'), age: 29)
gb_c = Community.create(name: 'Gaming Base', abbreviation: 'GB')
gb_t = Team.create(name: 'Gaming Base Team', abbreviation: 'GBT')

gb_g.memberships.build(type: :gamer_in_community,
                       community: gb_c, role: founder_role, status: :approved)
gb_g.memberships.build(type: :gamer_in_team,
                       team: gb_t, role: founder_role, status: :approved)
gb_t.memberships.build(type: :team_in_community,
                       community: gb_c, role: founder_role, status: :approved)
gb_g.save

# Create League of Legends sample data...

league_of_legends = Game.find_by_abbreviation('LoL')
data = YAML.load(File.read("#{data_path}/lol_communities.yml"))
data.each do |d|
  community = Community.new(name: d['community'][0], abbreviation: d['community'][1])
  community.description = "#{d['community'][0]} is the best community!"
  community.website = "http://www.#{d['community'][0].downcase}.#{d['community'][1].downcase}"
  community.games << league_of_legends
  community.save
  
  team = Team.new(name: d['community'][1])
  team.description = "#{d['community'][1]} is the best team!"
  team.games << league_of_legends
  team.memberships.build(type: :team_in_community,
                         community: community, role: founder_role, status: :approved, privacy: :team_or_community)
  team.save
  
  unless d['members'].blank?
    d['members'].each_with_index do |m, idx|
      user = User.new(email: "#{m[0].downcase}_#{community.abbreviation.downcase}@gamingbase.co",
                      confirmed_at: Date.today)
      user.password = 'qwerty'
      user.save(validate: false) # We don't want to send a lot of spam emails!!!
      
      gamer = user.build_gamer
      gamer.username    = m[0]
      gamer.description = "#{m[0]} is the best gamer!"
      gamer.sex = :male
      gamer.dedication  = :pro
      gamer.weekday_availability = :always
      gamer.weekend_availability = :always
      gamer.privacy = :team_or_community
      
      gamer.first_name  = m[1]
      gamer.last_name   = m[2]
      gamer.games << league_of_legends
      
      role = idx == 0 ? founder_role : member_role
      gamer.memberships.build(type: :gamer_in_community,
                              community: community, role: role, status: :approved, privacy: :team_or_community)
      gamer.memberships.build(type: :gamer_in_team,
                              team: team, role: role, status: :approved, privacy: :team_or_community)
      gamer.save
    end
  end
end
data = nil
