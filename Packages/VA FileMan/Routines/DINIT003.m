DINIT003 ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ; 3/30/99  10:41:48
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^DD(.847,.01,"DT")
 ;;=2940524
 ;;^DD(.847,1,0)
 ;;=FOREIGN TEXT^.8471^^1;0
 ;;^DD(.847,1,21,0)
 ;;=^^3^3^2941118^
 ;;^DD(.847,1,21,1,0)
 ;;=Insert here the non-English equivalent for this language to the text in
 ;;^DD(.847,1,21,2,0)
 ;;=the TEXT field for this entry.  This field may contain windows for
 ;;^DD(.847,1,21,3,0)
 ;;=variable parameters the same as the TEXT field.
 ;;^DD(.8471,0)
 ;;=FOREIGN TEXT SUB-FIELD^^.01^1
 ;;^DD(.8471,0,"DT")
 ;;=2930811
 ;;^DD(.8471,0,"NM","FOREIGN TEXT")
 ;;=
 ;;^DD(.8471,0,"UP")
 ;;=.847
 ;;^DD(.8471,.01,0)
 ;;=FOREIGN TEXT^WL^^0;1^Q
 ;;^DD(.8471,.01,3)
 ;;=Enter the non-English dialog text
 ;;^DD(.8471,.01,"DT")
 ;;=2930811
