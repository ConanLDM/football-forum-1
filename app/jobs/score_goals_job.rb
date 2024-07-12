class ScoreGoalsJob < ApplicationJob
  queue_as :default

  def perform

  end
end


ScoreGoalsJob.perform_later
