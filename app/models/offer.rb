# == Schema Information
#
# Table name: offers
#
#  id             :uuid             not null, primary key
#  name           :string           default(""), not null
#  description    :string           default(""), not null
#  original_value :float            default(0.0), not null
#  current_value  :float            default(0.0), not null
#  shop_id        :uuid             not null
#  start_time     :datetime         not null
#  end_time       :datetime         not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Offer < ActiveRecord::Base
  belongs_to :shop
  has_many :photos, -> { order(position: :asc) }
  accepts_nested_attributes_for :photos
end
