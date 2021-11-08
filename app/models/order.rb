class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy





  # validates_presence_of :name, :address,:pay_type => "を入力して下さい。"

  enum payment_method: { credit_card: 0, transfer: 1 }




  attribute :status, :integer, default: '0'

end
