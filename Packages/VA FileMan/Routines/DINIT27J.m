DINIT27J ;SFISC/DPC-ORACLE (FIXED FORMAT) FOREIGN FORMAT ;2/26/93  10:59 AM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT27K S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DIST(.44,.008,0)
 ;;=ORACLE (FIXED FORMAT)^^^^^1^1^255^1^^^1
 ;;^DIST(.44,.008,1)
 ;;=D ORACTL^DDXPLIB
 ;;^DIST(.44,.008,3,0)
 ;;=^^5^5^2930125^
 ;;^DIST(.44,.008,3,1,0)
 ;;=Use this format to export data to an Oracle table.  Data will be exported
 ;;^DIST(.44,.008,3,2,0)
 ;;=in fixed format.  The user will be prompted for the length of each field
 ;;^DIST(.44,.008,3,3,0)
 ;;=and the field name.  By default, the data will be imported into an Oracle
 ;;^DIST(.44,.008,3,4,0)
 ;;=table with the same name as the export template used to export the data.
 ;;^DIST(.44,.008,3,5,0)
 ;;=The field names should be the column_names in the Oracle table.
 ;;^DIST(.44,.008,4,0)
 ;;=^^14^14^2930125^
 ;;^DIST(.44,.008,4,1,0)
 ;;=This format produces a control file to be used with Oracle's SQL*LOADER
 ;;^DIST(.44,.008,4,2,0)
 ;;=utility to load data into a preexisting Oracle table.  The control file is
 ;;^DIST(.44,.008,4,3,0)
 ;;=complete as created, but you may edit the file to modify the import.  By
 ;;^DIST(.44,.008,4,4,0)
 ;;=default, the data will be imported into a table with the same name as that
 ;;^DIST(.44,.008,4,5,0)
 ;;=of the export template.  Spaces in the export template name will be
 ;;^DIST(.44,.008,4,6,0)
 ;;=converted to underscores (_). So, either that table must exist in your
 ;;^DIST(.44,.008,4,7,0)
 ;;=Oracle table_space with the columns specified when the export template was
 ;;^DIST(.44,.008,4,8,0)
 ;;=built or the exported file will need to be modified to show the correct
 ;;^DIST(.44,.008,4,9,0)
 ;;=table_name.  A minimum syntax for loading an export file named
 ;;^DIST(.44,.008,4,10,0)
 ;;=INTO_ORACLE.CTL would be:
 ;;^DIST(.44,.008,4,11,0)
 ;;=|TAB|
 ;;^DIST(.44,.008,4,12,0)
 ;;=       SQLLOAD USERID=username/password, CONTROL=INTO_ORACLE.CTL|TAB|
 ;;^DIST(.44,.008,4,13,0)
 ;;= 
 ;;^DIST(.44,.008,4,14,0)
 ;;=Of course, other options are available.  Consult your Oracle documentation.
 ;;^DIST(.44,.008,5,0)
 ;;=^.441^^
