# encoding: utf-8

require 'spec_helper'

describe ExaminingBoard do
    
    before do
        @examining_board = ExaminingBoard.new(subtype: ExaminingBoard::SUBTYPE_VALUES[0], date: "20/10/2012", text: "Pernalonga, Patolino")
    end
    
    let(:user) { FactoryGirl.create(:user) } 
    subject { @examining_board }

    it { should respond_to(:type) }
    it { should respond_to(:date) }
    it { should respond_to(:subtype) }
    it { should respond_to(:text) }
    it { should respond_to(:user_id) }

    it { should be_valid }

    describe "accessible attributes" do
		it "should not allow access to user id" do
			expect do
				ExaminingBoard.new(user_id: user.id)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

    describe "when subtype is not one of the allowed strings" do
        before { @examining_board.subtype = ' ' }
        it { should_not be_valid }
    end

    describe "when date is not present" do
        before { @examining_board.date = ' ' }
        it { should_not be_valid }
    end
    
    pending "validar data com expressão regular"

    describe "when text is not present" do
        before { @examining_board.text = ' ' }
        it { should_not be_valid }
    end

    describe "when subtype is valid" do
        it "should be valid" do
            ExaminingBoard::SUBTYPE_VALUES.each do |valid_subtype|
                @examining_board.subtype = valid_subtype
                @examining_board.should be_valid
            end
        end
    end
end
