# encoding: utf-8

class DegreesController < ApplicationController

    def new
        @degree = Degree.new
        preencher_options_de_status
    end

    def create
        @degree = Degree.new(params[:degree])
		if @degree.save
			flash[:success] = "Grau ou título inserido com sucesso!"
			redirect_to root_path
		else
            preencher_options_de_status
			render 'new'
		end
    end

    private
        
        def preencher_options_de_status
            @options_for_select_status = Degree::STATUS_VALUES
            #Degree::STATUS_VALUES.each_with_index do |valor, chave|
                #@options_for_select_status << [valor, chave]
            #end        
        end
end
