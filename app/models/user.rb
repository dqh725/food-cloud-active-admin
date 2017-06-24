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

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :offers, dependent: :nullify
  belongs_to :shop

  # 100
  def is_staff?
    access_level.to_s(2)[-3] == '1'
  end

  # 010
  def is_admin?
    access_level.to_s(2)[-2] == '1'
  end

  # 001
  def is_customer?
    access_level.to_s(2)[-1] == '1'
  end

  def role_names; end

  def add_role(role)
    case role
    when :staff
      self.access_level += 4 unless is_staff?
    when :admin
      self.access_level += 2 unless is_admin?
    when :customer
      self.access_level += 1 unless is_customer?
    end
  end

  # Removed the desired bit
  def remove_role(role)
    case role
    when :staff
      self.access_level -= 4 unless is_staff?
    when :admin
      self.access_level -= 2 unless is_admin?
    when :customer
      self.access_level -= 1 unless is_customer?
    end
  end
end
