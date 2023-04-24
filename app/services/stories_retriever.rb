class StoriesRetriever

    def filter_by_status_and_date(column_id, statuses: , dates: )
        return [] unless column_id.present?
        
        stories = load_stories(column_id)
        stories = stories.where(status: statuses) if statuses.present?
        stories = stories.where(due_date: dates) if dates.present?
    
        
        stories.to_a
    end

    def filter_order(column_id, statuses: , dates: , order_column:  , order_type: )
      return [] unless column_id.present?
        
      stories = load_stories(column_id)

      stories = stories.where(status: statuses) if statuses.present?
      stories = stories.where(due_date: dates) if dates.present?
  
      order_column ||= :title
      order_type ||= :desc
        
      stories = stories.reorder(order_column => order_type)
  
      stories
    end

    def load_stories(column_id)
        column = Column.find_by(id: column_id).stories
    end


    def order_by(column_id, order_column: , order_type: )
        return [] unless column_id.present?
        
        order_column ||= :title
        order_type ||= :asc
        stories = load_stories(column_id)
        stories = stories.reorder(order_column => order_type)

        stories
    end

  end




  