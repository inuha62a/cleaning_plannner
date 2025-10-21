class StaticPagesController < ApplicationController
  def home
    return unless user_signed_in?
  
    @today_tasks = current_user.tasks
      .where(group_id: nil)
      .select { |task| task.calculate_next_due_date == Date.current }
  end  

  def terms; end

  def privacy; end

  def contact; end
end
