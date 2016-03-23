class SurveyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        # scope.all
        scope.joins(:practice).where('practices.site_id' => user.site_id)
      end
    end
  end
end