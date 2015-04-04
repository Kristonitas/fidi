ActiveAdmin.register FidiUser do
  permit_params :email, :password, :password_confirmation, :booth_id

  index do
    selectable_column
    id_column
    column :email
    column :booth
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :booth_id
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Fidi User Details" do
      f.input :email, label: "Email (may not be a real email)"
      f.input :booth_id, as: :select, :collection => Booth.all.pluck(:name, :id), multiple: false
      f.input :password 
      f.input :password_confirmation
    end
    f.actions
  end

end
