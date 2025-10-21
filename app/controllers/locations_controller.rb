class LocationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_context
    before_action :set_location, only: [:edit, :update, :destroy]

    helper_method :context_params
  
    def index
      @locations = @group ? @group.locations : current_user.locations.where(group_id: nil)
    end
  
    def show; end

    def create
      @location = @group ? @group.locations.new(location_params) : current_user.locations.new(location_params.merge(group_id: nil))
      
      if @location.save
        redirect_to locations_path(context_params), notice: "場所を登録しました"
      else
        render :new
      end
    end

    def update
      if @location.update(location_params)
        redirect_to locations_path(context_params), notice: "場所を更新しました"
      else
        render :edit
      end
    end
  
    def edit; end
    
    def destroy
      @location.destroy
      redirect_to locations_path(context_params), notice: "場所を削除しました"
    end
  
    private
  
    def set_context
      @group = params[:group_id] ? current_user.groups.find(params[:group_id]) : nil
    end
  
    def set_location
      @location = @group ? @group.locations.find(params[:id]) : current_user.locations.where(group_id: nil).find(params[:id])
    end
  
    def location_params
      params.require(:location).permit(:name)
    end
  
    def context_params
      @group ? { group_id: @group.id } : {}
    end
  end
