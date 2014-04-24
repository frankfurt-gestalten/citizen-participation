task :update_search_subscriptions => :environment do
  SearchSubscription.notify
end