# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

food_shop = Shop.find_or_create_by(name: 'Food Shop') do |s|
  s.phone = '0412601638'
  s.address = '5/5 murrumbeena street'
end

red_hourse = Shop.find_or_create_by(name: 'Red House') do |s|
  s.phone = '0412601638'
  s.address = '186 Peel Street, North Melbourne'
end

User.find_or_create_by(email: 'staff@vivi.io') do |u|
  u.password = 'password'
  u.name = 'Alba'
  u.password_confirmation = 'password'
  u.add_role :staff
end

User.find_or_create_by(email: 'admin@vivi.io') do |u|
  u.password = 'password'
  u.name = 'Alba'
  u.shop = red_hourse
  u.password_confirmation = 'password'
  u.add_role :admin
end

Offer.find_or_create_by(name: '4-6 meal') do |o|
  o.shop = food_shop
  o.start_time = 1.days.ago
  o.end_time = Time.now + 1.days
end

Offer.find_or_create_by(name: 'Long leg girl') do |o|
  o.shop = red_hourse
  o.start_time = 1.days.ago
  o.end_time = Time.now + 1.days
end
