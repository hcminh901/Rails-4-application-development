class DashboardController < ApplicationController
  before_action :load_subdomain

  def show
    @user.organizations.each do |o|
      @organization_name = o.name
    end
  end

  private
  def not_found
    raise ActionController::RoutingError.new "User Not Found"
  end

  def load_subdomain
    @user = User.where(domain_name: request.subdomain).first || not_found
  end
end
