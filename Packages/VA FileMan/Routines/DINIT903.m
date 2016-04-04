DINIT903 ;GFT/GFT-DIALOG FILE INITS ;3MAY2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,8000,2,1,0)
 ;;=COMMAND:
 ;;^UTILITY(U,$J,.84,8000,5,0)
 ;;=^.841^3^3
 ;;^UTILITY(U,$J,.84,8000,5,1,0)
 ;;=DIR0H
 ;;^UTILITY(U,$J,.84,8000,5,2,0)
 ;;=DIR02
 ;;^UTILITY(U,$J,.84,8000,5,3,0)
 ;;=DDSCOM^EGP
 ;;^UTILITY(U,$J,.84,8000.1,0)
 ;;=8000.1^3^^2
 ;;^UTILITY(U,$J,.84,8000.1,2,0)
 ;;=^^1^1^2991028^
 ;;^UTILITY(U,$J,.84,8000.1,2,1,0)
 ;;=Enter a COMMAND, or "^" followed by the CAPTION of a FIELD to jump to.
 ;;^UTILITY(U,$J,.84,8000.1,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8000.1,5,1,0)
 ;;=DDSCOM^EGP
 ;;^UTILITY(U,$J,.84,8000.101,0)
 ;;=8000.101^3^^2
 ;;^UTILITY(U,$J,.84,8000.101,2,0)
 ;;=^^1^1^3040501
 ;;^UTILITY(U,$J,.84,8000.101,2,1,0)
 ;;=Click on one of the above COMMANDs, or on a FIELD
 ;;^UTILITY(U,$J,.84,8000.101,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8000.101,5,1,0)
 ;;=DDSCOM^EGP
 ;;^UTILITY(U,$J,.84,8000.11,0)
 ;;=8000.11^3^^2
 ;;^UTILITY(U,$J,.84,8000.11,2,0)
 ;;=^^1^1^2991028^^^
 ;;^UTILITY(U,$J,.84,8000.11,2,1,0)
 ;;=Exit the Form
 ;;^UTILITY(U,$J,.84,8000.11,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8000.11,5,1,0)
 ;;=DDSCOM
 ;;^UTILITY(U,$J,.84,8000.01,0)
 ;;=8000.01^3^^2
 ;;^UTILITY(U,$J,.84,8000.01,2,0)
 ;;=^^1^1^2991028^^^
 ;;^UTILITY(U,$J,.84,8000.01,2,1,0)
 ;;=Exit
 ;;^UTILITY(U,$J,.84,8000.01,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8000.01,5,1,0)
 ;;=DDSCOM
 ;;^UTILITY(U,$J,.84,8000.02,0)
 ;;=8000.02^3^^2
 ;;^UTILITY(U,$J,.84,8000.02,2,0)
 ;;=^^1^1^2991028^^^
 ;;^UTILITY(U,$J,.84,8000.02,2,1,0)
 ;;=Close
 ;;^UTILITY(U,$J,.84,8000.02,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8000.02,5,1,0)
 ;;=DDSCOM
 ;;^UTILITY(U,$J,.84,8000.03,0)
 ;;=8000.03^3^^2
 ;;^UTILITY(U,$J,.84,8000.03,2,0)
 ;;=^^1^1^2991028^^^
 ;;^UTILITY(U,$J,.84,8000.03,2,1,0)
 ;;=Save
 ;;^UTILITY(U,$J,.84,8000.03,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8000.03,5,1,0)
 ;;=DDSCOM
 ;;^UTILITY(U,$J,.84,8000.04,0)
 ;;=8000.04^3^^2
 ;;^UTILITY(U,$J,.84,8000.04,2,0)
 ;;=^^1^1^2991028^^^
 ;;^UTILITY(U,$J,.84,8000.04,2,1,0)
 ;;=Next Page
 ;;^UTILITY(U,$J,.84,8000.04,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8000.04,5,1,0)
 ;;=DDSCOM
 ;;^UTILITY(U,$J,.84,8000.05,0)
 ;;=8000.05^3^^2
 ;;^UTILITY(U,$J,.84,8000.05,2,0)
 ;;=^^1^1^2991028^^^
 ;;^UTILITY(U,$J,.84,8000.05,2,1,0)
 ;;=Refresh
 ;;^UTILITY(U,$J,.84,8000.05,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8000.05,5,1,0)
 ;;=DDSCOM
 ;;^UTILITY(U,$J,.84,8000.06,0)
 ;;=8000.06^3^^2
 ;;^UTILITY(U,$J,.84,8000.06,2,0)
 ;;=^^1^1^3040503
 ;;^UTILITY(U,$J,.84,8000.06,2,1,0)
 ;;=Previous Page
 ;;^UTILITY(U,$J,.84,8000.06,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8000.06,5,1,0)
 ;;=DDSCOM;
 ;;^UTILITY(U,$J,.84,8000.07,0)
 ;;=8000.07^3^^2
 ;;^UTILITY(U,$J,.84,8000.07,2,0)
 ;;=^^1^1^3040503
 ;;^UTILITY(U,$J,.84,8000.07,2,1,0)
 ;;=Quit
 ;;^UTILITY(U,$J,.84,8000.07,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8000.07,5,1,0)
 ;;=DDSCOM
 ;;^UTILITY(U,$J,.84,8000.11,0)
 ;;=8000.11^3^^2
 ;;^UTILITY(U,$J,.84,8000.11,2,0)
 ;;=^^1^1^2991028^^^
 ;;^UTILITY(U,$J,.84,8000.11,2,1,0)
 ;;=Exit the Form
 ;;^UTILITY(U,$J,.84,8000.11,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8000.11,5,1,0)
 ;;=DDSCOM
 ;;^UTILITY(U,$J,.84,8000.12,0)
 ;;=8000.12^3^^2
 ;;^UTILITY(U,$J,.84,8000.12,2,0)
 ;;=^^1^1^2991028^^
 ;;^UTILITY(U,$J,.84,8000.12,2,1,0)
 ;;=Close the window and return to previous level
 ;;^UTILITY(U,$J,.84,8000.12,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8000.12,5,1,0)
 ;;=DDSCOM
 ;;^UTILITY(U,$J,.84,8000.13,0)
 ;;=8000.13^3^^2
 ;;^UTILITY(U,$J,.84,8000.13,2,0)
 ;;=^^1^1^2991028^^
 ;;^UTILITY(U,$J,.84,8000.13,2,1,0)
 ;;=Save all changes but continue editing
 ;;^UTILITY(U,$J,.84,8000.13,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8000.13,5,1,0)
 ;;=DDSCOM
 ;;^UTILITY(U,$J,.84,8000.14,0)
 ;;=8000.14^3^^2
 ;;^UTILITY(U,$J,.84,8000.14,2,0)
 ;;=^^1^1^2991028^^
 ;;^UTILITY(U,$J,.84,8000.14,2,1,0)
 ;;=Go to next page
 ;;^UTILITY(U,$J,.84,8000.14,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8000.14,5,1,0)
 ;;=DDSCOM
 ;;^UTILITY(U,$J,.84,8000.15,0)
 ;;=8000.15^3^^2
 ;;^UTILITY(U,$J,.84,8000.15,2,0)
 ;;=^^1^1^2991028^^
 ;;^UTILITY(U,$J,.84,8000.15,2,1,0)
 ;;=Repaint the screen
 ;;^UTILITY(U,$J,.84,8000.15,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8000.15,5,1,0)
 ;;=DDSCOM
 ;;^UTILITY(U,$J,.84,8000.16,0)
 ;;=8000.16^3^^2
 ;;^UTILITY(U,$J,.84,8000.15,2,0)
 ;;=^^1^1^3040503
 ;;^UTILITY(U,$J,.84,8000.16,2,1,0)
 ;;=Go to previous page
 ;;^UTILITY(U,$J,.84,8000.16,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8000.16,5,1,0)
 ;;=DDSCOM
 ;;^UTILITY(U,$J,.84,8000.17,0)
 ;;=8000.17^3^^2
 ;;^UTILITY(U,$J,.84,8000.17,2,0)
 ;;=^^1^1^3040503
 ;;^UTILITY(U,$J,.84,8000.17,2,1,0)
 ;;=Quit without filing
 ;;^UTILITY(U,$J,.84,8000.17,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8000.17,5,1,0)
 ;;=DDSCOM
 ;;^UTILITY(U,$J,.84,8100,0)
 ;;=8100^2^^2
 ;;^UTILITY(U,$J,.84,8100,2,0)
 ;;=^^1^1^2990908^^
 ;;^UTILITY(U,$J,.84,8100,2,1,0)
 ;;=Input to what File: 
 ;;^UTILITY(U,$J,.84,8100,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8100,5,1,0)
 ;;=DICRW
 ;;^UTILITY(U,$J,.84,8101,0)
 ;;=8101^2^^2
 ;;^UTILITY(U,$J,.84,8101,2,0)
 ;;=^^1^1^2991012^^^^
 ;;^UTILITY(U,$J,.84,8101,2,1,0)
 ;;=Output from what File: 
 ;;^UTILITY(U,$J,.84,8101,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8101,5,1,0)
 ;;=DICRW
 ;;^UTILITY(U,$J,.84,8101.1,0)
 ;;=8101.1^2^^2
 ;;^UTILITY(U,$J,.84,8101.1,2,0)
 ;;=^^1^1^2991012^^
 ;;^UTILITY(U,$J,.84,8101.1,2,1,0)
 ;;= START WITH What File: 
 ;;^UTILITY(U,$J,.84,8101.1,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8101.1,5,1,0)
 ;;=DICRW1^L+1
 ;;^UTILITY(U,$J,.84,8101.2,0)
 ;;=8101.2^2^^2
 ;;^UTILITY(U,$J,.84,8101.2,2,0)
 ;;=^^1^1^2991012^^
 ;;^UTILITY(U,$J,.84,8101.2,2,1,0)
 ;;=      GO TO What File: 
 ;;^UTILITY(U,$J,.84,8101.2,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8101.2,5,1,0)
 ;;=DICRW1^C3
 ;;^UTILITY(U,$J,.84,8102,0)
 ;;=8102^2^^2
 ;;^UTILITY(U,$J,.84,8102,2,0)
 ;;=^^1^1^2990908^
 ;;^UTILITY(U,$J,.84,8102,2,1,0)
 ;;=Modify what File: 
 ;;^UTILITY(U,$J,.84,8102,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8102,5,1,0)
 ;;=DICRW
 ;;^UTILITY(U,$J,.84,8103,0)
 ;;=8103^2^^2
 ;;^UTILITY(U,$J,.84,8103,2,0)
 ;;=^^1^1^2990908^
 ;;^UTILITY(U,$J,.84,8103,2,1,0)
 ;;=Extract from what File: 
 ;;^UTILITY(U,$J,.84,8103,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8103,5,1,0)
 ;;=DICRW
 ;;^UTILITY(U,$J,.84,8104,0)
 ;;=8104^2^^2
 ;;^UTILITY(U,$J,.84,8104,2,0)
 ;;=^^1^1^2990908^
 ;;^UTILITY(U,$J,.84,8104,2,1,0)
 ;;=Archive from what File: 
 ;;^UTILITY(U,$J,.84,8104,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8104,5,1,0)
 ;;=DICRW
 ;;^UTILITY(U,$J,.84,8105,0)
 ;;=8105^2^^2
 ;;^UTILITY(U,$J,.84,8105,2,0)
 ;;=^^1^1^2990908^
 ;;^UTILITY(U,$J,.84,8105,2,1,0)
 ;;=Audit from what File: 
 ;;^UTILITY(U,$J,.84,8105,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8105,5,1,0)
 ;;=DICRW
 ;;^UTILITY(U,$J,.84,8106,0)
 ;;=8106^2^^2
 ;;^UTILITY(U,$J,.84,8106,2,0)
 ;;=^^1^1^2991011^^
 ;;^UTILITY(U,$J,.84,8106,2,1,0)
 ;;=Compare Entries in what File: 
 ;;^UTILITY(U,$J,.84,8106,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8106,5,1,0)
 ;;=DICRW
 ;;^UTILITY(U,$J,.84,8107,0)
 ;;=8107^2^^2
 ;;^UTILITY(U,$J,.84,8107,2,0)
 ;;=^^1^1^2991011^^^
 ;;^UTILITY(U,$J,.84,8107,2,1,0)
 ;;=Edit/Create Form for what File: 
 ;;^UTILITY(U,$J,.84,8107,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8107,5,1,0)
 ;;=DDGFFM
 ;;^UTILITY(U,$J,.84,8108,0)
 ;;=8108^2^^2
 ;;^UTILITY(U,$J,.84,8108,2,0)
 ;;=^^1^1^2991011^^
 ;;^UTILITY(U,$J,.84,8108,2,1,0)
 ;;=Clone Form from what File: 
 ;;^UTILITY(U,$J,.84,8108,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8108,5,1,0)
 ;;=DDSCLONE^EGP
 ;;^UTILITY(U,$J,.84,8108.1,0)
 ;;=8108.1^2^^2
 ;;^UTILITY(U,$J,.84,8108.1,2,0)
 ;;=^^1^1^2991011^^^
 ;;^UTILITY(U,$J,.84,8108.1,2,1,0)
 ;;=Purge Unused Blocks from what File: 
 ;;^UTILITY(U,$J,.84,8108.1,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8108.1,5,1,0)
 ;;=DDSDBLK^EGP
 ;;^UTILITY(U,$J,.84,8108.2,0)
 ;;=8108.2^2^^2
 ;;^UTILITY(U,$J,.84,8108.2,2,0)
 ;;=^^1^1^2991011^
 ;;^UTILITY(U,$J,.84,8108.2,2,1,0)
 ;;=Delete Form for what File: 
 ;;^UTILITY(U,$J,.84,8108.2,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8108.2,5,1,0)
 ;;=DDSDFRM^EGP
 ;;^UTILITY(U,$J,.84,8108.3,0)
 ;;=8108.3^2^^2
 ;;^UTILITY(U,$J,.84,8108.3,2,0)
 ;;=^^1^1^2991011^
 ;;^UTILITY(U,$J,.84,8108.3,2,1,0)
 ;;=Run Form from what File: 
 ;;^UTILITY(U,$J,.84,8108.3,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8108.3,5,1,0)
 ;;=DDSRUN^EGP
 ;;^UTILITY(U,$J,.84,8109,0)
 ;;=8109^2^y^2
 ;;^UTILITY(U,$J,.84,8109,2,0)
 ;;=^^1^1^2990531^^
 ;;^UTILITY(U,$J,.84,8109,2,1,0)
 ;;=|1| Search
 ;;^UTILITY(U,$J,.84,8109,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8109,3,1,0)
 ;;=1^Filename
 ;;^UTILITY(U,$J,.84,8109,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8109,5,1,0)
 ;;=DIP3^HD
 ;;^UTILITY(U,$J,.84,8110,0)
 ;;=8110^2^y^2
 ;;^UTILITY(U,$J,.84,8110,2,0)
 ;;=^^1^1^2990531^^
 ;;^UTILITY(U,$J,.84,8110,2,1,0)
 ;;=|1| Statistics
 ;;^UTILITY(U,$J,.84,8110,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8110,3,1,0)
 ;;=1^Filename
 ;;^UTILITY(U,$J,.84,8110,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8110,5,1,0)
 ;;=DIP3^HD
 ;;^UTILITY(U,$J,.84,8111,0)
 ;;=8111^2^y^2
 ;;^UTILITY(U,$J,.84,8111,2,0)
 ;;=^^1^1^2990531^^^
 ;;^UTILITY(U,$J,.84,8111,2,1,0)
 ;;=|1| Extract Search
 ;;^UTILITY(U,$J,.84,8111,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8111,3,1,0)
 ;;=1^Filename
 ;;^UTILITY(U,$J,.84,8111,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8111,5,1,0)
 ;;=DIP3^HD
 ;;^UTILITY(U,$J,.84,8112,0)
 ;;=8112^2^y^2
 ;;^UTILITY(U,$J,.84,8112,2,0)
 ;;=^^1^1^2990706^^^^
 ;;^UTILITY(U,$J,.84,8112,2,1,0)
 ;;=|1| Archive Search
 ;;^UTILITY(U,$J,.84,8112,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8112,3,1,0)
 ;;=1^Filename
 ;;^UTILITY(U,$J,.84,8112,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8112,5,1,0)
 ;;=DIP3^HD
 ;;^UTILITY(U,$J,.84,8113,0)
 ;;=8113^2^y^2
 ;;^UTILITY(U,$J,.84,8113,2,0)
 ;;=^^1^1^2990710^^^^
 ;;^UTILITY(U,$J,.84,8113,2,1,0)
 ;;=ARE YOU SURE YOU WANT TO DELETE THE ENTIRE |1|
 ;;^UTILITY(U,$J,.84,8113,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8113,3,1,0)
 ;;=1^Name of File or Sub-File
 ;;^UTILITY(U,$J,.84,8113,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8113,5,1,0)
 ;;=DIE2^D+1
 ;;^UTILITY(U,$J,.84,8114,0)
 ;;=8114^2^^2
 ;;^UTILITY(U,$J,.84,8114,2,0)
 ;;=^^1^1^2990710^^^^
 ;;^UTILITY(U,$J,.84,8114,2,1,0)
 ;;=<NOTHING DELETED>
 ;;^UTILITY(U,$J,.84,8114,5,0)
 ;;=^.841^2^2
 ;;^UTILITY(U,$J,.84,8114,5,1,0)
 ;;=DIE2^N
 ;;^UTILITY(U,$J,.84,8114,5,2,0)
 ;;=DIWE3^D+5
 ;;^UTILITY(U,$J,.84,8115,0)
 ;;=8115^2^^2
 ;;^UTILITY(U,$J,.84,8115,2,0)
 ;;=^^1^1^2990710^^^
 ;;^UTILITY(U,$J,.84,8115,2,1,0)
 ;;=ARE YOU SURE YOU WANT TO DELETE THE ENTIRE TEXT
 ;;^UTILITY(U,$J,.84,8115,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8115,5,1,0)
 ;;=DIWE3^D+4
 ;;^UTILITY(U,$J,.84,8116,0)
 ;;=8116^2^y^2
 ;;^UTILITY(U,$J,.84,8116,2,0)
 ;;=1
 ;;^UTILITY(U,$J,.84,8116,2,1,0)
 ;;=OK TO REMOVE |1| LINE(S)
 ;;^UTILITY(U,$J,.84,8116,3,0)
 ;;=^.845^1^1
