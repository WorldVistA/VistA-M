DINIT2BA ;SFISC/MKO-SQLI FILES ;10:51 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT2BB
Q Q
 ;;^DD(1.5217,11,.1)
 ;;=Ext. Frm.
 ;;^DD(1.5217,11,3)
 ;;=Type a Number between 1 and 511, 0 Decimal Digits
 ;;^DD(1.5217,11,9)
 ;;=^
 ;;^DD(1.5217,11,21,0)
 ;;=^^2^2^2960926^^^
 ;;^DD(1.5217,11,21,1,0)
 ;;=First character to be extracted with $EXTRACT
 ;;^DD(1.5217,11,21,2,0)
 ;;=NULL unless specified by form E1,30.
 ;;^DD(1.5217,11,"DT")
 ;;=2960926
 ;;^DD(1.5217,12,0)
 ;;=C_EXTRACT_THRU^NJ3,0^^0;13^K:+X'=X!(X>511)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(1.5217,12,.1)
 ;;=Ext. Thru
 ;;^DD(1.5217,12,3)
 ;;=Type a Number between 1 and 511, 0 Decimal Digits
 ;;^DD(1.5217,12,9)
 ;;=^
 ;;^DD(1.5217,12,21,0)
 ;;=^^1^1^2960926^^
 ;;^DD(1.5217,12,21,1,0)
 ;;=Last character to extract with $E
 ;;^DD(1.5217,12,"DT")
 ;;=2960926
 ;;^DD(1.5217,13,0)
 ;;=C_COMPUTE_EXEC^K^^2;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(1.5217,13,.1)
 ;;=Computation
 ;;^DD(1.5217,13,3)
 ;;=M code to return value in {V}: machine generated
 ;;^DD(1.5217,13,4)
 ;;=W ?5,"Enter code to return value in {V}"
 ;;^DD(1.5217,13,9)
 ;;=^
 ;;^DD(1.5217,13,21,0)
 ;;=^^1^1^2970311^^^^
 ;;^DD(1.5217,13,21,1,0)
 ;;=Computation execute uses $$GET1^DIQ to return code by default
 ;;^DD(1.5217,13,"DT")
 ;;=2960926
 ;;^DD(1.5217,14,0)
 ;;=C_FM_EXEC^K^^3;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(1.5217,14,.1)
 ;;=FileMan Retrieval Strategy
 ;;^DD(1.5217,14,3)
 ;;=Don't enter manually: machine generated.
 ;;^DD(1.5217,14,4)
 ;;=W ?5,"Don't enter this. It should be auto-generated."
 ;;^DD(1.5217,14,9)
 ;;=^
 ;;^DD(1.5217,14,21,0)
 ;;=^^2^2^2970311^^^^
 ;;^DD(1.5217,14,21,1,0)
 ;;=Standard $$GET1^DIQ code to return value of pointer, variable pointer
 ;;^DD(1.5217,14,21,2,0)
 ;;=and computed values, or when security flag is set
 ;;^DD(1.5217,14,"DT")
 ;;=2960926
 ;;^DD(1.5217,15,0)
 ;;=C_POINTER^K^^4;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(1.5217,15,.1)
 ;;=Pointer or Set Param
 ;;^DD(1.5217,15,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(1.5217,15,9)
 ;;=^
 ;;^DD(1.5217,15,21,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.5217,15,21,1,0)
 ;;=Set translation string for SET, or global root for POINTER
 ;;^DD(1.5217,15,"DT")
 ;;=2960906
 ;;^DD(1.5217,16,0)
 ;;=C_OUTPUT_FORMAT^P1.5214'^DMSQ("OF",^0;4^Q
 ;;^DD(1.5217,16,.1)
 ;;=Output Format
 ;;^DD(1.5217,16,1,0)
 ;;=^.1
 ;;^DD(1.5217,16,1,1,0)
 ;;=1.5217^E
 ;;^DD(1.5217,16,1,1,1)
 ;;=S ^DMSQ("C","E",$E(X,1,30),DA)=""
 ;;^DD(1.5217,16,1,1,2)
 ;;=K ^DMSQ("C","E",$E(X,1,30),DA)
 ;;^DD(1.5217,16,1,1,"%D",0)
 ;;=^^1^1^2960909^
 ;;^DD(1.5217,16,1,1,"%D",1,0)
 ;;=Column by output format
 ;;^DD(1.5217,16,1,1,"DT")
 ;;=2960909
 ;;^DD(1.5217,16,9)
 ;;=^
 ;;^DD(1.5217,16,21,0)
 ;;=^^2^2^2960926^
 ;;^DD(1.5217,16,21,1,0)
 ;;=IEN of default output format in SQLI_OUTPUT_FORMAT for this column
 ;;^DD(1.5217,16,21,2,0)
 ;;=Always present for SET, POINTER and VARIABLE-POINTER data types
 ;;^DD(1.5217,16,"DT")
 ;;=2960926
