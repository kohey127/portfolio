ActiveAdmin.register Service do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :customer_id, :content, :place, :catchphrase, :image_id, :point, :is_active, :format
  #
  # or
  #
  # permit_params do
  #   permitted = [:customer_id, :content, :place, :catchphrase, :image_id, :point, :is_active, :format]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :is_active
end
