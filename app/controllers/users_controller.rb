class UsersController < ApplicationController
  def create
    render :text => omniauth.to_hash.inspect
    # account = Account::Github.find_or_create_by_omniauth(omniauth)
    # current_user = account.user
    # redirect_to root_path
  end

protected

  def omniauth
    request.env['omniauth.auth']
  end
end