namespace :exo do
  namespace :contributors do
    desc "Generate a contributor"
    task :new, [:email, :password] => :environment do |t, args|
      c = Exo::Contributor.new
      c.email = args[:email]
      c.password = args[:password]
      c.save!
    end
  end
end