DINIT010 ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ; 3/30/99  10:41:48
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,9548,1,2,0)
 ;;=DD, and KEY or INDEX entry for the new DD is already on file.
 ;;^UTILITY(U,$J,.84,9548,2,0)
 ;;=^^2^2^2980610^
 ;;^UTILITY(U,$J,.84,9548,2,1,0)
 ;;=|1| '|2|' for file |3| already exists.
 ;;^UTILITY(U,$J,.84,9548,2,2,0)
 ;;=Check this after the TRANSFER is complete.
 ;;^UTILITY(U,$J,.84,9548,3,0)
 ;;=^.845^3^3
 ;;^UTILITY(U,$J,.84,9548,3,1,0)
 ;;=1^The word 'KEY' or 'INDEX'
 ;;^UTILITY(U,$J,.84,9548,3,2,0)
 ;;=2^Name of INDEX or KEY
 ;;^UTILITY(U,$J,.84,9548,3,3,0)
 ;;=3^File/subfile number
 ;;^UTILITY(U,$J,.84,9548,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9548,5,1,0)
 ;;=DIT1^IXKEY
