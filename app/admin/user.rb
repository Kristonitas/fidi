ActiveAdmin.register User do
  permit_params :name, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :name
    column :created_at
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

      row('QR link:') { "http://79.98.25.158/qr_codes/#{user.id}_qr.png" }
      row('QR data:') { "http://79.98.25.158/attempt_for/#{user.id}" }
    end
  end

end
