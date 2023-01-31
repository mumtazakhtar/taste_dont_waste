class MyRecipePolicy < ApplicationPolicy
  before_action :set_user

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # scope.all
      scope.where(user: user)
    end
  end

  private

  def set_user
    record.user == user
  end
end
