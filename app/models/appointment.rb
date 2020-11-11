class Appointment < ApplicationRecord
  belongs_to :service
  belongs_to :to_customer, class_name:"Customer", foreign_key: :to_customer_id
  belongs_to :from_customer, class_name:"Customer", foreign_key: :from_customer_id
  has_one :appointment_comment
  has_many :exp_histories, dependent: :destroy
  
  validates :to_customer_id, presence: true
  validates :from_customer_id, presence: true
  validates :request_date, presence: true
  
  enum status:{ applying: 0, success: 1, failure: 2, done: 3 }
  validates :status, presence: true

  enum request_format:{ online: 0, telephone: 1, message: 2, anything: 3 }
  validates :request_format, presence: true
  
  def partner_customer(id)
    return self.to_customer if self.from_customer_id == id    
    self.from_customer
  end

  def chat_lead_message(id)
    case id
    when self.from_customer_id
      if self.applying?
        return "相手の体験を申込中です。相手に体験の利用意思を伝え、申込の承認もしくは中断を依頼してください。"
      elsif self.success?
        return "相手に体験の申込を承認されました。\n体験が終わったら、画面下のレビューを送信して体験を完了してください。\n（※レビューを送信すると相手にポイントが支払われます。）"
      elsif self.failure?
        return "相手に体験の申込を中断されました。\nこのチャットは中断から3日後に見れなくなります。\nなお、送信したメッセージは相手に表示されません。"
      elsif self.done?
        return "過去に利用した体験のチャットです。送信したメッセージは相手に表示されません。"
      else
        return "不正なチャットです。"
      end
    when self.to_customer_id
      if self.applying?
        return "相手があなたの体験に申込んでいます。以下①～③を実施してください。\n① 相手の体験の利用意思を確認してください。\n② 利用したい意思が確認出来たら日程の調整をしてください。\n③ 申込状況の承認待ち一覧から対象の申込を、承認もしくは中断/拒否してください。\n（※③の操作は取り消せないため、必ず相手に許可をもらってから実施してください。③で申込を承認すると、相手はあなたにポイントを払わなければならなくなります。）"
      elsif self.success?
        return "相手の申込を承認しました。体験の提供が終わったら、ここで相手にレビューを依頼してください。\n相手がレビューを送信することで本取引は完了し、このチャットは閉じられます。"
      else
        return "不正なチャットです。"
      end
    end
  end
end