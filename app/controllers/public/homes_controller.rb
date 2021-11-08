class Public::HomesController < ApplicationController
  def top
    @items = Item.all
    # 降順にする場合は”DESC”を設定。昇順は”ASC” ("name DESC")で名前の降順
    @item = Item.order(" created_at DESC ")
  end

  def about
  end
end
