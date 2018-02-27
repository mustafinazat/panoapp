ActiveAdmin.register Faq do

  permit_params :answer, :question



  form do |f|
    f.inputs do

      f.input :question
      f.input :answer,  :input_html => { :class => "tinymce" }
    end

    f.actions
  end

  action_item :index do
    link_to 'На сайте', faqs_path
  end



  index do
    selectable_column
    id_column
    column :question
    column "Answer" do |faq|
      faq.question.slice(0,20)
    end
    column :created_at
    column :updated_at
    actions

  end

end
