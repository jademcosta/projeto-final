# encoding: utf-8

require 'spec_helper'

describe Award do
    before do
        @award = Award.new(status: Award::STATUS_VALUES[0], text: "Medalha Fields")
    end
    
    let(:user) { FactoryGirl.create(:user) } 
    subject { @award }

    it { should respond_to(:type) }
    it { should respond_to(:status) }
    it { should respond_to(:date) }
    it { should respond_to(:institution) }
    it { should respond_to(:text) }
    it { should respond_to(:user_id) }
    
    it { should be_valid }

    describe "accessible attributes" do
		it "should not allow access to user id" do
			expect do
				Award.new(user_id: user.id)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

    describe "when status is not one of the allowed strings" do
        before { @award.status = ' ' }
        it { should_not be_valid }
    end

    describe "when name is not present" do
        before { @award.text = '' }
        it { should_not be_valid }
    end

    describe "when status is valid" do
        it "should be valid" do
            Award::STATUS_VALUES.each do |valid_status|
                @award.status = valid_status
                @award.should be_valid
            end
        end
    end
end
