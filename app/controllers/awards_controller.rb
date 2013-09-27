# encoding: utf-8

class AwardsController < ApplicationController

    before_filter :signed_in_user, only: [:new, :create, :destroy]

    def new
        @award = Award.new
        preencher_options_de_status
    end

    def create
        @award = Award.new(params[:award])
		if @award.save
			flash[:success] = "Prêmio inserido com sucesso!"
			redirect_to root_path
		else
            preencher_options_de_status
			render 'new'
		end
    end

    private
        
        def preencher_options_de_status
            @options_for_select_status = Award::STATUS_VALUES
            #Award::STATUS_VALUES.each_with_index do |valor, chave|
                #@options_for_select_status << [valor, chave]
            #end        
        end
end
