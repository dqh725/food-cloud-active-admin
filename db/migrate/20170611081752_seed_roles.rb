class SeedRoles < ActiveRecord::Migration
  def up
    Role.reset_column_information
    Role.find_or_create_by(name: :admin).update_attribute(:display_name, 'Admin')
    Role.find_or_create_by(name: :staff).update_attribute(:display_name, 'Staff')
    Role.find_or_create_by(name: :customer).update_attribute(:display_name, 'Customer')

    # Student is lack of role, to avoid requiring logic to prevent both presenter and student roles.
  end
end
