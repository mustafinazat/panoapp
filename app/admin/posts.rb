ActiveAdmin.register Post do

    permit_params :title,:description, :user_id, :slug, :closed, :all_tags

    index do
      selectable_column
      id_column

      column :title
      column "Описание" do |post|
        post.description.slice(0,40)
      end
      column :created_at

      actions do |post|
        item "Открыть(сайт)", post_path(post), class: "view_link member_link"
        item "Редактировать (сайт)", edit_post_path(post), class: "view_link member_link"
      end

    end


    form do |f|
      f.inputs do
        f.input :title
        f.input :description
        f.input :user_id, as: :select, collection: User.all.map{|u| [u.nickname, u.id]}
        f.input :slug
        f.input :all_tags
        f.input :closed
      end

      f.actions
    end

    action_item :view, only: :show do
      link_to 'На сайте', post_path(post)
    end

    action_item :index do
      link_to 'На сайте(все посты)', posts_path
    end

    show do

      attributes_table do
        row :title
        row :description
        row "User" do
          post.user.nickname
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



