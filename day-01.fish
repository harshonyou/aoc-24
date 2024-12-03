#!/usr/bin/env fish
echo "day-01"
set filepath input/day-01.txt

set first (cat $filepath | awk '{print $1}' | sort -n)
set last (cat $filepath | awk '{print $2}' | sort -n)

if not test (count $first) -eq (count $last)
  echo "The length aren't equal"
end

set length (count $first)
set sum 0

for i in (seq 1 $length)
  set difference (math $first[$i] - $last[$i])

  set sum (math $sum + abs $difference)
end

# part-one
echo "part-one: $sum"

set sum 0

for num in $first
  set freq (string match $num $last | count)

  set sum (math "$sum + $num * $freq")
end

# part-two
echo "part-two: $sum"
