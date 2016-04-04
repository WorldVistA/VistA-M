DINIT00B ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ; 3/30/99  10:41:48
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,820,1,2,0)
 ;;=is empty for the operating system being used.  It is impossible to perform
 ;;^UTILITY(U,$J,.84,820,1,3,0)
 ;;=functions such as compiling templates or cross references.
 ;;^UTILITY(U,$J,.84,820,2,0)
 ;;=^^1^1^2931109^
 ;;^UTILITY(U,$J,.84,820,2,1,0)
 ;;=There is no way to save routines on the system.
 ;;^UTILITY(U,$J,.84,840,0)
 ;;=840^1^y^5
 ;;^UTILITY(U,$J,.84,840,1,0)
 ;;=^^1^1^2931109^
 ;;^UTILITY(U,$J,.84,840,1,1,0)
 ;;=The Terminal Type file does not have an entry that matches IOST(0).
 ;;^UTILITY(U,$J,.84,840,2,0)
 ;;=^^1^1^2931109^
 ;;^UTILITY(U,$J,.84,840,2,1,0)
 ;;=Terminal type '|1|' cannot be found in the Terminal Type file.
 ;;^UTILITY(U,$J,.84,840,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,840,3,1,0)
 ;;=1^Terminal type as identified by IOST(0).
 ;;^UTILITY(U,$J,.84,842,0)
 ;;=842^1^y^5
 ;;^UTILITY(U,$J,.84,842,1,0)
 ;;=^^2^2^2931110^^
 ;;^UTILITY(U,$J,.84,842,1,1,0)
 ;;=The field in the Terminal Type field that contains the specified
 ;;^UTILITY(U,$J,.84,842,1,2,0)
 ;;=characteristic of the terminal is null.
 ;;^UTILITY(U,$J,.84,842,2,0)
 ;;=^^1^1^2931109^
 ;;^UTILITY(U,$J,.84,842,2,1,0)
 ;;=|1| cannot be found for Terminal Type |2|.
 ;;^UTILITY(U,$J,.84,842,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,842,3,1,0)
 ;;=1^Terminal Type characteristic.
 ;;^UTILITY(U,$J,.84,842,3,2,0)
 ;;=2^Terminal type.
 ;;^UTILITY(U,$J,.84,845,0)
 ;;=845^1^^5
 ;;^UTILITY(U,$J,.84,845,1,0)
 ;;=^^1^1^2931109^
 ;;^UTILITY(U,$J,.84,845,1,1,0)
 ;;=A %ZIS call with IOP set to "HOME" returns POP.
 ;;^UTILITY(U,$J,.84,845,2,0)
 ;;=^^1^1^2931109^
 ;;^UTILITY(U,$J,.84,845,2,1,0)
 ;;=The characteristics for the HOME device cannot be obtained.
 ;;^UTILITY(U,$J,.84,1300,0)
 ;;=1300^1^y^5
 ;;^UTILITY(U,$J,.84,1300,1,0)
 ;;=^^1^1^2970210^^
 ;;^UTILITY(U,$J,.84,1300,1,1,0)
 ;;=The entry encountered an error during subfile filing.
 ;;^UTILITY(U,$J,.84,1300,2,0)
 ;;=^^1^1^2970210^
 ;;^UTILITY(U,$J,.84,1300,2,1,0)
 ;;=The entry encountered an error during subfile filing.
 ;;^UTILITY(U,$J,.84,1300,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,1300,3,1,0)
 ;;=IEN^Entry Number
 ;;^UTILITY(U,$J,.84,1500,0)
 ;;=1500^1^y^5
 ;;^UTILITY(U,$J,.84,1500,1,0)
 ;;=^^2^2^2931112^
 ;;^UTILITY(U,$J,.84,1500,1,1,0)
 ;;=Error given for unsuccessful lookup of search template in BY(0) input
 ;;^UTILITY(U,$J,.84,1500,1,2,0)
 ;;=variable.
 ;;^UTILITY(U,$J,.84,1500,2,0)
 ;;=^^2^2^2931112^
 ;;^UTILITY(U,$J,.84,1500,2,1,0)
 ;;=Search template |1| in BY(0) variable cannot be found,
 ;;^UTILITY(U,$J,.84,1500,2,2,0)
 ;;=is for the wrong file, or has no list of search results.
 ;;^UTILITY(U,$J,.84,1500,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,1500,3,1,0)
 ;;=1^Name of search template in input variable BY(0).
 ;;^UTILITY(U,$J,.84,1500,5,0)
 ;;=^.841^2^2
 ;;^UTILITY(U,$J,.84,1500,5,1,0)
 ;;=DIP^EN1
 ;;^UTILITY(U,$J,.84,1500,5,2,0)
 ;;=DIS^ENS
 ;;^UTILITY(U,$J,.84,1501,0)
 ;;=1501^1^^5
 ;;^UTILITY(U,$J,.84,1501,1,0)
 ;;=^^2^2^2931116^^^
 ;;^UTILITY(U,$J,.84,1501,1,1,0)
 ;;=Error message shown to user when no code was generated during compilation
 ;;^UTILITY(U,$J,.84,1501,1,2,0)
 ;;=of SORT TEMPLATES.
 ;;^UTILITY(U,$J,.84,1501,2,0)
 ;;=^^1^1^2931116^
 ;;^UTILITY(U,$J,.84,1501,2,1,0)
 ;;=There is no code to save for this compiled Sort Template routine.
 ;;^UTILITY(U,$J,.84,1501,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1501,5,1,0)
 ;;=DIP^EN1
 ;;^UTILITY(U,$J,.84,1502,0)
 ;;=1502^1^^5
 ;;^UTILITY(U,$J,.84,1502,1,0)
 ;;=^^3^3^2931116^^^
 ;;^UTILITY(U,$J,.84,1502,1,1,0)
 ;;=Error message notifying the user that there are no more available
 ;;^UTILITY(U,$J,.84,1502,1,2,0)
 ;;=routine numbers for compiled sort template routines.  This should
 ;;^UTILITY(U,$J,.84,1502,1,3,0)
 ;;=never happen, since routine numbers are re-used.
 ;;^UTILITY(U,$J,.84,1502,2,0)
 ;;=^^2^2^2940909^
 ;;^UTILITY(U,$J,.84,1502,2,1,0)
 ;;=All available routine numbers for compilation are in use.
 ;;^UTILITY(U,$J,.84,1502,2,2,0)
 ;;=IRM needs to run ENRLS^DIOZ() to release the routine numbers.
 ;;^UTILITY(U,$J,.84,1502,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1502,5,1,0)
 ;;=DIP^EN1
 ;;^UTILITY(U,$J,.84,1503,0)
 ;;=1503^1^y^5
 ;;^UTILITY(U,$J,.84,1503,1,0)
 ;;=^^1^1^2931116^^^^
 ;;^UTILITY(U,$J,.84,1503,1,1,0)
 ;;=Warn user to shorten compiled cross-reference routine name.
 ;;^UTILITY(U,$J,.84,1503,2,0)
 ;;=^^1^1^2931116^^
 ;;^UTILITY(U,$J,.84,1503,2,1,0)
 ;;= routine name is too long.  Compilation has been aborted.
 ;;^UTILITY(U,$J,.84,1503,5,0)
 ;;=^.841^6^6
 ;;^UTILITY(U,$J,.84,1503,5,1,0)
 ;;=DIEZ^ 
 ;;^UTILITY(U,$J,.84,1503,5,2,0)
 ;;=DIEZ^EN
 ;;^UTILITY(U,$J,.84,1503,5,3,0)
 ;;=DIKZ^ 
 ;;^UTILITY(U,$J,.84,1503,5,4,0)
 ;;=DIKZ^EN
 ;;^UTILITY(U,$J,.84,1503,5,5,0)
 ;;=DIPZ^ 
 ;;^UTILITY(U,$J,.84,1503,5,6,0)
 ;;=DIPZ^EN
 ;;^UTILITY(U,$J,.84,1504,0)
 ;;=1504^1^^5
 ;;^UTILITY(U,$J,.84,1504,1,0)
 ;;=^^2^2^2940316^
 ;;^UTILITY(U,$J,.84,1504,1,1,0)
 ;;=If doing Transfer/Merge of a single record from one file to another, and
 ;;^UTILITY(U,$J,.84,1504,1,2,0)
 ;;=the .01 field names do not match, we cannot do the transfer/merge.
 ;;^UTILITY(U,$J,.84,1504,2,0)
 ;;=^^1^1^2940316^
 ;;^UTILITY(U,$J,.84,1504,2,1,0)
 ;;=No matching .01 field names found.  Transfer/Merge cannot be done.
 ;;^UTILITY(U,$J,.84,1504,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1504,5,1,0)
 ;;=DIT^TRNMRG
 ;;^UTILITY(U,$J,.84,1610,0)
 ;;=1610^1^^5
 ;;^UTILITY(U,$J,.84,1610,1,0)
 ;;=^^2^2^2940223^^
 ;;^UTILITY(U,$J,.84,1610,1,1,0)
 ;;=A question mark or, in the case of a variable pointer field, a <something>.?
 ;;^UTILITY(U,$J,.84,1610,1,2,0)
 ;;=was passed to the Validator.  The Validator does not process help requests.
 ;;^UTILITY(U,$J,.84,1610,2,0)
 ;;=^^1^1^2940223^^^
 ;;^UTILITY(U,$J,.84,1610,2,1,0)
 ;;=Help is being requested from the Validator utility.
 ;;^UTILITY(U,$J,.84,1610,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,1610,3,1,0)
 ;;=FILE^File number.
 ;;^UTILITY(U,$J,.84,1610,3,2,0)
 ;;=FIELD^Field number.
 ;;^UTILITY(U,$J,.84,1610,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1610,5,1,0)
 ;;=DIE^FILE
 ;;^UTILITY(U,$J,.84,1700,0)
 ;;=1700^1^y^5
 ;;^UTILITY(U,$J,.84,1700,1,0)
 ;;=^^1^1^2940310^^
 ;;^UTILITY(U,$J,.84,1700,1,1,0)
 ;;=Generic message for Silent DIFROM
 ;;^UTILITY(U,$J,.84,1700,2,0)
 ;;=^^1^1^2940310^^
 ;;^UTILITY(U,$J,.84,1700,2,1,0)
 ;;=Error: |1|.
 ;;^UTILITY(U,$J,.84,1700,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,1700,3,1,0)
 ;;=1^Generic message
 ;;^UTILITY(U,$J,.84,1701,0)
 ;;=1701^1^y^5
 ;;^UTILITY(U,$J,.84,1701,1,0)
 ;;=^^1^1^2940912^^^
