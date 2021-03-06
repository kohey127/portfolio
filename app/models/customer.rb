class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :services, dependent: :destroy
  has_many :comments, dependent: :destroy
  # has_many :contacts, dependent: :destroy
  has_many :appointment_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :point_histories, dependent: :destroy
  
  has_many :exp_histories, dependent: :destroy

  validates :name, presence: true, length: {maximum: 8}
  validates :email, presence: true, uniqueness: true

  attachment :image

  # 顧客が受けたレビューを取得
  def get_comments
    Comment.joins(service: :customer).where(customers: {id: self.id})
  end

  # 顧客が受けたレビューのポジティブ具合(Natural Language)の平均を百分率で取得
  def get_raty
    # sum_ratyでレビューの合計を取得
    sum_raty = 0
    # count_ratyでレビューの件数を取得
    count_raty = 0
    # 顧客が受けたレビューの中でNatural Languageのデータが存在するものだけを配列で取得
    Comment.joins(service: :customer).where(customers: {id: self.id}).pluck(:score).compact.each do |raty|
      sum_raty += raty
      count_raty += 1
    end
    if count_raty != 0 
      # レビューの平均値を百分率で取得
      ( sum_raty / count_raty * 100 ).round
    else
      0
    end
  end

  # Shexper(ユーザ)検索メソッド
  def Customer.search(word)
    # 有効会員のうち、管理者ユーザ以外を取得
    target = Customer.where(is_active: true).where.not(id: 1)
    target.where("name LIKE?", "%#{word}%")
  end
  
  # 申込している体験の件数を取得するメソッド
  def be_applying
    # 対象Shexperが申し込んだ体験のうち、申込ステータスが申込中、もしくは予約成立中のものを返す
    Appointment.where(status: "applying").or(Appointment.where(status: "success")).where(from_customer_id: self.id)
  end
  
  # 申込されている体験の件数を取得するメソッド
  def have_been_applied
    # 対象Shexperが申し込まれた体験のうち、申込ステータスが申込中、もしくは予約成立中のものを返す
    Appointment.where(status: "applying").or(Appointment.where(status: "success")).where(to_customer_id: self.id)
  end

  # 顧客が獲得したお気に入りの件数を取得するメソッド
  def get_favorites_count
    Favorite.joins(service: :customer).where(customers: {id: self.id}).count
  end

end
