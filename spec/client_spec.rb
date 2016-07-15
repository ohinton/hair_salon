require ('spec_helper')

describe(Client) do
  describe("#first_name") do
    it("returns the client's first name") do
      test_client = Client.new({:first_name => "Olivia", :last_name => "Hinton", :stylist_id => nil, :id => nil})
      expect(test_client.first_name()).to(eq("Olivia"))
    end
  end

  describe("#last_name") do
    it("returns the client's last name") do
      test_client = Client.new({:first_name => "Olivia", :last_name => "Hinton", :stylist_id => nil, :id => nil})
      expect(test_client.last_name()).to(eq("Hinton"))
    end
  end

  describe(".all") do
    it('will return an empty array at first') do
      expect(Client.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("will save the client's info") do
      test_client = Client.new({:first_name => "Olivia", :last_name => "Hinton", :stylist_id => 1, :id => nil})
      test_client.save
      expect(Client.all()).to(eq([test_client]))
    end
  end

  describe(".find") do
    it("returns a client based on its id") do
      client1 = Client.new({:first_name => "Olivia", :last_name => "Hinton", :stylist_id => 1, :id => nil})
      client2 = Client.new({:first_name => "Ally", :last_name => "Layton", :stylist_id => 2, :id => nil})
      client1.save
      client2.save
      expect(Client.find(client1.id)).to(eq(client1))
    end
  end

  describe("#update") do
    it("updates a client's info") do
      client = Client.new({:first_name => "Test", :last_name => "Test", :stylist_id => 1, :id => nil})
      client.save
      client.update({:first_name => "New", :last_name => "Test", :stylist_id => 1})
      expect(client.first_name()).to(eq("New"))
    end
  end

  describe("#delete") do
    it("deletes a client from the database") do
      client1 = Client.new({:first_name => "Olivia", :last_name => "Hinton", :stylist_id => 1, :id => nil})
      client2 = Client.new({:first_name => "Ally", :last_name => "Layton", :stylist_id => 1, :id => nil})
      client1.save
      client2.save
      client1.delete
      expect(Client.all()).to(eq([client2]))
    end
  end

end
