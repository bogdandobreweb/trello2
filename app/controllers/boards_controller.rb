class BoardsController < ApplicationController
  before_action :set_board, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit
  # before_action :check_permission_level, only: [:index]
  # GET /boards or /boards.json
  def index
    # @boards = Board.all
    @boards = current_user.boards
    render json: @boards, status: :ok
  end

  # GET /boards/1 or /boards/1.json
  def show
    @board = Board.find(params[:id])
    authorize @board
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards or /boards.json
  def create
    @board = current_user.boards.build(board_params)
    authorize @board

    respond_to do |format|
      if @board.save
        format.json { render :show, status: :created, location: @board }
      else
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1 or /boards/1.json
  def update
    @board = Board.find(params[:id])
    authorize @board

    respond_to do |format|
      if @board.update(board_params)
        format.json { render :show, status: :ok, board: @board }
      else
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1 or /boards/1.json
  def destroy
    @board.destroy
    authorize @board
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def board_params
      params.require(:board).permit(:title)
    end
end
