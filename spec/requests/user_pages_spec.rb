require 'spec_helper'

describe "UserPages" do
    subject { page }

    describe "signup page" do
        before { visit signup_path }

        it { should have_title(full_title('Cadastro')) } 
    end

    describe "signup" do    
        before { visit signup_path }

        let(:submit) { "Criar conta" }

        describe "with invalid information" do
            it "should not create a user" do
                expect { click_button submit }.not_to change(User, :count)
            end
        end

        describe "with valid and necessary information" do
            
            before do
                fill_in "Nome", with: "Example user"
                fill_in "Email", with: "example@email.com"
                fill_in "Senha", with: "1234"
                fill_in "Confirme a senha", with: "1234"
            end

            it "should create a user" do
                expect { click_button submit }.to change(User, :count).by(1)
            end
        end
    end

end
