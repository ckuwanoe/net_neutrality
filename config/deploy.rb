# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'net_neutrality'
set :deploy_user, 'deployer'

# setup repo details
set :scm, :git
set :repo_url, "git@github.com:ckuwanoe/#{fetch(:application)}.git"


# how many old releases do we want to keep
set :keep_releases, 5

# files we want symlinking to specific entries in shared.
set :linked_files, %w{config/database.yml config/application.yml config/secrets.yml config/initializers/setup_mail.rb}

# dirs we want symlinking to shared
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system db/backups public/uploads}

# what specs should be run before deployment is allowed to
# continue, see lib/capistrano/tasks/run_tests.cap
set :tests, ["spec"]

# which config files should be copied by deploy:setup_config
# see documentation in lib/capistrano/tasks/setup_config.cap
# for details of operations
set(:config_files, %w(
  nginx.conf
  application.yml
  database.example.yml
  log_rotation
  monit
  unicorn.rb
  unicorn_init.sh
))

# which config files should be made executable after copying
# by deploy:setup_config
set(:executable_config_files, %w(
  unicorn_init.sh
))

# files which need to be symlinked to other parts of the
# filesystem. For example nginx virtualhosts, log rotation
# init scripts etc.
set(:symlinks, [
  {
    source: "nginx.conf",
    link: "/etc/nginx/sites-enabled/#{fetch(:full_app_name)}"
  },
  {
    source: "unicorn_init.sh",
    link: "/etc/init.d/unicorn_#{fetch(:full_app_name)}"
  },
  {
    source: "log_rotation",
   link: "/etc/logrotate.d/#{fetch(:full_app_name)}"
  },
  {
    source: "monit",
    link: "/etc/monit/conf.d/#{fetch(:full_app_name)}.conf"
  }
])

# Uncomment this line if your workers need access to the Rails environment:
#set :resque_environment_task, true
#set :whenever_roles, -> {:app}
#set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
# this:
# http://www.capistranorb.com/documentation/getting-started/flow/
# is worth reading for a quick overview of what tasks are called
# and when for `cap stage deploy`
set :bundle_flags, '--deployment'
namespace :deploy do
  # make sure we're deploying what we think we're deploying
  before :deploy, "deploy:check_revision"
  # only allow a deploy with passing tests to deployed
  before :deploy, "deploy:run_tests"
  # compile assets locally then rsync
  #after :updating, 'figaro:symlink'
  #after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'cache:clear'
  after :finishing, 'deploy:restart'
  #after :finishing, 'delayed_job:restart'
  #after :finishing, 'resque:restart'
  after :finishing, 'deploy:cleanup'
end