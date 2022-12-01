class UsersController < ApplicationController
  def create
    user = User.create(user_params)
    if user.valid?
      session[:user_id] ||= user.id
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    user = User.find_by(session[:user_id])
    if user
      render json: user
    else
      render json: { error: "Sorry buddy! Not Authorized..." }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:username, :password)
  end
end
