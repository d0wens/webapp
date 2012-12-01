class CoursesController < ApplicationController
  before_filter :signed_in_user, only: [:index, :show]
  before_filter :admin_user, 	 only: [:edit, :create, :destroy, :update, :new]

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end
  
  def index
    @courses = Course.paginate(page: params[:page])
  end
  
  def create
    @course = Course.new(params[:course])
	if @course.save
	  flash[:success] = "Successfully created course!"
	  redirect_to @course
	else
	  render 'new'
	end
  end
  
  def destroy
    Course.find(params[:id]).destroy
	flash[:success] = "Course destroyed."
	redirect_to courses_path
  end
  
  def edit
  end
  
  def update
	if @course.update_attributes(params[:course])
	  flash[:success] = "Course updated"
	  redirect_to @course
	else
	  render 'edit'
	end
  end
  
  def enlisters
    @title = "Users Enlisted"
	@course = Course.find(params[:id])
	@users = @course.enrolled_users.paginate(page: params[:page])
	render 'show_enlist'
  end

end
