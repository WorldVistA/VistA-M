DINIT00K ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ;22MAY2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999,1004**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,8065,2,0)
 ;;=^^1^1^2940314^^^
 ;;^UTILITY(U,$J,.84,8065,2,1,0)
 ;;=|1|-Entry 
 ;;^UTILITY(U,$J,.84,8065,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8065,3,1,0)
 ;;=1^Number of entries in list
 ;;^UTILITY(U,$J,.84,8066,0)
 ;;=8066^2^y^5
 ;;^UTILITY(U,$J,.84,8066,1,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8066,1,1,0)
 ;;=Lookup Part IV
 ;;^UTILITY(U,$J,.84,8066,2,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8066,2,1,0)
 ;;=|1| List
 ;;^UTILITY(U,$J,.84,8066,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8066,3,1,0)
 ;;=1^Filename
 ;;^UTILITY(U,$J,.84,8067,0)
 ;;=8067^2^^5
 ;;^UTILITY(U,$J,.84,8067,1,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8067,1,1,0)
 ;;=For list of Fields on Lookup
 ;;^UTILITY(U,$J,.84,8067,2,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8067,2,1,0)
 ;;=, or
 ;;^UTILITY(U,$J,.84,8068,0)
 ;;=8068^2^^5
 ;;^UTILITY(U,$J,.84,8068,1,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8068,1,1,0)
 ;;=The Chooser
 ;;^UTILITY(U,$J,.84,8068,2,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8068,2,1,0)
 ;;=Choose from:
 ;;^UTILITY(U,$J,.84,8069,0)
 ;;=8069^2^y^5
 ;;^UTILITY(U,$J,.84,8069,1,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8069,1,1,0)
 ;;=New entry allowed message
 ;;^UTILITY(U,$J,.84,8069,2,0)
 ;;=^^1^1^2940315^^
 ;;^UTILITY(U,$J,.84,8069,2,1,0)
 ;;=You may enter a new |1|, if you wish
 ;;^UTILITY(U,$J,.84,8069,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8069,3,1,0)
 ;;=1^Filename
 ;;^UTILITY(U,$J,.84,8070,0)
 ;;=8070^2^y^5
 ;;^UTILITY(U,$J,.84,8070,1,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8070,1,1,0)
 ;;=Variable Pointer Lookup
 ;;^UTILITY(U,$J,.84,8070,2,0)
 ;;=^^1^1^2980304^
 ;;^UTILITY(U,$J,.84,8070,2,1,0)
 ;;=     Searching for a |1|
 ;;^UTILITY(U,$J,.84,8070,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8070,3,1,0)
 ;;=1^Filename
 ;;^UTILITY(U,$J,.84,8071,0)
 ;;=8071^2^^5
 ;;^UTILITY(U,$J,.84,8071,1,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8071,1,1,0)
 ;;=Variable Pointer lookup
 ;;^UTILITY(U,$J,.84,8071,2,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8071,2,1,0)
 ;;=Enter one of the following:
 ;;^UTILITY(U,$J,.84,8072,0)
 ;;=8072^2^y^5
 ;;^UTILITY(U,$J,.84,8072,1,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8072,1,1,0)
 ;;=Variable Pointer Lookup
 ;;^UTILITY(U,$J,.84,8072,2,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8072,2,1,0)
 ;;=  |1|.EntryName to select a |2|
 ;;^UTILITY(U,$J,.84,8072,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,8072,3,1,0)
 ;;=1^Prefix
 ;;^UTILITY(U,$J,.84,8072,3,2,0)
 ;;=2^Filename
 ;;^UTILITY(U,$J,.84,8073,0)
 ;;=8073^2^^5
 ;;^UTILITY(U,$J,.84,8073,1,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8073,1,1,0)
 ;;=Variable Pointer Lookup
 ;;^UTILITY(U,$J,.84,8073,2,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8073,2,1,0)
 ;;=To see the entries in any particular file type <Prefix.?>
 ;;^UTILITY(U,$J,.84,8074,0)
 ;;=8074^2^^5
 ;;^UTILITY(U,$J,.84,8074,1,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8074,1,1,0)
 ;;=How to call for help
 ;;^UTILITY(U,$J,.84,8074,2,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8074,2,1,0)
 ;;=Press <F1>H for help
 ;;^UTILITY(U,$J,.84,8074.1,0)
 ;;=8074.1^2^^5
 ;;^UTILITY(U,$J,.84,8074.1,1,0)
 ;;=^^1^1^3040430
 ;;^UTILITY(U,$J,.84,8074.1,1,1,0)
 ;;=How to click for help
 ;;^UTILITY(U,$J,.84,8074.1,2,0)
 ;;=^^1^1^3040430
 ;;^UTILITY(U,$J,.84,8074.1,2,1,0)
 ;;=HELP
 ;;^UTILITY(U,$J,.84,8075,0)
 ;;=8075^2^^5
 ;;^UTILITY(U,$J,.84,8075,1,0)
 ;;=^^1^1^2940524^^
 ;;^UTILITY(U,$J,.84,8075,1,1,0)
 ;;=Save changes question on form exit
 ;;^UTILITY(U,$J,.84,8075,2,0)
 ;;=^^1^1^2940524^^
 ;;^UTILITY(U,$J,.84,8075,2,1,0)
 ;;=Save changes before leaving form (Y/N)?
 ;;^UTILITY(U,$J,.84,8076,0)
 ;;=8076^2^^5
 ;;^UTILITY(U,$J,.84,8076,1,0)
 ;;=^^1^1^2940315^
 ;;^UTILITY(U,$J,.84,8076,1,1,0)
 ;;=Timeout
 ;;^UTILITY(U,$J,.84,8076,2,0)
 ;;=^^1^1^2940315^
 ;;^UTILITY(U,$J,.84,8076,2,1,0)
 ;;=Timed out.  
 ;;^UTILITY(U,$J,.84,8077,0)
 ;;=8077^2^^5
 ;;^UTILITY(U,$J,.84,8077,1,0)
 ;;=^^1^1^2940315^
 ;;^UTILITY(U,$J,.84,8077,1,1,0)
 ;;=Changes not saved on leaving form
 ;;^UTILITY(U,$J,.84,8077,2,0)
 ;;=^^1^1^2940315^
 ;;^UTILITY(U,$J,.84,8077,2,1,0)
 ;;=Changes not saved!
 ;;^UTILITY(U,$J,.84,8078,0)
 ;;=8078^2^^5
 ;;^UTILITY(U,$J,.84,8078,1,0)
 ;;=^^1^1^2940316^
 ;;^UTILITY(U,$J,.84,8078,1,1,0)
 ;;=Wording for record
 ;;^UTILITY(U,$J,.84,8078,2,0)
 ;;=^^1^1^2940316^
 ;;^UTILITY(U,$J,.84,8078,2,1,0)
 ;;=record
 ;;^UTILITY(U,$J,.84,8079,0)
 ;;=8079^2^^5
 ;;^UTILITY(U,$J,.84,8079,1,0)
 ;;=^^1^1^2940316^
 ;;^UTILITY(U,$J,.84,8079,1,1,0)
 ;;=Wording for Subrecord
 ;;^UTILITY(U,$J,.84,8079,2,0)
 ;;=^^1^1^2940316^
 ;;^UTILITY(U,$J,.84,8079,2,1,0)
 ;;=Subrecord
 ;;^UTILITY(U,$J,.84,8080,0)
 ;;=8080^2^y^5
 ;;^UTILITY(U,$J,.84,8080,1,0)
 ;;=^^1^1^2940316^
 ;;^UTILITY(U,$J,.84,8080,1,1,0)
 ;;=Warning for immediate deletion of entries.
 ;;^UTILITY(U,$J,.84,8080,2,0)
 ;;=^^3^3^2940316^
 ;;^UTILITY(U,$J,.84,8080,2,1,0)
 ;;=  WARNING: DELETIONS ARE DONE IMMEDIATELY!
 ;;^UTILITY(U,$J,.84,8080,2,2,0)
 ;;=           (EXITING WITHOUT SAVING WILL NOT RESTORE DELETED RECORDS.)
 ;;^UTILITY(U,$J,.84,8080,2,3,0)
 ;;=Are you sure you want to delete this entire |1| (Y/N)?
 ;;^UTILITY(U,$J,.84,8080,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8080,3,1,0)
 ;;=1^Record or Subrecord
 ;;^UTILITY(U,$J,.84,8081,0)
 ;;=8081^2^y^5
 ;;^UTILITY(U,$J,.84,8081,1,0)
 ;;=^^1^1^2940316^
 ;;^UTILITY(U,$J,.84,8081,1,1,0)
 ;;=Choose from-to dialog
 ;;^UTILITY(U,$J,.84,8081,2,0)
 ;;=^^1^1^2940316^^
 ;;^UTILITY(U,$J,.84,8081,2,1,0)
 ;;=Choose |1| or '^' to quit: 
 ;;^UTILITY(U,$J,.84,8081,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8081,3,1,0)
 ;;=1^Number range for selection
 ;;^UTILITY(U,$J,.84,8082,0)
 ;;=8082^2^^5
 ;;^UTILITY(U,$J,.84,8082,1,0)
 ;;=^^2^2^2940318^^^^
 ;;^UTILITY(U,$J,.84,8082,1,1,0)
 ;;=Used to build error prompts in the TRANSFER/MERGE routine ^DIT3.  Could be
 ;;^UTILITY(U,$J,.84,8082,1,2,0)
 ;;=used elsewhere, however, so I didn't put it into the ERROR category.
 ;;^UTILITY(U,$J,.84,8082,2,0)
 ;;=^^1^1^2940318^
 ;;^UTILITY(U,$J,.84,8082,2,1,0)
 ;;=Transfer FROM
 ;;^UTILITY(U,$J,.84,8082,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8082,5,1,0)
 ;;=DIT^TRNMRG
 ;;^UTILITY(U,$J,.84,8083,0)
 ;;=8083^2^^5
 ;;^UTILITY(U,$J,.84,8083,1,0)
 ;;=^^2^2^2940318^^^^
 ;;^UTILITY(U,$J,.84,8083,1,1,0)
 ;;=Used to build error prompts in the TRANSFER/MERGE routine ^DIT3.  Could be
 ;;^UTILITY(U,$J,.84,8083,1,2,0)
 ;;=used elsewhere, however, so I didn't put it into the ERROR category.
 ;;^UTILITY(U,$J,.84,8083,2,0)
 ;;=^^1^1^2940318^
 ;;^UTILITY(U,$J,.84,8083,2,1,0)
 ;;=Transfer TO
 ;;^UTILITY(U,$J,.84,8083,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8083,5,1,0)
 ;;=DIT^TRNMRG
 ;;^UTILITY(U,$J,.84,8084,0)
 ;;=8084^2^^5
 ;;^UTILITY(U,$J,.84,8084,1,0)
 ;;=^^1^1^2940318^
 ;;^UTILITY(U,$J,.84,8084,1,1,0)
 ;;=The words 'file number' to be used in any dialog.
