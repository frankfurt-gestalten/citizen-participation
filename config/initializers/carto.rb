if Rails.env.test?
  class FakeCartoDB
    def query(sql)
      {
        rows: []
      }
    end
  end

  module CartoDB
    Connection = FakeCartoDB.new
  end
else
  CartoDB::Init.start('host' => ENV['CARTODB_HOST'], 'api_key' => ENV['CARTODB_API_KEY'])
end