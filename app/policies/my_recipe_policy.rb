class MyRecipePolicy < ApplicationPolicy

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # This makes sure the user only sees their own recipes, not all my recipes
      scope.where(user: user)
    end
  end

  def index?
    record.user == user
  end

  def show?
    record.user == user
  end

  def create?
    record.user == user
  end

  def update?
    record.user == user
  end

  def destroy
    record.user == user
  end

end
