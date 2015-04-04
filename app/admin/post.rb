ActiveAdmin.register Post do
  permit_params :content, :visible, :name, :priority, :category

  index do
    selectable_column
    id_column
    column :name
    column :priority
    column :category
    column :created_at
    actions
  end

  filter :name
  filter :category

  form do |f|
    f.inputs "Fidi Post Details" do
      f.input :name
      f.input :content
      f.input :category, as: :select, collection: Post.categories.keys.to_a, multiple: false
      f.input :priority
    end
    f.actions
  end
end
