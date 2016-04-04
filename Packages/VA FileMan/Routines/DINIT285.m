DINIT285 ;SFISC/TKW-ALTERNATE EDITOR FILE ;9/9/94  14:33
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) G:X="" ^DINIT286 S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^DIC("B","ALTERNATE EDITOR",1.2)
 ;;=
 ;;^DIC(1.2,"%D",0)
 ;;=^^6^6^2940908^
 ;;^DIC(1.2,"%D",1,0)
 ;;=This file stores information about the editors that can be used to edit VA
 ;;^DIC(1.2,"%D",2,0)
 ;;=FileMan WP fields. The LINE EDITOR and SCREEN EDITOR are exported with VA
 ;;^DIC(1.2,"%D",3,0)
 ;;=FileMan, but instructions are given to allow site managers to enter local
 ;;^DIC(1.2,"%D",4,0)
 ;;=editors of their choice.  There is a pointer in the NEW PERSON File to
 ;;^DIC(1.2,"%D",5,0)
 ;;=this file.  The pointed-to editor for that person is then used whenever
 ;;^DIC(1.2,"%D",6,0)
 ;;=the person edits a WP field.
 ;;^DD(1.2,0)
 ;;=FIELD^NL^7^5
 ;;^DD(1.2,0,"IX","B",1.2,.01)
 ;;=
 ;;^DD(1.2,0,"NM","ALTERNATE EDITOR")
 ;;=
 ;;^DD(1.2,0,"PT",200,31.3)
 ;;=
 ;;^DD(1.2,.01,0)
 ;;=NAME^RFX^^0;1^K:$L(X)>30!(X?.N)!($L(X)<3)!'(X'?1P.E) X I $D(X) S %=$O(^DIST(1.2,"B",$E(X))) I $E(%)=$E(X) K X
 ;;^DD(1.2,.01,1,0)
 ;;=^.1
 ;;^DD(1.2,.01,1,1,0)
 ;;=1.2^B
 ;;^DD(1.2,.01,1,1,1)
 ;;=S ^DIST(1.2,"B",$E(X,1,30),DA)=""
 ;;^DD(1.2,.01,1,1,2)
 ;;=K ^DIST(1.2,"B",$E(X,1,30),DA)
 ;;^DD(1.2,.01,3)
 ;;=NAME MUST BE 3-30 CHAR., and start with a unique alpha char.
 ;;^DD(1.2,.01,21,0)
 ;;=2^^2^2^2920506^^^
 ;;^DD(1.2,.01,21,1,0)
 ;;=This is the name of the alternate editor. It must start with a unique
 ;;^DD(1.2,.01,21,2,0)
 ;;=character.
 ;;^DD(1.2,.01,"DT")
 ;;=2901212
 ;;^DD(1.2,1,0)
 ;;=ACTIVATION CODE FROM DIWE^RK^^1;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(1.2,1,3)
 ;;=This is Standard MUMPS code, used to set up the environment for editing a Standard FileMan word-processing field using this editor.
 ;;^DD(1.2,1,9)
 ;;=@
 ;;^DD(1.2,1,21,0)
 ;;=^^17^17^2920513^^^^
 ;;^DD(1.2,1,21,1,0)
 ;;=This field holds the MUMPS code to properly establish the environment
 ;;^DD(1.2,1,21,2,0)
 ;;=that will allow use of this editor to edit any VA FileMan word-processing
 ;;^DD(1.2,1,21,3,0)
 ;;=type field.  Typically this code might move the text into another
 ;;^DD(1.2,1,21,4,0)
 ;;=MUMPS global (like ^UTILITY) or to some other file format for editing.
 ;;^DD(1.2,1,21,5,0)
 ;;=If the editor is written in MUMPS, it should either use variables that
 ;;^DD(1.2,1,21,6,0)
 ;;=do not begin with the letter "D", or should NEW all its local variables
 ;;^DD(1.2,1,21,7,0)
 ;;=to avoid problems on return to the FileMan editor.
 ;;^DD(1.2,1,21,8,0)
 ;;=
 ;;^DD(1.2,1,21,9,0)
 ;;=If the variable DIWE(1) is defined, it indicated that the user
 ;;^DD(1.2,1,21,10,0)
 ;;=has switched to this editor from the standard FileMan Line Editor, and
 ;;^DD(1.2,1,21,11,0)
 ;;=upon return, the control will be returned to the line editor.
 ;;^DD(1.2,1,21,12,0)
 ;;=
 ;;^DD(1.2,1,21,13,0)
 ;;=This editor may set the variable DIWESW to 1, if they wish to allow
 ;;^DD(1.2,1,21,14,0)
 ;;=the user to switch to an alternate editor from this one.
 ;;^DD(1.2,1,21,15,0)
 ;;=
 ;;^DD(1.2,1,21,16,0)
 ;;=This editor is required to restore the edited text to standard FileMan
 ;;^DD(1.2,1,21,17,0)
 ;;=word-processing format before exiting.
 ;;^DD(1.2,1,"DT")
 ;;=2900202
 ;;^DD(1.2,2,0)
 ;;=OK TO RUN TEST^K^^2;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(1.2,2,3)
 ;;=This is Standard MUMPS code that sets $T to true if it is OK to use this editor.
 ;;^DD(1.2,2,9)
 ;;=@
 ;;^DD(1.2,2,21,0)
 ;;=^^9^9^2920513^^^^
 ;;^DD(1.2,2,21,1,0)
 ;;=This field holds MUMPS code used to pre-check the environment before
 ;;^DD(1.2,2,21,2,0)
 ;;=allowing the user to enter this editor.  This field should set the
 ;;^DD(1.2,2,21,3,0)
 ;;=$TEST indicator.  If $TEST is true then it is OK for this editor to
 ;;^DD(1.2,2,21,4,0)
 ;;=run at this time.  If $T is false, the user will be returned to the
 ;;^DD(1.2,2,21,5,0)
 ;;=FileMan line editor.
 ;;^DD(1.2,2,21,6,0)
 ;;=
 ;;^DD(1.2,2,21,7,0)
 ;;=If the field is null, it will be the same as $T=true
