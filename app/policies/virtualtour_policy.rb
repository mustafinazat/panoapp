class VirtualtourPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def update?
    return true if  user.present? && user == virtualtour.user || user.present? && user.admin?
  end

  def edit?
    return true if  user.present? && user == virtualtour.user || user.present? && user.admin?
  end


  private

  def virtualtour
    record
  end
end