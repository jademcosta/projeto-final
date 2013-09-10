# encoding: utf-8

require 'spec_helper'

describe "OrientationPages" do

    subject { page }

    describe "insert" do
        before { visit new_orientation_path }

        it { should have_title(full_title('Nova orientação'))}
        let(:submit) { 'Criar' }

        describe "with invalid information" do
            it "should not create an orientation" do
                expect { click_button submit }.not_to change(Orientation, :count)
            end

            describe "after submission" do
                before { click_button submit }
                it { should have_title(full_title('Nova orientação')) }
                it { should have_selector('li', text: 'Student can\'t be blank') }
            end
        end

        describe "with valid and necessary information" do
            before do
                fill_in "Estudante", with: "Jade Costa"
                select "conclusão", from: 'Status'
                select "PFC", from: 'Tipo'
            end

            it "should create an orientation" do
                expect { click_button submit }.to change(Orientation, :count).by(1) 
            end

            describe "should show right success message" do
                before { click_button submit }
                it { should have_selector('div.alert-success', text: 'Orientação inserida com sucesso!') }
            end
        end
    end
end
