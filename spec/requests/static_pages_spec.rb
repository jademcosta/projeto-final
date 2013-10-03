# encoding: utf-8

require 'spec_helper'

describe "StaticPages" do
   
    subject { page }

    describe "Home Page" do
        before { visit root_path }
        
        pending "Testar o h1 daqui"
        it { should have_title(full_title('')) }

        describe "for signed-in users" do
            let(:user) { FactoryGirl.create(:user) }
            before do
                FactoryGirl.create(:extension_activity, user: user, title: "Primeira ext")
                FactoryGirl.create(:extension_activity, user: user, title: "Segunda ext")
                sign_in user
                #visit root_path
            end
            
            it { should have_link("Usuários", href: users_path) }
            it { should have_link("Perfil", href: user_path(user)) }
            
            describe "the feed" do
                
                it "should show user's entries" do
                    user.feed.each do |entry|
                        page.should have_content("Primeira ext")
                        page.should have_content("Segunda ext")
                    end    
                end
           end
        end
    end

    describe "Contact" do

        before { visit contact_path }

        it { should have_title(full_title('Contato')) }
    end
end
