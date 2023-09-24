class Api::V0::UsersController < ApplicationController
  def create
    if user_params[:email] && user_params[:password] == user_params[:password_confirmation]
      user = User.new(email: user_params[:email], password: user_params[:password])
      if user.save
        render json: UserSerializer.serialize(user)
      end
    else
      render json: ErrorSerializer.serialize("Invalid parameters"), status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end