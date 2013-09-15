require 'spec_helper'

describe EventParticipation do
    
   before do
        @event_participation = EventParticipation.new(title: "SSBC", subtype: EventParticipation::SUBTYPE_VALUES[0])
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

    it { should be_valid }

    describe "accessible attributes" do
		it "should not allow access to user id" do
			expect do
				EventParticipation.new(user_id: user.id)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end 
    
    describe "when title is not present" do
        before { @event_participation.title = ' ' }
        it { should_not be_valid }
    end

    describe "when subtype is not one of the allowed strings" do
        before { @event_participation.subtype = ' ' }
        it { should_not be_valid }
    end

    describe "when subtype is valid" do
        it "should be valid" do
            EventParticipation::SUBTYPE_VALUES.each do |valid_subtype|
                @event_participation.subtype = valid_subtype
                @event_participation.should be_valid
            end
        end
    end

    describe "when event type is not valid" do
        before { @event_participation.event_type = 'Qualquer um' }
        it { should_not be_valid }
    end

    describe "when event type is valid" do
        it "should be valid" do
            EventParticipation::EVENT_TYPE_VALUES.each do |valid_event_type|
                @event_participation.event_type = valid_event_type
                @event_participation.should be_valid
            end
        end
    end
end
