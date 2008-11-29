
namespace :db do
  desc "Recreates the development database and loads the bootstrap fixtures from db/bootstrap."
  task :bootstrap => [:environment, :create, :migrate, "bootstrap:load", "log:clear", "gems:install"]
  
  namespace :bootstrap do
    
    task :again => [:environment, "db:drop", "db:create", "db:migrate", "bootstrap:load", "log:clear", "gems:install"]

    desc "Load fixtures from db/bootstrap into the database"
    task :load => :environment do
      require 'active_record/fixtures'
      ActiveRecord::Base.establish_connection(RAILS_ENV.to_sym)
      (ENV['FIXTURES'] ? ENV['FIXTURES'].split(/,/) : Dir.glob(File.join(RAILS_ROOT, 'db', 'bootstrap', '*.{yml,csv}'))).each do |fixture_file|
        Fixtures.create_fixtures('db/bootstrap', File.basename(fixture_file, '.*'))
      end
    end

    desc 'Create YAML test fixtures from data in an existing database. Defaults to development database.  Set RAILS_ENV to override.'
 
    task :extract_fixtures => :environment do
      sql  = "SELECT * FROM %s"
      skip_tables = ["schema_migrations"]
      ActiveRecord::Base.establish_connection
      (ActiveRecord::Base.connection.tables - skip_tables).each do |table_name|
        i = "000"
        File.open("#{RAILS_ROOT}/db/bootstrap/#{table_name}.yml", 'w') do |file|
          data = ActiveRecord::Base.connection.select_all(sql % table_name)
          file.write data.inject({}) { |hash, record|
            hash["#{table_name}_#{i.succ!}"] = record
            hash
          }.to_yaml
        end
      end
    end

  end
end
