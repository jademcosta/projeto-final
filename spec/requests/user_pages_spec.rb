# encoding: utf-8


require 'spec_helper'

describe "UserPages" do
    subject { page }

    describe "signup" do    
        before { visit signup_path }
        
        it { should have_title(full_title('Cadastro')) } 

        let(:submit) { "Criar conta" }

        describe "with invalid information" do
            it "should not create a user" do
                expect { click_button submit }.not_to change(User, :count)
            end

            describe "after submission" do

				before { click_button submit }

#				it { should have selector('title', text: 'Sign up') }
				it { should have_selector('li', text: 'Name can\'t be blank') }
			end
        end

        describe "with valid and necessary information" do
            
            before do
                fill_in "Nome", with: "Example user"
                fill_in "Email", with: "example@email.com"
                fill_in "Senha", with: "1234"
                fill_in "Confirme a senha", with: "1234"
            end

            it "should create a user" do
                expect { click_button submit }.to change(User, :count).by(1)
            end
        end
    end

    describe "index" do
        let(:user) { FactoryGirl.create(:user) }

        before :each do
            sign_in user
            visit users_path
        end

        it { should have_title(full_title('Lista de usuários')) } 
        it { should have_selector('h1', text: 'Usuários') }

        describe "pagination" do
            it "should list each user" do
                User.paginate(page: 1).each do |user|
                    page.should have_selector('li', text: user.name)
                end
            end
        end
    end

    describe "profile page" do
        let(:user) { FactoryGirl.create(:user) }
        before { visit user_path(user) }
        
        it { should have_selector('h1', text: user.name)}
        it { should have_title(full_title(user.name)) }
        it { should have_link("Seguindo #{user.followed_users.count}", href: following_user_path(user)) }
        it { should have_link("#{user.followers.count} seguidores", href: followers_user_path(user)) }

        describe "follow/unfollow buttons" do
            let(:other_user) { FactoryGirl.create(:user) }
            before { sign_in user }
            
            describe "following a user" do
                before { visit user_path(other_user) }
                 
                it "should increment the folloed users count" do
                    expect do
                        click_button "Seguir"
                    end.to change(user.followed_users, :count).by(1)
                end
                
                it "should increment the other user's followers count" do
				    expect do
					    click_button "Seguir"
					end.to change(other_user.followers, :count).by(1)
				end

				describe "toggling the button" do
					before { click_button "Seguir" }
					it { should have_selector("input[type=submit][value='Deixar de seguir']") }
				end
            end

            describe "unfollowing a user" do
                before do
                    user.follow!(other_user)
                    visit user_path(other_user)
                end
                it "should decrement the followed user count" do
                    expect do
                        click_button "Deixar de seguir"
                    end.to change(user.followed_users, :count).by(-1)
                end
                it "should decrement the other user's followers count" do
                    expect do
                        click_button "Deixar de seguir"
                    end.to change(other_user.followers, :count).by(-1)
                end
                describe "toggling the button" do
                    before { click_button "Deixar de seguir" }
                    it { should have_selector("input[type=submit][value='Seguir']") }
                    it { find(".btn").visible? }
                    # apenas para mostrar que o método acima tb é possível ;)
                end
            end
        end
    end

    describe "edit" do
		let(:user) { FactoryGirl.create(:user) }
		before do 
			sign_in user
			visit edit_user_path(user)
		end
        
        pending "Fazer com que as validações no método criar e editar sejam diferentemente avalidadas"

		describe "page" do
			it { should have_selector('h1', text: 'Editar perfil') }
            it { should have_title(full_title('Editar perfil')) }
		end

		describe "with invalid information" do
			before do
                fill_in "Nome", with: ""
                click_button "Salvar alterações"
            end
			it { should have_content('error') }
		end

		describe "with valid information" do
			let(:new_name) { "Novo nome" }
			let(:new_email) { "novo@example.com" }
		
			before do
				fill_in "Nome", with: new_name
				fill_in "Email", with: new_email
				fill_in "Senha", with: user.password
				fill_in "Confirme a senha", with: user.password
                fill_in "Instituição", with: "UFRJ"
                fill_in "Cargo", with: "Professor"
                fill_in "Título", with: "Mestre"
				click_button "Salvar alterações"
			end
		
            it { should have_title(full_title(new_name)) }
			it { should have_selector('div.alert.alert-success') }
			it { should have_link('Sair', href: signout_path) }
			specify { user.reload.name.should == new_name }
			specify { user.reload.email.should == new_email }
		end
	end

    describe "following/followers" do
		let(:user) { FactoryGirl.create(:user) }
		let(:other_user) { FactoryGirl.create(:user) }
		before { user.follow!(other_user) }

		describe "followed users" do
			before do
				sign_in user
				visit following_user_path(user)
			end

            it { should have_title(full_title('Seguindo')) }
			it { should have_selector('h3', text: 'Seguindo') }
			it { should have_link(other_user.name, href: user_path(other_user)) }
		end

		describe "followers" do
			before do
				sign_in other_user
				visit followers_user_path(other_user)
			end
            it { should have_title(full_title('Seguidores')) }
			it { should have_selector('h3', text: 'Seguidores') }
			it { should have_link(user.name, href: user_path(user)) }
		end
	end


end
