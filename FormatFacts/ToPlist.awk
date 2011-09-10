#!/usr/bin/awk -f

BEGIN {

   print "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
   print "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">"
   print "<plist version=\"1.0\">"
   print "<dict>"
   print "\t<key>Facts</key>"
   print "\t<array>"

}

{

printf "\t\t<string>%s</string>\n", $0

}

END {
   print "\t</array>"
   print "</dict>"
   print "</plist>"
}
