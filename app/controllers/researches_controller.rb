# encoding: utf-8

class ResearchesController < ApplicationController

    before_filter :signed_in_user, only: [:new, :create, :destroy]

    def new
        @research = Research.new
    end

    def create
        @research = Research.new(params[:research])
		if @research.save
			flash[:success] = "Bolsa inserida com sucesso!"
			redirect_to root_path
		else
            render 'new'
		end
    end
end
