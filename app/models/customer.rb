class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :services, dependent: :destroy
  has_many :comments, dependent: :destroy
  # has_many :contacts, dependent: :destroy
  has_many :appointment_comments, dependent: :destroy
  # has_many :favorites, dependent: :destroy
  has_many :point_histories, dependent: :destroy
  
  has_many :exp_histories, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  scope :only_active, -> { where(is_active: true) }
  
  attachment :image

  # def get_comments
  #   test = self.services.pluck(:id)
  #   Commnet.where(service_id: test)
  # end

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
end
