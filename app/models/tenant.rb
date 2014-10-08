class Tenant
  ROLES = [:admin, :owner]
  def initialize user
    @user = user
  end

  def restaurants
    if admin?
      Restaurant.all
    else
      Restaurant.where "organization_id = ?", @user.organizations.first.id
    end
  end

  private
  ROLES.each do |role|
    define_method("#{role}?"){@user.has_role? "{a}"}
  end
end