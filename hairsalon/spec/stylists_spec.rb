require "spec_helper"

describe(Stylists) do
  describe("#==") do
    it("returns true for stylists who have same name and id") do
      stylist1 = Stylists.new({:name => 'Trinie', :id => nil})
      stylist2 = Stylists.new({:name => 'Trinie', :id => nil})
      expect(stylist1.==(stylist2)).to(eq(true))
    end
  end

  describe("#save") do
    it("add new stylist to Stylists table") do
      stylist1 = Stylists.new({:name => 'Trinie', :id => nil})
      stylist1.save()
      expect(Stylists.all()).to(eq([stylist1]))
    end
  end

  describe(".find") do
    it("returns a stylist with the given id") do
      stylist1 = Stylists.new({:name => 'Trinie', :id => nil})
      stylist1.save()
      expect(Stylists.find(stylist1.id)).to(eq(stylist1))
    end
  end

  describe("#delete") do
    it("deletes a stylist from the Stylists table") do
      stylist1 = Stylists.new({:name => 'Trinie', :id => nil})
      stylist1.save()
      stylist2 = Stylists.new({:name => 'Jessica', :id => nil})
      stylist2.save()
      stylist1.delete()
      expect(Stylists.all()).to(eq([stylist2]))
    end

    it("deletes all the stylists") do
      stylist1 = Stylists.new({:name => 'Trinie', :id => nil})
      stylist1.save()
      stylist2 = Stylists.new({:name => 'Jessica', :id => nil})
      stylist2.save()
      stylist1.delete()
      stylist2.delete()
      expect(Stylists.all()).to(eq([]))
    end
  end

  describe("#update") do
    it("updates or allows edit to the stylist's name") do
      stylist1 = Stylists.new({:name => 'Trinie', :id => nil})
      stylist1.save()
      stylist1.update({:name => 'Trinie Jr'})
      stylist1.save()
      expect(stylist1.name()).to(eq('Trinie Jr'))
    end

    it("updates the stylist in the database") do
      stylist1 = Stylists.new({:name => 'Trinie', :id => nil})
      stylist1.save()
      stylist1.update({:name => 'Trinie Jr'})
      updated_stylist1 = Stylists.find(stylist1.id)
      expect(updated_stylist1.name).to(eq('Trinie Jr'))
    end
  end

end
