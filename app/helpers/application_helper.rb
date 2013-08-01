module ApplicationHelper

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    current_user
  end

  def authorize
    redirect_to root_url, notice: "You do not have permission to do this!" if current_user.id != params[:id]
  end

  def authenticate
    current_user
  end

end
