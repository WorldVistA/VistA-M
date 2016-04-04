DINIT287 ;SFISC/MLH-ALTERNATE EDITOR FILE ;5/27/92  2:27 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT290
Q Q
 ;;^DIST(1.2,0)
 ;;=ALTERNATE EDITOR^1.2^9^8
 ;;^DIST(1.2,1,0)
 ;;=LINE EDITOR - VA FILEMAN
 ;;^DIST(1.2,1,1)
 ;;=G GO^DIWE
 ;;^DIST(1.2,2,0)
 ;;=SCREEN EDITOR - VA FILEMAN
 ;;^DIST(1.2,2,1)
 ;;=D ^DDW
 ;;^DIST(1.2,2,7,0)
 ;;=^^2^2^2901212^^^
 ;;^DIST(1.2,2,7,1,0)
 ;;=
 ;;^DIST(1.2,2,7,2,0)
 ;;=The standard VA FileMan full-screen text editor.
