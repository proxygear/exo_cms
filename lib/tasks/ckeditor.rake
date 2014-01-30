namespace :exo do
  namespace :ckeditor do
    desc "Railsing ckeditor source folder"
    task railsing!: :environment do
      path = File.join Rails.root, '_vendor', 'ckeditor'
      CkeditorRailser.new().process path
    end
  end
end