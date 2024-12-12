#!/usr/bin/env fish
echo "day-05"
set filepath input/day-05.txt

set toggle 0

set rules
set updates

while read -l line
  if test $line = ''
    set toggle 1
    continue
  end

  if test $toggle -eq 0
    set -a rules $line
  else
    set -a updates $line
  end
end < $filepath

function middle_child
  set elems (string split "," $argv[1])
  set length (count $elems)

  echo $elems[(math "($length + 1) / 2")]
end

function check
  set elems $argv[1]

  for rule in $rules
    set ops (string split "|" $rule)
    if string match -q "*$ops[1]*" "$elems" && string match -q "*$ops[2]*" "$elems"
      if ! string match -q -r "$ops[1].*$ops[2]" "$elems"
        return 1
      end
    end
  end
  
  return 0
end


set sum 0

for update in $updates
  if check $update
    set sum (math $sum + (middle_child $update))
  end
end

# part-one
echo "part-one: $sum"

