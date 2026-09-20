# 固定データ管理
class DataServices::FixeddataService
  # 都道府県のハッシュ
  def self.prefectures
    I18n.t('app.data.prefectures')
  end
end
