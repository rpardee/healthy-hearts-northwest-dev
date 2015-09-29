class EventPolicy < ApplicationPolicy
	class Scope < Scope
		def resolve
			if user.admin?
				scope.all
			else
				scope.all
				# scope.joins(:partners).where('partners.site_id' => user.site_id)
			end
		end
	end
end