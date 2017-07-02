class CustomersController < ApplicationController
  layout 'user'
  before_action :authenticate_customer!
  def index
    @top_offers = Offer.all
  end

  def search
    @q = Offer.ransack(params[:q])
    @offers = @q.result(distinct: true)
  end
end
