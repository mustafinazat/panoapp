class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    return true if  user.present?
  end

  def update?
   return true if  user.present? && user == post.user || user.present? && user.admin?
  end

  def edit?
   return true if  user.present? && user == post.user || user.present? && user.admin?
  end

   private
 
    def post
      record
    end
end
