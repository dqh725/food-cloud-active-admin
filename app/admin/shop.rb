ActiveAdmin.register Shop do
  menu priority: 1
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  permit_params [:name, :phone, :address, :latitude, :longitude]

  index do
    selectable_column
    column :name
    column :phone
    column :address
    actions
  end

  config.sort_order = 'name'

  filter :name
  filter :address
  # ransacker of :role is defined in User model for filter
  # filter :role_in, label: 'Role', as: :select, collection: -> { Role.accessible_by(current_ability).map { |r| [r.display_name, r.id] }.push(['Student', 'student']) }

  show do |shop|
    panel 'Details' do
      attributes_table_for shop do
        row :id
        row :name
      end
    end

    panel 'Location' do
      attributes_table_for shop do
        row :address
        row :latitude
        row :longitude
      end
    end
  end

  form do |_f|
    semantic_errors
    inputs 'Details' do
      para 'Note that regardless of whether you use AD, you will log in to this admin portal with the email and password set here. AD will be used to log in to the app.'
      input :name, hint: 'Name shown in the app. Synchronised from AD if used.'
      input :phone, hint: 'Email used to log in to the app if not using AD. Also used for communication. Synchronised from AD if used.'
      input :address, hint: 'Password used to log in to the app if not using AD.'
    end
    actions
  end
end
