class ApplicationController < ActionController::Base

  before_action :require_admin, unless: :devise_controller?

  def require_admin
    unless current_user && current_user.admin
      flash[:notice] = "Permissão negada. Favor logar como administrador."
      redirect_to(root_path)
    end
  end

end
