nums = [1, 2, 3, 5, 3]
operands = ['+', '*', '-', '*']

str = nums[0].to_s
operands.each_with_index {
  |oper, index|
  str << ' ' + oper + ' ' + nums[index+1].to_s
}

puts str
puts eval str
puts eval "1 + 2 * 3 - 5 * 3"