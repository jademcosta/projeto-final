# encoding: utf-8

class PublicationsController < ApplicationController

    def new
        @publication = Publication.new
        3.times { @publication.authors.build }
        preencher_options_de_status
        preencher_options_de_tipo
    end

    def create
        @publication = Publication.new(params[:publication])
		if @publication.save
			flash[:success] = "Publicação inserida com sucesso!"
			redirect_to root_path
		else
            preencher_options_de_status
            preencher_options_de_tipo
			render 'new'
		end
    end

    private
        
        def preencher_options_de_status
            @options_for_select_status = Publication::STATUS_VALUES
            #Award::STATUS_VALUES.each_with_index do |valor, chave|
                #@options_for_select_status << [valor, chave]
            #end        
        end

        def preencher_options_de_tipo
            @options_for_select_subtype = Publication::SUBTYPE_VALUES
        end
end
