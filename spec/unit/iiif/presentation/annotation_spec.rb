describe IIIF::Presentation::Annotation do

  let(:fixed_values) { {} }

  describe "#{described_class}.define_methods_for_abstract_resource_only_keys" do
    it_behaves_like 'it has the appropriate methods for abstract_resource_only_keys'
  end

  it_behaves_like 'it has symmetric as_json and to_json methods'
end
