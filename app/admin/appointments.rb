ActiveAdmin.register Appointment do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :service_id, :to_customer_id, :from_customer_id, :request_format, :request_date, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:service_id, :to_customer_id, :from_customer_id, :request_format, :request_date, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :status, :from_customer_id, :to_customer_id, :service_id
end
