# I'll be working on this over the next week. I'm sure you understand I have a busy schedule.

example_one = [
{ name: "Meeting 1", duration: 1.5, type: :onsite },
{ name: "Meeting 2", duration: 2, type: :offsite },
{ name: "Meeting 3", duration: 1, type: :onsite },
{ name: "Meeting 4", duration: 1, type: :offsite },
{ name: "Meeting 5", duration: 1, type: :offsite }
]

example_two = [
{ name: "Meeting 1", duration: 4, type: :offsite },
{ name: "Meeting 2", duration: 4, type: :offsite }
]

example_three = [
{ name: "Meeting 1", duration: 0.5, type: :offsite },
{ name: "Meeting 2", duration: 0.5, type: :onsite },
{ name: "Meeting 3", duration: 2.5, type: :offsite },
{ name: "Meeting 4", duration: 3, type: :onsite }
]

# I've added an additional test to account for the case of only onsite meetings
example_four = [
{ name: "Meeting 1", duration: 4, type: :onsite },
{ name: "Meeting 2", duration: 4, type: :onsite }
]

def schedule_planner(meeting_list)
  # offsite meetings will be checked first. this way, the leading travel time will always be discarded.
  # if leading travel time occurs before the start of work, it can be discarded. if it overlaps with the previous meeting's trailing travel time, it can be discarded
  # trailing travel time is only subtracted after checking the time remaining because if it occurs after the end of day, it can be discarded.

  offsite_meetings = meeting_list.select { |schedule| schedule[:type] == :offsite }
  list_checker_output = list_checker(offsite_meetings)

  return list_checker_output[0] if list_checker_output[1] < -0.5

  onsite_meetings = meeting_list.select { |schedule| schedule[:type] == :onsite }
  list_checker_output = list_checker(onsite_meetings, list_checker_output[0], list_checker_output[1])

  return list_checker_output[0]
end

# refactoring the original into this method is debatable for readability, but it is DRYer

def list_checker(partial_list, suggested_schedule = [], time_remaining = 8)
  partial_list.each do |meeting|
    time_remaining = time_remaining - meeting[:duration]

    if time_remaining < 0
      # This would be done differently in production, but I feel this is a sufficient way to end the method early for this exercise
      return ["These meetings can't fit into one business day! Consider taking a nap.", -1]
    else
      start_time = clock_converter(time_remaining + meeting[:duration])
      end_time = clock_converter(time_remaining)

      suggested_schedule << start_time + " - " + end_time + " - " + meeting[:name]

      time_remaining = time_remaining - 0.5 if meeting[:type] == :offsite
    end
  end

  return [suggested_schedule, time_remaining]
end

def clock_converter(time_remaining)
  military_time = 17 - time_remaining

  # AM and PM are discarded in this implementation since there will only be one instance of each hour during a normal business day
  if military_time >= 13
    decimal_time = military_time - 12
  else
    decimal_time = military_time
  end

  hour = decimal_time.to_i

  # minutes are expressed as an integer
  minutes = (decimal_time % hour * 60).to_i

  # minutes are now expressed with a leading 0 if single digit. probably unnecessary, but this edge case has been accounted for
  minutes = sprintf '%02d', minutes

  # seconds have beeen simply discarded. other rounding methods could be used

  output_time = hour.to_s + ":" + minutes.to_s

  output_time
end

puts schedule_planner(example_one)
puts "\n"
puts schedule_planner(example_two)
puts "\n"
puts schedule_planner(example_three)
puts "\n"
puts schedule_planner(example_four)
puts "\n"
