class Client
  attr_reader(:first_name, :last_name, :id, :stylist_id)

  define_method(:initialize) do |attributes|
    @first_name = attributes.fetch(:first_name)
    @last_name = attributes.fetch(:last_name)
    @stylist_id = attributes[:stylist_id]
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    returned_clients.each do |client|
      first_name = client.fetch("first_name")
      last_name = client.fetch("last_name")
      stylist_id = client.fetch("stylist_id")
      id = client.fetch("id").to_i()
      clients.push(Client.new({:first_name => first_name, :last_name => last_name, :stylist_id => stylist_id, :id => id}))
    end
    clients
  end

  define_method(:save) do
    client = DB.exec("INSERT INTO clients (first_name, last_name) VALUES ('#{@first_name}', '#{@last_name}') RETURNING id;")
    @id = client.first.fetch('id').to_i
  end

  define_method(:==) do |another_client|
    self.id == another_client.id
  end

  define_singleton_method(:find) do |id|
    client = DB.exec("SELECT * FROM clients WHERE id = #{id};")
    first_name = client.first.fetch("first_name")
    last_name = client.first.fetch("last_name")
    stylist_id = client.first.fetch("stylist_id")
    id = client.first.fetch("id").to_i
    Client.new({:first_name => first_name, :last_name => last_name, :stylist_id => stylist_id, :id => id})
  end

  define_method(:update) do |attributes|
    @first_name = attributes.fetch(:first_name)
    @last_name = attributes.fetch(:last_name)
    DB.exec("UPDATE clients SET first_name = '#{@first_name}', last_name = '#{@last_name}' WHERE id = #{self.id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM clients WHERE id = #{self.id()};")
  end



end
