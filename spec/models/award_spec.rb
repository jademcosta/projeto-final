require 'spec_helper'

describe Award do
    before do
        @award = Award.new
    end
    
    let(:user) { FactoryGirl.create(:user) } 
    subject { @award }

    it { should respond_to(:type) }
    it { should respond_to(:status) }
    it { should respond_to(:date) }
    it { should respond_to(:institution) }
    it { should respond_to(:text) }
    it { should respond_to(:user_id) }

    describe "accessible attributes" do
		it "should not allow access to user id" do
			expect do
				Award.new(user_id: user.id)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end
end