class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :orders, dependent: :destroy
         has_many :addresses, dependent: :destroy
         has_many :cart_items, dependent: :destroy



        # 必須項目
         validates :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, presence: true

        #退会ユーザーはログインできなくする
        # ログインする時に退会済み(is_active==true)のユーザーを弾くためのメソッド
        
        # 
        # def active_for_authentication?
        #     super && (self.is_active == false)
        # end
end
