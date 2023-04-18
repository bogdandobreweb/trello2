class StoriesController < ApplicationController
  before_action :get_board_and_column
  before_action :set_story, only: %i[ show edit update destroy ]
  # before_action :set_due_date
  # GET /stories or /stories.json
  def index
    @column = Column.find(params[:column_id])
    @stories = @column.stories.all
  end

  def filter_by_status_and_date
    @column = Column.find(params[:column_id])
    statuses = params[:statuses] || []
    dates = params[:dates] || []

    @stories = @column.stories.filter_by_status_and_date(statuses, dates)

    render json: @board_column_stories
  end
  # GET /stories/1 or /stories/1.json
  def show
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
      params.require(:story).permit(:title, :column_id, :position, :description)
    end
end
