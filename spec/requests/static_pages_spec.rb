require 'spec_helper'

describe "StaticPages" do
   
    subject { page }

    describe "Home Page" do
        before { visit root_path }
        
        #it { should have_selector('h1', text: 'Rede de pesquisadores') }
        it { should have_title(full_title('')) }

    end

    describe "Contact" do

        before { visit contact_path }

        it { should have_title(full_title('Contato')) }
    end
end
