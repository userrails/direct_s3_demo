class HomeController < ApplicationController
  before_action do
    ActiveStorage::Current.host = request.base_url
  end

  before_action :authorized, only: [:index]

  def index; end
end
