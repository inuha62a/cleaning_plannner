class StaticPagesController < ApplicationController
  before_action :authenticate_user!
  def home; end

  def terms; end

  def privacy; end

  def contact; end
end
