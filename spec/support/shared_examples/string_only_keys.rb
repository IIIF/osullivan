require 'set'

shared_examples 'it has the appropriate methods for string-only keys' do

  described_class.new.string_only_keys.each do |prop|

    describe "#{prop}=" do
      it "sets #{prop}" do
        ex = 'foo'
        subject.send("#{prop}=", ex)
        expect(subject[prop]).to eq ex
      end
      it 'raises an exception when attempting to set it to something other than a String' do
        expect { subject.send("#{prop}=", ['Foo']) }.to raise_error IIIF::Presentation::IllegalValueError
      end
    end

    describe "#{prop}" do
      it "gets #{prop}" do
        ex = 'bar'
        subject[prop] = ex
        expect(subject.send(prop)).to eq ex
      end
    end

  end

end

