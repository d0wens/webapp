class TakeAssignmentsController < ApplicationController
  before_filter :signed_in_user
  
  def new
    @assignment = Assignment.find(params[:id]) if params[:id]
    respond_to do |format|
      format.html
    end
  end

  def create
    params[:response].each do |question, answer|
      current_user.responses.create :question_id => question, :answer_id => answer[:answer_id], :content => answer[:content],
        :user_id => current_user.id
    end
    if current_user.save
      flash[:info] = "Your assignment has been successfully created!"
      redirect_to take_assignment_path(Assignment.find(params[:assignment_id]))
    else
      flash.now[:error] = "There were problems with your assignment submission."
      render :edit
    end
  end

  def edit
    @assignment = Assignment.find(params[:id]) if params[:id]
  end

  def show
    @assignment = Assignment.find(params[:id]) if params[:id]
  end

end
