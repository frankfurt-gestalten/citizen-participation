class InitiativenMailer < ActionMailer::Base
   default from: APP[:default_from]

  def new_comment_moderator(comment)
    @initiative = comment.commentable
    @comment = comment
    @comment_author = comment.user.try(:username) || comment.user_name
    mail(:to => "service@frankfurt-gestalten.de",
        :subject => "[#{APP[:name]}] Neuer Kommentar zur Initiative " + @initiative.title,
        :template_name => 'new_comment_mail')
  end

  def new_comment_email(comment, subscription)
    @initiative = subscription.subscribable
    @subscriber = subscription.user
    @comment = comment
    @comment_author = comment.user.try(:username) || comment.user_name
    mail(:to => @subscriber.email,
        :subject => "[#{APP[:name]}] Neuer Kommentar zur Initiative " + @initiative.title,
        :template_name => 'new_comment_mail')
  end

  def new_supporter(initiative, supporter)
    @initiative = initiative
    @supporter = supporter
    mail(:to => initiative.user.email, :subject => "[#{APP[:name]}] Neuer Unterstützer für #{initiative.title}", :template_name => 'new_supporter')
  end

  def new_initiative(initiative)
    @initiative = initiative
    mail(:to => "service@frankfurt-gestalten.de", :subject => "Neue Initiative #{initiative.title}", :template_name => 'new_initiative')
  end

  def initiator_email(sender, initiative, text)
    @author = initiative.user
    @message = text
    @initiative = initiative
    @anfrager = sender
    mail(:to => @author.email, :subject => "[#{APP[:name]}] Nachricht zu Deiner Initiative", :template_name => 'initiator_email')
  end

  def initiator_moderator_email(sender, moderator, initiative, text)
    @moderator = moderator
    @message = text
    @initiative = initiative
    @anfrager = sender
    mail(:to => moderator.email, :subject => "[#{APP[:name]}] Nachricht von einem Initiator", :template_name => 'moderator_email')
  end

  def initiator_reminder(initiative)
    @initiative = initiative
    mail(:to => initiative.user.email, :subject => "[#{APP[:name]}]" + initiative.title, :template_name => 'initiator_reminder')
  end
 end
