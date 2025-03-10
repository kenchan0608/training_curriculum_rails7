class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    get_week
    @plan = Plan.new
  end

  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']
    @todays_date = Date.today

    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)

    7.times do |x|
      today = @todays_date + x
      today_plans = plans.select { |plan| plan.date == today }.map(&:plan)

      days = {
        month: today.month,
        date: today.day,
        wday: wdays[today.wday], 
        plans: today_plans
      }
      @week_days.push(days)
    end
  end
end

