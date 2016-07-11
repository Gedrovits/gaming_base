class EnablePostgresExtensions < ActiveRecord::Migration[5.0]
  def up
    enable_extension 'hstore' unless extension_enabled?('hstore')
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  end
  
  def down
    disable_extension 'hstore'
    disable_extension 'pgcrypto'
  end
end
