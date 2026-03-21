# 独自バリデーション管理
class DataServices::ValidationService
  # 画像検査
  # 
  # SVGは利用不可
  def self.valid_image(image)
    image.blob.content_type.start_with?("image/") &&
      image.blob.content_type != "image/svg+xml"
  end
end
