require 'spec_helper'

describe Kudo do
   

    let(:user) { FactoryGirl.create(:user) } 
    before do
        @kudo = user.kudos.build
    end

    subject { @kudo }

    it { should respond_to(:user) }
    it { should respond_to(:input) }

    it { should be_valid }

    describe "accessible attributes" do
		it "should not allow access to user id" do
			expect do
				Kudo.new(user_id: user.id)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

    describe "when user_id is not present" do
		before { @kudo.user_id = nil }
		it { should_not be_valid }
	end

    describe "when input_id is not present" do
		before { @kudo.input_id = nil }
		it { should_not be_valid }
	end
end
