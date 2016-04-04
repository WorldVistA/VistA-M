DINIT27K ;SFISC/DPC-ORACLE (DELIMITED) FOREIGN FORMAT ;6/10/93  13:35
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT28 S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DIST(.44,.009,0)
 ;;=ORACLE (DELIMITED)^,^^^^0^1^0^1^1^^1
 ;;^DIST(.44,.009,1)
 ;;=D ORACTL^DDXPLIB
 ;;^DIST(.44,.009,3,0)
 ;;=^^7^7^2930125^
 ;;^DIST(.44,.009,3,1,0)
 ;;=Use this format to export data to an Oracle table.  Data will be exported
 ;;^DIST(.44,.009,3,2,0)
 ;;=in comma-delimited format and non-numeric fields will be surrounded by
 ;;^DIST(.44,.009,3,3,0)
 ;;=quotes.  The user will be prompted for field names.  The field names
 ;;^DIST(.44,.009,3,4,0)
 ;;=should be the column_names in the Oracle table.  Also, the user will need
 ;;^DIST(.44,.009,3,5,0)
 ;;=to supply the maximum length of a record to be exported.  By default, data
 ;;^DIST(.44,.009,3,6,0)
 ;;=will be imported into a table with the same name as that of the export
 ;;^DIST(.44,.009,3,7,0)
 ;;=template.
 ;;^DIST(.44,.009,4,0)
 ;;=^^13^13^2930125^
 ;;^DIST(.44,.009,4,1,0)
 ;;=This format produces a control file to be used with Oracle's SQL*LOADER
 ;;^DIST(.44,.009,4,2,0)
 ;;=utility to load data into a preexisting Oracle table.  The control file is
 ;;^DIST(.44,.009,4,3,0)
 ;;=complete as created, but you may edit the file to modify the import.  By
 ;;^DIST(.44,.009,4,4,0)
 ;;=default, the data will be imported into a table with the same name as that
 ;;^DIST(.44,.009,4,5,0)
 ;;=of the export template.  So, either that table must exist in your Oracle
 ;;^DIST(.44,.009,4,6,0)
 ;;=table_space with the columns specified when the export template was built
 ;;^DIST(.44,.009,4,7,0)
 ;;=or the exported file will need to be modified to show the correct
 ;;^DIST(.44,.009,4,8,0)
 ;;=table_name.  A minimum syntax for loading an export file named
 ;;^DIST(.44,.009,4,9,0)
 ;;=INTO_ORACLE.CTL would be:
 ;;^DIST(.44,.009,4,10,0)
 ;;= |TAB|
 ;;^DIST(.44,.009,4,11,0)
 ;;=       SQLLOAD USERID=username/password, CONTROL=INTO_ORACLE.CTL|TAB|
 ;;^DIST(.44,.009,4,12,0)
 ;;= 
 ;;^DIST(.44,.009,4,13,0)
 ;;=Of course, other options are available.  Consult your Oracle documentation.
 ;;^DIST(.44,.009,5,0)
 ;;=^.441^^
