# Rebuild Task
# @author Vjatseslav Gedrovits
# @license MIT
namespace :db do
  desc 'Drop, create, migrate, seed the database with prompt.'
  task rebuild: [:environment, :production_protection, :internal_metadata_check] do
    puts 'Database rebuild process started...'
    
    $stdout.puts 'Drop old database? (y/n)'
    if $stdin.gets.strip == 'y'
      puts 'Dropping old database...'
      Rake::Task['db:drop'].invoke
    end
    
    $stdout.puts 'Create new database? (y/n)'
    if $stdin.gets.strip == 'y'
      puts 'Creating database...'
      Rake::Task['db:create'].invoke
    end
    
    $stdout.puts 'Migrate new database? (y/n)'
    if $stdin.gets.strip == 'y'
      puts 'Migrating new database...'
      Rake::Task['db:migrate'].invoke
    end
    
    $stdout.puts 'Seed new database? (y/n)'
    if $stdin.gets.strip == 'y'
      puts 'Seeding new database...'
      Rake::Task['db:seed'].invoke
    end
    
    puts 'Task completed successfully!'
  end
  
  desc 'Drop, create, migrate, seed the database without prompt.'
  task rebuild_silent: [:environment, :production_protection, :internal_metadata_check] do
    puts 'Database rebuild process started...'
    %w(drop create migrate seed).each do |task|
      puts "Performing database #{task}..."
      Rake::Task["db:#{task}"].invoke
    end
    puts 'Task completed successfully!'
  end

  desc 'Recreate "public" schema, migrate, seed the database with prompt.'
  task rebuild_schema: [:environment, :production_protection, :internal_metadata_check] do
    puts 'Database schema rebuild process started...'

    $stdout.puts 'Recreate database schema "public"? (y/n)'
    if $stdin.gets.strip == 'y'
      puts 'Dropping "public" schema...'
      ApplicationRecord.connection.execute 'DROP SCHEMA public CASCADE;'

      puts 'Creating "public" schema...'
      ApplicationRecord.connection.execute 'CREATE SCHEMA public;'
    end

    $stdout.puts 'Migrate new database? (y/n)'
    if $stdin.gets.strip == 'y'
      puts 'Migrating new database...'
      Rake::Task['db:migrate'].invoke
    end

    $stdout.puts 'Seed new database? (y/n)'
    if $stdin.gets.strip == 'y'
      puts 'Seeding new database...'
      Rake::Task['db:seed'].invoke
    end

    puts 'Task completed successfully!'
  end

  desc 'Recreate "public" schema, migrate, seed the database without prompt.'
  task rebuild_schema_silent: [:environment, :production_protection, :internal_metadata_check] do
    puts 'Database schema rebuild process started...'

    puts 'Dropping "public" schema...'
    ApplicationRecord.connection.execute 'DROP SCHEMA public CASCADE;'
    puts 'Creating "public" schema...'
    ApplicationRecord.connection.execute 'CREATE SCHEMA public;'

    %w(migrate seed).each do |task|
      puts "Performing database #{task}..."
      Rake::Task["db:#{task}"].invoke
    end
    puts 'Task completed successfully!'
  end

  desc 'Show confirmation for production environment'
  task :production_protection do
    next unless Rails.env.production?
    $stdout.puts 'NB! You are trying to rebuild production database! Are you completely sure? (y/n)'
    abort unless $stdin.gets.strip == 'y'
  end
  
  desc 'Sets internal metadata if missing'
  task :internal_metadata_check do
    next unless ::Rails::VERSION::MAJOR == 5
    if !ActiveRecord::InternalMetadata.table_exists? || !ActiveRecord::InternalMetadata[:environment]
      puts 'Environment data not found in the schema. Resolving...'
      Rake::Task['db:environment:set'].invoke
    end
  end
end
