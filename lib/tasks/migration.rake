namespace :exo do
  desc "Migrate values to _values"
  task value_migration: :environment do |t, args|
    Exo::Resource::Item.each do |i|
      begin
        i.migrate_values!
      rescue Exception => e
        puts "=> #{i.inspect}\n#{e.message}\n#{e.backtrace}"
        raise e
      end
    end
  end
end