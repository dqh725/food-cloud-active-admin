class CustomersController < ApplicationController
  layout 'user'
  before_action :authenticate_customer!
  def index; end
end
