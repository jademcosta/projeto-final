# encoding: utf-8

require 'spec_helper'

describe ExtensionActivity do
  
    before do
        @extension_activity = ExtensionActivity.new(title: "Curso de administração")
    end
    
    let(:user) { FactoryGirl.create(:user) } 

    subject { @extension_activity }

    it { should respond_to(:text) }
    it { should respond_to(:type) }
    it { should respond_to(:date) }
    it { should respond_to(:end_date) }
    it { should respond_to(:subtype) }
    it { should respond_to(:title) }
    it { should respond_to(:user_id) }

    it { should be_valid }

    describe "accessible attributes" do
		it "should not allow access to user id" do
			expect do
				ExtensionActivity.new(user_id: user.id)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

    describe "when title is not present" do
        before { @extension_activity.title = ' ' }
        it { should_not be_valid }
    end
end
