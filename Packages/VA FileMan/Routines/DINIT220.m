DINIT220 ;SFISC/DPC-LOAD DATA FOR DATA TYPE FILE ;7/22/94  10:50
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT24 S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DI(.81,0)
 ;;=DATA TYPE^.81^99^10
 ;;^DI(.81,1,0)
 ;;=DATE/TIME^D
 ;;^DI(.81,2,0)
 ;;=NUMERIC^N
 ;;^DI(.81,3,0)
 ;;=SET OF CODES^S
 ;;^DI(.81,1,0)
 ;;=DATE/TIME^D
 ;;^DI(.81,2,0)
 ;;=NUMERIC^N
 ;;^DI(.81,3,0)
 ;;=SET OF CODES^S
 ;;^DI(.81,4,0)
 ;;=FREE TEXT^F
 ;;^DI(.81,5,0)
 ;;=WORD-PROCESSING^W
 ;;^DI(.81,6,0)
 ;;=COMPUTED^C
 ;;^DI(.81,7,0)
 ;;=POINTER TO A FILE^P
 ;;^DI(.81,8,0)
 ;;=VARIABLE-POINTER^V
 ;;^DI(.81,9,0)
 ;;=MUMPS^K
 ;;^DI(.81,99,0)
 ;;=RESERVED FOR FILEMAN
