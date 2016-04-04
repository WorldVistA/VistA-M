DINIT00J ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ;12:15 PM  6 Nov 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,8044,1,0)
 ;;=^^1^1^2940314^^
 ;;^UTILITY(U,$J,.84,8044,1,1,0)
 ;;=Used for time input to the reader.
 ;;^UTILITY(U,$J,.84,8044,2,0)
 ;;=^^1^1^2940314^^
 ;;^UTILITY(U,$J,.84,8044,2,1,0)
 ;;= and optional time
 ;;^UTILITY(U,$J,.84,8045,0)
 ;;=8045^2^y^5
 ;;^UTILITY(U,$J,.84,8045,1,0)
 ;;=^^3^3^2940310^^^^
 ;;^UTILITY(U,$J,.84,8045,1,1,0)
 ;;=This prompt is used by the reader when he is building prompts for
 ;;^UTILITY(U,$J,.84,8045,1,2,0)
 ;;=Set-of-codes type data.
 ;;^UTILITY(U,$J,.84,8045,1,3,0)
 ;;=Note: Dialog will be used with $$EZBLD^DIALOG call, only one text line!!
 ;;^UTILITY(U,$J,.84,8045,2,0)
 ;;=^^1^1^2940310^^^
 ;;^UTILITY(U,$J,.84,8045,2,1,0)
 ;;=Enter |1|: 
 ;;^UTILITY(U,$J,.84,8045,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8045,3,1,0)
 ;;=1^Default Prompt from DIR("A")
 ;;^UTILITY(U,$J,.84,8046,0)
 ;;=8046^2^^5
 ;;^UTILITY(U,$J,.84,8046,1,0)
 ;;=^^1^1^2960124^^
 ;;^UTILITY(U,$J,.84,8046,1,1,0)
 ;;=Reader prompt for choices from a list
 ;;^UTILITY(U,$J,.84,8046,2,0)
 ;;=^^1^1^2960124^^^
 ;;^UTILITY(U,$J,.84,8046,2,1,0)
 ;;=Select one of the following:
 ;;^UTILITY(U,$J,.84,8047,0)
 ;;=8047^2^^5
 ;;^UTILITY(U,$J,.84,8047,1,0)
 ;;=^^1^1^2940315^^^^
 ;;^UTILITY(U,$J,.84,8047,1,1,0)
 ;;=Part one of the Replace with prompt (including spaces).
 ;;^UTILITY(U,$J,.84,8047,2,0)
 ;;=^^1^1^2940315^^^^
 ;;^UTILITY(U,$J,.84,8047,2,1,0)
 ;;=  Replace 
 ;;^UTILITY(U,$J,.84,8048,0)
 ;;=8048^2^^5
 ;;^UTILITY(U,$J,.84,8048,1,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,8048,1,1,0)
 ;;=Part two of the Replace With editor (including spaces).
 ;;^UTILITY(U,$J,.84,8048,2,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,8048,2,1,0)
 ;;= With 
 ;;^UTILITY(U,$J,.84,8050,0)
 ;;=8050^2^^5
 ;;^UTILITY(U,$J,.84,8050,1,0)
 ;;=^^2^2^2971125^
 ;;^UTILITY(U,$J,.84,8050,1,1,0)
 ;;=Print the word 'Another' when prompting user to select another entry in
 ;;^UTILITY(U,$J,.84,8050,1,2,0)
 ;;=Inquire mode.
 ;;^UTILITY(U,$J,.84,8050,2,0)
 ;;=^^1^1^2971125^
 ;;^UTILITY(U,$J,.84,8050,2,1,0)
 ;;=Another 
 ;;^UTILITY(U,$J,.84,8050,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8050,5,1,0)
 ;;=DIC11^GETPRMT
 ;;^UTILITY(U,$J,.84,8051,0)
 ;;=8051^2^^5
 ;;^UTILITY(U,$J,.84,8051,1,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,8051,1,1,0)
 ;;=Reader prompt
 ;;^UTILITY(U,$J,.84,8051,2,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,8051,2,1,0)
 ;;=Enter response: 
 ;;^UTILITY(U,$J,.84,8052,0)
 ;;=8052^2^^5
 ;;^UTILITY(U,$J,.84,8052,1,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,8052,1,1,0)
 ;;=Prompt for the reader
 ;;^UTILITY(U,$J,.84,8052,2,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,8052,2,1,0)
 ;;=Enter Yes or No: 
 ;;^UTILITY(U,$J,.84,8053,0)
 ;;=8053^2^^5
 ;;^UTILITY(U,$J,.84,8053,1,0)
 ;;=^^1^1^2940316^^
 ;;^UTILITY(U,$J,.84,8053,1,1,0)
 ;;=Prompt for the reader: End of page
 ;;^UTILITY(U,$J,.84,8053,2,0)
 ;;=^^1^1^2940316^^
 ;;^UTILITY(U,$J,.84,8053,2,1,0)
 ;;=Type <Enter> to continue or '^' to exit: 
 ;;^UTILITY(U,$J,.84,8054,0)
 ;;=8054^2^^5
 ;;^UTILITY(U,$J,.84,8054,1,0)
 ;;=^^1^1^2940310^^
 ;;^UTILITY(U,$J,.84,8054,1,1,0)
 ;;=Prompt for the reader: numbers
 ;;^UTILITY(U,$J,.84,8054,2,0)
 ;;=^^1^1^2940310^^
 ;;^UTILITY(U,$J,.84,8054,2,1,0)
 ;;=Enter a number
 ;;^UTILITY(U,$J,.84,8055,0)
 ;;=8055^2^^5
 ;;^UTILITY(U,$J,.84,8055,1,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,8055,1,1,0)
 ;;=Prompt for the reader: date
 ;;^UTILITY(U,$J,.84,8055,2,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,8055,2,1,0)
 ;;=Enter a date
 ;;^UTILITY(U,$J,.84,8056,0)
 ;;=8056^2^^5
 ;;^UTILITY(U,$J,.84,8056,1,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,8056,1,1,0)
 ;;=Prompt for the reader: List
 ;;^UTILITY(U,$J,.84,8056,2,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,8056,2,1,0)
 ;;=Enter a list or range of numbers
 ;;^UTILITY(U,$J,.84,8057,0)
 ;;=8057^2^^5
 ;;^UTILITY(U,$J,.84,8057,1,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,8057,1,1,0)
 ;;=Prompt for the Reader: Pointers
 ;;^UTILITY(U,$J,.84,8057,2,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,8057,2,1,0)
 ;;=Select: 
 ;;^UTILITY(U,$J,.84,8058,0)
 ;;=8058^2^y^5
 ;;^UTILITY(U,$J,.84,8058,1,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8058,1,1,0)
 ;;=Part II of the 'Are you adding a new...' question
 ;;^UTILITY(U,$J,.84,8058,2,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8058,2,1,0)
 ;;= (the |1|
 ;;^UTILITY(U,$J,.84,8058,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8058,3,1,0)
 ;;=1^Ordinal number of new entry
 ;;^UTILITY(U,$J,.84,8059,0)
 ;;=8059^2^y^5
 ;;^UTILITY(U,$J,.84,8059,1,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8059,1,1,0)
 ;;=Part III of the 'Are you adding a new...' question
 ;;^UTILITY(U,$J,.84,8059,2,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8059,2,1,0)
 ;;= for this |1|
 ;;^UTILITY(U,$J,.84,8059,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8059,3,1,0)
 ;;=1^Filename
 ;;^UTILITY(U,$J,.84,8060,0)
 ;;=8060^2^^5
 ;;^UTILITY(U,$J,.84,8060,1,0)
 ;;=^^1^1^2940314^^
 ;;^UTILITY(U,$J,.84,8060,1,1,0)
 ;;=Part Ia of the 'Are you adding...' message
 ;;^UTILITY(U,$J,.84,8060,2,0)
 ;;=^^1^1^2940314^^
 ;;^UTILITY(U,$J,.84,8060,2,1,0)
 ;;=  Are you adding 
 ;;^UTILITY(U,$J,.84,8061,0)
 ;;=8061^2^y^5
 ;;^UTILITY(U,$J,.84,8061,1,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8061,1,1,0)
 ;;=Part Ib of the 'Are you adding...' question
 ;;^UTILITY(U,$J,.84,8061,2,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8061,2,1,0)
 ;;='|1|' as 
 ;;^UTILITY(U,$J,.84,8061,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8061,3,1,0)
 ;;=1^Input value for .01 field
 ;;^UTILITY(U,$J,.84,8062,0)
 ;;=8062^2^y^5
 ;;^UTILITY(U,$J,.84,8062,1,0)
 ;;=^^1^1^2940314^^^
 ;;^UTILITY(U,$J,.84,8062,1,1,0)
 ;;=Part Ic of the "Are you adding..." message
 ;;^UTILITY(U,$J,.84,8062,2,0)
 ;;=^^1^1^2940314^^^^
 ;;^UTILITY(U,$J,.84,8062,2,1,0)
 ;;=a new |1|
 ;;^UTILITY(U,$J,.84,8062,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8062,3,1,0)
 ;;=1^Filename
 ;;^UTILITY(U,$J,.84,8063,0)
 ;;=8063^2^y^5
 ;;^UTILITY(U,$J,.84,8063,1,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8063,1,1,0)
 ;;=Lookup Part I
 ;;^UTILITY(U,$J,.84,8063,2,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8063,2,1,0)
 ;;= Answer with |1|
 ;;^UTILITY(U,$J,.84,8063,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8063,3,1,0)
 ;;=1^Filename
 ;;^UTILITY(U,$J,.84,8064,0)
 ;;=8064^2^^5
 ;;^UTILITY(U,$J,.84,8064,1,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8064,1,1,0)
 ;;=Lookup Part II
 ;;^UTILITY(U,$J,.84,8064,2,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,8064,2,1,0)
 ;;= Do you want the entire 
 ;;^UTILITY(U,$J,.84,8065,0)
 ;;=8065^2^y^5
 ;;^UTILITY(U,$J,.84,8065,1,0)
 ;;=^^1^1^2940314^^
 ;;^UTILITY(U,$J,.84,8065,1,1,0)
 ;;=Lookup Part III
