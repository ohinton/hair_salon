require ("spec_helper")

describe(Stylist) do
  describe("#first_name") do
    it("returns the stylist's first name") do
      test_stylist = Stylist.new({:first_name => "Paul", :last_name => "Mitchell", :id => nil})
      expect(test_stylist.first_name()).to(eq("Paul"))
    end
  end

  describe("#last_name") do
    it("returns the stylist's last name") do
      test_stylist = Stylist.new({:first_name => "Paul", :last_name => "Mitchell", :id => nil})
      expect(test_stylist.last_name()).to(eq("Mitchell"))
    end
  end

  describe(".all") do
    it('will return an empty array at first') do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("will save the stylist's info") do
      test_stylist = Stylist.new({:first_name => "Paul", :last_name => "Mitchell", :id => nil})
      test_stylist.save
      expect(Stylist.all()).to(eq([test_stylist]))
    end
  end

  describe(".find") do
    it("returns a stylist based on its id") do
      stylist1 = Stylist.new({:first_name => "Paul", :last_name => "Mitchell", :id => nil})
      stylist2 = Stylist.new({:first_name => "John", :last_name => "Frieda", :id => nil})
      stylist1.save
      stylist2.save
      expect(Stylist.find(stylist1.id)).to(eq(stylist1))
    end
  end

  describe("#update") do
    it("updates a stylist's info") do
      stylist = Stylist.new({:first_name => "Test", :last_name => "Test", :id => nil})
      stylist.save
      stylist.update({:first_name => "New", :last_name => "Test"})
      expect(stylist.first_name()).to(eq("New"))
    end
  end

  describe("#delete") do
    it("deletes a stylist from the database") do
      stylist1 = Stylist.new({:first_name => "Paul", :last_name => "Mitchell", :id => nil})
      stylist2 = Stylist.new({:first_name => "John", :last_name => "Frieda", :id => nil})
      stylist1.save
      stylist2.save
      stylist1.delete
      expect(Stylist.all()).to(eq([stylist2]))
    end
  end

end
