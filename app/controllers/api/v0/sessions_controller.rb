class Api::V0::SessionsController < ApplicationController
  def create
    if !user_params[:email] || !user_params[:password]
      render json: ErrorSerializer.serialize("Invalid credentials"), status: 401
    else
      if !User.find_by(email: user_params[:email])
        render json: ErrorSerializer.serialize("Invalid credentials"), status: 401
      else
        user = User.find_by(email: user_params[:email])
        if !user.authenticate(user_params[:password])
          render json: ErrorSerializer.serialize("Invalid credentials"), status: 401
        else
          render json: UserSerializer.new(user)
        end
      end
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end