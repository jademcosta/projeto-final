# encoding: utf-8

class KudosController < ApplicationController

    def create
        @kudo = current_user.kudos.build(params[:kudo])
        if @kudo.save
            respond_to do |format|
                format.html { redirect_to root_path }
                format.js
            end
        else

        end 
    end
end
