#!/usr/bin/env fish
echo "day-03"
set filepath input/day-03.txt

set operations (grep -oE 'mul\([0-9]+,[0-9]+\)' $filepath)


set operands

for operation in $operations
  set -a operands (echo $operation | awk -F'[()]' '{print $2}')
end


set sum 0

for pair in $operands
  set ops (string split ',' $pair)

  set sum (math $sum + \($ops[1] \* $ops[2]\))
end

# part-one
echo "part-one: $sum"
