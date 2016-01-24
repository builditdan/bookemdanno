class UsersController < ApplicationController


  def show
    redirect_to (welcome_index_path) if current_user.blank?
    @user = current_user
    #@items = Item.where(user_id: params[:id])

  end

  def new
	end

  #### end class
  end
