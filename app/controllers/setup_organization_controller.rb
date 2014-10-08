class SetupOrganizationController < ApplicationController
  include Wicked::Wizard
  steps :organization_setup

  def show
    @user = current_user
    case step
    when :organization_setup
      @organization = Organization.new
    end
    render_wizard
  end

  def update
    @user = current_user
    @organization = Organization.new organization_params
    @organization.users << @user
    render_wizard @organization
  end

  private
  def organization_params
    params.require(:organization).permit :name, :description, :plan_id,
      {user_ids: []}
  end

  def finish_wizard_path
    dashboard_path(flash[:notice] = "Thank you for signing up. You can now build
      beautiful menus")
  end
end
