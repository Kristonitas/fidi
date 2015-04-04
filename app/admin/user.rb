ActiveAdmin.register User do
  permit_params :name, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :name
    column :booth_id
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

end
