ActiveAdmin.register Attempt do

  actions :index, :show, :destroy
  
  config.batch_actions = false

  index do
    selectable_column
    id_column
    column :user
    column :booth
    column :comment
    column :score
    column :entries
    column :created_at
    actions
  end

  filter :comment
  filter :score
  filter :created_at

end