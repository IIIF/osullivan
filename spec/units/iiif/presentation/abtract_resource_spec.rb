require 'active_support/inflector'
require 'json'

describe IIIF::Presentation::AbstractResource do

  let(:fixtures_dir) { File.join(File.dirname(__FILE__), '../../../fixtures') }
  let(:manifest_from_spec_path) { File.join(fixtures_dir, 'manifests/complete_from_spec.json') }
  let(:abstract_resource_subclass) do
    Class.new(IIIF::Presentation::AbstractResource) do
      include IIIF::Presentation::HashBehaviours

      def initialize(hsh={}, include_context=false)
        hsh['@type'] = 'a:SubClass' unless hsh.has_key?('@type')
        unless hsh.has_key?('@id')
          hsh['@id'] = 'http://example.com/prefix/manifest/123'
        end
        super(hsh, true)
      end

      def required_keys
        super + %w{ @id }
      end
    end
  end

  subject { abstract_resource_subclass.new }

  describe '#initialize' do
    it 'raises an error if you try to instantiate AbstractResource' do
      expect { IIIF::Presentation::AbstractResource.new }.to raise_error(RuntimeError)
    end
    it 'sets @type' do
      expect(subject['@type']).to eq 'a:SubClass'
    end
    it 'can take any old hash' do
      hsh = JSON.parse(IO.read(manifest_from_spec_path))
      new_instance = abstract_resource_subclass.new(hsh)
      expect(new_instance['label']).to eq 'Book 1'
    end
  end

  describe 'self.parse' do
    it 'works from a file' do
      abs_obj = abstract_resource_subclass.parse(manifest_from_spec_path)
      expect(abs_obj['label']).to eq 'Book 1'
    end
    it 'works from a string of JSON' do
      file = File.open(manifest_from_spec_path, 'rb')
      json_string = file.read
      file.close
      abs_obj = abstract_resource_subclass.parse(json_string)
      expect(abs_obj['label']).to eq 'Book 1'
    end
    describe 'works from a hash' do
      it 'plain old' do
        h = JSON.parse(IO.read(manifest_from_spec_path))
        abs_obj = abstract_resource_subclass.parse(h)
        expect(abs_obj['label']).to eq 'Book 1'
      end
      it 'ActiveSupport::OrderedHash' do
        h = JSON.parse(IO.read(manifest_from_spec_path))
        oh = ActiveSupport::OrderedHash[h]
        abs_obj = abstract_resource_subclass.parse(oh)
        expect(abs_obj['label']).to eq 'Book 1'
      end
    end
    it 'turns camels to snakes' do
      abs_obj = abstract_resource_subclass.parse(manifest_from_spec_path)
      expect(abs_obj.keys.include?('see_also')).to be_truthy
      expect(abs_obj.keys.include?('seeAlso')).to be_falsey
    end
  end

  describe 'A nested object (e.g. self[\'metdata\'])' do
    it 'returns [] if not set' do
      expect(subject.metadata).to eq([])
    end
    it 'is not in #to_ordered_hash at all if we access it but do not append to it' do
      subject.metadata # touch it
      expect(subject.metadata).to eq([])
      expect(subject.to_ordered_hash.has_key?('metadata')).to be_falsey
    end
    it 'gets structured as we\'d expect' do
      subject.metadata << {
        'label' => 'Author',
        'value' => 'Anne Author'
      }
      subject.metadata << {
        'label' => 'Published',
        'value' => [
          {'@value'=> 'Paris, circa 1400', '@language'=>'en'},
          {'@value'=> 'Paris, environ 14eme siecle', '@language'=>'fr'}
        ]
      }
      expect(subject.metadata[0]['label']).to eq('Author')
      expect(subject.metadata[1]['value'].length).to eq(2)
      expect(subject.metadata[1]['value'].select { |e| e['@language'] == 'fr'}.last['@value']).to eq('Paris, environ 14eme siecle')
    end
    it 'roundtrips' do
      subject.metadata << {
        'label' => 'Author',
        'value' => 'Anne Author'
      }
      subject.metadata << {
        'label' => 'Published',
        'value' => [
          {'@value'=> 'Paris, circa 1400', '@language'=>'en'},
          {'@value'=> 'Paris, environ 14eme siecle', '@language'=>'fr'}
        ]
      }
      File.open('/tmp/osullivan-spec.json','w') do |f|
        f.write(subject.to_json)
      end
      parsed = subject.class.parse('/tmp/osullivan-spec.json')
      expect(parsed.metadata[0]['label']).to eq('Author')
      expect(parsed.metadata[1]['value'].length).to eq(2)
      expect(parsed.metadata[1]['value'].select { |e| e['@language'] == 'fr'}.last['@value']).to eq('Paris, environ 14eme siecle')
      expect(parsed['metadata'][0]['label']).to eq('Author')
      expect(parsed['metadata'][1]['value'].length).to eq(2)
      expect(parsed['metadata'][1]['value'].select { |e| e['@language'] == 'fr'}.last['@value']).to eq('Paris, environ 14eme siecle')
      File.delete('/tmp/osullivan-spec.json')
    end
  end

  describe '#required_keys' do
    it 'accumulates' do
      expect(subject.required_keys).to eq %w{ @type @id }
    end
  end

  describe '#to_ordered_hash' do
    it 'converts snake_case keys to camelCase' do
      subject['see_also'] = @uri
      subject['within'] = @within_uri
      ordered_hash = subject.to_ordered_hash
      expect(ordered_hash.keys.include?('seeAlso')).to be_truthy
    end
  end


end

