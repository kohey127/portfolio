ActiveAdmin.register PointHistory do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :customer_id, :balance, :trigger_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:customer_id, :balance, :trigger_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :balance, :customer_id, :trigger_id
end
