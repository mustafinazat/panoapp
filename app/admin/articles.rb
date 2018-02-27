ActiveAdmin.register Article do
  permit_params :title,:shortdesc, :description, :user_id, :slug, :all_tags



  action_item :view, only: :show do
  link_to 'На сайте', article_path(article)
end

action_item :index do
  link_to 'На сайте(все статьи)', articles_path
end


  index do
    selectable_column
    id_column

    column :title
    column :shortdesc
    column "Описание" do |article|
      article.description.slice(0,40)
    end
    column :created_at

    actions do |article|
      item "Открыть(сайт)", article_path(article), class: "view_link member_link"
      item "Редактировать (сайт)", edit_article_path(article), class: "view_link member_link"
    end

  end


  form do |f|
    f.inputs do
      f.input :title
      f.input :shortdesc
      f.input :description,  :input_html => { :class => "tinymce" }
      f.input :user_id, as: :select, collection: User.all.map{|u| [u.nickname, u.id]}
      f.input :slug
      f.input :all_tags
    end

    f.actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row "User" do
        article.user.nickname
      end
      row :slug
      row :all_tags
      row :updated_at
      row :created_at

    end
    active_admin_comments
  end


end
