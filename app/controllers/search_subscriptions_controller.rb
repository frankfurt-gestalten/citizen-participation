class SearchSubscriptionsController < ApplicationController
  def new
    @subscription = SearchSubscription.new(query: params[:query])
  end

  def create
    subscription = SearchSubscription.build_for(params[:search_subscription], current_user)
    subscription.save!

    if subscription.confirmation_token
      SubscriptionMailer.confirmation(subscription).deliver
    end
    if current_user
      redirect_to search_subscriptions_url, notice: "Du hast nun ein Abo für den Begriff #{subscription.query}"
    else
      redirect_to root_url, notice: "Du bekommst in Kürze eine E-Mail zur Bestätigung deines Abos"
    end
  end

  def index
    @subscriptions = SearchSubscription.where(email: current_user.email)
    @subscriptions_iniatives = Subscription.where(user_id: current_user.id)
  end

  def confirm
    @subscription = SearchSubscription.where(confirmation_token: params[:id]).first!
    @subscription.confirm!
  end
  def destroy
    @subscription = SearchSubscription.find(params[:id])
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to search_subscriptions_url, notice: 'Abo erfolgreich gelöscht.' }
      format.json { head :no_content }
      format.js { render }
    end
  end
end
