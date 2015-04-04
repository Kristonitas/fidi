ActiveAdmin.register Booth do
  permit_params :name, :description, :image_url, :pos_x, :pos_y

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :image_url
    column :pos_x
    column :pos_y
    actions
  end

  filter :name
  filter :description

  form do |f|
    f.inputs "Booth details" do
      f.input :name
      f.input :description
      f.input :image_url
      f.input :pos_x, label: 'Pos x (in pixels)'
      f.input :pos_y, label: 'Pos y (in pixels)'
    end
    f.actions
  end
end