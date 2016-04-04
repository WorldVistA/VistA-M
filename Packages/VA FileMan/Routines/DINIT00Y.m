DINIT00Y ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ; 3/30/99  10:41:48
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,9515,2,1,0)
 ;;=Partial DD.  No sending of data allowed for file |1|.
 ;;^UTILITY(U,$J,.84,9516,0)
 ;;=9516^1^y^5
 ;;^UTILITY(U,$J,.84,9516,1,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9516,1,1,0)
 ;;=Invalid entry in trasnport structure.
 ;;^UTILITY(U,$J,.84,9516,2,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9516,2,1,0)
 ;;=Transport structure does not contain |1| with IEN: |2|.
 ;;^UTILITY(U,$J,.84,9517,0)
 ;;=9517^1^y^5
 ;;^UTILITY(U,$J,.84,9517,1,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9517,1,1,0)
 ;;=DIFROM Server unable to install block.
 ;;^UTILITY(U,$J,.84,9517,2,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9517,2,1,0)
 ;;=DIFROM Server unable to install |1| block.
 ;;^UTILITY(U,$J,.84,9518,0)
 ;;=9518^1^y^5
 ;;^UTILITY(U,$J,.84,9518,1,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9518,1,1,0)
 ;;=DIFROM Server installed block but associated file not present.
 ;;^UTILITY(U,$J,.84,9518,2,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9518,2,1,0)
 ;;=|1| block installed but associated file #|2| is not on your system.
 ;;^UTILITY(U,$J,.84,9519,0)
 ;;=9519^1^^5
 ;;^UTILITY(U,$J,.84,9519,1,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9519,1,1,0)
 ;;=File number missing for "FILE-PRE" in KIDS process.
 ;;^UTILITY(U,$J,.84,9519,2,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9519,2,1,0)
 ;;=File number missing in "FILE-PRE".
 ;;^UTILITY(U,$J,.84,9520,0)
 ;;=9520^1^^5
 ;;^UTILITY(U,$J,.84,9520,1,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9520,1,1,0)
 ;;=Package name missing for "FILE-PRE" in KIDS process.
 ;;^UTILITY(U,$J,.84,9520,2,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9520,2,1,0)
 ;;=Package name missing for "FILE-PRE".
 ;;^UTILITY(U,$J,.84,9521,0)
 ;;=9521^1^^5
 ;;^UTILITY(U,$J,.84,9521,1,0)
 ;;=^^1^1^2940909^^
 ;;^UTILITY(U,$J,.84,9521,1,1,0)
 ;;=Invalid file number in KIDS "ENTRY-PRE"
 ;;^UTILITY(U,$J,.84,9521,2,0)
 ;;=^^1^1^2940909^^
 ;;^UTILITY(U,$J,.84,9521,2,1,0)
 ;;=File number invalid in "ENTRY-PRE".
 ;;^UTILITY(U,$J,.84,9522,0)
 ;;=9522^1^^5
 ;;^UTILITY(U,$J,.84,9522,1,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9522,1,1,0)
 ;;=Invalid entry number in KIDS "ENTRY-PRE"
 ;;^UTILITY(U,$J,.84,9522,2,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9522,2,1,0)
 ;;=Entry number invalid for "ENTRY-PRE"
 ;;^UTILITY(U,$J,.84,9523,0)
 ;;=9523^1^^5
 ;;^UTILITY(U,$J,.84,9523,1,0)
 ;;=^^1^1^2940909^^
 ;;^UTILITY(U,$J,.84,9523,1,1,0)
 ;;=Invalid entry in transport array.
 ;;^UTILITY(U,$J,.84,9523,2,0)
 ;;=^^1^1^2940909^^
 ;;^UTILITY(U,$J,.84,9523,2,1,0)
 ;;=Entry number invalid in transport array (source site DA).
 ;;^UTILITY(U,$J,.84,9524,0)
 ;;=9524^1^^5
 ;;^UTILITY(U,$J,.84,9524,1,0)
 ;;=^^1^1^2940909^^
 ;;^UTILITY(U,$J,.84,9524,1,1,0)
 ;;=Package name invalid in "ENTRY-PRE".
 ;;^UTILITY(U,$J,.84,9524,2,0)
 ;;=^^1^1^2940909^^
 ;;^UTILITY(U,$J,.84,9524,2,1,0)
 ;;=Invalid package name in "ENTRY-PRE".
 ;;^UTILITY(U,$J,.84,9525,0)
 ;;=9525^1^y^5
 ;;^UTILITY(U,$J,.84,9525,1,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9525,1,1,0)
 ;;=Package name ambigious.  Pointer not resolved.
 ;;^UTILITY(U,$J,.84,9525,2,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9525,2,1,0)
 ;;=|1| package name is ambigious.  Pointer |2| not resolved.
 ;;^UTILITY(U,$J,.84,9526,0)
 ;;=9526^1^^5
 ;;^UTILITY(U,$J,.84,9526,1,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9526,1,1,0)
 ;;=ZSave not defined in MUMPS Operating file.  Can not compile templates.
 ;;^UTILITY(U,$J,.84,9526,2,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9526,2,1,0)
 ;;=Unable to compile templates.  ZSave undefined in OS file.
 ;;^UTILITY(U,$J,.84,9527,0)
 ;;=9527^1^y^5
 ;;^UTILITY(U,$J,.84,9527,1,0)
 ;;=^^1^1^2940909^^^
 ;;^UTILITY(U,$J,.84,9527,1,1,0)
 ;;=Invalid form.  DIFROM Server is unable to compile.
 ;;^UTILITY(U,$J,.84,9527,2,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9527,2,1,0)
 ;;=|1| form invalid.  Can not be compiled by KIDS process.
 ;;^UTILITY(U,$J,.84,9528,0)
 ;;=9528^1^y^5
 ;;^UTILITY(U,$J,.84,9528,1,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9528,1,1,0)
 ;;=Template can not be compiled.
 ;;^UTILITY(U,$J,.84,9528,2,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9528,2,1,0)
 ;;=|1| template |2| is invalid.  KIDS process can not compile.
 ;;^UTILITY(U,$J,.84,9529,0)
 ;;=9529^1^^5
 ;;^UTILITY(U,$J,.84,9529,1,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9529,1,1,0)
 ;;=Template or form file number is invalid.  DIFROM Server/KIDS
 ;;^UTILITY(U,$J,.84,9529,2,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9529,2,1,0)
 ;;=Template or form file number is invalid.
 ;;^UTILITY(U,$J,.84,9530,0)
 ;;=9530^1^^5
 ;;^UTILITY(U,$J,.84,9530,1,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9530,1,1,0)
 ;;=Transport package name is invalid.  (KIDS)
 ;;^UTILITY(U,$J,.84,9530,2,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9530,2,1,0)
 ;;=Transport package name is invalid.  (DIFROM Server/KIDS)
 ;;^UTILITY(U,$J,.84,9531,0)
 ;;=9531^1^^5
 ;;^UTILITY(U,$J,.84,9531,1,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9531,1,1,0)
 ;;=Invalid EDE(s).
 ;;^UTILITY(U,$J,.84,9531,2,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9531,2,1,0)
 ;;=Invalid EDE(s).  (DIFROM Server/KIDS)
 ;;^UTILITY(U,$J,.84,9532,0)
 ;;=9532^1^^5
 ;;^UTILITY(U,$J,.84,9532,1,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9532,1,1,0)
 ;;=No IEN(s) in array.  (KIDS)
 ;;^UTILITY(U,$J,.84,9532,2,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9532,2,1,0)
 ;;=No IEN(s) in list.
 ;;^UTILITY(U,$J,.84,9533,0)
 ;;=9533^1^^5
 ;;^UTILITY(U,$J,.84,9533,1,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9533,1,1,0)
 ;;=Source array root missing.
 ;;^UTILITY(U,$J,.84,9533,2,0)
 ;;=^^1^1^2940909^
 ;;^UTILITY(U,$J,.84,9533,2,1,0)
 ;;=Source array root missing.
 ;;^UTILITY(U,$J,.84,9534,0)
 ;;=9534^1^y^5
 ;;^UTILITY(U,$J,.84,9534,1,0)
 ;;=^^1^1^2940909^^^
 ;;^UTILITY(U,$J,.84,9534,1,1,0)
 ;;=Resolved value data link missing.
 ;;^UTILITY(U,$J,.84,9534,2,0)
 ;;=^^1^1^2940909^^^
 ;;^UTILITY(U,$J,.84,9534,2,1,0)
 ;;=Resolved Value Data Link missing |1|.
 ;;^UTILITY(U,$J,.84,9535,0)
 ;;=9535^1^y^5
 ;;^UTILITY(U,$J,.84,9535,1,0)
 ;;=^^1^1^2940909^^^
 ;;^UTILITY(U,$J,.84,9535,1,1,0)
 ;;=Pointer file missing.
 ;;^UTILITY(U,$J,.84,9535,2,0)
 ;;=^^1^1^2940909^^^
 ;;^UTILITY(U,$J,.84,9535,2,1,0)
 ;;=Pointer file missing |1|.
 ;;^UTILITY(U,$J,.84,9536,0)
 ;;=9536^1^y^5
 ;;^UTILITY(U,$J,.84,9536,1,0)
 ;;=^^1^1^2940909^^
 ;;^UTILITY(U,$J,.84,9536,1,1,0)
 ;;=Pointed too file not on target system.
 ;;^UTILITY(U,$J,.84,9536,2,0)
 ;;=^^1^1^2940909^^
 ;;^UTILITY(U,$J,.84,9536,2,1,0)
 ;;=Pointed too file not on target system |1|.
