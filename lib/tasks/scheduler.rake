desc "This task is called by the Heroku scheduler add-on"
task :refresh_posts => :environment do
  puts "Refreshing posts..."
  AdminAccount.refresh_posts
  puts "done."
end