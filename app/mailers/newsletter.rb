class Newsletter < ActionMailer::Base
  default from: "noreply@pinpost.com"

  def letter user, pins
    @user = user
    @pins = pins
    mail to: @user.email, subject: "Latest Pins from Our Users"
  end
end
