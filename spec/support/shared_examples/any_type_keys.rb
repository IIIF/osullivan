require 'set'

shared_examples 'it has the appropriate methods for any-type keys' do

  described_class.new.any_type_keys.each do |prop|
    describe "##{prop}=" do
      it "sets self['#{prop}']" do
        subject.send("#{prop}=", fixed_values[prop])
        expect(subject[prop]).to eq fixed_values[prop]
      end
      if prop.camelize(:lower) != prop
        it "is aliased as ##{prop.camelize(:lower)}=" do
          subject.send("#{prop.camelize(:lower)}=", fixed_values[prop])
          expect(subject[prop]).to eq fixed_values[prop]
        end
      end
    end

    describe "##{prop}" do
      it "gets self[#{prop}]" do
        subject.send("[]=", prop, fixed_values[prop])
        expect(subject.send("#{prop}")).to eq fixed_values[prop]
      end
      if prop.camelize(:lower) != prop
        it "is aliased as ##{prop.camelize(:lower)}" do
          subject.send("[]=", prop, fixed_values[prop])
          expect(subject.send("#{prop.camelize(:lower)}")).to eq fixed_values[prop]
        end
      end
    end
  end

end
