ActiveAdmin.register Page do
  permit_params :title, :body, :slug

  form do |f|
    f.inputs do
      f.input :title
      f.input :body,  :input_html => { :class => "tinymce" }
      f.input :slug
    end
    f.actions
  end


  action_item :view, only: :show do
    link_to 'На сайте', page_path(page)
  end


  index do
    selectable_column
    id_column
    column :title
    column "Body" do |page|
      page.body.slice(0,20)
    end
    column :slug
    column :created_at

    actions do |page|
      item "Открыть(сайт)", page_path(page), class: "view_link member_link"
    end

  end

end
