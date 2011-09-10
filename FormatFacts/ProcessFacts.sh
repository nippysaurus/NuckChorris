echo Sorting Facts
ruby GroupSortFacts.rb > FactsMasterListSorted.csv

echo Converting to Plist
awk -f ToPlist.awk FactsMasterListSorted.csv > "Facts.plist"

plutil "Facts.plist"
