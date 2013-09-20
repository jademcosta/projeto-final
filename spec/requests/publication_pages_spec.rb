# encoding: utf-8

require 'spec_helper'

describe "PublicationPages" do

    subject { page }

    describe "insert" do
        before { visit new_publication_path }

        it { should have_title(full_title('Nova publicação')) }
        let(:submit) { 'Criar' }

        describe "with invalid information" do
            it "should not create a publication" do
                expect { click_button submit }.not_to change(Publication, :count)
            end

            describe "After submission" do
                before { click_button submit }
                it { should have_title(full_title('Nova publicação')) }
                it { should have_selector('li', text: 'Title can\'t be blank') }
            end
        end

        describe "with valid and necessary information" do
            before do
                fill_in "Título/tema", with: "Rede de pesquisadores"
                select "publicado (online)", from: "Status"
                select "artigo completo", from: 'Tipo'
            end

            it "should create a publication" do
                expect { click_button submit }.to change(Publication, :count).by(1)
            end

            describe "should show right success message" do
                before { click_button submit }
                it { should have_selector('div.alert-success', text: 'Publicação inserida com sucesso!') }
            end
        end
    end
end
