crumb :root do
  link "Главная", root_path
end

 crumb :posts do
   link "Посты", posts_path
 end

crumb :about do
  link "О сервисе", '/about'
end

crumb :tags do
  link "Теги", tags_path
end

crumb :tag do |tag|
  link "#"+tag.name, tag_path
end

crumb :faq do
  link "FAQ", faqs_path
end

crumb :sign_in do
  link "Войти", new_user_session_path
end

crumb :sign_up do
  link "Регистрация", new_user_registration_path
end

crumb :new_password do
  link "Забыли пароль?",  new_user_password_path
end

crumb :edit_password do
  link "Изменить пароль",  edit_user_password_path
end

crumb :new_confirmation do
  link "Не получили подтверждения?", new_user_confirmation_path
end

crumb :user do |user|
  link user.nickname, user_path
end

crumb :useredit do
  link "Редактирование профиля "+ resource.nickname, edit_user_registration_path

end


 crumb :post do |post|
   link post.title, post_path
   parent :posts
 end


  crumb :postedit do |post|
   link "Редактирование", edit_post_path
   parent :post , post
 end

  crumb :postnew do |post|
   link "Создать", new_post_path
   parent :posts, post
 end


  crumb :virtualtours do
   link "Виртуальные туры", virtualtours_path
 end

 crumb :virtualtour do |virtualtour|
   link virtualtour.title, virtualtour_path
   parent :virtualtours
 end


  crumb :virtualtouredit do |virtualtour|
   link "Редактирование", edit_virtualtour_path
   parent :virtualtour , virtualtour
 end

  crumb :virtualtournew do |virtualtour|
   link "Создать", new_virtualtour_path
   parent :virtualtours, virtualtour
 end


   crumb :articles do
   link "Статьи", articles_path
   end



 crumb :article do |article|
   link article.title, article_path
   parent :articles
 end


  crumb :articleedit do |article|
   link "Редактирование", edit_article_path
   parent :article , article
 end

  crumb :articlenew do |article|
   link "Создать", new_article_path
   parent :articles, article
  end



# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).