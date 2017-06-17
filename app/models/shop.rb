# == Schema Information
#
# Table name: shops
#
#  id         :uuid             not null, primary key
#  name       :string           default(""), not null
#  phone      :string           default(""), not null
#  address    :string           default(""), not null
#  latitude   :float            default(0.0), not null
#  longitude  :float            default(0.0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Shop < ActiveRecord::Base
  geocoded_by :address           # can also be an IP address
  after_validation :geocode      # auto-fetch coordinates
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode # auto-fetch address

  has_many :offers, dependent: :nullify
  has_many :users, dependent: :nullify
end
