DINIT00X ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ;21APR2003
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**41,125,999**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,9258,2,8,0)
 ;;=prompt.
 ;;^UTILITY(U,$J,.84,9258,2,9,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9258,2,10,0)
 ;;=You cannot use the Form Editor to delete entire forms or blocks.  A separate
 ;;^UTILITY(U,$J,.84,9258,2,11,0)
 ;;=utility provides that functionality.
 ;;^UTILITY(U,$J,.84,9259,0)
 ;;=9259^3^^5
 ;;^UTILITY(U,$J,.84,9259,1,0)
 ;;=^^1^1^2940707^^
 ;;^UTILITY(U,$J,.84,9259,1,1,0)
 ;;=Help Screen 9 of Form Editor.
 ;;^UTILITY(U,$J,.84,9259,2,0)
 ;;=^^16^16^2940707^
 ;;^UTILITY(U,$J,.84,9259,2,1,0)
 ;;=                                                          \BHelp Screen 9 of 9\n
 ;;^UTILITY(U,$J,.84,9259,2,2,0)
 ;;=\BREORDERING FIELDS ON A BLOCK\n
 ;;^UTILITY(U,$J,.84,9259,2,3,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9259,2,4,0)
 ;;=After creating and arranging all the elements on a block, you can quickly
 ;;^UTILITY(U,$J,.84,9259,2,5,0)
 ;;=make the field orders of all the elements equivalent to the tab order
 ;;^UTILITY(U,$J,.84,9259,2,6,0)
 ;;=by doing the following:
 ;;^UTILITY(U,$J,.84,9259,2,7,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9259,2,8,0)
 ;;=     1.  Go to the Block Viewer page (<F1>V)
 ;;^UTILITY(U,$J,.84,9259,2,9,0)
 ;;=     2.  Select the block (<SpaceBar> over the block name)
 ;;^UTILITY(U,$J,.84,9259,2,10,0)
 ;;=     3.  Press <F1>O
 ;;^UTILITY(U,$J,.84,9259,2,11,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9259,2,12,0)
 ;;=The field order is the order in which the elements on the block are
 ;;^UTILITY(U,$J,.84,9259,2,13,0)
 ;;=traversed when the user presses the <Enter> key.  The <F1>O key
 ;;^UTILITY(U,$J,.84,9259,2,14,0)
 ;;=sequence reassigns field order numbers to all the elements on the
 ;;^UTILITY(U,$J,.84,9259,2,15,0)
 ;;=block, so that the <Enter> key takes the user from element to element
 ;;^UTILITY(U,$J,.84,9259,2,16,0)
 ;;=in the same order as the <Tab> key (left to right, top to bottom).
 ;;^UTILITY(U,$J,.84,9501,0)
 ;;=9501^1^^5
 ;;^UTILITY(U,$J,.84,9501,1,0)
 ;;=^^1^1^2940909^^^^
 ;;^UTILITY(U,$J,.84,9501,1,1,0)
 ;;=DIFROM Server, FIA array does not exist or invalid.
 ;;^UTILITY(U,$J,.84,9501,2,0)
 ;;=^^1^1^2940909^^^^
 ;;^UTILITY(U,$J,.84,9501,2,1,0)
 ;;=FIA array does not exist or invalid.
 ;;^UTILITY(U,$J,.84,9502,0)
 ;;=9502^1^^5
 ;;^UTILITY(U,$J,.84,9502,1,0)
 ;;=^^1^1^2940908^
 ;;^UTILITY(U,$J,.84,9502,1,1,0)
 ;;=FIA file number invalid.
 ;;^UTILITY(U,$J,.84,9502,2,0)
 ;;=^^1^1^2940908^
 ;;^UTILITY(U,$J,.84,9502,2,1,0)
 ;;=FIA file number invalid.
 ;;^UTILITY(U,$J,.84,9503,0)
 ;;=9503^1^^5
 ;;^UTILITY(U,$J,.84,9503,1,0)
 ;;=^^1^1^2940908^^^^
 ;;^UTILITY(U,$J,.84,9503,1,1,0)
 ;;=DIFROM Server; FIA node is set to "NO DD UPDATE"
 ;;^UTILITY(U,$J,.84,9503,2,0)
 ;;=^^1^1^2940908^^^^
 ;;^UTILITY(U,$J,.84,9503,2,1,0)
 ;;=File will not be installed!  Installation parameter specifies: "No DD Update"
 ;;^UTILITY(U,$J,.84,9504,0)
 ;;=9504^1^^5
 ;;^UTILITY(U,$J,.84,9504,1,0)
 ;;=^^1^1^2940908^^
 ;;^UTILITY(U,$J,.84,9504,1,1,0)
 ;;=DIFROM Server; Installing DD only if file is new on target system.
 ;;^UTILITY(U,$J,.84,9504,2,0)
 ;;=^^1^1^2940908^^
 ;;^UTILITY(U,$J,.84,9504,2,1,0)
 ;;=Data Dictionary not installed; DD already exist on target system.
 ;;^UTILITY(U,$J,.84,9505,0)
 ;;=9505^1^^5
 ;;^UTILITY(U,$J,.84,9505,1,0)
 ;;=^^1^1^2940915^^^
 ;;^UTILITY(U,$J,.84,9505,1,1,0)
 ;;=DIFROM Server; Did not pass DD screen.
 ;;^UTILITY(U,$J,.84,9505,2,0)
 ;;=^^1^1^2940915^^^
 ;;^UTILITY(U,$J,.84,9505,2,1,0)
 ;;=Data Dictionary not updated; Did not pass DD Screen.
 ;;^UTILITY(U,$J,.84,9506,0)
 ;;=9506^1^^5
 ;;^UTILITY(U,$J,.84,9506,1,0)
 ;;=^^1^1^2940909^^^^
 ;;^UTILITY(U,$J,.84,9506,1,1,0)
 ;;=DIFROM Server;  Transport structure does not exist or invalid.
 ;;^UTILITY(U,$J,.84,9506,2,0)
 ;;=^^1^1^2940909^^^^
 ;;^UTILITY(U,$J,.84,9506,2,1,0)
 ;;=Transport array does not exist or invalid.
 ;;^UTILITY(U,$J,.84,9507,0)
 ;;=9507^1^^5
 ;;^UTILITY(U,$J,.84,9507,1,0)
 ;;=^^1^1^2940908^^
 ;;^UTILITY(U,$J,.84,9507,1,1,0)
 ;;=DIFROM Server;  FIA file number invalid.
 ;;^UTILITY(U,$J,.84,9507,2,0)
 ;;=^^1^1^2940908^^
 ;;^UTILITY(U,$J,.84,9507,2,1,0)
 ;;=Data Dictionary not installed; FIA file number invalid.
 ;;^UTILITY(U,$J,.84,9508,0)
 ;;=9508^1^^5
 ;;^UTILITY(U,$J,.84,9508,1,0)
 ;;=^^1^1^2940908^^^
 ;;^UTILITY(U,$J,.84,9508,1,1,0)
 ;;=DIFROM Server;  File does not exist on target system (Partial DD).
 ;;^UTILITY(U,$J,.84,9508,2,0)
 ;;=^^1^1^2940908^^^
 ;;^UTILITY(U,$J,.84,9508,2,1,0)
 ;;=Data Dictionary not installed; Partial DD/File does not exist.
 ;;^UTILITY(U,$J,.84,9509,0)
 ;;=9509^1^^5
 ;;^UTILITY(U,$J,.84,9509,1,0)
 ;;=^^1^1^2940908^^^
 ;;^UTILITY(U,$J,.84,9509,1,1,0)
 ;;=DIFROMS Server;  FIA node is set to send "No Data"
 ;;^UTILITY(U,$J,.84,9509,2,0)
 ;;=^^1^1^2940908^^^
 ;;^UTILITY(U,$J,.84,9509,2,1,0)
 ;;=FIA array is set to "No data"
 ;;^UTILITY(U,$J,.84,9510,0)
 ;;=9510^1^^5
 ;;^UTILITY(U,$J,.84,9510,1,0)
 ;;=^^1^1^2940908^
 ;;^UTILITY(U,$J,.84,9510,1,1,0)
 ;;=DIFROM Server;  Records to transport do not exist.
 ;;^UTILITY(U,$J,.84,9510,2,0)
 ;;=^^1^1^2940908^
 ;;^UTILITY(U,$J,.84,9510,2,1,0)
 ;;=Records do not exist.
 ;;^UTILITY(U,$J,.84,9511,0)
 ;;=9511^1^^5
 ;;^UTILITY(U,$J,.84,9511,1,0)
 ;;=^^1^1^2940908^
 ;;^UTILITY(U,$J,.84,9511,1,1,0)
 ;;=DIFROM Server; DD not installed because FIA array does not exist.
 ;;^UTILITY(U,$J,.84,9511,2,0)
 ;;=^^1^1^2940908^
 ;;^UTILITY(U,$J,.84,9511,2,1,0)
 ;;=Data Dictionary not installed; FIA array does not exist.
 ;;^UTILITY(U,$J,.84,9512,0)
 ;;=9512^1^y^5
 ;;^UTILITY(U,$J,.84,9512,1,0)
 ;;=^^1^1^2940909^^^^
 ;;^UTILITY(U,$J,.84,9512,1,1,0)
 ;;=Parent DD missing on Partial DD.
 ;;^UTILITY(U,$J,.84,9512,2,0)
 ;;=^^1^1^2940909^^^^
 ;;^UTILITY(U,$J,.84,9512,2,1,0)
 ;;=DD: |1| not installed, parent DD(s) missing.
 ;;^UTILITY(U,$J,.84,9513,0)
 ;;=9513^1^y^5
 ;;^UTILITY(U,$J,.84,9513,1,0)
 ;;=^^1^1^2940909^^^
 ;;^UTILITY(U,$J,.84,9513,1,1,0)
 ;;=Invalid record in file.
 ;;^UTILITY(U,$J,.84,9513,2,0)
 ;;=^^1^1^2940909^^^
 ;;^UTILITY(U,$J,.84,9513,2,1,0)
 ;;=IEN: |1| in file |2| is invalid.
 ;;^UTILITY(U,$J,.84,9513.1,0)
 ;;=9513.1^1^y^5
 ;;^UTILITY(U,$J,.84,9513.1,1,0)
 ;;=^^4^4^3000524^
 ;;^UTILITY(U,$J,.84,9513.1,1,1,0)
 ;;=Incoming data record has a .001 field or is DINUMed. There is already a
 ;;^UTILITY(U,$J,.84,9513.1,1,2,0)
 ;;=record at that IEN on the target site. The .01 field, required
 ;;^UTILITY(U,$J,.84,9513.1,1,3,0)
 ;;=Identifiers or Primary KEY don't match incoming record. Therefore record is
 ;;^UTILITY(U,$J,.84,9513.1,1,4,0)
 ;;=not added at target site.
 ;;^UTILITY(U,$J,.84,9513.1,2,0)
 ;;=^^2^2^3000524^
 ;;^UTILITY(U,$J,.84,9513.1,2,1,0)
 ;;=Record with .01 value |.01| and internal entry #|IEN|
 ;;^UTILITY(U,$J,.84,9513.1,2,2,0)
 ;;=could not be added to file |FILE|.
 ;;^UTILITY(U,$J,.84,9513.1,3,0)
 ;;=^.845^3^3
 ;;^UTILITY(U,$J,.84,9513.1,3,1,0)
 ;;=.01^.01 value from incoming record
 ;;^UTILITY(U,$J,.84,9513.1,3,2,0)
 ;;=IEN^IEN of incoming record
 ;;^UTILITY(U,$J,.84,9513.1,3,3,0)
 ;;=FILE^File Number
 ;;^UTILITY(U,$J,.84,9513.1,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9513.1,5,1,0)
 ;;=DITR^I
 ;;^UTILITY(U,$J,.84,9514,0)
 ;;=9514^1^y^5
 ;;^UTILITY(U,$J,.84,9514,1,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9514,1,1,0)
 ;;=Dangling pointer.  File, IEN and field.
 ;;^UTILITY(U,$J,.84,9514,2,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9514,2,1,0)
 ;;=Dangling pointer.  FILE: |1|, IEN: |2| FIELD: |3|
 ;;^UTILITY(U,$J,.84,9515,0)
 ;;=9515^1^y^5
 ;;^UTILITY(U,$J,.84,9515,1,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9515,1,1,0)
 ;;=No sending data on partial DDs.
 ;;^UTILITY(U,$J,.84,9515,2,0)
 ;;=^^1^1^2940909^
