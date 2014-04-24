if Rails.env.production?
  FlyingSphinx::API.send :remove_const, :SERVER
  FlyingSphinx::API::SERVER = Kernel.URI 'https://flying-sphinx.com'
end