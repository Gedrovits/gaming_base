class PlayController < ApplicationController
  def index
    @filters = OpenStruct.new
  end

  layout false, only: :results

  def results
    @page = params[:page] ||= 1

    # TODO: Later this can be object Filters
    # @filters = OpenStruct.new(params[:filters])
    # @games = @filters.dig(:games)&.reject(&:blank?)

    q = Gamer.where.not(id: current_gamer.id) # Do not show self
    # Games filters
    q = q.joins(:games).where(games: { id: params[:game] }) # unless @games.blank?

    # print q.to_sql
    @gamers = q.page(@page).per(15)
  end
end
