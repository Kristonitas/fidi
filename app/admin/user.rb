ActiveAdmin.register User do
  permit_params :name, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    column :total_score
    actions
  end

  filter :name

  form do |f|
    f.inputs "Fidi User Details" do
      f.input :name
      f.input :password 
      f.input :password_confirmation
    end
    f.actions
  end

  show do |resource|
    attributes_table do
      row :id
      row :name
      row :created_at
      row :updated_at

      row('QR link:') { user.qr_link }
      row('QR data:') { user.qr_data }
      row('Google QR data:') { user.google_qr_link }
    end
  end

end
