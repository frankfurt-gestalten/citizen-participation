class KontaktMailer < ActionMailer::Base
  default from: APP[:default_from]

  def kontakt_form(text, username, email)
    @username = username
    @email = email
    @text = text
    mail(to: "service@frankfurt-gestalten.de", subject: "Kontakt frankfurt-gestalten")
  end
end