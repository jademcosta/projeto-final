# encoding: utf-8

class UsersController < ApplicationController

    before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
	before_filter :correct_user, only: [:edit, :update]


    def index
		@users = User.search(params[:search], params[:page])
	end

    def new
        @user = User.new
    end

    def create
        @user = User.new(params[:user])

		if @user.save
			sign_in @user
			flash[:success] = "Bem vindo ao DontPerish!"
			redirect_to root_path
		else
			render 'new'
		end
    end

    def show
        @user = User.find(params[:id])
        @feed_items = @user.inputs.paginate(page: params[:page])
    end

    def edit
    end

    def update
		if @user.update_attributes(params[:user])
			flash[:success] = "Perfil atualizado"
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end

    def following
		@title = "Seguindo"
		@user = User.find(params[:id])
		@users = @user.followed_users.paginate(page: params[:page])
		render 'show_follow'
	end

	def followers
		@title = "Seguidores"
		@user = User.find(params[:id])
		@users = @user.followers.paginate(page: params[:page])
        render 'show_follow'
    end

    def htmlpage
        user = current_user
        pubs = Publication.where(user_id: current_user.id)

        pubs_format = ""
        pubs_format += "<ul>" if (!pubs.nil? && !pubs.empty?)
        pubs.each do |p|
            
            autores = Author.where(input_id: p.id)
            autores_str = ""
            autores.each do |a|
                autores_str += "#{a.name}, "
            end
            autores_str = autores_str[0, autores_str.length - 2]

            pubs_format += "<li>#{autores_str}, <b>#{p.title}</b>"
            pubs_format += ", DOI: #{p.doi}" if !p.doi.blank?
            pubs_format += ", Bibtex: #{p.bibtex}" if !p.bibtex.blank?

            pubs_format += "</li>"
        end
        pubs_format += "</ul>" if (!pubs.nil? && !pubs.empty?)

        str_final = "<h1>#{user.name}</h1>"
        str_final += pubs_format if !pubs_format.blank?

        send_data str_final, filename: "page.html"
    end

    private
        
        def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end
end
