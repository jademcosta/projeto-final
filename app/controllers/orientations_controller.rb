# encoding: utf-8

class OrientationsController < ApplicationController

    before_filter :signed_in_user, only: [:new, :create, :destroy]

    def new
        @orientation = current_user.orientations.build
        preencher_options_de_status
        preencher_options_de_subtype
    end

    def create
        @orientation = current_user.orientations.build(params[:orientation])
		if @orientation.save
			flash[:success] = "Orientação inserida com sucesso!"
			redirect_to root_path
		else
            preencher_options_de_status
            preencher_options_de_subtype
			render 'new'
		end
    end

    private
        
        def preencher_options_de_subtype
            @options_for_select_subtype = Orientation::SUBTYPE_VALUES
        end

        def preencher_options_de_status
            @options_for_select_status = Orientation::STATUS_VALUES
            #Orientation::STATUS_VALUES.each_with_index do |valor, chave|
                #@options_for_select_status << [valor, chave]
            #end        
        end
end
