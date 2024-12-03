#!/usr/bin/env fish
echo "day-02"
set filepath input/day-02.txt

set reports (cat $filepath)

function safety-check
  set report $argv[1]
  set levels (string split ' ' $report)
  set length (count $levels)

  if test $length -eq 0
    return 0
  end
  if test $length -eq 1
    return 1
  end

  set constant 1

  if test $levels[1] -gt $levels[-1]
    set constant -1
  end

  for i in (seq 2 $length)
    set difference (math $levels[$i] - $levels[(math $i - 1)])
    set abs_difference (math abs $difference)

    if not test (math $difference \* $constant) -ge 0 
      return 0
    end
    if not test $abs_difference -ge 1 -a $abs_difference -le 3
      return 0
    end
  end

  return 1
end

set count 0

for report in $reports
  safety-check $report
  set count (math $count + $status)
end

# part-one
echo "part-one: $count"


function one-off
  set report $argv[1]

  set length (echo $report | awk '{print NF}') 
  set valid 0

  for i in (seq 1 $length)
    set arr
    
    for j in (seq 1 $length)
      if not test $i -eq $j
        set -a arr (echo $report | awk "{print \$$j}")
      end
    end

    safety-check (string join ' ' $arr)

    set valid (math $valid + $status)

    if test $valid -ge 1
      return 1
    end
  end

  return 0
end


set count 0

for report in $reports
  safety-check $report
  set safety_status $status
  set count (math $count + $safety_status)

  if test $safety_status -ne 1
    one-off $report
    set count (math $count + $status)
  end
end

# part-two
echo "part-two: $count"
