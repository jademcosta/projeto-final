# encoding: utf-8
class AdministrativeActivitiesController < ApplicationController
    
    def new
        @administrative_activity = AdministrativeActivity.new
    end

    def create
        @administrative_activity = AdministrativeActivity.new(params[:administrative_activity])
		if @administrative_activity.save
			flash[:success] = "Atividade administrativa inserida com sucesso!"
			redirect_to root_path
		else
			render 'new'
		end
    end

end
