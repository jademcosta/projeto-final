require 'spec_helper'

describe ExaminingBoard do
    
    before do
        @examining_board = ExaminingBoard.new
    end
    
    let(:user) { FactoryGirl.create(:user) } 
    subject { @examining_board }

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

    describe "accessible attributes" do
		it "should not allow access to user id" do
			expect do
				ExaminingBoard.new(user_id: user.id)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end
end
