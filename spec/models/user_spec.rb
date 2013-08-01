require 'spec_helper'



#===================================================
#Soh voltar a mexer aqui quando tivermos seguidores
#===================================================





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


end
