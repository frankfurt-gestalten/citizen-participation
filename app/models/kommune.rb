class Kommune
  include Cacheable

  attr_accessor :id, :name, :latitude, :longitude

  def initialize(id, name, latitude, longitude)
    @id = id
    @name = name
    @latitude = latitude
    @longitude = longitude
  end

  def quarters
    Quarter.all.select { |q| q.kommune == name }
  end

  def self.find(id)
    id = id.to_i
    all.find { |kommune| kommune.id == id }
  end

  def self.all
    cache do
      fetch_kommunen
    end
  end

  def self.fetch_kommunen
    result = CartoDB::Connection.query(
      "SELECT cartodb_id, latitude, longitude, name FROM aachen_kommune " +
      "ORDER BY name ASC"
    )
    result[:rows].map do |row|
      Kommune.new(row[:cartodb_id], row[:name], row[:latitude], row[:longitude])
    end
  end
end
