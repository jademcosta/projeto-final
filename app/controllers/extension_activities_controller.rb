# encoding: utf-8

class ExtensionActivitiesController < ApplicationController

    def new
        @extension_activity = ExtensionActivity.new
    end

    def create
        @extension_activity = ExtensionActivity.new(params[:extension_activity])
		if @extension_activity.save
			flash[:success] = "Atividade de extensão inserida com sucesso!"
			redirect_to root_path
		else
			render 'new'
		end
    end
end
