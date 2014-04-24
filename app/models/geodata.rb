module Geodata
  def self.included(model)
    model.scope :within_quarter, ->(quarter_id) do
      ids = Geodata.type_ids(model.model_name.element, quarter_id)
      model.scoped.where(id: ids)
    end

    model.after_commit :synchronize_geodata
    model.after_destroy :destroy_geodata
  end

  def self.where(conditions)
    result = db.query("SELECT * FROM #{table_name} WHERE #{conditions}")

    result[:rows].map do |row|
      GeodataModel.new(id: row[:cartodb_id], type_id: row[:type_id], title: row[:title], geom: row[:the_geom])
    end
  end

  def self.type_ids(type, quarter_id)
    result = db.query("SELECT #{table_name}.type_id FROM #{table_name}, frankfurt_stadtteile WHERE #{table_name}.type = '#{type}' AND
      st_intersects(#{table_name}.the_geom,frankfurt_stadtteile.the_geom) AND frankfurt_stadtteile.cartodb_id = #{quarter_id} ORDER BY name")
    result[:rows].map { |h| h[:type_id] }
  end

  def self.db
    CartoDB::Connection
  end

  def self.table_name
    if Rails.env.development?
      'frankfurt_docs_dev'
    else
      'frankfurt_docs'
    end
  end

  def self.find(id)
    attributes = db.row(table_name, id)
    GeodataModel.new(id: id, type_id: attributes[:type_id], title: attributes[:title], geom: attributes[:the_geom])
  end

  def self.insert(attributes)
    result = db.insert_row(table_name, attributes)
    result[:id]
  end

  def self.update(id, attributes)
    db.update_row(table_name, id, attributes)
  end

  def self.destroy(id)
    db.delete_row(table_name, id)
  end

  def synchronize_geodata
    if geodata_id
      if previous_changes.include?('title') || previous_changes.include?('long') || previous_changes.include?('lat')
        geodata.update!(title, long, lat)
      end
    else
      @geodata = GeodataModel.create!(self.class.model_name.element, id, title, long, lat)
      update_column(:geodata_id, @geodata.id)
    end
  end

  def destroy_geodata
    if geodata_id
      Geodata.destroy(geodata_id)
    end
  end

  def geodata
    @geodata ||= Geodata.find(geodata_id) if geodata_id
  end

  def self.coords_to_geom(long, lat)
    RGeo::Geographic.spherical_factory(srid: 4326).point(long, lat)
  end

  class GeodataModel
    attr_accessor :id, :title, :geom, :type_id

    def initialize(attributes)
      @id = attributes[:id]
      @type = attributes[:type]
      @type_id = attributes[:type_id]
      @title = attributes[:title]
      @geom = attributes[:geom] || Geodata.coords_to_geom(attributes[:long], attributes[:lat])
    end

    def as_json(options={})
      {
        'id' => id,
        'type' => @type,
        'type_id' => type_id,
        'title' => title,
        'long' => @geom.longitude,
        'lat' => @geom.latitude
      }
    end

    def self.create!(type, type_id, title, *geom)
      if geom.size > 1
        geom = Geodata.coords_to_geom(*geom)
      else
        geom = geom.first
      end

      new_id = Geodata.insert(type: type, type_id: type_id, title: title, the_geom: geom)
      new(id: new_id, tittle: title, geom: geom, type_id: type_id)
    end

    def update!(title, *geom)
      if geom.size > 1
        geom = Geodata.coords_to_geom(*geom)
      else
        geom = geom.first
      end

      Geodata.update(id, title: title, the_geom: geom)
    end
  end
end
