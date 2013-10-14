# encoding: utf-8

class DegreesController < ApplicationController

    before_filter :signed_in_user, only: [:new, :create, :destroy]

    def new
        @degree = current_user.degrees.build
        preencher_options_de_status
    end

    def create
        @degree = current_user.degrees.build(params[:degree])
		if @degree.save
			flash[:success] = "Grau ou título inserido com sucesso!"
			redirect_to root_path
		else
            preencher_options_de_status
			render 'new'
		end
    end

    def destroy
        Degree.destroy(params[:id])
		flash[:success] = "Grau ou título apagado"
		redirect_back_or root_path
    end

    private
        
        def preencher_options_de_status
            @options_for_select_status = Degree::STATUS_VALUES
            #Degree::STATUS_VALUES.each_with_index do |valor, chave|
                #@options_for_select_status << [valor, chave]
            #end        
        end
end
