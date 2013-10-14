# encoding: utf-8

class ResearchesController < ApplicationController

    before_filter :signed_in_user, only: [:new, :create, :destroy]

    def new
        @research = current_user.researches.build
    end

    def create
        @research = current_user.researches.build(params[:research])
		if @research.save
			flash[:success] = "Pesquisa inserida com sucesso!"
			redirect_to root_path
		else
            render 'new'
		end
    end

    def destroy
        Research.destroy(params[:id])
		flash[:success] = "Pesquisa em evento apagada"
		redirect_back_or root_path
    end
end
