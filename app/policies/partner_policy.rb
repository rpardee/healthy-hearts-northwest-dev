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
end