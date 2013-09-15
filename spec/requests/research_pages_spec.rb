# encoding: utf-8

require 'spec_helper'

describe "ResearchPages" do

    subject { page }

    describe "insert" do
        before { visit new_research_path }

        it { should have_title(full_title('Nova bolsa de pesquisa, fomento ou auxílio')) }
        let(:submit) { 'Criar' }

        describe "with invalid information" do
            it "should not create an research" do
                expect { click_button submit }.not_to change(Research, :count)
            end

            describe "after submission" do
                before { click_button submit }
                it { should have_title(full_title('Nova bolsa de pesquisa, fomento ou auxílio')) }
                it { should have_selector('li', text: 'Subtype can\'t be blank') }
            end
        end

        describe "with valid and necessary information" do
            before { fill_in "Tipo", with: "Bolsa de produção acadêmica" }

            it "should create an research" do
                expect { click_button submit }.to change(Research, :count).by(1)
            end

            describe "should show the right message" do
                before { click_button submit }
                it { should have_selector('div.alert-success', text: 'Bolsa inserida com sucesso!') }
            end
        end
    end
end
