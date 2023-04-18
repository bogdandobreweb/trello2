class ColumnsController < ApplicationController
  before_action :get_board
  before_action :set_column, only: %i[ show edit update destroy ]

  # GET /columns or /columns.json
  def index
    @columns = @board.columns
  end

  # GET /columns/1 or /columns/1.json
  def show
  end

  # GET /columns/new
  def new
    @column = @board.columns.build
  end

  # GET /columns/1/edit
  def edit
  end

  # POST /columns or /columns.json
  def create
    @board = Board.find(params[:board_id])
    @column = @board.columns.build(column_params)

    respond_to do |format|
      if @column.save
        format.json { render :show, status: :created, location: [@board, @column] }
      else
        format.json { render json: @column.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /columns/1 or /columns/1.json
  def update
    @board = Board.find(params[:board_id])
    respond_to do |format|
      if @column.update(column_params)
        format.json { render :show, status: :ok, location: @column }
      else
        format.json { render json: @column.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /columns/1 or /columns/1.json
  def destroy
    @column.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
  
  private
  
    def get_board
      @board = Board.find(params[:board_id])
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_column
      @column = @board.columns.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def column_params
      params.require(:column).permit(:name, :board_id, :position)
    end
end
