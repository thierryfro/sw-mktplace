class UsersController < ApplicationController
  skip_before_action :require_admin

  def edit_profile
    if current_user.update!(user_params)
      flash[:notice] = 'Perfil atualizado com sucesso!'
    else
      flash[:notice] = 'Algo errado não está certo!'
    end
    redirect_to user_info_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :last_name, :birthdate, :photo)
  end

end
