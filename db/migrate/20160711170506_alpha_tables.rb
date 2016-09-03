class AlphaTables < ActiveRecord::Migration[5.0]
  def change
    #= Users
    create_table :users do |t|
      t.column :uuid, :uuid, default: UUID_DB_RANDOM_METHOD
      
      t.boolean :active,  default: true
      t.boolean :is_core, default: false
      t.string  :locale, default: Rails.application.config.i18n.default_locale
      t.string  :time_zone, default: Rails.application.config.time_zone
      
      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: true,  default: ''
      
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      
      ## Rememberable
      t.datetime :remember_created_at
      
      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      
      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable
      
      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at
      
      t.timestamps
    end
    
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
    
    #= Identity
    create_table :identities do |t|
      t.column :uuid, :uuid, default: UUID_DB_RANDOM_METHOD
      
      t.references :user, foreign_key: true, index: true
      t.string     :uid
      t.string     :provider
      
      t.timestamps
    end
    
    #= Friendly ID
    create_table :friendly_id_slugs do |t|
      t.string   :slug,           null: false
      t.integer  :sluggable_id,   null: false
      t.string   :sluggable_type, limit: 50
      t.string   :scope
      t.datetime :created_at
    end
    
    add_index :friendly_id_slugs, :sluggable_id
    add_index :friendly_id_slugs, [:slug, :sluggable_type]
    add_index :friendly_id_slugs, [:slug, :sluggable_type, :scope], unique: true
    add_index :friendly_id_slugs, :sluggable_type
    
    #= Games
    create_table :games do |t|
      t.column :uuid, :uuid, default: UUID_DB_RANDOM_METHOD
      
      t.string  :name
      t.string  :slug
      t.string  :abbreviation
      t.boolean :active, default: false
      
      t.timestamps
    end
    
    #= Roles
    create_table :roles do |t|
      t.column :uuid, :uuid, default: UUID_DB_RANDOM_METHOD
      
      t.string  :name
      t.string  :slug
      t.string  :abbreviation
      t.boolean :active, default: false
      
      t.timestamps
    end
    
    #= Gamers
    create_table :gamers do |t|
      t.column :uuid, :uuid, default: UUID_DB_RANDOM_METHOD
      
      t.references :user, foreign_key: true, index: true
      t.string :username
      t.string :description, limit: 1000
      t.string :slug
      t.integer :dedication, default: 0
      
      t.integer :weekday_availability, default: 0
      t.integer :weekend_availability, default: 0
      
      t.integer :swearing, default: 0
      t.integer :swearing_tolerance, default: 0
      
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.date   :birth_date
      t.integer :sex, default: 0
      t.integer :age # will be populated from birth_date
      
      t.boolean :active, default: true
      t.integer :privacy, index: true, default: Gamer.privacies[:anyone]
      t.boolean :verified, default: false
      
      t.timestamps
    end
    
    create_join_table :gamers, :games do |t|
      t.foreign_key :gamers
      t.foreign_key :games
      t.index [:gamer_id, :game_id], unique: true
    end
    
    #= Teams
    create_table :teams do |t|
      t.column :uuid, :uuid, default: UUID_DB_RANDOM_METHOD
      
      t.string :name
      t.string :abbreviation
      t.string :description, limit: 1000
      t.string :slug
      t.boolean :active, default: true
      t.integer :privacy, index: true, default: Team.privacies[:anyone]
      t.integer :status, default: 0
      t.boolean :verified, default: false
      
      t.timestamps null: false
    end
    
    create_join_table :teams, :games do |t|
      t.foreign_key :teams
      t.foreign_key :games
      t.index [:team_id, :game_id], unique: true
    end
    
    #= Communities
    create_table :communities do |t|
      t.column :uuid, :uuid, default: UUID_DB_RANDOM_METHOD
      
      t.string  :name
      t.string  :abbreviation
      t.string  :description, limit: 1000
      t.string  :website, limit: 500
      t.string  :slug
      t.boolean :active, default: true
      t.integer :privacy, index: true, default: Community.privacies[:anyone]
      t.integer :status, default: 0
      t.boolean :verified, default: false
      
      t.timestamps
    end
    
    create_join_table :communities, :games do |t|
      t.foreign_key :communities
      t.foreign_key :games
      t.index [:community_id, :game_id], unique: true
    end
    
    #= Memberships
    create_table :memberships do |t|
      t.column :uuid, :uuid, default: UUID_DB_RANDOM_METHOD
      t.integer :type, index: true
      
      t.belongs_to :community, foreign_key: true, index: true
      t.belongs_to :team, foreign_key: true, index: true
      t.belongs_to :gamer, foreign_key: true, index: true
      
      t.belongs_to :role, foreign_key: true, index: true
      
      t.boolean :active, default: true
      t.integer :privacy, index: true, default: Membership.privacies[:anyone]
      t.integer :status, default: 0
      
      t.timestamps
    end
    
    #= LanguageProficiencies
    create_table :language_proficiencies do |t|
      t.references :gamer, foreign_key: true # FIXME: Should it be user who knows languages, not gamer?
      t.string :language # iso_639_1
      
      t.boolean :native, default: false
      # PG smallint
      t.integer :understanding, default: 1, limit: 2
      t.integer :speaking, default: 1, limit: 2
      t.integer :writing, default: 1, limit: 2
      
      t.timestamps

      t.index [:gamer_id, :language], unique: true
    end
    
    #= GamingSessions
    create_table :gaming_sessions, id: :uuid, default: UUID_DB_RANDOM_METHOD do |t|
      t.integer :type, default: 0
      t.integer :status, default: 0
      t.integer :privacy, index: true, default: 0
      t.tstzrange :duration
      t.string :description, limit: 1000
      
      t.timestamps
    end
    
    create_join_table :gaming_sessions, :games do |t|
      t.references :gaming_session, type: :uuid, foreign_key: true, null: false
      t.references :game, foreign_key: true, null: false
      t.index [:gaming_session_id, :game_id], unique: true
    end
    
    create_join_table :gaming_sessions, :gamers do |t|
      t.references :gaming_session, type: :uuid, foreign_key: true, null: false
      t.references :gamer, foreign_key: true, null: false
      t.index [:gaming_session_id, :gamer_id], unique: true

      t.integer :status, default: 0
    end
  end
end
