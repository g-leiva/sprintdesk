class DashboardController < ApplicationController
  def index
    @teams = current_user.teams.includes(:sprints)
  end
end
