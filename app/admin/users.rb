ActiveAdmin.register User do

permit_params :nickname,:description,:email, :password, :password_confirmation, :slug, :role

# end


  action_item :view, only: :show do
    link_to 'На сайте', user_path(user)
  end



  index do
    selectable_column
    id_column
    column :nickname
    column :description
    column :email
    column :role
    column :created_at
    actions do |user|
      item "Открыть(сайт)", user_path(user), class: "view_link member_link"
    end
  end

  form do |f|
    f.inputs do
      f.input :nickname
      f.input :description
      f.input :role, as: :select, collection: User.roles.keys
      f.input :email
    end
    f.actions
  end

end
