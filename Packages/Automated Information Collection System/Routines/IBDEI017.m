IBDEI017 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3)
 ;;=^IBE(358.3,
 ;;^UTILITY(U,$J,358.3,0)
 ;;=IMP/EXP SELECTION^358.3I^35717^35717
 ;;^UTILITY(U,$J,358.3,1,0)
 ;;=S04.61XA^^1^1^4
 ;;^UTILITY(U,$J,358.3,1,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1,1,3,0)
 ;;=3^Injury of acoustic nerve, right side, initial encounter
 ;;^UTILITY(U,$J,358.3,1,1,4,0)
 ;;=4^S04.61XA
 ;;^UTILITY(U,$J,358.3,1,2)
 ;;=^5020540
 ;;^UTILITY(U,$J,358.3,2,0)
 ;;=S04.61XD^^1^1^5
 ;;^UTILITY(U,$J,358.3,2,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2,1,3,0)
 ;;=3^Injury of acoustic nerve, right side, subsequent encounter
 ;;^UTILITY(U,$J,358.3,2,1,4,0)
 ;;=4^S04.61XD
 ;;^UTILITY(U,$J,358.3,2,2)
 ;;=^5020541
 ;;^UTILITY(U,$J,358.3,3,0)
 ;;=S04.61XS^^1^1^6
 ;;^UTILITY(U,$J,358.3,3,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3,1,3,0)
 ;;=3^Injury of acoustic nerve, right side, sequela
 ;;^UTILITY(U,$J,358.3,3,1,4,0)
 ;;=4^S04.61XS
 ;;^UTILITY(U,$J,358.3,3,2)
 ;;=^5020542
 ;;^UTILITY(U,$J,358.3,4,0)
 ;;=S04.62XA^^1^1^1
 ;;^UTILITY(U,$J,358.3,4,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4,1,3,0)
 ;;=3^Injury of acoustic nerve, left side, initial encounter
 ;;^UTILITY(U,$J,358.3,4,1,4,0)
 ;;=4^S04.62XA
 ;;^UTILITY(U,$J,358.3,4,2)
 ;;=^5020543
 ;;^UTILITY(U,$J,358.3,5,0)
 ;;=S04.62XD^^1^1^3
 ;;^UTILITY(U,$J,358.3,5,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5,1,3,0)
 ;;=3^Injury of acoustic nerve, left side, subsequent encounter
 ;;^UTILITY(U,$J,358.3,5,1,4,0)
 ;;=4^S04.62XD
 ;;^UTILITY(U,$J,358.3,5,2)
 ;;=^5020544
 ;;^UTILITY(U,$J,358.3,6,0)
 ;;=S04.62XS^^1^1^2
 ;;^UTILITY(U,$J,358.3,6,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6,1,3,0)
 ;;=3^Injury of acoustic nerve, left side, sequela
 ;;^UTILITY(U,$J,358.3,6,1,4,0)
 ;;=4^S04.62XS
 ;;^UTILITY(U,$J,358.3,6,2)
 ;;=^5020545
 ;;^UTILITY(U,$J,358.3,7,0)
 ;;=S04.9XXA^^1^1^7
 ;;^UTILITY(U,$J,358.3,7,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7,1,3,0)
 ;;=3^Injury of unspecified cranial nerve, initial encounter
 ;;^UTILITY(U,$J,358.3,7,1,4,0)
 ;;=4^S04.9XXA
 ;;^UTILITY(U,$J,358.3,7,2)
 ;;=^5020573
 ;;^UTILITY(U,$J,358.3,8,0)
 ;;=S04.9XXD^^1^1^9
 ;;^UTILITY(U,$J,358.3,8,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8,1,3,0)
 ;;=3^Injury of unspecified cranial nerve, subsequent encounter
 ;;^UTILITY(U,$J,358.3,8,1,4,0)
 ;;=4^S04.9XXD
 ;;^UTILITY(U,$J,358.3,8,2)
 ;;=^5020574
 ;;^UTILITY(U,$J,358.3,9,0)
 ;;=S04.9XXS^^1^1^8
 ;;^UTILITY(U,$J,358.3,9,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9,1,3,0)
 ;;=3^Injury of unspecified cranial nerve, sequela
 ;;^UTILITY(U,$J,358.3,9,1,4,0)
 ;;=4^S04.9XXS
 ;;^UTILITY(U,$J,358.3,9,2)
 ;;=^5020575
 ;;^UTILITY(U,$J,358.3,10,0)
 ;;=H93.213^^1^2^5
 ;;^UTILITY(U,$J,358.3,10,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10,1,3,0)
 ;;=3^Auditory recruitment, bilateral
 ;;^UTILITY(U,$J,358.3,10,1,4,0)
 ;;=4^H93.213
 ;;^UTILITY(U,$J,358.3,10,2)
 ;;=^5006970
 ;;^UTILITY(U,$J,358.3,11,0)
 ;;=H93.212^^1^2^6
 ;;^UTILITY(U,$J,358.3,11,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11,1,3,0)
 ;;=3^Auditory recruitment, left ear
 ;;^UTILITY(U,$J,358.3,11,1,4,0)
 ;;=4^H93.212
 ;;^UTILITY(U,$J,358.3,11,2)
 ;;=^5006969
 ;;^UTILITY(U,$J,358.3,12,0)
 ;;=H93.211^^1^2^7
 ;;^UTILITY(U,$J,358.3,12,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12,1,3,0)
 ;;=3^Auditory recruitment, right ear
 ;;^UTILITY(U,$J,358.3,12,1,4,0)
 ;;=4^H93.211
 ;;^UTILITY(U,$J,358.3,12,2)
 ;;=^5006968
 ;;^UTILITY(U,$J,358.3,13,0)
 ;;=H93.25^^1^2^8
 ;;^UTILITY(U,$J,358.3,13,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13,1,3,0)
 ;;=3^Central auditory processing disorder
 ;;^UTILITY(U,$J,358.3,13,1,4,0)
 ;;=4^H93.25
