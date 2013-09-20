require 'spec_helper'

describe Publication do
    before do
        @publication = Publication.new(status: Publication::STATUS_VALUES[0], title: "Rede social de pesquisadores", subtype: Publication::SUBTYPE_VALUES[0])
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
    
    it { should be_valid }

    describe "accessible attributes" do
		it "should not allow access to user id" do
			expect do
				Publication.new(user_id: user.id)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

    describe "when title is not present" do
        before { @publication.title = ' ' }
        it { should_not be_valid }
    end

    describe "when status is not one of the allowed strings" do
        before { @publication.status = ' ' }
        it { should_not be_valid }
    end

    describe "when subtype is not one of the allowed strings" do
        before { @publication.subtype = ' ' }
        it { should_not be_valid }
    end

    describe "when status is valid" do
        it "should be valid" do
            Publication::STATUS_VALUES.each do |valid_status|
                @publication.status = valid_status
                @publication.should be_valid
            end
        end
    end

    describe "when status is valid" do
        it "should be valid" do
            Publication::SUBTYPE_VALUES.each do |valid_subtype|
                @publication.subtype = valid_subtype
                @publication.should be_valid
            end
        end
    end
end
