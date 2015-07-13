def towerInitial(num)
  towerArray = {}
  towerArray["1"] = [0]*num
  towerArray["2"] = [0]*num
  towerArray["3"] = [0]*num
  1.upto(num) {|row|
               towerArray["1"][row-1] = (num-row+1)
               }
puts towerArray
return towerArray
end

def towerDraw(towerArray)
  (towerArray["1"].length-1).downto(0){|number|
    print("#"*towerArray["1"][number]+"   "*(towerArray["1"].length+2 - towerArray["1"][number]))
    print("#"*towerArray["2"][number]+"   "*(towerArray["1"].length+2 - towerArray["2"][number]))
    print("#"*towerArray["3"][number]+"   "*(towerArray["1"].length+2 - towerArray["3"][number]))
    print"\n"
  }
  puts("1"+"   "*(towerArray["1"].length+1)+"2"+"   "*(towerArray["1"].length+1)+"3")
end

def input(num1,num2)
  puts"choose start tower"
  num1 = gets.chomp
  puts"choose end"
  num2 = gets.chomp
  if num1 =="q" || num2 == "q"
    puts "Game Quit"
    return main()
  end
  return [num1,num2]
end

def check(num1, num2, towerArray)
  checkpass1 = 0
  checkpass2 = 0
  checkpass3 = 0
  checkpass = 0
  num1 = num1
  num2 = num2
  while checkpass !=1 do
     checkpass1,num1,num2 = inputcheck(num1,num2)
      checkpass2,num1,num2 = emptycheck(towerArray,num1,num2)
     checkpass3,num1,num2 = largercheck(num1,num2,towerArray)
      checkpass = checkpass1*checkpass2*checkpass3
    end
end

def inputcheck(num1,num2)
  checkpass1 = 0
     if ((num1== "3" )||(num1=="1") ||(num1== "2")||(num1=="q" ))&&((num2 == "3")||(num2== "1")||(num2==  "2")||(num2 == "q" ))
       puts"checkpass-1"
       checkpass1 = 1
       return checkpass1,num1,num2
     else
       puts"input is not allowed by the format"
       num1,num2 = input(num1,num2) until ((num1== "3" )||(num1=="1") ||(num1== "2")||(num1=="q" ))&&((num2 == "3")||(num2== "1")||(num2==  "2")||(num2 == "q" ))
      checkpass1 = 1
      return checkpass1,num1,num2
    end
end

def emptycheck(towerArray,num1,num2)
    checkpass2 = 0
    if towerArray[num1]!=[0]*(towerArray[num1].length)
      puts"checkpass-2"
      checkpass2 =1
      return checkpass2,num1,num2
    else
      puts"start tower is empty,choose another way to move"
      num1,num2 = input(num1,num2) until towerArray[num1]!=[0]*(towerArray[num1].length)
      checkpass2 = 1
      return checkpass2,num1,num2
    end
    
end

def largercheck(num1,num2,towerArray)
  checkpass3 = 0
  if  (towerArray[num1][findLast(towerArray[num1])]<towerArray[num2][findLast(towerArray[num2])]) || (towerArray[num2][findLast(towerArray[num2])]==0)
  checkpass3 = 1
  puts"checkpass-3"
  return checkpass3,num1,num2
  else
    puts towerArray[num1][findLast(towerArray[num1])]
    puts towerArray[num2][findLast(towerArray[num2])]
    puts"larger loop are not allowed to put on "
    num1,num2 = input(num1,num2) until (towerArray[num1.to_s][findLast(towerArray[num1.to_s])]>towerArray[num2.to_s][findLast(towerArray[num2.to_s])])&&(towerArray[num2.to_s][findLast(towerArray[num2.to_s])]!=0)
    return checkpass3,num1,num2
  end
end


def move(num1,num2,towerArray)
 num1 =  num1.to_s
  num2 = num2.to_s
  trail = towerArray[num1][findLast(towerArray[num1])]
  towerArray[num1][findLast(towerArray[num1])] = 0
  addNew(towerArray[num2],trail)
  return towerArray
end

=begin
def checkFull(arr)
  if arr[arr.length-1]!=0
    puts"Warning, the target tower is full, please choose another move!"
    return initialMove()
  end
end
=end

def findLast(arr)
  (arr.size - 1).downto(0) {
  |index|
  unless arr[index] == 0
    return index
    end
  }
  return (-1)
end

def addNew(arr, trail)
  arr[findLast(arr)+1] = trail
end

def towerCheck(tower,win)
  unless  tower["3"][tower["3"].length-1] == 0
    puts"you win"
    win = 1
  end
end

def main()
  num1 = 0
  num2 = 0
  win = 0
  puts"hanoi tower game start"
  puts"how tall is the tower(type a number)"
  num = gets.chomp
  tower = towerInitial(num.to_i)
  towerDraw(tower)
  puts"press q to quit"
      puts tower
  while win!=1 || num1!="q"||num2 != "q" do
    num1,num2 = input(num1,num2)#[0], input(num1,num2)[1]
    check(num1, num2, tower)
    tower = move(num1,num2,tower)
    towerDraw(tower)
    towerCheck(tower,win)
  end
end

main()
