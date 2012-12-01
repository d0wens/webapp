class EnrollmentsController < ApplicationController
  before_filter :signed_in_user
  
  def create
    @user = User.find(params[:enrollments][:user_id])
	@course = Course.find(params[:enrollments][:course_id])
	current_user.enroll!(@course)
	@course.enlist!(@user)
	redirect_to @course
  end
  
  def destroy
    @user = Enrollment.find(params[:user_id]).user
	@course = Enrollment.find(params[:course_id]).course
	current_user.unenroll!(@course)
	@course.unenlist!(@user)
	redirect_to @user
  end
  
end