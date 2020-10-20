describe IIIF::Service do
  
  let(:fixed_values) { {} }

  describe 'self#get_descendant_class_by_jld_type' do
    before do
      class DummyClass < IIIF::Service
        TYPE = "sc:Collection"
        def self.singleton_class?
          true
        end
      end
    end
    after do
      Object.send(:remove_const, :DummyClass)
    end
    it 'gets the right class' do
      klass = described_class.get_descendant_class_by_jld_type('sc:Canvas')
      expect(klass).to be IIIF::Presentation::Canvas
    end
    context "when there are singleton classes which are returned" do
      it "gets the right class" do
        allow(IIIF::Service).to receive(:descendants).and_return([DummyClass, IIIF::Presentation::Collection])
        klass = described_class.get_descendant_class_by_jld_type('sc:Collection')
        expect(klass).to be IIIF::Presentation::Collection
      end
    end
  end

  it_behaves_like 'it has symmetric as_json and to_json methods'

end
