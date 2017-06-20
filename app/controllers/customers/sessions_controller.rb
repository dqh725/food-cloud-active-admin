class Customers::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(_resource)
    '/users/index'
  end

  def after_sign_out_path_for(_resource)
    '/'
  end
end
