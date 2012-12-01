class ResponsesController < ApplicationController
  before_filter :signed_in_user, only: :index
  before_filter :ta_user,		 only: :index
  before_filter :prof_user,		 only: [:index, :show]
  before_filter :admin_user,	 only: [:index, :show, :new, :create, :edit, :update, :destroy]
  
  def index
    @user = User.find(params[:user_id])
    @responses = Response.not_anonymous.where(user_id: @user.id)
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end