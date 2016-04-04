DIPKI00B ;VEN/TOAD-PACKAGE FILE INIT ; 30-MAR-1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"SBF",9.4,9.4)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.402)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.404)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.409)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.41)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.414)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.415007)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.42)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.43)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.431)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.432)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.44)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.444)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.45)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.454)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.455)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.456)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.46)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.47)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.48)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.485)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.49)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.4901)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.49011)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.491)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.492)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.493)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.495)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.4961)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.4962)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.4963)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.54)
 ;;=
