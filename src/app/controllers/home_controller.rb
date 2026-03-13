class HomeController < ApplicationController
  def index
  end

  def info
    info_service = InfoServices::InfoService.new

    @infos = info_service.get_infos
  end
end
