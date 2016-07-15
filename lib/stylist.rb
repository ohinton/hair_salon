class Stylist
  attr_reader(:first_name, :last_name, :id)

  define_method(:initialize) do |attributes|
    @first_name = attributes.fetch(:first_name)
    @last_name = attributes.fetch(:last_name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    stylists = []
    returned_stylists.each do |stylist|
      first_name = stylist.fetch("first_name")
      last_name = stylist.fetch("last_name")
      id = stylist.fetch("id").to_i()
      stylists.push(Stylist.new({:first_name => first_name, :last_name => last_name, :id => id}))
    end
    stylists
  end

  define_method(:save) do
    stylist = DB.exec("INSERT INTO stylists (first_name, last_name) VALUES ('#{@first_name}', '#{@last_name}') RETURNING id;")
    @id = stylist.first.fetch('id').to_i
  end

  define_method(:==) do |another_stylist|
    self.id == another_stylist.id
  end

  define_singleton_method(:find) do |id|
    stylist = DB.exec("SELECT * FROM stylists WHERE id = #{id};")
    first_name = stylist.first.fetch("first_name")
    last_name = stylist.first.fetch("last_name")
    id = stylist.first.fetch("id").to_i
    Stylist.new({:first_name => first_name, :last_name => last_name, :id => id})
  end

  define_method(:update) do |attributes|
    @first_name = attributes.fetch(:first_name, @first_name)
    @last_name = attributes.fetch(:last_name, @last_name)
    DB.exec("UPDATE stylists SET first_name = '#{@first_name}', last_name = '#{@last_name}' WHERE id = #{self.id()};")

    attributes.fetch(:client_ids, []).each() do |client_id|
      DB.exec("INSERT INTO clients (stylist_id) VALUES (#{stylist_id});")
    end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stylists WHERE id = #{self.id()};")
  end

  define_method(:clients) do
    stylist_clients = []
    clients = DB.exec("SELECT * FROM clients WHERE stylist_id = #{self.id()};")
    clients.each() do |client|
      first_name = client.fetch("first_name")
      last_name = client.fetch("last_name")
      stylist_id = client.fetch("stylist_id").to_i()
      id = client.fetch("id").to_i()
      stylist_clients.push(Client.new({:first_name => first_name, :last_name => last_name, :stylist_id => stylist_id, :id => id}))
    end
    stylist_clients
  end


end
