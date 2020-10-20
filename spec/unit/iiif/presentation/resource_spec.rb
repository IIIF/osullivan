describe IIIF::Presentation::Resource do

  let(:fixed_values) do 
    {
      '@id' => 'http://www.example.org/iiif/book1/resource',
      # '@type' => 'sc:Range',
      'label' => 'Introduction'
    }
  end

  describe "#{described_class}.define_methods_for_abstract_resource_only_keys" do
    it_behaves_like 'it has the appropriate methods for abstract_resource_only_keys'
  end

  describe "#{described_class}.int_only_keys" do
    it_behaves_like 'it has the appropriate methods for integer-only keys'
  end

  describe "#{described_class}.define_methods_for_string_only_keys" do
    it_behaves_like 'it has the appropriate methods for string-only keys'
  end

  it_behaves_like 'it has symmetric as_json and to_json methods'
end

