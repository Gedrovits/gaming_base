class AlphaTables < ActiveRecord::Migration[5.0]
  def change
    #= Users
    create_table :users, id: :uuid, default: UUID_DB_RANDOM_METHOD do |t|
      t.boolean :active,  default: true
      t.boolean :is_core, default: false
      t.string  :locale, default: Rails.application.config.i18n.default_locale
      t.string  :time_zone, default: Rails.application.config.time_zone
      
      ## Database authenticatable
      t.string :email, index: { unique: true }, null: false
      t.string :encrypted_password, null: false
      
      ## Recoverable
      t.string   :reset_password_token, index: { unique: true }
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
      t.string   :confirmation_token, index: { unique: true }
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable
      
      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token, index: { unique: true } # Only if unlock strategy is :email or :both
      t.datetime :locked_at
      
      t.timestamps
      t.datetime :deleted_at
    end
    
    #= Identity
    create_table :identities, id: :uuid, default: UUID_DB_RANDOM_METHOD do |t|
      t.references :user, type: :uuid, foreign_key: true, index: true, null: false
      t.string :uid
      t.string :provider
      
      t.timestamps
      t.datetime :deleted_at
    end
    
    #= Friendly ID
    create_table :friendly_id_slugs do |t|
      t.string   :slug, index: true, null: false
      t.integer  :sluggable_id, index: true, null: false
      t.string   :sluggable_type, limit: 50
      t.string   :scope
      t.datetime :created_at
      
      t.index [:slug, :sluggable_type]
      t.index [:slug, :sluggable_type, :scope], unique: true
    end
    
    #= Games
    create_table :games, id: :uuid, default: UUID_DB_RANDOM_METHOD do |t|
      t.string  :name
      t.string  :slug
      t.string  :abbreviation
      t.boolean :active, default: false
      
      t.timestamps
      t.datetime :deleted_at
    end
    
    #= Roles
    create_table :roles, id: :uuid, default: UUID_DB_RANDOM_METHOD do |t|
      t.string  :name
      t.string  :slug
      t.string  :abbreviation
      t.boolean :active, default: false
      
      t.timestamps
      t.datetime :deleted_at
    end
    
    #= Gamers
    create_table :gamers, id: :uuid, default: UUID_DB_RANDOM_METHOD do |t|
      t.references :user, type: :uuid, foreign_key: true, index: true
      
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
      t.integer :sex, default: 0 # TODO: Should be fixed enum of :unknown, :female, :male
      t.integer :age # will be populated from birth_date
      
      t.boolean :active, default: true
      t.integer :privacy, index: true, default: Gamer.privacies[:anyone]
      t.boolean :verified, default: false
      
      t.timestamps
      t.datetime :deleted_at
    end
    
    create_table :gamers_games, id: false do |t|
      t.references :gamer, type: :uuid, foreign_key: true, index: true
      t.references :game, type: :uuid, foreign_key: true, index: true
      t.index [:gamer_id, :game_id], unique: true
    end
    
    #= Teams
    create_table :teams, id: :uuid, default: UUID_DB_RANDOM_METHOD do |t|
      t.string :name
      t.string :abbreviation
      t.string :description, limit: 1000
      t.string :slug
      t.boolean :active, default: true
      t.integer :privacy, index: true, default: Team.privacies[:anyone]
      t.integer :status, default: 0
      t.boolean :verified, default: false
      
      t.timestamps
      t.datetime :deleted_at
    end
    
    create_table :games_teams, id: false do |t|
      t.references :game, type: :uuid, foreign_key: true, index: true
      t.references :team, type: :uuid, foreign_key: true, index: true
      t.index [:game_id, :team_id], unique: true
    end
    
    #= Communities
    create_table :communities, id: :uuid, default: UUID_DB_RANDOM_METHOD do |t|
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
      t.datetime :deleted_at
    end

    create_table :communities_games, id: false do |t|
      t.references :community, type: :uuid, foreign_key: true, index: true
      t.references :game, type: :uuid, foreign_key: true, index: true
      t.index [:community_id, :game_id], unique: true
    end
    
    #= Memberships
    create_table :memberships, id: :uuid, default: UUID_DB_RANDOM_METHOD do |t|
      t.integer :type, index: true
      
      t.references :community, type: :uuid, foreign_key: true, index: true
      t.references :team, type: :uuid, foreign_key: true, index: true
      t.references :gamer, type: :uuid, foreign_key: true, index: true
      
      t.references :role, type: :uuid, foreign_key: true, index: true
      
      t.boolean :active, default: true
      t.integer :privacy, index: true, default: Membership.privacies[:anyone]
      t.integer :status, default: 0
      
      t.timestamps
      t.datetime :deleted_at
    end
    
    #= LanguageProficiencies
    create_table :language_proficiencies, id: :uuid, default: UUID_DB_RANDOM_METHOD do |t|
      t.references :gamer, type: :uuid, foreign_key: true # FIXME: Should it be user who knows languages, not gamer?
      t.string :language # iso_639_1
      
      t.boolean :native, default: false
      # PG smallint
      t.integer :understanding, default: 1, limit: 2
      t.integer :speaking, default: 1, limit: 2
      t.integer :writing, default: 1, limit: 2
      
      t.timestamps
      t.datetime :deleted_at

      t.index [:gamer_id, :language], unique: true
    end
    
    #= GamingSessions
    create_table :gaming_sessions, id: :uuid, default: UUID_DB_RANDOM_METHOD do |t|
      t.integer :type, default: 0
      t.integer :status, default: 0
      t.integer :privacy, index: true, default: 0
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :description, limit: 1000
      
      t.timestamps
    end
    
    create_table :games_gaming_sessions, id: false do |t|
      t.references :game, type: :uuid, foreign_key: true, null: false
      t.references :gaming_session, type: :uuid, foreign_key: true, null: false
      t.index [:game_id, :gaming_session_id], unique: true
    end

    create_table :gamers_gaming_sessions, id: false do |t|
      t.references :gamer, type: :uuid, foreign_key: true, null: false
      t.references :gaming_session, type: :uuid, foreign_key: true, null: false
      t.index [:gamer_id, :gaming_session_id], unique: true
      
      t.integer :status, default: 0
    end
  end
end
