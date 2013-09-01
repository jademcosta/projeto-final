require 'spec_helper'

describe EventParticipation do
    
   before do
        @event_participation = EventParticipation.new
    end
    
    let(:user) { FactoryGirl.create(:user) } 

    subject { @event_participation }

    it { should respond_to(:title) }
    it { should respond_to(:type) }
    it { should respond_to(:city) }
    it { should respond_to(:country) }
    it { should respond_to(:subtype) }
    it { should respond_to(:date) }
    it { should respond_to(:event_type) }
    it { should respond_to(:user_id) }

    describe "accessible attributes" do
		it "should not allow access to user id" do
			expect do
				EventParticipation.new(user_id: user.id)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end 
    
end
