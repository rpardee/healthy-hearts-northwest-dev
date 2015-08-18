class PartnerPolicy < ApplicationPolicy
	class Scope < Scope
		def resolve
			if user.admin?
				scope.all
			else
				scope.where(:site_id => user.site_id)
			end
		end
	end

	def index?
    user.admin?
  end

  def show?
    user.admin? or user == @user
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    return false if user == @user
    user.admin?
  end
end