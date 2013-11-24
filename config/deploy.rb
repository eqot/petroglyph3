set :application, 'petroglyph'
set :repo_url, 'https://github.com/eqot/petroglyph3.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/usr/share/nginx/rails/petroglyph'
# set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :deploy do

  set :unicorn_pid, "/var/tmp/unicorn.pid"
  set :unicorn_config, "#{current_path}/config/unicorn.conf.rb"

  def start_unicorn
    within current_path do
      execute :bundle, :exec, :unicorn, "-c #{fetch(:unicorn_config)} -E #{fetch(:rails_env)} -D"
    end
  end

  def stop_unicorn
    execute :kill, "-QUIT `cat #{fetch(:unicorn_pid)}`"
  end

  def reload_unicorn
    execute :kill, "-USR2 `cat #{fetch(:unicorn_pid)}`"
    execute :kill, "-QUIT `cat #{fetch(:unicorn_pid)}.oldbin`"
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      if test("[ -f #{fetch(:unicorn_pid)} ]")
        reload_unicorn
      else
        start_unicorn
      end
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

  after :finished, :notify do
    system("which -s growlnotify && growlnotify -n 'Capistrano' -t 'Capistrano' -m 'Completed.'")
  end

end
