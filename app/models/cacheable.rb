module Cacheable
  extend ActiveSupport::Concern

  module ClassMethods
    def cache
      retrieve_cache || save_cache(yield)
    end

    def retrieve_cache
      if @cache && @cache_saved_at > 3.hours.ago
        @cache
      end
    end

    def save_cache(value)
      @cache_saved_at = Time.now
      @cache = value
    end
  end
end
