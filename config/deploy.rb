require 'yaml'
require 'bundler/capistrano'

set :use_sudo, false
set :user, "alien"

set :application, "babality"
set :repository,  "git@alien-invaders.ru:chishop.git"
set :backups, "/home/alien/babality/backups/"

set :bundle_flags, ""

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/home/alien/babality"
role :web, "babality.ru"                          # Your HTTP server, Apache/etc
role :app, "babality.ru"                          # This may be the same as your `Web` server
role :db,  "babality.ru", :primary => true # This is where Rails migrations will run

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

before("deploy:migrate", "backup")
after("deploy:update_code", "create_symlinks")

desc "Backup the remote production database"
task :backup, :roles => :db, :only => { :primary => true } do
  filename = "#{application}.dump.#{Time.now.to_i}.sql.bz2"
  file = "#{backups}#{filename}"
  on_rollback { delete file }
  db = YAML::load(ERB.new(IO.read(File.join(File.dirname(__FILE__), '../../babality_backups/database.yml'))).result)['production']
  run "mysqldump -u #{db['username']} --password=#{db['password']} #{db['database']} | bzip2 -c > #{file}"  do |ch, stream, data|
    puts data
  end
  get file, "../babality_backups/#{filename}"
end

task :create_symlinks do
  run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"
  run "ln -nfs #{deploy_to}/#{shared_dir}/assets #{release_path}/public/assets"
end