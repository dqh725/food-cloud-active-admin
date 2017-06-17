# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  offer_id   :uuid
#  image_uid  :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Photo < ActiveRecord::Base
  belongs_to :offer, inverse_of: :photos
  acts_as_list scope: :offer
  dragonfly_accessor :image

  validates_property :format, of: :image, in: ['png', 'jpeg'], message: 'image must be a PNG or JPEG'
  validates :image, presence: true
end
