describe IIIF::Presentation::ImageResource do

  describe '#initialize' do
    it 'sets @type to dctypes:Image' do
      expect(subject['@type']).to eq 'dctypes:Image'
    end
  end

  describe "#{described_class}.int_only_keys" do
    it_behaves_like 'it has the appropriate methods for integer-only keys'
  end

  let(:fixed_values) do
    {
      "@context" => "http://iiif.io/api/presentation/2/context.json",
      "@id" => "http://www.example.org/iiif/image",
      "label" => "p. 1",
      "height" => 1000,
      "width" => 750,
    }
  end
  
  it_behaves_like 'it has symmetric as_json and to_json methods'
end
