
#!/usr/bin/env fish
echo "day-06"
set filepath input/day-06.txt

set matrix (cat $filepath | string join "|")

set max_row (echo $matrix | string split "|" | count)
set max_col (echo $matrix | string split "|" | sed -n 1p | string split "" | count)

set coord (string split "," (cat $filepath | grep -n -m 1 '\^' | awk -F: '{print $1 "," index($2, "^")}'))

function validate
  set row $argv[1]
  set col $argv[2]

  if test $row -ge 1 -a $row -le $max_row -a $col -ge 1 -a $col -le $max_col
    return 0
  end

  return 1
end

function elem_safe
  set row $argv[1]
  set col $argv[2]

  if test $row -ge 1 -a $row -le $max_row -a $col -ge 1 -a $col -le $max_col
      echo $matrix | string split "|" | sed -n "$row"p | string split "" | sed -n "$col"p
  else
      echo ""
  end
end

set x $coord[1]
set y $coord[2]
set orientation 1
set -g visited

while validate $x $y
  if not contains "$x,$y" $visited
    set -ga visited "$x,$y"
  end

  set dx $x
  set dy $y

  # up
  if test $orientation -eq 1
    set dx (math $dx - 1)
  end

  # down
  if test $orientation -eq 3
    set dx (math $dx + 1)
  end

  # left
  if test $orientation -eq 4
    set dy (math $dy - 1)
  end

  # right
  if test $orientation -eq 2
    set dy (math $dy + 1)
  end

  set elem (elem_safe $dx $dy)

  if test $elem = "#"
    # blocked
    set orientation (math "(($orientation) % 4)+1")
  else 
    set -g x $dx
    set -g y $dy
  end
end

# first-part
echo "first-part: $(count $visited)"
