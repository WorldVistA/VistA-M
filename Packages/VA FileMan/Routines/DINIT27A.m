DINIT27A ;ISCSF/DPC-FOREIGN FORMAT 1-2-3 DATA PARSE ;1/11/93  2:27 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT27B S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DIST(.44,.001,0)
 ;;=1-2-3 DATA PARSE^^^^^1^^240^1^^1^1
 ;;^DIST(.44,.001,1)
 ;;=W $$DP123^DDXPLIB(DDXPXTNO)
 ;;^DIST(.44,.001,3,0)
 ;;=^^4^4^2921106^
 ;;^DIST(.44,.001,3,1,0)
 ;;=This format produces fixed length records designed for import into Lotus
 ;;^DIST(.44,.001,3,2,0)
 ;;=1-2-3.  The user is prompted for data types.  A special header is created
 ;;^DIST(.44,.001,3,3,0)
 ;;=that is used by 1-2-3's Data Parser.  The maximum record length is 240
 ;;^DIST(.44,.001,3,4,0)
 ;;=characters.
 ;;^DIST(.44,.001,4,0)
 ;;=^^10^10^2921120^
 ;;^DIST(.44,.001,4,1,0)
 ;;=To import data into 1-2-3 from a file created with this format: 1) Use
 ;;^DIST(.44,.001,4,2,0)
 ;;=File->Import->Text and select the file.  2) The first line of the file
 ;;^DIST(.44,.001,4,3,0)
 ;;=contains the information for the data parser.  You must change this from a
 ;;^DIST(.44,.001,4,4,0)
 ;;=label, preceded by ', to a format, preceded by ||.  Edit the line to make
 ;;^DIST(.44,.001,4,5,0)
 ;;=this change.  3) Use Data->Parse.  The Input Column range should include
 ;;^DIST(.44,.001,4,6,0)
 ;;=all the imported data, including the format line.  Select a desired Output
 ;;^DIST(.44,.001,4,7,0)
 ;;=Range. Finally, select Go to format the data in the output range. Be sure
 ;;^DIST(.44,.001,4,8,0)
 ;;=your columns are wide enough to hold the data.  NOTE: dates will be
 ;;^DIST(.44,.001,4,9,0)
 ;;=changed into numbers, 1-2-3's internal representation of a date. You can
 ;;^DIST(.44,.001,4,10,0)
 ;;=make the date readable by using Range->Format->Date.
 ;;^DIST(.44,.001,5,0)
 ;;=^.441^1^1
 ;;^DIST(.44,.001,5,1,0)
 ;;=Lotus 1-2-3 Data Parse
 ;;^DIST(.44,.001,5,"B","Lotus 1-2-3 Data Parse",1)
 ;;=
 ;;^DIST(.44,.001,6)
 ;;=S Y=$E(X,6,7)_"-"_$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,+$E(X,4,5))_"-"_$E(X,2,3) S:$E(X)'=2 Y="NOT 1900s"
