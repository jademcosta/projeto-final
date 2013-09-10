# encoding: utf-8

require 'spec_helper'

describe "AwardPages" do

    subject { page }

    describe "insert" do
        before { visit new_award_path }

        it { should have_title(full_title('Novo prêmio')) }
        let(:submit) { 'Criar' }

        describe "with invalid information" do
            it "should not create a degree" do
                expect { click_button submit }.not_to change(Award, :count)
            end

            describe "After submission" do
                before { click_button submit }
                it { should have_title(full_title('Novo prêmio')) }
                it { should have_selector('li', text: 'Text can\'t be blank') }
                pending "Internacionalizar frase de erro no form award"

            end
        end

        describe "with valid and necessary information" do
            before do
                fill_in "Nome", with: "Prêmio Nobel de física"
                select "recebido", from: 'Status'
            end

            it "should create an award" do
                expect { click_button submit }.to change(Award, :count).by(1)
            end

            describe "should show right success message" do
                before { click_button submit }
                it { should have_selector('div.alert-success', text: 'Prêmio inserido com sucesso!') }
            end
        end
    end
end
