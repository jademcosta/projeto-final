require 'spec_helper'

describe Publication do
    before do
        @publication = Publication.new
    end
    
    let(:user) { FactoryGirl.create(:user) } 

    subject { @publication }

    it { should respond_to(:link) }
    it { should respond_to(:type) }
    it { should respond_to(:language) }
    it { should respond_to(:doi) }
    it { should respond_to(:bibtex) }
    it { should respond_to(:status) }
    it { should respond_to(:title) }
    it { should respond_to(:user_id) }
    it { should respond_to(:text) }
    it { should respond_to(:subtype) }

    describe "accessible attributes" do
		it "should not allow access to user id" do
			expect do
				Publication.new(user_id: user.id)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end
end
