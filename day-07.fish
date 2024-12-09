#!/usr/bin/env fish
echo "day-07"
set filepath input/day-07.txt

echo "warning: it might take upto a couple of hours, you have been warned :)"

set target (cat $filepath | awk -F': '  '{print $1}')

set operands (cat $filepath | awk -F': '  '{print $2}')

function get_permutations
  set length $argv[1]

  set permutations (python3 -c "
import itertools
length = $length
perms = list(itertools.product([0, 1], repeat=length))
print('|'.join([' '.join(map(str, p)) for p in perms]))
")

  echo $permutations
end

function process_cell
  set tar $argv[1]
  set ops $argv[2]
  set ops (string split ' ' $ops)
  set length (count $ops)

  set permutations (string split '|' (get_permutations (math $length - 1)))
  

  for perm in $permutations
    set resultant $ops[1]
    set counter 2

    for operator in (string split ' ' $perm)
      if test $operator -eq 0
        set resultant (math $resultant + $ops[$counter]) 
      end
      if test $operator -eq 1
        set resultant (math $resultant \* $ops[$counter]) 
      end

      set counter (math $counter + 1)
    end

    if test $resultant -eq $tar
      return 0
    end
    
  end

  return 1
end

set sum 0

for i in (seq 1 (count $target))
  if process_cell $target[$i] $operands[$i]
    set sum (math $sum + $target[$i])
  end
end

# part-one
echo "part-one: $sum"


function get_permutations_two
  set length $argv[1]

  set permutations (python3 -c "
import itertools
length = $length
perms = list(itertools.product([0, 1, 2], repeat=length))
print('|'.join([' '.join(map(str, p)) for p in perms]))
")

  echo $permutations
end

function process_cell_two
  set tar $argv[1]
  set ops $argv[2]
  set ops (string split ' ' $ops)
  set length (count $ops)

  set permutations (string split '|' (get_permutations_two (math $length - 1)))
  

  for perm in $permutations
    set resultant $ops[1]
    set counter 2

    for operator in (string split ' ' $perm)
      if test $operator -eq 0
        set resultant $resultant$ops[$counter]
      end
      if test $operator -eq 1
        set resultant (math $resultant \* $ops[$counter]) 
      end
      if test $operator -eq 2
        set resultant (math $resultant + $ops[$counter]) 
      end

      if test $resultant -gt $tar
        break
      end

      set counter (math $counter + 1)
    end

    if test $resultant -eq $tar
      return 0
    end
    
  end

  return 1
end

set sum 0

for i in (seq 1 (count $target))
  if process_cell_two $target[$i] $operands[$i]
    set sum (math $sum + $target[$i])
  end
end

# part-two
echo "part-two: $sum"
