ActiveAdmin.register Attempt do

  actions :index, :show, :destroy
  
  config.batch_actions = false

  index do
    selectable_column
    id_column
    column :user
    column :booth
    column :comment
    column :is_record
    column :score
    column :created_at
    actions
  end

  filter :comment
  filter :score
  filter :created_at
  filter :is_record

end