class UploadsController < ApplicationController
  before_action :authorized

  before_action do
    ActiveStorage::Current.host = request.base_url
  end

  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(upload_params.merge(user_id: current_user.id))
    if @upload.save
      redirect_to user_uploads_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @uploads = current_user.uploads
  end

  def show
    @upload = current_user.uploads.find(params[:id])
    expiring_url = @upload.expiring_url
    Rails.logger.info "******************************"
    Rails.logger.info expiring_url
    Rails.logger.info "******************************"
    redirect_to expiring_url, allow_other_host: true
  end

  private

  def upload_params
    params.require(:upload).permit(:file)
  end
end
