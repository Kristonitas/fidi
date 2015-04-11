ActiveAdmin.register Booth do
  batch_action :destroy, false
  
  permit_params :name, :description, :popup_image, :pointer_image, :pos_x, :pos_y, :userable, :code,
                :min_score, :max_score, :max_attempts, available_scores: []

  config.filters = false
  
  index do
    selectable_column
    id_column
    column :name
    column 'Pav', :popup_image
    column :description do |booth|
        booth.description.slice(0, 50) + '...'
    end
    column 'numF', :number_of_fidders
    column :userable
    column 'Kods', :code
    # column 'Daugiklis', :multi
    column 'Min', :min_score
    column 'Max', :max_score
    column 'Galimi', :available_scores
    column 'Kelis kartus', :max_attempts
    column 'X', :pos_x
    column 'Y', :pos_y
    actions
  end

  form do |f|
    f.inputs "Booth details" do
      f.input :name
      f.input :description

      f.input :userable
      f.input :code
      f.input :min_score
      f.input :max_score
      f.input :available_scores, as: :select, :collection => (1..500).to_a, multiple: true
      # f.input :available_scores, as: :select, multiple: true, :input_html_options => {:multiple => true}
      f.input :max_attempts, label: 'Kelis kartus (0-neribotai)'

      f.label :popup_image, Dir["./public/booths/*"].each {|x| x.slice!('./public/booths/') }.to_s
      f.label :popup_image, 'naudoti http:// jei tiesiogini url, kitaip automatiskai prides'

      f.input :popup_image
      f.input :pointer_image
      f.input :pos_x, label: 'Pos x (in pixels)'
      f.input :pos_y, label: 'Pos y (in pixels)'
    end
    f.actions
  end
end