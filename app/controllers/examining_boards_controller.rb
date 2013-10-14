# encoding: utf-8

class ExaminingBoardsController < ApplicationController
    
    before_filter :signed_in_user, only: [:new, :create, :destroy]

    def new
        @examining_board = current_user.examining_boards.build
        first_author = @examining_board.authors.build
        first_author.name = current_user.name
        2.times { @examining_board.authors.build }
        preencher_options_de_tipo
    end

    def create
        @examining_board = current_user.examining_boards.build(params[:examining_board])
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
