# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin_user = User.new(:email => ENV['admin_user_email'], :password => ENV['admin_user_pw'], :password_confirmation => ENV['admin_user_pw'], :is_master_user => true)
admin_user.save
