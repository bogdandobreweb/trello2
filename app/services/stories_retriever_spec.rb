require './stories_retriever.rb'
require 'rspec'
require_relative '../../config/environment.rb'

RSpec.describe StoriesRetriever do
  describe "#filter_order" do
    let(:column_id) { 1 }
    let(:statuses) { ["pending", "in progress"] }
    let(:dates) { [Date.today] }
    let(:order_column) { :created_at }
    let(:order_type) { :desc }

    context "when column_id exists" do
      let(:column) { instance_double("Column", id: column_id, stories: stories) }
      let(:stories) { instance_double("ActiveRecord::Relation") }

      before do
        allow(Column).to receive(:find_by).with(id: column_id).and_return(column)
        allow(stories).to receive(:where).with(status: statuses).and_return(stories)
        allow(stories).to receive(:where).with(due_date: dates).and_return(stories)
        allow(stories).to receive(:reorder).with(order_column => order_type).and_return(stories)
      end

      it "loads stories and filters them by status, date, and order" do
        expect(column).to receive(:stories).and_return(stories)
        expect(stories).to receive(:where).with(status: statuses).and_return(stories)
        expect(stories).to receive(:where).with(due_date: dates).and_return(stories)
        expect(stories).to receive(:reorder).with(order_column => order_type).and_return(stories)

        subject.filter_order(column_id, statuses: statuses, dates: dates, order_column: order_column, order_type: order_type)
      end

      it "returns the filtered and ordered stories" do
        expect(subject.filter_order(column_id, statuses: statuses, dates: dates, order_column: order_column, order_type: order_type)).to eq(stories)
      end
    end

    context "when column_id doesn't exist" do
      let(:column) { nil }
      let(:stories_retriever) { described_class.new }
      before do
        allow(Column).to receive(:find_by).with(id: column_id).and_return(column)
      end

      it "returns an empty array" do
        filtered_stories = stories_retriever.filter_order(
          nil,
          statuses: [1],
          dates: (Date.today - 30.days)..Date.today,
          order_column: :due_date,
          order_type: :desc
        )

        expect(filtered_stories).to eq([])
      end
    end
  end
end