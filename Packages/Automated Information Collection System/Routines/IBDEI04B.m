IBDEI04B ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1333,2)
 ;;=^5020541
 ;;^UTILITY(U,$J,358.3,1334,0)
 ;;=S04.61XS^^14^147^6
 ;;^UTILITY(U,$J,358.3,1334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1334,1,3,0)
 ;;=3^Injury of acoustic nerve, right side, sequela
 ;;^UTILITY(U,$J,358.3,1334,1,4,0)
 ;;=4^S04.61XS
 ;;^UTILITY(U,$J,358.3,1334,2)
 ;;=^5020542
 ;;^UTILITY(U,$J,358.3,1335,0)
 ;;=S04.62XA^^14^147^1
 ;;^UTILITY(U,$J,358.3,1335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1335,1,3,0)
 ;;=3^Injury of acoustic nerve, left side, initial encounter
 ;;^UTILITY(U,$J,358.3,1335,1,4,0)
 ;;=4^S04.62XA
 ;;^UTILITY(U,$J,358.3,1335,2)
 ;;=^5020543
 ;;^UTILITY(U,$J,358.3,1336,0)
 ;;=S04.62XD^^14^147^3
 ;;^UTILITY(U,$J,358.3,1336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1336,1,3,0)
 ;;=3^Injury of acoustic nerve, left side, subsequent encounter
 ;;^UTILITY(U,$J,358.3,1336,1,4,0)
 ;;=4^S04.62XD
 ;;^UTILITY(U,$J,358.3,1336,2)
 ;;=^5020544
 ;;^UTILITY(U,$J,358.3,1337,0)
 ;;=S04.62XS^^14^147^2
 ;;^UTILITY(U,$J,358.3,1337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1337,1,3,0)
 ;;=3^Injury of acoustic nerve, left side, sequela
 ;;^UTILITY(U,$J,358.3,1337,1,4,0)
 ;;=4^S04.62XS
 ;;^UTILITY(U,$J,358.3,1337,2)
 ;;=^5020545
 ;;^UTILITY(U,$J,358.3,1338,0)
 ;;=S04.9XXA^^14^147^7
 ;;^UTILITY(U,$J,358.3,1338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1338,1,3,0)
 ;;=3^Injury of unspecified cranial nerve, initial encounter
 ;;^UTILITY(U,$J,358.3,1338,1,4,0)
 ;;=4^S04.9XXA
 ;;^UTILITY(U,$J,358.3,1338,2)
 ;;=^5020573
 ;;^UTILITY(U,$J,358.3,1339,0)
 ;;=S04.9XXD^^14^147^9
 ;;^UTILITY(U,$J,358.3,1339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1339,1,3,0)
 ;;=3^Injury of unspecified cranial nerve, subsequent encounter
 ;;^UTILITY(U,$J,358.3,1339,1,4,0)
 ;;=4^S04.9XXD
 ;;^UTILITY(U,$J,358.3,1339,2)
 ;;=^5020574
 ;;^UTILITY(U,$J,358.3,1340,0)
 ;;=S04.9XXS^^14^147^8
 ;;^UTILITY(U,$J,358.3,1340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1340,1,3,0)
 ;;=3^Injury of unspecified cranial nerve, sequela
 ;;^UTILITY(U,$J,358.3,1340,1,4,0)
 ;;=4^S04.9XXS
 ;;^UTILITY(U,$J,358.3,1340,2)
 ;;=^5020575
 ;;^UTILITY(U,$J,358.3,1341,0)
 ;;=H93.213^^14^148^5
 ;;^UTILITY(U,$J,358.3,1341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1341,1,3,0)
 ;;=3^Auditory recruitment, bilateral
 ;;^UTILITY(U,$J,358.3,1341,1,4,0)
 ;;=4^H93.213
 ;;^UTILITY(U,$J,358.3,1341,2)
 ;;=^5006970
 ;;^UTILITY(U,$J,358.3,1342,0)
 ;;=H93.212^^14^148^6
 ;;^UTILITY(U,$J,358.3,1342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1342,1,3,0)
 ;;=3^Auditory recruitment, left ear
 ;;^UTILITY(U,$J,358.3,1342,1,4,0)
 ;;=4^H93.212
 ;;^UTILITY(U,$J,358.3,1342,2)
 ;;=^5006969
 ;;^UTILITY(U,$J,358.3,1343,0)
 ;;=H93.211^^14^148^7
 ;;^UTILITY(U,$J,358.3,1343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1343,1,3,0)
 ;;=3^Auditory recruitment, right ear
 ;;^UTILITY(U,$J,358.3,1343,1,4,0)
 ;;=4^H93.211
 ;;^UTILITY(U,$J,358.3,1343,2)
 ;;=^5006968
 ;;^UTILITY(U,$J,358.3,1344,0)
 ;;=H93.25^^14^148^8
 ;;^UTILITY(U,$J,358.3,1344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1344,1,3,0)
 ;;=3^Central auditory processing disorder
 ;;^UTILITY(U,$J,358.3,1344,1,4,0)
 ;;=4^H93.25
 ;;^UTILITY(U,$J,358.3,1344,2)
 ;;=^5006984
 ;;^UTILITY(U,$J,358.3,1345,0)
 ;;=H93.223^^14^148^9
 ;;^UTILITY(U,$J,358.3,1345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1345,1,3,0)
 ;;=3^Diplacusis, bilateral
 ;;^UTILITY(U,$J,358.3,1345,1,4,0)
 ;;=4^H93.223
 ;;^UTILITY(U,$J,358.3,1345,2)
 ;;=^5006974
 ;;^UTILITY(U,$J,358.3,1346,0)
 ;;=H93.222^^14^148^10
 ;;^UTILITY(U,$J,358.3,1346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1346,1,3,0)
 ;;=3^Diplacusis, left ear
