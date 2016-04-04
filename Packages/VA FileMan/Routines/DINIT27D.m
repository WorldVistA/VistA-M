DINIT27D ;SFISC/DPC-FOREIGN FORMAT EXCEL(DATA PARSE) ;11/30/92  3:42 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT27E S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DIST(.44,.004,0)
 ;;=EXCEL (DATA PARSE)^^^^^1^^255^1^^^1
 ;;^DIST(.44,.004,1)
 ;;=W $$DPXCEL^DDXPLIB(DDXPXTNO)
 ;;^DIST(.44,.004,3,0)
 ;;=^^4^4^2921120^
 ;;^DIST(.44,.004,3,1,0)
 ;;=Use the EXCEL-DATA PARSE format to export data to the EXCEL spreadsheet
 ;;^DIST(.44,.004,3,2,0)
 ;;=program running on the Macintosh or under windows.  Exported data is fixed
 ;;^DIST(.44,.004,3,3,0)
 ;;=length.  The first line output is a guide for use by EXCEL's Data Parser
 ;;^DIST(.44,.004,3,4,0)
 ;;=to place data into columns.  Maximum record length is 255 characters.
 ;;^DIST(.44,.004,4,0)
 ;;=^^7^7^2921120^
 ;;^DIST(.44,.004,4,1,0)
 ;;=To import a file created in this format into Excel, choose the Open
 ;;^DIST(.44,.004,4,2,0)
 ;;=command on the File menu and select the file.  Each record will be put
 ;;^DIST(.44,.004,4,3,0)
 ;;=into a single cell.  Select the column that has the data, including the
 ;;^DIST(.44,.004,4,4,0)
 ;;=first record which will contain the guide for data parsing.  Then, choose
 ;;^DIST(.44,.004,4,5,0)
 ;;=Parse from the Data menu.  Press the GUESS button and then press OK.  The
 ;;^DIST(.44,.004,4,6,0)
 ;;=data will be put into correct columns.  You may need to adjust column
 ;;^DIST(.44,.004,4,7,0)
 ;;=widths.
