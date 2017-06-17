ActiveAdmin.register Offer do
  menu parent: 'Shops'

  permit_params do
    set = [:id, :name, :description, :original_value, :current_value,
           :start_time, :end_time,
           photos_attributes: [:id, :image, :_destroy]]
    if current_user.is_staff?
      set.concat [:offer_id]
    end
  end

  controller do
    def scoped_collection
      super.includes :shop
    end

    def new
      @offer = build_authorized_resource
      authorize! :create, Offer
    end

    def create
      @offer = build_authorized_resource
      authorize! :create, @offer
      super
    end

    def update
      @offer = Offer.find(params[:id])
      super
    end

    def build_authorized_resource
      offer = Offer.new(permitted_params[:offer])
      if current_user.is_admin?
        offer.shop = current_user.shop
      end
      offer
    end
  end

  index do
    selectable_column
    column :name
    column :shop
    column :original_value
    column :current_value
    column :start_time
    column :end_time
    actions
  end

  config.sort_order = 'name'

  filter :name
  filter :description
  filter :shop

  # ransacker of :role is defined in User model for filter
  # filter :role_in, label: 'Role', as: :select, collection: -> { Role.accessible_by(current_ability).map { |r| [r.display_name, r.id] }.push(['Student', 'student']) }

  show do |offer|
    panel 'Details' do
      attributes_table_for offer do
        row :id
        row :name
        row :description
        row :original_value
        row :current_value
      end
    end

    panel 'Condition' do
      attributes_table_for offer do
        row :start_time
        row :end_time
      end
    end
  end

  form do |_f|
    semantic_errors
    inputs 'Details' do
      para 'Note that regardless of whether you use AD, you will log in to this admin portal with the email and password set here. AD will be used to log in to the app.'
      input :name, hint: 'Name shown in the app. Synchronised from AD if used.'
      input :description, hint: 'Email used to log in to the app if not using AD. Also used for communication. Synchronised from AD if used.'
      input :original_value, hint: 'Password used to log in to the app if not using AD.'
      input :current_value
      input :start_time
      input :end_time
    end
    inputs 'Short Names' do
      li do
        para 'xxx'
      end
      has_many :photos, heading: false, new_record: 'Add Photo', allow_destroy: true do |s|
        s.input :image, as: :file, label: 'Image'
      end
    end
    actions
  end
end
