echo doing magic process
ruby GroupSortFacts.rb > FactsMasterListSorted.csv

echo converting to plist
awk -f ToPlist.awk FactsMasterListSorted.csv > "Facts.plist"

rm FactsMasterListSorted.csv

echo doing plist lint
plutil "Facts.plist" > /dev/null

if [[ $? != 0 ]] ; then
    echo "PLUTIL FAILED"
    exit 1
fi

echo deploying
mv -f Facts.plist ../NuckChorris/Facts.plist

exit 0
