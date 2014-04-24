class UserRegistrationsController < Devise::RegistrationsController

  def edit
    @subscriptions = SearchSubscription.where(email: current_user.email)
    @subscriptions_iniatives = Subscription.where(user_id: current_user.id)
    quarter_ids = current_user.quarter_subscriptions.pluck(:quarter_id)
    if quarter_ids.present?
      @quarter_subscriptions = Quarter.fetch_quarters_with_ids(quarter_ids)
    else
      @quarter_subscriptions = []
    end
  end

  private

  def after_sign_up_path_for(resource)
    NutzerMailer.new_user(current_user).deliver
    # gb = Gibbon::API.new(ENV['MAILCHIMP'])
    # gb.lists.subscribe({:id => 'fc4198bf0b', :email => {:email => current_user.email}, :merge_vars => {:LNAME => current_user.username}, :double_optin => false})
    edit_user_registration_path
  end

  def after_inactive_sign_up_path_for(resource)
    edit_user_registration_path
  end

  def after_update_path_for(resource)
    profile_path(resource)
  end
end
