DINIT286 ;SFISC/TKW-ALTERNATE EDITOR FILE ;5/27/92  1:56 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) G:X="" ^DINIT287 S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^DD(1.2,2,21,8,0)
 ;;=
 ;;^DD(1.2,2,21,9,0)
 ;;=An example would be a mixed VAX-PDP site using a VMS editor.
 ;;^DD(1.2,2,"DT")
 ;;=2900202
 ;;^DD(1.2,3,0)
 ;;=RETURN TO CALLING EDITOR^K^^3;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(1.2,3,3)
 ;;=This is Standard MUMPS code used to restore the environment needed by the VA FileMan line editor.
 ;;^DD(1.2,3,9)
 ;;=@
 ;;^DD(1.2,3,21,0)
 ;;=^^3^3^2920513^^^^
 ;;^DD(1.2,3,21,1,0)
 ;;=If the user switched to this editor from the FileMan line editor, then
 ;;^DD(1.2,3,21,2,0)
 ;;=DIWE(1) exists.  This field should contain MUMPS code used to reset
 ;;^DD(1.2,3,21,3,0)
 ;;=the environment needed by the Line Editor.
 ;;^DD(1.2,3,"DT")
 ;;=2900202
 ;;^DD(1.2,7,0)
 ;;=DESCRIPTION^1.207^^7;0
 ;;^DD(1.2,7,21,0)
 ;;=^^3^3^2920506^^^^
 ;;^DD(1.2,7,21,1,0)
 ;;=This is a description of the editor that will be shown to the user
 ;;^DD(1.2,7,21,2,0)
 ;;=if they enter ??? at the Select prompt.
 ;;^DD(1.2,7,21,3,0)
 ;;=Not in use yet.
 ;;^DD(1.207,0)
 ;;=DESCRIPTION SUB-FIELD^^.01^1
 ;;^DD(1.207,0,"NM","DESCRIPTION")
 ;;=
 ;;^DD(1.207,0,"UP")
 ;;=1.2
 ;;^DD(1.207,.01,0)
 ;;=DESCRIPTION^WL^^0;1^Q
 ;;^DD(1.207,.01,"DT")
 ;;=2900202
