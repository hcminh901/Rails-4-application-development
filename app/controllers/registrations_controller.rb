class RegistrationsController < Devise::RegistrationsController
  protected
  def after_sign_up_path_for resource
    session[:plan_id] = params[:plan_id]
    setup_organization_path :organization_setup
  end
end