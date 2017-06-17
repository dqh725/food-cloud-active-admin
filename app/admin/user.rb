ActiveAdmin.register User do
  permit_params [:id, :name, :email, :password, :password_confirmation,
                 :enable_email_notification, :confirmed_at, role_ids: []]

  csv do
    column('ID', humanize_name: false, &:id)
    column :name
    column :email
  end

  controller do
    before_filter :strip_blank_password, only: :update

    def strip_blank_password
      if params[:user][:password].blank?
        params[:user].delete('password')
        params[:user].delete('password_confirmation')
      end
    end

    def scoped_collection
      super.includes :roles
    end

    def new
      @user = build_authorized_resource
      authorize! :create, User
    end

    def create
      @user = build_authorized_resource
      # @user.skip_confirmation!
      authorize! :create, @user
      super
    end

    def update
      @user = User.find(params[:id])
      # @user.skip_reconfirmation!
      super
    end

    def build_authorized_resource
      User.new(permitted_params[:user])
    end
  end

  index do
    selectable_column
    column :name
    column :email
    column 'Roles', :role_names, sortable: false
    actions
  end

  config.sort_order = 'email_asc'

  filter :name
  filter :email
  # ransacker of :role is defined in User model for filter
  # filter :role_in, label: 'Role', as: :select, collection: -> { Role.accessible_by(current_ability).map { |r| [r.display_name, r.id] }.push(['Student', 'student']) }

  show do |user|
    panel 'Details' do
      attributes_table_for user do
        row :id
        row :name
        row :email
        row('Roles') { user.role_names }
      end
    end

    panel 'Session' do
      attributes_table_for user do
        row :sign_in_count
        row :current_sign_in_ip
        row :last_sign_in_ip
      end
    end

    panel 'Timestamps' do
      attributes_table_for user do
        row :current_sign_in_at
        row :last_sign_in_at
        row :reset_password_sent_at
        row :confirmation_sent_at
        row :confirmed_at
        row :updated_at
        row :created_at
      end
    end
  end

  form do |_f|
    semantic_errors
    inputs 'Details' do
      para 'Note that regardless of whether you use AD, you will log in to this admin portal with the email and password set here. AD will be used to log in to the app.'
      input :name, hint: 'Name shown in the app. Synchronised from AD if used.'
      input :email, hint: 'Email used to log in to the app if not using AD. Also used for communication. Synchronised from AD if used.'
      input :password, hint: 'Password used to log in to the app if not using AD.'
      input :password_confirmation
      input :roles, as: :check_boxes, collection: Role.accessible_by(current_ability), label: 'Roles'
    end
    actions
  end
end
