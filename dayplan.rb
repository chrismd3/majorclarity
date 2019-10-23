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
