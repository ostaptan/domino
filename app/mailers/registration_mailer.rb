class RegistrationMailer < ActionMailer::Base
  default from: "dominotron@support.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def account_activation(user)
    @user = user
    mail :to => user.email, :subject => t('user_mailer.account_activation.subject')
  end
end