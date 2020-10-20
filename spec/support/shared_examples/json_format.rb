shared_examples 'it has symmetric as_json and to_json methods' do
  describe "#{described_class}.as_json" do
    it 'should return a json representation of the object as a ruby hash' do
      obj = described_class.new(fixed_values)
      expect(obj.as_json).to eq JSON.parse(obj.to_json)
    end
  end
end
