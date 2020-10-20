describe IIIF::Presentation::Collection do

  let(:fixed_values) do 
    {
      '@context' => 'http://iiif.io/api/presentation/2/context.json',
      '@id' => 'http://example.org/iiif/collection/top',
      '@type' => 'sc:Collection',
      'label' => 'Top Level Collection for Example Organization',
      'description' => 'Description of Collection',
      'attribution' => 'Provided by Example Organization',

      'collections' => [
        { '@id' => 'http://example.org/iiif/collection/part1',
          '@type' => 'sc:Collection',
          'label' => 'Sub Collection 1'
         },
         { '@id' => 'http://example.org/iiif/collection/part2',
           '@type' => 'sc:Collection',
           'label' => 'Sub Collection 2'
          }
      ],
      'manifests' => [
        { '@id' => 'http://example.org/iiif/book1/manifest',
          '@type' => 'sc:Manifest',
          'label' =>  'Book 1'
        }
      ]
    }
  end

  describe '#initialize' do
    it 'sets @type to sc:Collection by default' do
      expect(subject['@type']).to eq 'sc:Collection'
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


