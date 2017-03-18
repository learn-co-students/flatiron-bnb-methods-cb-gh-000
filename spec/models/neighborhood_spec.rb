describe Neighborhood do
  describe 'associations' do
    it 'has a name' do
      expect(@nabe3.name).to eq('Brighton Beach')
    end

    it 'belongs to a city' do
      expect(@nabe3.city.name).to eq('NYC')
    end

    it 'has many listings' do
      expect(@nabe3.listings).to include(@listing3)
    end
  end

  describe 'class methods' do
    describe ".most_res" do
      it 'knows the neighborhood with the most reservations' do
        expect(Neighborhood.most_res).to eq(@nabe1)
      end
      it "doesn't hardcode the neighborhood with the most reservations" do
        make_denver
        expect(Neighborhood.most_res).to eq(Neighborhood.find_by(:name => "Lakewood"))
      end
    end
  end
end
