# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  name                   :string           default(""), not null
#  access_level           :integer          default(0), not null
#  shop_id                :uuid
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Customer < User
end
