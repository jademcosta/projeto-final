require 'spec_helper'

describe AdministrativeActivity do
    
    before do
        @administrative_activity = AdministrativeActivity.new
    end
    
    let(:user) { FactoryGirl.create(:user) } 
    subject { @administrative_activity }

    it { should respond_to(:type) }
    it { should respond_to(:title) }
    it { should respond_to(:date) }
    it { should respond_to(:end_date) }
    it { should respond_to(:institution) }
    it { should respond_to(:user_id) }

    describe "accessible attributes" do
		it "should not allow access to user id" do
			expect do
			AdministrativeActivity.new(user_id: user.id)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end
end
