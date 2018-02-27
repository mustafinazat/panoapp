ActiveAdmin.register Virtualtour do
 permit_params :title,:description, :user_id, :connections, :slug, :closed, :all_tags



 action_item :view, only: :show do
   link_to 'На сайте', virtualtour_path(virtualtour)
 end

 action_item :index do
   link_to 'На сайте(все виртуальные туры)', virtualtours_path
 end


    index do
      selectable_column
      id_column
      column :title
      column "Описание" do |virtualtour|
        virtualtour.description.slice(0,40)
      end
      column :created_at
      actions do |virtualtour|
        item "Открыть(сайт)", virtualtour_path(virtualtour), class: "view_link member_link"
        item "Редактировать (сайт)", edit_virtualtour_path(virtualtour), class: "view_link member_link"
      end
    end


    form do |f|
      f.inputs do
        f.input :title
        f.input :description
        f.input :connections
        f.input :user_id, as: :select, collection: User.all.map{|u| [u.nickname, u.id]}
        f.input :slug
        f.input :all_tags
        f.input :closed
      end

      f.actions
    end

    show do
      attributes_table do
        row :title
        row :description
        row "User" do
          virtualtour.user.nickname
        end
        row :slug
        row :all_tags
        row :closed
        row :updated_at
        row :created_at

      end
      active_admin_comments
    end


end



