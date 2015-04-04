# config valid only for current version of Capistrano
lock '3.3.5'


require 'capistrano-db-tasks'
set :db_local_clean, true
set :db_remote_clean, true

# set :log_level, :debug

set :skip_data_sync_confirm, false

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

set :repo_url, 'git@github.com:Kristonitas/fidi.git'
set :application, 'fidi'

set :deploy_to, '/var/www/fidi'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

# namespace :deploy do
#   after 'deploy:setup_config', 'nginx:reload'
# end