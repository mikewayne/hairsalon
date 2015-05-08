class Stylists
  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def ==(other_stylist)
    same_name = @name.eql?(other_stylist.name)
    same_id = @id.eql?(other_stylist.id)
    same_name.&(same_id)
  end

  def save
    result = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def self.all
    stylists = []
    results = DB.exec("SELECT * FROM stylists;")
    results.each() do |result|
      name = result.fetch("name")
      id = result.fetch("id").to_i
      stylist = Stylists.new({:name => name, :id => id})
      stylists.push(stylist)
    end
    stylists
  end

  def update(attributes)
    @line = attributes.fetch(:name)
    DB.exec("UPDATE stylists SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM stylists WHERE id = #{@id};")
  end

  def self.find(stylist_id)
    result = DB.exec("SELECT * FROM stylists WHERE id = #{stylist_id};")
    name = result.first.fetch("name")
    id = result.first.fetch("id").to_i
    Stylists.new({:name => name, :id => id})
  end

end
