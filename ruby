require 'date'
require 'optparse'

def create_calendar(_mon = Date.today.mon)
  year = Date.today.year
  month = _mon
  month_name = Date::MONTHNAMES[month]

  calender_head = "#{month_name} #{year}"

  week = %w[月 火 水 木 金 土 日].join(' ')
  puts calender_head.center(20)
  puts week

  first_wday = Date.new(year, month, 1) # 月初めの曜日
  last_day = Date.new(year, month, -1) # 月終わり
  print '   ' * first_wday.wday

  (first_wday..last_day).each do |date|
    print date.day.to_s.rjust(2) + ' '
    puts if date.wday == 0
  end
end

def get_month_by_option
  opt = OptionParser.new

  opt.on('-m VAL') do |m|
    month = m.to_i
    if month > 12
      puts " #{month} is neither a month number (1..12) nor a name"
    else
      create_calendar(month)
    end
  end

  if ARGV.empty?
    default_month = Date.today.mon
    create_calendar(default_month)
  end
  opt.parse!(ARGV)
end

get_month_by_option
