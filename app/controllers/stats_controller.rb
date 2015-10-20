class StatsController < ApplicationController

  def entries
  	@total_count = Entry.count
    sql = "SELECT COUNT(*), state=#{ State::PROCESSED } AS is_processed, EXTRACT(MONTH FROM fetched_at) AS month, DATE(fetched_at) AS date
      FROM entries
      WHERE EXTRACT(YEAR FROM fetched_at)=#{ Date.today.year }
      GROUP BY month, state=#{ State::PROCESSED }, date ORDER BY date DESC;"
    @entries_counters = ActiveRecord::Base.connection.execute(sql).to_a
    @months = (1..Date.today.month.to_i).to_a
  end

end
