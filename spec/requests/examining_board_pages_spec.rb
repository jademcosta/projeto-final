# encoding: utf-8

require 'spec_helper'

describe "ExaminingBoardPages" do

    subject { page }
    let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }

    describe "insert" do
        before { visit new_examining_board_path }

        it { should have_title(full_title('Nova participação em banca examinadora'))}
        let(:submit) { 'Criar' }

        describe "with invalid information" do
            it "should not create an examining board" do
                expect { click_button submit }.not_to change(ExaminingBoard, :count)
            end

            describe "after submission" do
                before { click_button submit }
                it { should have_title(full_title('Nova participação em banca examinadora')) }
                it { should have_selector('li', text: 'Text can\'t be blank') }
            end
        end

        describe "with valid and necessary information" do
            before do
                fill_in 'Candidatos', with: 'Pernalonga, Patolino'
                fill_in 'Data', with: '20/10/2012'
                select 'concurso público', from: 'Tipo'
            end

            it "should create an examining board participation" do
                expect { click_button submit }.to change(ExaminingBoard, :count).by(1)
            end
            
            describe "should show right success message" do
                before { click_button submit }
                it { should have_selector('div.alert-success', text: 'Participação em banca examinadora inserida com sucesso!') }
            end
        end
    end
end
