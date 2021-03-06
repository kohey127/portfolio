class Public::AppointmentsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    receive_appointments = Appointment.where(to_customer_id: current_customer.id).order(created_at: "desc").includes(:service)
    send_appointments = Appointment.where(from_customer_id: current_customer.id).order(created_at: "desc").includes(:service)

    # 申込があった体験
    @comming_appointments = receive_appointments.where(status: "applying")

    # 承認後、相手のレビュー待ちの体験
    @waiting_review_appointments = receive_appointments.where(status: "success")

    # 申込中の体験
    @applying_appointments = send_appointments.where(status: "applying")

    # 申込を承認された体験
    @success_appointments = send_appointments.where(status: "success")

    # 申込が中断された体験
    @failure_appointments = send_appointments.where(status: "failure", created_at: 3.day.ago.beginning_of_day..Time.zone.now.end_of_day)

    # 過去に申し込んだ体験
    @done_appointments = send_appointments.where(status: "done")
  end

  def create
    # 申込新規作成準備
    @appointment = Appointment.new(appointment_params)
    @appointment.status = "applying"
    if params[:request_date_exist] == "0"
      @appointment.request_date = "undecided"
    else
      @appointment.request_date = params[:appointment][:request_date]
    end

    # エラーフラグの初期値を設定
    error_flag = 0

    # ポイントが足りないときにエラーを表示
    @service = Service.find(params[:service_id])
    if current_customer.point < @service.point
      flash.now[:danger] = "ポイントが足りません"
      error_flag = 1
    end

    if error_flag != 1
      # 申込進行中の体験があるときにエラーを表示
      if current_customer.be_applying.present?
        flash.now[:danger] = "現在、取引が進行中の体験があります。ポイントの不整合を防ぐため、現在の取引を完了してからお申し込みください。"
        error_flag = 1
      end
    end

    if error_flag != 1
      # 初期メッセージが空の時、もしくは400文字以上の時にエラーを表示(appointment_commentは、appointmentのidを格納するため、appointment作成後に作成する必要がある。そのためバリデーションチェックは事前に手動で実施している。)
      if params[:appointment][:first_message] == "" || params[:appointment][:first_message].length >= 400
        flash.now[:danger] = "メッセージは、1文字以上400文字以下で入力してください。"
        error_flag = 1
      end
    end

    if error_flag == 0 && @appointment.save
      # 申込を作成できたらコメントを新規作成
      appointment_comment = AppointmentComment.new
      appointment_comment.customer_id = current_customer.id
      appointment_comment.appointment_id = @appointment.id
      appointment_comment.content = params[:appointment][:first_message]
      appointment_comment.save
      redirect_to service_appointments_complete_path
    else
      # 予約を保存できなかったときにエラーを表示
      render :new
    end
  end

  def new
    @appointment = Appointment.new
    @service = Service.find(params[:service_id])
  end

  def complete
  end

  def update
    appointment = Appointment.find(params[:id])
    case params[:update_param]
      when "success"
        if appointment.success!
          flash[:success] = "申込を承認しました"
        end
      when "failure"
        if appointment.failure!
          flash[:success] = "申込を拒否／中断しました"
        end
    end
    redirect_to appointments_path
  end

  private
  def appointment_params
    params.require(:appointment).permit(:service_id, :to_customer_id, :from_customer_id, :request_format, :request_date, :status)
  end
end
