# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.find_or_create_by(email: 'staff@vivi.io') do |u|
  u.password = 'password'
  u.password_confirmation = 'password'
  u.add_role :staff
end

Shop.find_or_create_by(name: 'First Shop') do |s|
  s.phone = '0412601638'
  s.address = '5/5 murrumbeena street'
end

Shop.find_or_create_by(name: 'Second Shop') do |s|
  s.phone = '0412601638'
  s.address = '186 Peel Street, North Melbourne'
end

Offer.find_or_create_by(name: 'First Offer') do |s|
end

Offer.find_or_create_by(name: 'Second Offer') do |s|
end
