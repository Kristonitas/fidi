# config valid only for current version of Capistrano
lock '3.3.5'

# server 'fidi', port: 3000, roles: [:web, :app, :db], primary: true

set :repo_url, 'git@github.com:Kristonitas/fidi.git'
set :application, 'fidi'
set :user, "deployer"

# set :puma_threads,    [4, 16]
# set :puma_workers,    0

set :pty, true
set :stage, :production
set :deploy_to, '/var/www/fidi'

# Default value for :scm is :git
set :scm, :git

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# set :puma_bind, "unix:///tmp/sockets/#{fetch(:application)}-puma.sock"

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false


# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5



# namespace :puma do
#   desc 'Create Directories for Puma Pids and Socket'
#   task :make_dirs do
#     on roles(:app) do
#       execute "mkdir #{shared_path}/tmp/sockets -p"
#       execute "mkdir #{shared_path}/tmp/pids -p"
#     end
#   end

#   before :start, :make_dirs
# end


namespace :deploy do

  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end

  # desc 'Initial Deploy'
  # task :initial do
  #   on roles(:app) do
  #     before 'deploy:restart', 'puma:start'
  #     invoke 'deploy'
  #   end
  # end

  # desc 'Restart application'
  # task :restart do
  #   on roles(:app), in: :sequence, wait: 5 do
  #     invoke 'puma:restart'
  #   end
  # end

  # # before :starting,     :check_revision
  # # after  :finishing,    :compile_assets
  # after  :finishing,    :cleanup
  # after  :finishing,    :restart

end
