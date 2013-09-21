require 'spec_helper'

describe Author do

    before  do
        @author = Author.new(name: "Jade Moreira da Costa")
    end

    subject { @author }

    it { should respond_to(:name) }
    it { should respond_to(:input) }

    it { should be_valid }

    describe "accessible attributes" do
        it "should not allow access to input id" do
            expect do
                Author.new(input_id: 1)
            end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
        end
    end

    describe "when name is not present" do
        before { @author.name = '' }
        it { should_not be_valid }
    end
end
