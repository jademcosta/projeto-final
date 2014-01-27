# encoding: utf-8

require 'spec_helper'

describe "Authentication" do

    subject { page }
    
    describe "validações de permissoes" do
        pending "escrever validações de permissão"
    end

    describe "signin page" do
        before { visit signin_path }

        it { should have_selector('h1', text: 'Entrar') }
        it { should have_title(full_title('Entrar')) }
    end


    describe "signin" do
        before { visit signin_path }

        describe "with invalid information" do
            before { click_button "Entrar" }

            #			it { should have_selector('title', text: 'Sign in') }
            it { should have_selector('div.alert.alert-error', text: 'incorreto') }

            describe "after visiting another page" do
                before { click_link "DontPerish" }
                it { should_not have_selector('div.alert.alert-error') }
            end
        end

        describe "with valid information" do

            let(:user) { FactoryGirl.create(:user) }
            before { sign_in user }

            #			before do
            #				fill_in "Email", with: user.email
            #				fill_in "Senha", with: user.password
            #				click_button "Entrar"
            #			end

            #			it { should have_selector('title', text: user.name) }
            it { should have_link('Perfil', href: user_path(user)) }
            it { should have_link('Usuários', href: users_path) }
            #it { should have_link('Configurações', href: edit_user_path(user)) }
            it { should have_link('Sair', href: signout_path) }
            it { should_not have_link('Entrar', href: signin_path) }

            describe "followed by signout" do
                before { click_link "Sair" }
                it { should have_link('Entrar') }
            end
        end
    end
end
