describe IIIF::Presentation::Range do

  let(:fixed_values) do 
    {
      '@id' => 'http://www.example.org/iiif/book1/range/r1',
      '@type' => 'sc:Range',
      'label' => 'Introduction',
      'ranges' => [
        'http://www.example.org/iiif/book1/range/r1-1',
        'http://www.example.org/iiif/book1/range/r1-2'
      ],
      'canvases' => [
        'http://www.example.org/iiif/book1/canvas/p1',
        'http://www.example.org/iiif/book1/canvas/p2',
        'http://www.example.org/iiif/book1/canvas/p3#xywh=0,0,750,300'
      ]
    }
  end

  describe '#initialize' do
    it 'sets @type to sc:Range by default' do
      expect(subject['@type']).to eq 'sc:Range'
    end
  end

  describe "#{described_class}.define_methods_for_array_only_keys" do
    it_behaves_like 'it has the appropriate methods for array-only keys'
  end

  describe "#{described_class}.define_methods_for_string_only_keys" do
    it_behaves_like 'it has the appropriate methods for string-only keys'
  end

  describe "#{described_class}.define_methods_for_any_type_keys" do
    it_behaves_like 'it has the appropriate methods for any-type keys'
  end

  describe '#validate' do
  end

  it_behaves_like 'it has symmetric as_json and to_json methods'
end


