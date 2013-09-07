# encoding: utf-8

require 'spec_helper'

describe "DegreePages" do

    subject { page}

    describe "insert" do
        before { visit new_degree_path }

        it { should have_title(full_title('Novo grau ou título')) }
        let(:submit) { 'Criar' }

        describe "with invalid information" do
            it "should not create a degree" do
                expect { click_button submit }.not_to change(Degree, :count)
            end

            describe "after submission" do
                
                before { click_button submit }
                
                it { should have_title(full_title('Novo grau ou título')) }
                it { should have_selector('li', text: 'Subtype can\'t be blank') }
                pending "Internacionalizar frase de erro no form degree"
            end
        end

        describe "with valid and necessary information" do
            before do
                fill_in "Tipo", with: "Mestrado"
                select "qualificação", from: 'Status'
            end

            it "should create a degree" do
                expect { click_button submit }.to change(Degree, :count).by(1)
            end

            describe "should show right success message" do
                before { click_button submit }
                it { should have_selector('div.alert-success', text: 'Grau ou título inserido com sucesso!')}
            end
        end
    end
end
