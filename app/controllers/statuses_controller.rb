class StatusesController < ApplicationController
  before_action :authenticate_user!
  
  def show
    set_status
  end

  def new
    @status = current_user.statuses.build
  end

  def create
    @status = current_user.statuses.build(status_params)
    respond_to do |format|
      if @status.save
        current_user.posts.create(postable: @status)
        format.html { redirect_to user_path(current_user), notice: 'Status successfully created. ' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    set_status
  end

  def update
    set_status
    respond_to do |format|
      if @status.update(status_params)
        format.html { redirect_to @status, notice: 'Status successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    set_status
    redirect_to picture_path(@status) unless current_user == @status.user
    @status.destroy
    respond_to do |format|
      format.html { redirect_to statuses_path, notice: 'Status was successfully deleted.' }
    end
  end

  def index
    set_user
    @statuses = @user.statuses
  end

  private

  def set_user
    begin
      @user = User.find(params[:user_id])
    rescue ActiveRecord::RecordNotFound => es
      @user = current_user
    end
  end

  def set_status
    @status = Status.find(params[:id])
  end

  def status_params
    params.require(:status).permit(:body)
  end

end