# encoding: utf-8

require 'spec_helper'

describe "EventParticipationPages" do
    subject { page }
    let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }

    describe "insert" do
        before { visit new_event_participation_path }

        it { should have_title(full_title('Nova participação em evento')) }
        let(:submit) { 'Criar' }

        describe "with invalid information" do
            it "should not create a event participation" do
                expect { click_button submit }.not_to change(EventParticipation, :count)
            end

            describe "After submission" do
                before { click_button submit }
                it { should have_title(full_title('Nova participação em evento')) }
                it { should have_selector('li', text: 'Title can\'t be blank') }
            end
        end

        describe "with valid and necessary information" do
            before do 
                fill_in "Nome", with: "SBSC"
                select "participante", from: 'Tipo de participação'
            end

            it "should create an event participation" do
                expect { click_button submit }.to change(EventParticipation, :count).by(1)
            end

            describe "should show right success message" do
                before { click_button submit }
                it { should have_selector('div.alert-success', text: 'Participação em evento inserida com sucesso!') }
            end
        end
    end
end
