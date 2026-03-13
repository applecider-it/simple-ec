# お知らせ管理
class InfoServices::InfoService
  # お知らせを返す
  def get_infos
    [
      {
        title: "お知らせテスト",
        description: "お知らせ内容 お知らせ内容 お知らせ内容 お知らせ内容 ",
        date: "2026/3/13",
      }
    ]
  end
end
