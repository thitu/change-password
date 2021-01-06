# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative('config/application')

Rails.application.load_tasks

if Rails.env.development? || Rails.env.test?
  require('dotenv/tasks')
  require('rubocop/rake_task')

  RuboCop::RakeTask.new
  Rake::Task['default'].clear

  task :default do
    Rake::Task['spec'].invoke
    Rake::Task['cucumber'].invoke
    # Rake::Task['rubocop'].invoke
  end
end
