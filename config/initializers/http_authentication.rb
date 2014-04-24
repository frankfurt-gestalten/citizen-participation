if ENV['HTTP_AUTHENTICATION'] == 'true'
  AachenGestalten::Application.configure do
    config.middleware.insert_after(::Rack::Lock, "::Rack::Auth::Basic", "Developing") do |u, p|
      [u, p] == ['frankfurt', ENV['HTTP_AUTHENTICATION_PASSWORD']]
    end
  end
end