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
  filter :image_url

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
  # config.batch_actions = false
  
  # filter :country_1, as: :select
  # filter :country_2, as: :select
  # filter :starts_at 
  # filter :ends_at
  
  # index download_links: false do
  #   column :starts_at
  #   column :ends_at
  #   column :country_1
  #   column :country_2
  #   column :victory_points_country_1
  #   column :victory_points_country_2
  #   actions do |world_war|
  #     link_to('Create Antimatter vs Metal', create_antimatter_metal_war_new_admin_world_war_path(world_war))
  #   end
  # end

  # form do |f|
  #   f.inputs 'War duration' do
  #     f.input :starts_at, as: :datepicker    
  #     f.input :ends_at, as: :datepicker
  #   end

  #   f.inputs 'Flags' do
  #     f.input :country_1_iso_code, as: :select, :collection => [['Antimatter', 'Antimatter'], ['Metal', 'Metal'], ['China', 'CN'], ['Czech Republic', 'CZ'], ['Georgia', 'GE'], ['Indonesia', 'ID'], ['India', 'IN'], ['Iraq', 'IQ'], ['Iran', 'IR'], ['Russia', 'RU'], ['Thailand', 'TH'], ['Ukraine', 'UA'], ['United States', 'US'], ['Vietnam', 'VN']] 
  #     f.input :country_2_iso_code, as: :select, :collection => [['Antimatter', 'Antimatter'], ['Metal', 'Metal'], ['China', 'CN'], ['Czech Republic', 'CZ'], ['Georgia', 'GE'], ['Indonesia', 'ID'], ['India', 'IN'], ['Iraq', 'IQ'], ['Iran', 'IR'], ['Russia', 'RU'], ['Thailand', 'TH'], ['Ukraine', 'UA'], ['United States', 'US'], ['Vietnam', 'VN']]
  #   end

  #   f.inputs 'Involved countries' do
  #     f.input :countries_1_list, as: :select, :collection => User.non_single_player.finished_tutorial.select(:country_iso_code).distinct.pluck(:country_name, :country_iso_code), multiple: true
  #     f.input :countries_2_list, as: :select, :collection => User.non_single_player.finished_tutorial.select(:country_iso_code).distinct.pluck(:country_name, :country_iso_code), multiple: true
  #   end

  #   f.actions
  # end


  # controller do
  #   skip_before_filter :check_version_compatibility, :authenticate_user_from_token!

  #   def create
  #     parameters = world_war_params

  #     parameters[:country_1] = parameters[:country_1_iso_code].length == 2 ? User.find_by(country_iso_code: parameters[:country_1_iso_code]).country_name : parameters[:country_1_iso_code]
  #     parameters[:country_2] = parameters[:country_2_iso_code].length == 2 ? User.find_by(country_iso_code: parameters[:country_2_iso_code]).country_name : parameters[:country_2_iso_code]
    
  #     world_war = WorldWar.create!(parameters)

  #     redirect_to new_admin_world_war_path(world_war)
  #   end

  #   def world_war_params
  #     params.require(:world_war).permit(:country_1_iso_code, :country_2_iso_code, :starts_at, :ends_at, countries_1_list: [], countries_2_list: [])
  #   end
  # end

  # member_action :create_antimatter_metal_war, method: :get do
  #   world_war = WorldWar.find_by(id: params[:id])
  #   starts_at = world_war.starts_at
  #   ends_at = world_war.ends_at

  #   new_war = WorldWar.create_from_left(starts_at, ends_at)

  #   redirect_to new_admin_world_war_path(new_war)
  # end
