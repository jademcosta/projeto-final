# encoding: utf-8

class UsersController < ApplicationController
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
end
