# encoding: utf-8

require 'spec_helper'

describe Degree do
    
    before do
        @degree = Degree.new(status: Degree::STATUS_VALUES[0], subtype: "Mestrado")
    end
    
    let(:user) { FactoryGirl.create(:user) } 

    subject { @degree }

    it { should respond_to(:text) }
    it { should respond_to(:type) }
    it { should respond_to(:date) }
    it { should respond_to(:institution) }
    it { should respond_to(:subtype) }
    it { should respond_to(:status) }
    it { should respond_to(:user_id) }

    describe "accessible attributes" do
		it "should not allow access to user id" do
			expect do
				Degree.new(user_id: user.id)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

    describe "when subtype is not present" do
        before { @degree.subtype = ' ' }
        it { should_not be_valid }
    end

    describe "when status is not one of the allowed strings" do
        before { @degree.status = ' ' }
        it { should_not be_valid }
    end

    pending "O 'tipo' deve ser uma select com valores pré-definidos, ou deve ser livre?"

    describe "when status is valid" do
        it "should be valid" do
            Degree::STATUS_VALUES.each do |valid_status|
                @degree.status = valid_status
                @degree.should be_valid
            end
        end
        
    end

    it { should be_valid }
end
