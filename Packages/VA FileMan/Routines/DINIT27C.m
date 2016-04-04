DINIT27C ;SFISC/DPC-FOREIGN FORMAT EXCEL(COMMA) ;11/30/92  3:39 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT27D S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DIST(.44,.003,0)
 ;;=EXCEL (COMMA)^,^^^^^^1000^1^1^1^1
 ;;^DIST(.44,.003,3,0)
 ;;=^^6^6^2921120^
 ;;^DIST(.44,.003,3,1,0)
 ;;=Use this format to export data to the EXCEL spreadsheet running
 ;;^DIST(.44,.003,3,2,0)
 ;;=on the Macintosh or under Windows.  The exported data will have a comma
 ;;^DIST(.44,.003,3,3,0)
 ;;=between each field's value.  The user will be asked to specify the data
 ;;^DIST(.44,.003,3,4,0)
 ;;=type of each exported field.  Those fields that are not numeric will be
 ;;^DIST(.44,.003,3,5,0)
 ;;=surrounded by quotes (").  Commas are allowed in the non-numeric data, but
 ;;^DIST(.44,.003,3,6,0)
 ;;=quotes (") are not.
 ;;^DIST(.44,.003,4,0)
 ;;=^^3^3^2921120^^^^
 ;;^DIST(.44,.003,4,1,0)
 ;;=Select the Open command on Excel's File menu.  Press the TEXT button and
 ;;^DIST(.44,.003,4,2,0)
 ;;=make sure that the Column Delimiter is set to "comma."  Select the file.
 ;;^DIST(.44,.003,4,3,0)
 ;;=Each field's values will be imported into columns.
 ;;^DIST(.44,.003,5,0)
 ;;=^.441^2^2
 ;;^DIST(.44,.003,5,1,0)
 ;;=COMMA DELIMITED
 ;;^DIST(.44,.003,5,1,1,0)
 ;;=^^2^2^2921015^
 ;;^DIST(.44,.003,5,1,1,1,0)
 ;;=Exported data is delimited by commas.  Non-numeric data is surrounded by
 ;;^DIST(.44,.003,5,1,1,2,0)
 ;;=quotes.
 ;;^DIST(.44,.003,5,2,0)
 ;;=CSV
 ;;^DIST(.44,.003,5,2,1,0)
 ;;=^^1^1^2921120^^
 ;;^DIST(.44,.003,5,2,1,1,0)
 ;;=Comma Separated Values.
 ;;^DIST(.44,.003,5,"B","COMMA DELIMITED",1)
 ;;=
 ;;^DIST(.44,.003,5,"B","CSV",2)
 ;;=
