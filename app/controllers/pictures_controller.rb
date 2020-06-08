class PicturesController < ApplicationController
  before_action :authenticate_user!
  
  def show
    set_picture
  end

  def new
    @picture = current_user.pictures.build
  end

  def create
    @picture = current_user.pictures.build(create_picture_params)
    respond_to do |format|
      if @picture.save
        format.html { redirect_to pictures_url, notice: 'Picture successfully created. ' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    set_picture
  end

  def update
    set_picture
    respond_to do |format|
      if @picture.update(update_picture_params)
        format.html { redirect_to @picture, notice: 'Description successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    set_picture
    redirect_to picture_path(@picture) unless current_user == @picture.user
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully deleted.' }
    end
  end


  def index
    set_user
    @pictures = @user.pictures
  end

  private

  def set_user
    begin
      @user = User.find(params[:user_id])
    rescue ActiveRecord::RecordNotFound => es
      @user = current_user
    end
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def create_picture_params
    params.require(:picture).permit(:image, :description)
  end

  def update_picture_params
    params.require(:picture).permit(:description)
  end

end