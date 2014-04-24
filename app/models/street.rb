Street = Struct.new(:id, :name, :latitude, :longitude) do
  def coordinates
    "#{latitude}, #{longitude}"
  end
end
