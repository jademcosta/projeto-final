# encoding: utf-8

require 'spec_helper'


describe User do

    before do
        @user = User.new(email: 'user@example.com', name: 'Example User', homepage: 'www.example.com', institution: 'UFRJ', job_title: 'Professor', title: 'Msc', password: '1234', password_confirmation: '1234')
    end

    subject { @user }

    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:homepage) }
    it { should respond_to(:institution) }
    it { should respond_to(:job_title) }
    it { should respond_to(:title) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:authenticate) }
    it { should respond_to(:remember_token) }
    it { should respond_to(:relationships) }
	it { should respond_to(:followed_users) }
	it { should respond_to(:following?) }
	it { should respond_to(:follow!) }
	it { should respond_to(:reverse_relationships) }
	it { should respond_to(:followers) }
	it { should respond_to(:inputs) }
	it { should respond_to(:kudos) }
    
    it { should be_valid }

    describe "accessible attributes" do
        it "should not allow access to user id" do
            expect do
                User.new(admin: true)
            end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
        end
    end

    describe "remember token" do
        before { @user.save }
        its(:remember_token) { should_not be_blank }
    end


    describe "when name is not present" do
        before { @user.name = '' }
        it { should_not be_valid }
    end

    describe "when email is not present" do
        before { @user.email = '' }
        it { should_not be_valid }
    end
    
    describe "when email format is invalid" do
        
        it "should be invalid" do
            invalid_emails = %w[user@example,com user_at_example.org example.user@ex. user@examp_examp.com user@examp+examp.com]

            invalid_emails.each do |invalid_email|
                @user.email = invalid_email
                @user.should_not be_valid
            end
        end
    end

    describe "when email format is valid" do
        it "should be valid" do
            emails = %w[user@example.COM A_US-ER@f.b.org user.primeiro@email.com user+mais@email.com]

            emails.each do |email|
                @user.email = email
                @user.should be_valid
            end
        end
    end

    describe "when email address is already taken" do
        before do
            user_with_same_email = @user.dup
            user_with_same_email.email.upcase!
            user_with_same_email.save
        end

        it { should_not be_valid }
    end

    describe "when password is not present" do
        before { @user.password = @user.password_confirmation = ' ' }
        it { should_not be_valid }
    end

    describe "when password don't match confirmation" do
        before { @user.password_confirmation = 'abcd' }
        it { should_not be_valid }
    end
    
    describe "when password_confirmation is nil" do
        before { @user.password_confirmation = nil }
        it { should_not be_valid }
    end

    describe "return value of authenticate method" do
        before { @user.save }
        let(:found_user) { User.find_by_email(@user.email) }

        describe "with valid password" do
            it { should == found_user.authenticate(@user.password) }
        end

        describe "with invalid password" do
            let(:user_for_invalid_password) { found_user.authenticate("invalid") }

            it { should_not == user_for_invalid_password }
            specify { user_for_invalid_password.should be_false }
        end
    end

# ===== Seguidores e seguidos ===============
    
    describe "following" do
		let(:other_user) { FactoryGirl.create(:user) }
		before do
			@user.save
			@user.follow!(other_user)
		end

		it { should be_following(other_user) }
		its(:followed_users) { should include(other_user) }

		describe "followed user" do
			subject { other_user }
			its(:followers) { should include(@user) }
		end

		describe "and unfollowing" do
			before { @user.unfollow!(other_user) }
			it { should_not be_following(other_user) }
			its(:followed_users) { should_not include(other_user) }
		end

	end
    
# ========== Inputs ==========

    describe "inputs associations" do
        #puts "jade com userclass: #{ @user.class } e nome #{ @user.name }"
        before { @user.save }

        let!(:older_extension_activity) do
            FactoryGirl.create(:extension_activity, user: @user, created_at: 1.day.ago)
        end

        let!(:newer_extension_activity) do
            FactoryGirl.create(:extension_activity, user: @user, created_at: 1.hour.ago)
        end

        it "should have the right inputs in the right order" do
            @user.inputs.should == [newer_extension_activity, older_extension_activity]
        end

        it "should destroy associated microposts when user is deleted" do
            inputs = @user.inputs
            @user.destroy
            inputs.each do |input|
                Input.find_by_id(input.id).should be_nil
            end
        end

        pending "Fazer o teste de que um post de um usuário que eu não sigo não deve aparecer aqui"
    end

end


