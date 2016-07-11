# TODO: Work on this and move what is required to the Puma config

if ENV['PLATFORM'] == 'heroku'
  worker_processes Integer(ENV['WEB_CONCURRENCY'] || 3)
  timeout 15
  preload_app true
  
  before_fork do |server, worker|
    Signal.trap 'TERM' do
      puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
      Process.kill 'QUIT', Process.pid
    end
    
    defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  end
  
  after_fork do |server, worker|
    Signal.trap 'TERM' do
      puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
    end
    
    defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
  end
else
  app_path = "/home/deployer/gamingbase"
  working_directory "#{app_path}/current"
  pid               "#{app_path}/shared/tmp/pids/unicorn.pid"
  
  listen "#{app_path}/shared/tmp/unicorn.gamingbase.socket", backlog: 64
  timeout 30
  
  stderr_path "#{app_path}/shared/log/unicorn.stderr.log"
  stdout_path "#{app_path}/shared/log/unicorn.stdout.log"
  
  worker_processes 30
  
  before_exec do |server|
    ENV['BUNDLE_GEMFILE'] = "#{app_path}/current/Gemfile"
  end
  
  preload_app true
  
  before_fork do |server, worker|
    ActiveRecord::Base.connection.disconnect! if defined?(ActiveRecord::Base)
    $redis.client.disconnect if defined?($redis)
    
    old_pid = "#{server.config[:pid]}.oldbin"
    if File.exists?(old_pid) && server.pid != old_pid
      begin
        Process.kill("QUIT", File.read(old_pid).to_i)
      rescue Errno::ENOENT, Errno::ESRCH
      end
    end
  end
  
  after_fork do |server, worker|
    if defined?(ActiveRecord::Base)
      ActiveRecord::Base.establish_connection
    end
  end
end
