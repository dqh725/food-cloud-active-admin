# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

Rake::Task['db:migrate'].enhance do
  system 'bundle exec annotate --exclude tests,fixtures,factories,serializers' if Rails.env.development?
end
