# encoding: utf-8

require 'spec_helper'

describe "ExtensionActivityPages" do
    
    subject { page }
    let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }

    describe "insert" do
        before { visit new_extension_activity_path }

        it { should have_title(full_title('Nova atividade de extensão')) }
        let(:submit) { 'Criar' }

        describe "with invalid information" do
            it "should not create an extension activity" do
                expect { click_button submit }.not_to change(ExtensionActivity, :count)
            end

            describe "after submission" do
                before { click_button submit }
                it { should have_title(full_title('Nova atividade de extensão')) }
                it { should have_selector('li', text: 'Nome não pode ficar em branco')}
            end
        end

        describe "with valid and necessary information" do
            before do
                fill_in "Nome", with: "Curso de admin"
            end

            it "should create and extension activity" do
                expect { click_button submit }.to change(ExtensionActivity, :count).by(1) 
            end

            describe "should show right success message" do
                before { click_button submit }
                it { should have_selector('div.alert-success', text: 'Atividade de extensão inserida com sucesso!') }
            end
        end
    end
end
