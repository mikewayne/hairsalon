class Clients
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def ==(other_client)
    same_name = @name.eql?(other_client.name)
    same_id = @id.eql?(other_client.id)
    same_name.&(same_id)
  end

  def save
    result = DB.exec("INSERT INTO clients (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def self.find(client_id)
    result = DB.exec("SELECT * FROM clients WHERE id = #{client_id};")
    name = result.first.fetch("name")
    id = result.first.fetch("id").to_i
    Clients.new({:name => name, :id => id})
  end

  def update(attributes)
    @name = attributes.fetch(:name)
    DB.exec("UPDATE clients SET name = '#{@name}' WHERE id = #{@id};")
  end

  def self.all
    clients = []
    results = DB.exec("SELECT * FROM clients;")
    results.each() do |result|
      name = result.fetch("name")
      id = result.fetch("id").to_i
      client = Clients.new({:name => name, :id => id})
      clients.push(client)
  end
  clients
  end

  def delete
    DB.exec("DELETE FROM clients WHERE id = #{@id};")
  end

end
