class AdminController < ApplicationController

  def admins
    @admins = User.where(admin: true)
  end

  def offers
    @offers = Offer.all
  end

end
