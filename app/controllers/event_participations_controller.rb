# encoding: utf-8

class EventParticipationsController < ApplicationController

    before_filter :signed_in_user, only: [:new, :create, :destroy]

    def new
        @event_participation = current_user.event_participations.build
        preencher_options_de_subtype
        preencher_options_de_event_type
    end

    def create
        @event_participation = current_user.event_participations.build(params[:event_participation])
		if @event_participation.save
			flash[:success] = "Participação em evento inserida com sucesso!"
			redirect_to root_path
		else
            preencher_options_de_subtype
            preencher_options_de_event_type
			render 'new'
		end
    end

    private
        
        def preencher_options_de_subtype
            @options_for_select_subtype = EventParticipation::SUBTYPE_VALUES
            #Award::STATUS_VALUES.each_with_index do |valor, chave|
                #@options_for_select_status << [valor, chave]
            #end        
        end

        def preencher_options_de_event_type
            @options_for_select_event_type = EventParticipation::EVENT_TYPE_VALUES
            #Award::STATUS_VALUES.each_with_index do |valor, chave|
                #@options_for_select_status << [valor, chave]
            #end        
        end
end
