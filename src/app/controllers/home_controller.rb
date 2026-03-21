# トップ画面など
class HomeController < ApplicationController
  def index
  end

  # お知らせページなど
  def info
    info_service = InfoServices::InfoService.new

    @infos = info_service.get_infos
  end
end
