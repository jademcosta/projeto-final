require 'spec_helper'

describe Orientation do

    before do
        @orientation = Orientation.new(status: Orientation::STATUS_VALUES[0], student: "Jade Moreira da Costa", subtype: Orientation::SUBTYPE_VALUES[0])
    end
    
    let(:user) { FactoryGirl.create(:user) } 
    subject { @orientation }

    it { should respond_to(:type) }
    it { should respond_to(:status) }
    it { should respond_to(:date) }
    it { should respond_to(:end_date) }
    it { should respond_to(:subtype) }
    it { should respond_to(:institution) }
    it { should respond_to(:student) }
    it { should respond_to(:title) }
    it { should respond_to(:text) }
    it { should respond_to(:user_id) }

    it { should be_valid }

    describe "accessible attributes" do
		it "should not allow access to user id" do
			expect do
				Orientation.new(user_id: user.id)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

    describe "when status is not on of the allowed strings" do
        before { @orientation.status = ' ' }
        it { should_not be_valid }
    end
    
    describe "when subtype is not on of the allowed strings" do
        before { @orientation.subtype = ' ' }
        it { should_not be_valid }
    end

    describe "when the student name is not present" do
         before { @orientation.student = ' ' }
        it { should_not be_valid }
    end

    describe "when status is valid" do
        it "should be valid" do
            Orientation::STATUS_VALUES.each do |valid_status|
                @orientation.status = valid_status
                @orientation.should be_valid
            end
        end
    end

    describe "when subtype is valid" do
        it "should be valid" do
            Orientation::SUBTYPE_VALUES.each do |valid_subtype|
                @orientation.subtype = valid_subtype
                @orientation.should be_valid
            end
        end
    end
end
