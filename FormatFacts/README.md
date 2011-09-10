INTRO
=====

ThatGuyFacts reads the list of "facts" from a standard plist file named "Facts.plist" which must reside in the main project directory. The files in this directory will assist you with constructing the plist file the "facts master list".

FILES
=====

FactsMasterList.csv
-------------------

The master list of all facts in CSV format.

GroupSortFacts.rb
-----------------

This is the most complicated part of the process. This Ruby script uses the "awesomeness" rating which I have given each "fact" to make an evenly distributed list of awesome and less aresome facts.

ProcessFacts.sh
---------------

A bash script which executes the entire process. First it uses the ruby script to process the ordering of the facts into another CSV (FactsMasterListSorted.csv), then AWK to format that into a plist file.

FactsMasterList.csv >> GroupSortFacts.rb >> FactsMasterListSorted.csv
FactsMasterListSorted.csv >> ToPlist.awk >> Facts.plist

ToPlist.awk
-----------

This AWK script takes the sorted master list as an input and outputs a valid plist file.


UAGE
====

Simply navigate to this directory in a commandline environment and execute "ProcessFacts.sh", which should construct the plist file in the current directory. Once it has been created you can move it to the parent folder manually (gives you a chance to review its contents).