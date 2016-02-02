class ApplicationPolicy
  attr_reader :user, :record, :showing_public

  def initialize(user, record)
    @user = user
    @record = record
    @showing_public = showing_public
  end

  def index?
    true
  end

  def show?
    #scope.where(:id => record.id).exists?
    user_owns_record_or_admin?
  end

  def create?
    user_owns_record_or_admin?
  end

  def new?
    true
  end

  def update?
    user_owns_record_or_admin?
  end

  def edit?
    user_owns_record_or_admin?
  end

  def destroy?
    user_owns_record_or_admin?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end


  private

  def user_logged_in?

    if user == nil
      false
    else
      true
    end
  end

  def user_owns_record_or_admin?

    if record.user_id == user.id or user.admin?
      true
    else
      false
    end

  end


end
