class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def update?
    return true if  user.present? && user == article.user || user.present? && user.admin?
  end

  def edit?
    return true if  user.present? && user == article.user || user.present? && user.admin?
  end


  private

  def article
    record
  end
end