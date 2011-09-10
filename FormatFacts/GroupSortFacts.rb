require 'csv'

values = CSV.read("FactsMasterList.csv")

$facts = { 1 => [], 2 => [], 3 => [], 4 => [], 5 => [] }

values.each { |bla|
    if (bla[0].to_i == 0) then next end
    $facts[bla[0].to_i].push(bla[1])
    }

# ratio of this level to the one above it
$ratio = { 1 => 0.0, 2 => 0.0, 3 => 0.0, 4 => 0.0, 5 => 1.0 }

$ratio[5] = (1).to_f
$ratio[4] = ($facts[4].length.to_f / $facts[5].length.to_f).to_f
$ratio[3] = ($facts[3].length.to_f / $facts[4].length.to_f).to_f
$ratio[2] = ($facts[2].length.to_f / $facts[3].length.to_f).to_f
$ratio[1] = ($facts[1].length.to_f / $facts[2].length.to_f).to_f

# ratio of this level relative to level 5
$ratio_from_top = { 1 => 0.0, 2 => 0.0, 3 => 0.0, 4 => 0.0, 5 => 1.0 }

$ratio_from_top[5] = ($ratio[5]).to_f
$ratio_from_top[4] = ($ratio_from_top[5].to_f * $ratio[4].to_f).to_f
$ratio_from_top[3] = ($ratio_from_top[4].to_f * $ratio[3].to_f).to_f
$ratio_from_top[2] = ($ratio_from_top[3].to_f * $ratio[2].to_f).to_f
$ratio_from_top[1] = ($ratio_from_top[2].to_f * $ratio[1].to_f).to_f

$ZID = 1

#def DoLevel(level, output)
def DoLevel(level)

   # number of facts remaining for level
   remaining = $facts[level].length

   # how many would ideally be printed this time
   ideal = $ratio_from_top[level]

   enabled = false

   if (remaining < ideal)
      printnum = remaining
      enabled = false
   else
      printnum = ideal
      enabled = true
   end

   # print facts
   (1..printnum).each do |num|
      fact = $facts[level].pop
      #output << ["##{$ZID} #{fact}"]
      puts "##{$ZID} #{fact}"
      
      $ZID += 1
   end

   return enabled

end

$level_enabled = { 1 => true, 2 => true, 3 => true, 4 => true, 5 => true }

#outfile = File.open('FactsMasterListSorted.csv', 'wb')
#CSV::Writer.generate(outfile) do |output|

    while $level_enabled[2] == true || $level_enabled[3] == true || $level_enabled[4] == true || $level_enabled[5] == true do

       #$level_enabled[5] = DoLevel(5, output) if $level_enabled[5]
       #$level_enabled[4] = DoLevel(4, output) if $level_enabled[4]
       #$level_enabled[3] = DoLevel(3, output) if $level_enabled[3]
       #$level_enabled[2] = DoLevel(2, output) if $level_enabled[2]

       $level_enabled[5] = DoLevel(5) if $level_enabled[5]
       $level_enabled[4] = DoLevel(4) if $level_enabled[4]
       $level_enabled[3] = DoLevel(3) if $level_enabled[3]
       $level_enabled[2] = DoLevel(2) if $level_enabled[2]

    end

#end
