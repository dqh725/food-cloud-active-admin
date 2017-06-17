# == Schema Information
#
# Table name: roles
#
#  id            :uuid             not null, primary key
#  name          :string
#  display_name  :string
#  resource_id   :integer
#  resource_type :string
#  created_at    :datetime
#  updated_at    :datetime
#

class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: :users_roles
  belongs_to :resource, polymorphic: true

  scopify
end
