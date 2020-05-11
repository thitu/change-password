# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative('config/application')

Rails.application.load_tasks

if Rails.env.development? || Rails.env.test?
  require('rubocop/rake_task')
  require('dotenv/tasks')
  require('coveralls/rake/task')

  RuboCop::RakeTask.new
  Coveralls::RakeTask.new

  Rake::Task['default'].clear

  task :default do
    Rake::Task['spec'].invoke
    Rake::Task['cucumber'].invoke
    Rake::Task['rubocop:auto_correct'].invoke
    Rake::Task['coveralls:push'].invoke
  end
end


#require 'coveralls/rake/task'
#Coveralls::RakeTask.new
#task :test_with_coveralls => [:spec, :cucumber, 'coveralls:push']