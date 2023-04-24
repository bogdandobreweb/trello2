require_relative '../services/stories_retriever.rb'

class StoriesController < ApplicationController
  before_action :get_board_and_column
  before_action :set_story, only: %i[ show edit update destroy ]
  # before_action :set_due_date
  # GET /stories or /stories.json
  def index
    @column = Column.find(params[:column_id])
    

    status = []
    due_date = []
    column = :title
    type = :asc

    if params[:status] || params[:due_date] || params[:column] || params[:type]
      if params[:status].present?
        status = params[:status].split(',')
      end
      if params[:due_date].present?
        due_date = params[:due_date].split(',')
      end
      if params[:column].present?
        column = params[:column]
      end
      if params[:type].present?
        type = params[:type]
      end

      @stories = StoriesRetriever.new.filter_order(
          params[:column_id],
          statuses: status,
          dates: due_date,
          order_column: column,
          order_type: type
          )
    else
      @stories = @column.stories.all
    end
    # @stories = StoriesRetriever.new.filter_by_status_and_date(
    #   params[:column_id],
    #   statuses: 1,
    #   dates: (Date.today - 30)..(Date.today + 30)
    # )

    # @stories = StoriesRetriever.new.order_by(
    #   params[:column_id],
    #   order_column: :title,
    #   order_type: :desc
    # )

    render json: @stories, status: :ok

    # @stories = Story.reorder(created_at: :asc)
  end

  def show
    @story = @column.stories.find_by(id: params[:id])
    if @story
      render json: @story
    else
      render json: { error: "Story not found" }, status: :not_found
    end

  end

  # GET /stories/new
  def new
    @story = @column.stories.build
  end

  # GET /stories/1/edit
  def edit
  end

  # POST /stories or /stories.json
  def create
    @column = Column.find(params[:column_id])
    @story = @column.stories.build(story_params)

    respond_to do |format|
      if @story.save
        format.json { render :show, status: :created, location: [@board, @column, @story] }
      else
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stories/1 or /stories/1.json
  def update
    @column = Column.find(params[:column_id])
    respond_to do |format|
      if @story.update(story_params)
        format.json { render :show, status: :ok, location: [@board, @column, @story] }
      else
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1 or /stories/1.json
  def destroy
    @column = Column.find(params[:column_id])
    @story.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  # def set_due_date
  #   self.due_date =  Time.now + 60.days
  # end 

  private

    def get_board_and_column
      @board = Board.find(params[:board_id])
      @column = @board.columns.find(params[:column_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = @column.stories.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def story_params
      params.require(:story).permit(:title, :position, :description, :status, :due_date)
    end
end
