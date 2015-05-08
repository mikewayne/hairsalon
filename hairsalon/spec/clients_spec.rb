require("spec_helper")

describe(Clients) do
  describe("#==") do
    it("returns true for objects that have same name and id") do
      client1 = Clients.new({:name => 'Stephan', :id => nil})
      client2 = Clients.new({:name => 'Stephan', :id => nil})
      expect(client1.==(client2)).to(eq(true))
    end
  end

describe("#save") do
  it("adds a client to the clients table") do
    client1 = Clients.new({:name => 'Stephan', :id => nil})
    client1.save()
    expect(Clients.all()).to(eq([client1]))
  end
end

describe(".find") do
  it("returns a client with the given id") do
    client1 = Clients.new({:name => 'Hayden', :id => nil})
    client1.save()
    expect(Clients.find(client1.id)).to(eq(client1))
  end
end

describe("#delete") do
  it("deletes a client from the clients table") do
        client1 = Clients.new({:name => 'Hayden', :id => nil})
        client1.save()
        client2 = Clients.new({:name => 'Karin', :id => nil})
        client2.save()
        client1.delete()
        expect(Clients.all()).to(eq([client2]))
  end
end

end
