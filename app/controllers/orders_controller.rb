class OrdersController < ApplicationController
  skip_before_action :require_admin
  skip_before_action :verify_authenticity_token

  def return
    raise
  end

end
