def in_memory_database?
  if %w{test cucumber}.member? ENV['RAILS_ENV']
    ActiveRecord::Base.connection.class == ActiveRecord::ConnectionAdapters::SQLite3Adapter and
    Rails::Configuration.new.database_configuration[ENV['RAILS_ENV']]['database'] == ':memory:'
  else
    false
  end
end

if in_memory_database?
  puts "creating sqlite in memory database"
  load "#{RAILS_ROOT}/db/schema.rb" # use db agnostic schema by default
  # ActiveRecord::Migrator.up('db/migrate') # use migrations
end
