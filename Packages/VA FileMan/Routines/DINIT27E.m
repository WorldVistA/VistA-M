DINIT27E ;SFISC/DPC-FOREIGN FORMAT EXCEL(TAB) ;11/30/92  3:44 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT27F S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DIST(.44,.005,0)
 ;;=EXCEL (TAB)^009^^^^^^^1^^^1
 ;;^DIST(.44,.005,3,0)
 ;;=^^2^2^2921120^
 ;;^DIST(.44,.005,3,1,0)
 ;;=Format used to export data to EXCEL spreadsheet running on the Macintosh
 ;;^DIST(.44,.005,3,2,0)
 ;;=or under Windows.  A <TAB> is placed between each field's value.
 ;;^DIST(.44,.005,4,0)
 ;;=^^6^6^2921120^^^
 ;;^DIST(.44,.005,4,1,0)
 ;;=Select the Open command on Excel's File menu.  Press the TEXT button and
 ;;^DIST(.44,.005,4,2,0)
 ;;=make sure that the Column Delimiter is set to "TAB."  Select the file.
 ;;^DIST(.44,.005,4,3,0)
 ;;=Each field's values will be imported into columns.
 ;;^DIST(.44,.005,4,4,0)
 ;;=If you are capturing data to make your export file, be sure that the <TAB>
 ;;^DIST(.44,.005,4,5,0)
 ;;=(ASCII value 009) is not converted to spaces by your communications
 ;;^DIST(.44,.005,4,6,0)
 ;;=software.
 ;;^DIST(.44,.005,5,0)
 ;;=^.441^1^1
 ;;^DIST(.44,.005,5,1,0)
 ;;=Tab Delimited
 ;;^DIST(.44,.005,5,1,1,0)
 ;;=^^1^1^2921120^^
 ;;^DIST(.44,.005,5,1,1,1,0)
 ;;=A <TAB> is placed between each field's value.
 ;;^DIST(.44,.005,5,"B","Tab Delimited",1)
 ;;=
