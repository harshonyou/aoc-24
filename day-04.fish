#!/usr/bin/env fish
echo "day-04"
set filepath input/day-04.txt

set matrix (cat $filepath | string join "|")

set max_row (echo $matrix | string split "|" | count)
set max_col (echo $matrix | string split "|" | sed -n 1p | string split "" | count)

function elem_safe
  set row $argv[1]
  set col $argv[2]

  if test $row -ge 1 -a $row -le $max_row -a $col -ge 1 -a $col -le $max_col
      echo $matrix | string split "|" | sed -n "$row"p | string split "" | sed -n "$col"p
  else
      echo ""
  end
end

set count 0

function process_cell
  set i $argv[1]
  set j $argv[2]

  set e (elem_safe $i $j)

  if test $e = "X"
    set jm1 (elem_safe $i (math $j - 1))
    set jm2 (elem_safe $i (math $j - 2))
    set jm3 (elem_safe $i (math $j - 3))
    set jp1 (elem_safe $i (math $j + 1))
    set jp2 (elem_safe $i (math $j + 2))
    set jp3 (elem_safe $i (math $j + 3))

    set im1 (elem_safe (math $i - 1) $j)
    set im2 (elem_safe (math $i - 2) $j)
    set im3 (elem_safe (math $i - 3) $j)
    set ip1 (elem_safe (math $i + 1) $j)
    set ip2 (elem_safe (math $i + 2) $j)
    set ip3 (elem_safe (math $i + 3) $j)

    set bm1 (elem_safe (math $i - 1) (math $j - 1))
    set bm2 (elem_safe (math $i - 2) (math $j - 2))
    set bm3 (elem_safe (math $i - 3) (math $j - 3))
    set bp1 (elem_safe (math $i + 1) (math $j + 1))
    set bp2 (elem_safe (math $i + 2) (math $j + 2))
    set bp3 (elem_safe (math $i + 3) (math $j + 3))

    set fm1 (elem_safe (math $i - 1) (math $j + 1))
    set fm2 (elem_safe (math $i - 2) (math $j + 2))
    set fm3 (elem_safe (math $i - 3) (math $j + 3))
    set fp1 (elem_safe (math $i + 1) (math $j - 1))
    set fp2 (elem_safe (math $i + 2) (math $j - 2))
    set fp3 (elem_safe (math $i + 3) (math $j - 3))

    set local_count 0
    if test $jm1 = "M" -a $jm2 = "A" -a $jm3 = "S"
        set local_count (math $local_count + 1)
    end

    if test $jp1 = "M" -a $jp2 = "A" -a $jp3 = "S"
        set local_count (math $local_count + 1)
    end

    if test $im1 = "M" -a $im2 = "A" -a $im3 = "S"
        set local_count (math $local_count + 1)
    end

    if test $ip1 = "M" -a $ip2 = "A" -a $ip3 = "S"
        set local_count (math $local_count + 1)
    end

    if test $bm1 = "M" -a $bm2 = "A" -a $bm3 = "S"
        set local_count (math $local_count + 1)
    end

    if test $bp1 = "M" -a $bp2 = "A" -a $bp3 = "S"
        set local_count (math $local_count + 1)
    end

    if test $fm1 = "M" -a $fm2 = "A" -a $fm3 = "S"
        set local_count (math $local_count + 1)
    end

    if test $fp1 = "M" -a $fp2 = "A" -a $fp3 = "S"
        set local_count (math $local_count + 1)
    end

    set -g count (math $count + $local_count)
  end
end

for i in (seq 1 $max_row)
    for j in (seq 1 $max_col)
        process_cell $i $j
    end
end

# part-one
echo "part-one: $count"


set count 0

function process_cross
  set i $argv[1]
  set j $argv[2]

  set e (elem_safe $i $j)

  if test $e = "A"
    set bm (elem_safe (math $i - 1) (math $j - 1))
    set bp (elem_safe (math $i + 1) (math $j + 1))

    set fm (elem_safe (math $i - 1) (math $j + 1))
    set fp (elem_safe (math $i + 1) (math $j - 1))

    set local_count 0

    if test $bm = "M" -a $bp = "S"
      set local_count (math $local_count + 1)
    end

    if test $bm = "S" -a $bp = "M"
      set local_count (math $local_count + 1)
    end

    if test $fm = "M" -a $fp = "S"
      set local_count (math $local_count + 1)
    end

    if test $fm = "S" -a $fp = "M"
        set local_count (math $local_count + 1)
    end
    
    if test $local_count -ge 2
      set -g count (math $count + 1)
    end
  end
end

for i in (seq 1 $max_row)
    for j in (seq 1 $max_col)
        process_cross $i $j
    end
end

# part-two
echo "part-two: $count"
