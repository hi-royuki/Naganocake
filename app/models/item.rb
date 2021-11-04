class Item < ApplicationRecord

  belongs_to :genre

  attachment :image

  has_many :cart_items
  has_many :order_details



 enum is_active: { on_sale: 0, off_sale: 1 }


  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  
  
# 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end

end
