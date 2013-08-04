# encoding: utf-8

class UsersController < ApplicationController

    before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]

    def index
		@users = User.paginate(page: params[:page])
	end

    def new
        @user = User.new
    end

    def create
        @user = User.new(params[:user])

		if @user.save
			sign_in @user
			flash[:success] = "Bem vindo à rede de pesquisadores!"
			redirect_to root_path
		else
			render 'new'
		end
    end

    def show
        @user = User.find(params[:id])
    end

    def edit
            
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
end
