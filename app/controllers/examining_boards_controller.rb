# encoding: utf-8

class ExaminingBoardsController < ApplicationController
    
    before_filter :signed_in_user, only: [:new, :create, :destroy]

    def new
        @examining_board = ExaminingBoard.new
        preencher_options_de_tipo
    end

    def create
        @examining_board = ExaminingBoard.new(params[:examining_board])
		if @examining_board.save
			flash[:success] = "Participação em banca examinadora inserida com sucesso!"
			redirect_to root_path
		else
            preencher_options_de_tipo
			render 'new'
		end
    end

    private
        
        def preencher_options_de_tipo
            @options_for_select_subtype = ExaminingBoard::SUBTYPE_VALUES
        end
end
