DINIT911 ;GFT/GFT-DIALOG FILE INITS ;07:13 PM  5 Dec 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,7076,0)
 ;;=7076^1^^2
 ;;^UTILITY(U,$J,.84,7076,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,7076,2,1,0)
 ;;=SWITCH Function Restricted
 ;;^UTILITY(U,$J,.84,7076,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,7076,5,1,0)
 ;;=DDBR2
 ;;^UTILITY(U,$J,.84,7076.1,0)
 ;;=7076.1^2^^2
 ;;^UTILITY(U,$J,.84,7076.1,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,7076.1,2,1,0)
 ;;=SWITCH Function Restricted to Current List
 ;;^UTILITY(U,$J,.84,7076.1,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,7076.1,5,1,0)
 ;;=DDBR2
 ;;^UTILITY(U,$J,.84,7076.3,0)
 ;;=7076.3^1^^2
 ;;^UTILITY(U,$J,.84,7076.3,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,7076.3,2,1,0)
 ;;=YOU CANNOT PRINT THE BROWSER HELP ON A CRT.
 ;;^UTILITY(U,$J,.84,7076.3,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,7076.3,5,1,0)
 ;;=DDBRP
 ;;^UTILITY(U,$J,.84,7076.4,0)
 ;;=7076.4^2^^2
 ;;^UTILITY(U,$J,.84,7076.4,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,7076.4,2,1,0)
 ;;=PRINT BROWSER HELP
 ;;^UTILITY(U,$J,.84,7076.4,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,7076.4,5,1,0)
 ;;=DDBRP
 ;;^UTILITY(U,$J,.84,7077,0)
 ;;=7077^2^^2
 ;;^UTILITY(U,$J,.84,7077,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,7077,2,1,0)
 ;;=HYPERTEXT JUMP IS NOT AVAILABLE
 ;;^UTILITY(U,$J,.84,7077,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,7077,5,1,0)
 ;;=DDBRAHTJ
 ;;^UTILITY(U,$J,.84,7078,0)
 ;;=7078^2^^2
 ;;^UTILITY(U,$J,.84,7078,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,7078,2,1,0)
 ;;=Copy Text Line(s) to Paste Buffer
 ;;^UTILITY(U,$J,.84,7078,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,7078,5,1,0)
 ;;=DDBRWB
 ;;^UTILITY(U,$J,.84,7078.1,0)
 ;;=7078.1^2^^2
 ;;^UTILITY(U,$J,.84,7078.1,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,7078.1,2,1,0)
 ;;=* Enter line, or range of lines separated by ":" *
 ;;^UTILITY(U,$J,.84,7078.1,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,7078.1,5,1,0)
 ;;=DDBRWB
 ;;^UTILITY(U,$J,.84,7078.2,0)
 ;;=7078.2^1^y^2
 ;;^UTILITY(U,$J,.84,7078.2,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,7078.2,2,1,0)
 ;;=Must be a valid line or range of lines, from 1 to |1|
 ;;^UTILITY(U,$J,.84,7078.2,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,7078.2,3,1,0)
 ;;=1^Number of lines
 ;;^UTILITY(U,$J,.84,7078.2,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,7078.2,5,1,0)
 ;;=DDBRWB
 ;;^UTILITY(U,$J,.84,7078.3,0)
 ;;=7078.3^1^^2
 ;;^UTILITY(U,$J,.84,7078.3,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,7078.3,2,1,0)
 ;;=<< Copy to Paste Buffer RESTRICTED when Viewing Buffer >>
 ;;^UTILITY(U,$J,.84,7078.3,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,7078.3,5,1,0)
 ;;=DDBRWB
 ;;^UTILITY(U,$J,.84,7078.4,0)
 ;;=7078.4^1^^2
 ;;^UTILITY(U,$J,.84,7078.4,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,7078.4,2,1,0)
 ;;=<< RESTRICTED  Must exit HELP to Copy to Paste Buffer  >>
 ;;^UTILITY(U,$J,.84,7078.4,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,7078.4,5,1,0)
 ;;=DDBRWB
 ;;^UTILITY(U,$J,.84,7078.5,0)
 ;;=7078.5^1^^2
 ;;^UTILITY(U,$J,.84,7078.5,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,7078.5,2,1,0)
 ;;=<< RESTRICTED  Must Exit HELP to View Buffer >>
 ;;^UTILITY(U,$J,.84,7078.5,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,7078.5,5,1,0)
 ;;=DDBRWB
 ;;^UTILITY(U,$J,.84,7078.6,0)
 ;;=7078.6^2^^2
 ;;^UTILITY(U,$J,.84,7078.6,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,7078.6,2,1,0)
 ;;=<< RESTRICTED  Must Exit View Buffer to SWITCH >>
 ;;^UTILITY(U,$J,.84,7078.6,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,7078.6,5,1,0)
 ;;=DDBRWB
 ;;^UTILITY(U,$J,.84,8006.1,0)
 ;;=8006.1^2^^2
 ;;^UTILITY(U,$J,.84,8006.1,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,8006.1,2,1,0)
 ;;=NO MATCHES FOUND
 ;;^UTILITY(U,$J,.84,8006.1,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8006.1,5,1,0)
 ;;=DIO4
 ;;^UTILITY(U,$J,.84,8006.11,0)
 ;;=8006.11^2^^2
 ;;^UTILITY(U,$J,.84,8006.11,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,8006.11,2,1,0)
 ;;=NO OTHER MATCH FOUND
 ;;^UTILITY(U,$J,.84,8006.11,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8006.11,5,1,0)
 ;;=DDBR1
 ;;^UTILITY(U,$J,.84,8006.2,0)
 ;;=8006.2^2^y^2
 ;;^UTILITY(U,$J,.84,8006.2,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,8006.2,2,1,0)
 ;;=MATCHES FOUND: |1|
 ;;^UTILITY(U,$J,.84,8006.2,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8006.2,3,1,0)
 ;;=1^Number of matches
 ;;^UTILITY(U,$J,.84,8006.2,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8006.2,5,1,0)
 ;;=DIO4
 ;;^UTILITY(U,$J,.84,8007.1,0)
 ;;=8007.1^2^^2
 ;;^UTILITY(U,$J,.84,8007.1,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,8007.1,2,1,0)
 ;;=*** NO RECORDS TO PRINT ***
 ;;^UTILITY(U,$J,.84,8007.1,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8007.1,5,1,0)
 ;;=DIO4
 ;;^UTILITY(U,$J,.84,8075.1,0)
 ;;=8075.1^2^^2
 ;;^UTILITY(U,$J,.84,8075.1,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,8075.1,2,1,0)
 ;;=Do you want to save changes? 
 ;;^UTILITY(U,$J,.84,8075.1,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8075.1,5,1,0)
 ;;=DDW1
 ;;^UTILITY(U,$J,.84,8075.5,0)
 ;;=8075.5^2^^2
 ;;^UTILITY(U,$J,.84,8075.5,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,8075.5,2,1,0)
 ;;=Saving text ...
 ;;^UTILITY(U,$J,.84,8075.5,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8075.5,5,1,0)
 ;;=DDW1
 ;;^UTILITY(U,$J,.84,8126,0)
 ;;=8126^2^^2
 ;;^UTILITY(U,$J,.84,8126,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,8126,2,1,0)
 ;;=Find What: 
 ;;^UTILITY(U,$J,.84,8126,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8126,5,1,0)
 ;;=DDWF^FIND+2
 ;;^UTILITY(U,$J,.84,8126.1,0)
 ;;=8126.1^2^^2
 ;;^UTILITY(U,$J,.84,8126.1,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,8126.1,2,1,0)
 ;;=Replace With: 
 ;;^UTILITY(U,$J,.84,8126.1,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8126.1,5,1,0)
 ;;=DDWC1^FIND+1
 ;;^UTILITY(U,$J,.84,8127,0)
 ;;=8127^1^^2
 ;;^UTILITY(U,$J,.84,8127,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,8127,2,1,0)
 ;;=TEXT NOT FOUND
 ;;^UTILITY(U,$J,.84,8127,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8127,5,1,0)
 ;;=DDWF
 ;;^UTILITY(U,$J,.84,8128,0)
 ;;=8128^2^^2
 ;;^UTILITY(U,$J,.84,8128,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,8128,2,1,0)
 ;;=WARNING: Control characters in text have been replaced by spaces.
 ;;^UTILITY(U,$J,.84,8128,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8128,5,1,0)
 ;;=DDW1
 ;;^UTILITY(U,$J,.84,8140,0)
 ;;=8140^3^^2
 ;;^UTILITY(U,$J,.84,8140,2,0)
 ;;=^^3^3
 ;;^UTILITY(U,$J,.84,8140,2,1,0)
 ;;=Examples, to go to a screen:  S21  or  S+3  or  +3  or -3
 ;;^UTILITY(U,$J,.84,8140,2,2,0)
 ;;=          to go to a line:    L53  or  L+4  or  L-5
 ;;^UTILITY(U,$J,.84,8140,2,3,0)
 ;;=          to go to a column:  C40  or  C+10 or  C-20
 ;;^UTILITY(U,$J,.84,8140,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8140,5,1,0)
 ;;=DDWG
 ;;^UTILITY(U,$J,.84,8142,0)
 ;;=8142^2^^2
 ;;^UTILITY(U,$J,.84,8142,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,8142,2,1,0)
 ;;=Do you wish to select from current list? 
 ;;^UTILITY(U,$J,.84,8142,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8142,5,1,0)
 ;;=DDBR2
 ;;^UTILITY(U,$J,.84,8178,0)
 ;;=8178^2^^2
 ;;^UTILITY(U,$J,.84,8178,2,0)
 ;;=^^2^2
 ;;^UTILITY(U,$J,.84,8178,2,1,0)
 ;;=WARNING: This field is uneditable.
 ;;^UTILITY(U,$J,.84,8178,2,2,0)
 ;;=         Any changes made in the editor will not be saved.
 ;;^UTILITY(U,$J,.84,8178,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8178,5,1,0)
 ;;=DDSWP
 ;;^UTILITY(U,$J,.84,9110.8,0)
 ;;=9110.8^3^^2
 ;;^UTILITY(U,$J,.84,9110.8,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,9110.8,2,1,0)
 ;;=or 0157
 ;;^UTILITY(U,$J,.84,9110.8,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9110.8,5,1,0)
 ;;=DIEH1^DT+2
 ;;^UTILITY(U,$J,.84,8136,0)
 ;;=8136^3^^2
 ;;^UTILITY(U,$J,.84,8136,2,0)
 ;;=^^4^4
 ;;^UTILITY(U,$J,.84,8136,2,1,0)
 ;;  Specify in which column(s) you want to set tab stops. To set individual
 ;;^UTILITY(U,$J,.84,8136,2,2,0)
 ;;  tab stops, type a series of numbers separated by commas, for example:
 ;;^UTILITY(U,$J,.84,8136,2,3,0)
 ;;  4,7,15,20. To set tab stops at repeated intervals after the last stop,
 ;;^UTILITY(U,$J,.84,8136,2,4,0)
 ;;  or column 1, type the interval as +n, for example: 10,20,+5.
 ;;^UTILITY(U,$J,.84,8136,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8136,5,1,0)
 ;;=DDW2^TSALL
 ;;^UTILITY(U,$J,.84,8136.1,0)
 ;;=8136.1^2^^2
 ;;^UTILITY(U,$J,.84,8136.1,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,8136.1,2,1,0)
 ;;=Columns in which to set tab stops: 
 ;;^UTILITY(U,$J,.84,8136.1,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8136.1,5,1,0)
 ;;=DDW2
 ;;^UTILITY(U,$J,.84,8136.2,0)
 ;;=8136.2^1^^2
 ;;^UTILITY(U,$J,.84,8136.2,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,8136.2,2,1,0)
 ;;=Response can contain only commas (,), plus signs (+), and numbers.
 ;;^UTILITY(U,$J,.84,8136.2,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8136.2,5,1,0)
 ;;=DDW2
 ;;^UTILITY(U,$J,.84,8138.1,0)
 ;;=8138.1^1^^2
 ;;^UTILITY(U,$J,.84,8138.1,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,8138.1,2,1,0)
 ;;Margins cannot be set when wrap is off
 ;;^UTILITY(U,$J,.84,8138.1,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8138.1,5,1,0)
 ;;=DDW2
 ;;^UTILITY(U,$J,.84,8138.2,0)
 ;;=8138.2^1^^2
 ;;^UTILITY(U,$J,.84,8138.2,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,8138.2,2,1,0)
 ;;=Left margin cannot be set beyond column 231
 ;;^UTILITY(U,$J,.84,8138.2,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8138.2,5,1,0)
 ;;=DDW2
 ;;^UTILITY(U,$J,.84,8138.3,0)
 ;;=8138.3^1^^2
 ;;^UTILITY(U,$J,.84,8138.3,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,8138.3,2,1,0)
 ;;=Left margin must be left of right margin
 ;;^UTILITY(U,$J,.84,8138.3,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8138.3,5,1,0)
 ;;=DDW2
 ;;^UTILITY(U,$J,.84,8138.4,0)
 ;;=8138.4^1^^2
 ;;^UTILITY(U,$J,.84,8138.4,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,8138.4,2,1,0)
 ;;=Right margin cannot be set beyond column 245
 ;;^UTILITY(U,$J,.84,8138.4,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8138.4,5,1,0)
 ;;=DDW2
 ;;^UTILITY(U,$J,.84,8138.5,0)
 ;;=8138.5^1^^2
 ;;^UTILITY(U,$J,.84,8138.5,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,8138.5,2,1,0)
 ;;=Right margin must be right of left margin
 ;;^UTILITY(U,$J,.84,8138.5,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8138.5,5,1,0)
 ;;=DDW2
