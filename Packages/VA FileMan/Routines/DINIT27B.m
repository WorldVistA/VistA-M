DINIT27B ;ISCSF/DPC-FOREIGN FORMAT 1-2-3 IMPORT NUMBERS ;1/11/93  2:34 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT27C S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DIST(.44,.002,0)
 ;;=1-2-3 IMPORT NUMBERS^032^^^^^^0^1^1^1^1^0
 ;;^DIST(.44,.002,3,0)
 ;;=^^9^9^2930107^
 ;;^DIST(.44,.002,3,1,0)
 ;;=This format exports data for use with LOTUS 1-2-3 spreadsheets.
 ;;^DIST(.44,.002,3,2,0)
 ;;=Non-numeric fields will be in quotes.  Each field will be separated by
 ;;^DIST(.44,.002,3,3,0)
 ;;=a space.  Null-valued numeric fields in the primary file will be converted
 ;;^DIST(.44,.002,3,4,0)
 ;;=to a zero ('0'). WARNING: If the value of a field that is not in the
 ;;^DIST(.44,.002,3,5,0)
 ;;=primary file or that is not defined in the VA FILEMAN data dictionary as
 ;;^DIST(.44,.002,3,6,0)
 ;;=numeric is null or zero, nothing is output. That is, a zero (0) is NOT
 ;;^DIST(.44,.002,3,7,0)
 ;;=output.  This will destroy the positional results of the data and will
 ;;^DIST(.44,.002,3,8,0)
 ;;=install data in incorrect columns!!  If this situation is possible, do NOT
 ;;^DIST(.44,.002,3,9,0)
 ;;=use this format; consider the 123 DATA PARSE format.
 ;;^DIST(.44,.002,4,0)
 ;;=^^4^4^2930107^
 ;;^DIST(.44,.002,4,1,0)
 ;;=To import into 1-2-3, choose FILE->IMPORT->NUMBERS.
 ;;^DIST(.44,.002,4,2,0)
 ;;=Field values will automatically be placed into columns.
 ;;^DIST(.44,.002,4,3,0)
 ;;=Lotus 1-2-3 will automatically recognize your file for import if it has an
 ;;^DIST(.44,.002,4,4,0)
 ;;=extension of '.PRN'.
 ;;^DIST(.44,.002,5,0)
 ;;=^.441^1^1
 ;;^DIST(.44,.002,5,1,0)
 ;;=LOTUS 123 (NUMBERS)
 ;;^DIST(.44,.002,5,"B","LOTUS 123 (NUMBERS)",1)
 ;;=
