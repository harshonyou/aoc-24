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
      if not string match -q -r "$ops[1].*$ops[2]" "$elems"
        return 1
      end
    end
  end
  
  return 0
end


set sum 0
set -g failed

for idx in (seq 1 (count $updates))
  if check $updates[$idx]
    set sum (math $sum + (middle_child $updates[$idx]))
  else 
    set -g -a failed $idx
  end
end

# part-one
echo "part-one: $sum"



function correct
  set elems $argv[1]

  for rule in $rules
    set ops (string split "|" $rule)
    if string match -q "*$ops[1]*" "$elems" && string match -q "*$ops[2]*" "$elems"
      if ! string match -q -r "$ops[1].*$ops[2]" "$elems"
        set -l items (string split "," $elems)

        for i in (seq (count $items))
          if test $items[$i] = $ops[1]
            set pos1 $i
          end
          if test $items[$i] = $ops[2]
            set pos2 $i
          end
        end

        set temp $items[$pos1]
        set items[$pos1] $items[$pos2]
        set items[$pos2] $temp

        set elems (string join "," $items)
      end
    end
  end

  echo $elems
end


set sum 0

for fail_idx in $failed
  set elems $updates[$fail_idx]
  
  while not check $elems
    set elems (correct $elems)
  end
  
  set sum (math $sum + (middle_child $elems))
end

# part-two
echo "part-two: $sum"

