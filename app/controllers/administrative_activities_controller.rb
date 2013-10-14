# encoding: utf-8
class AdministrativeActivitiesController < ApplicationController
    
    before_filter :signed_in_user, only: [:new, :create, :destroy]

    def new
        @administrative_activity = current_user.administrative_activities.build
    end

    def create
        @administrative_activity = current_user.administrative_activities.build(params[:administrative_activity])
		if @administrative_activity.save
			flash[:success] = "Atividade administrativa inserida com sucesso!"
			redirect_to root_path
		else
			render 'new'
		end
    end

    def destroy
        AdministrativeActivity.destroy(params[:id])
		flash[:success] = "Atividade administrativa apagada"
		redirect_back_or root_path
    end
end
