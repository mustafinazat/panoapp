class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def update?
   return true if  user.present? && user == post.user
  end

  def edit?
   return true if  user.present? && user == post.user
  end


   private
 
    def post
      record
    end
end
