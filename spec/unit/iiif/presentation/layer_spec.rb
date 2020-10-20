describe IIIF::Presentation::Layer do

  let(:fixed_values) do
    {
      '@context' => 'http://iiif.io/api/presentation/2/context.json',
      '@id' => 'http://www.example.org/iiif/book1/layer/transcription',
      '@type' => 'sc:Layer',
      'label' => 'Diplomatic Transcription',
      'otherContent' => [
        'http://www.example.org/iiif/book1/list/l1',
        'http://www.example.org/iiif/book1/list/l2',
        'http://www.example.org/iiif/book1/list/l3',
        'http://www.example.org/iiif/book1/list/l4'
      ]
    }
  end


  describe '#initialize' do
    it 'sets @type' do
      expect(subject['@type']).to eq 'sc:Layer'
    end
  end

  describe "#{described_class}.define_methods_for_string_only_keys" do
    it_behaves_like 'it has the appropriate methods for string-only keys'
  end
  
  describe "#{described_class}.define_methods_for_array_only_keys" do
    it_behaves_like 'it has the appropriate methods for array-only keys'
  end

  describe "#{described_class}.define_methods_for_any_type_keys" do
    it_behaves_like 'it has the appropriate methods for any-type keys'
  end

  it_behaves_like 'it has symmetric as_json and to_json methods'

end

