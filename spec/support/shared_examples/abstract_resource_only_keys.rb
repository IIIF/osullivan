require 'set'

shared_examples 'it has the appropriate methods for abstract_resource_only_keys' do

  described_class.new.abstract_resource_only_keys.each do |entry|

    describe "#{entry[:key]}=" do
      it "sets #{entry[:key]}" do
        @ex = entry[:type].new
        subject.send("#{entry[:key]}=", @ex)
        expect(subject[entry[:key]]).to eq @ex
      end
      if entry[:key].camelize(:lower) != entry[:key]
        it "is aliased as ##{entry[:key].camelize(:lower)}=" do
          @ex = entry[:type].new
          subject.send("#{entry[:key].camelize(:lower)}=", @ex)
          expect(subject[entry[:key]]).to eq @ex
        end
      end
      it "raises an exception when attempting to set it to something other than an #{entry[:type]}" do
        e = IIIF::Presentation::IllegalValueError
        expect { subject.send("#{entry[:key]}=", 'Foo') }.to raise_error e
      end
    end

    describe "#{entry[:key]}" do
      it "gets #{entry[:key]}" do
        @ex = entry[:type].new
        subject[entry[:key]] = @ex
        expect(subject.send(entry[:key])).to eq @ex
      end
      if entry[:key].camelize(:lower) != entry[:key]
        it "is aliased as ##{entry[:key].camelize(:lower)}" do
          @ex = entry[:type].new
          subject[entry[:key]] = @ex
          expect(subject.send("#{entry[:key].camelize(:lower)}")).to eq @ex
        end
      end
    end

  end

end
