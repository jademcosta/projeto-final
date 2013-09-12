# encoding: utf-8

require 'spec_helper'

describe "AdministrativeActivityPages" do
    
    subject { page }

    describe "insert" do
        before { visit new_administrative_activity_path }

        it { should have_title(full_title('Nova atividade administrativa')) }
        let(:submit) { 'Criar' }

        describe "with invalid information" do
            it "should not create an administrative activity" do
                expect { click_button submit }.not_to change(AdministrativeActivity, :count) 
            end

            describe "After submission" do
                before { click_button submit }
                it { should have_title(full_title('Nova atividade administrativa')) }
                it { should have_selector('li', 'Title can\'t be blank') }
            end
        end

        describe "with valid and necessary information" do
            before do
                fill_in "Instituição", with: "UFRJ - IM"
                fill_in "Tipo de atividade/cargo/função", with: "Coordenador"
            end

            it "should create an administrative activity" do
                expect { click_button submit }.to change(AdministrativeActivity, :count).by(1) 
            end

            describe "should show right success message" do
                before { click_button submit }
                it { should have_selector('div.alert-success', text: 'Atividade administrativa inserida com sucesso!') }
            end
        end
    end
end