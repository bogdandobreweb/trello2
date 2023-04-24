class HardJob
  include Sidekiq::Job

  def perform(*args)
    stories = Story.where("due_date < ?", Date.today)

    stories.each do |story|
      story.update(side_status: "Archived")
    end
    
  end 
end
