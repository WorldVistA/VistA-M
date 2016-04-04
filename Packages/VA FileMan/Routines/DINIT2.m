DINIT2 ;SFISC/GFT-INITIALIZE VA FILEMAN ;7/22/94  10:41
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
DD F I=1:1 S X=$T(DD+I),Y=$P(X," ",3,99) G ^DINIT20:X?.P S @("^DD("_$E($P(X," ",2),3,99)_")=Y")
 ;;.2,0 DESTINATION^
 ;;.2,0,"NM","DESTINATION"
 ;;.2,.01,0 DESTINATION^P^DIC(.2,^0;1^Q
 ;;.2,.01,3 WHERE THIS DATA GOES (TO WHAT FORM, SYSTEM, ETC.)
 ;;.21,0 DATA DESTINATION
 ;;.21,0,"NM","DATA-DESTINATION"
 ;;.21,.01,0 DATA DESTINATION^F^^0;1^K:$L(X)<2!($L(X)>80) X
 ;;.21,.01,1,0 ^.1^1^1
 ;;.21,.01,1,1,0 .21^B
 ;;.21,.01,1,1,1 S ^DIC(.2,"B",X,DA)=""
 ;;.21,.01,1,1,2 K ^DIC(.2,"B",X,DA)
