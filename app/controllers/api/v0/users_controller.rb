class Api::V0::UsersController < ApplicationController
  def create
    user = User.new(user_params)
  
    if user.save
      render json: UserSerializer.new(user), status: :created
    else
      render json: ErrorSerializer.format_errors("Invalid parameters"), status: :unprocessable_entity
    end
  end
  

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end