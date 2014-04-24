class NutzerMailer < ActionMailer::Base
  default from: APP[:default_from]

  def new_user(user)
    @user = user
    mail(to: "service@frankfurt-gestalten.de", subject: "Neuer Nutzer",
      template_path: 'devise/mailer',
      :template_name => 'new_user_mail')
  end
end