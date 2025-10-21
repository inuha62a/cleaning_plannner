class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_context
    before_action :set_task, only: [:edit, :update, :destroy, :mark_as_done]
  
    def index
      @tasks = if @group
        @group.tasks
      else
        current_user.tasks.where(group_id: nil)
      end
    end
  
    def new
      @task = base_scope.new
    end
  
    def create
      @task = base_scope.new(task_params.merge(user: current_user))
      if @task.save
        redirect_to tasks_path(context_params), notice: "タスクを作成しました"
      else
        render :new
      end
    end
  
    def edit; end
  
    def update
      if @task.update(task_params)
        redirect_to tasks_path(context_params), notice: "更新しました"
      else
        render :edit
      end
    end
  
    def destroy
      @task.destroy
      redirect_to tasks_path(context_params), notice: "削除しました"
    end
  
    def mark_as_done
      @task.mark_as_done!
      redirect_to tasks_path(context_params), notice: "完了にしました"
    end
  
    private
  
    def set_context
      if params[:group_id]
        @group = current_user.groups.find(params[:group_id])
      else
        @group = nil
      end
    end
  
    def base_scope
      @group ? @group.tasks : current_user.tasks.where(group_id: nil)
    end
  
    def set_task
      @task = base_scope.find(params[:id])
    end
  
    def task_params
      params.require(:task).permit(:title, :status, :last_done_at, :frequency, :custom_interval_days, :location_id)
    end
  
    def context_params
      @group ? { group_id: @group.id } : {}
    end
  end
  