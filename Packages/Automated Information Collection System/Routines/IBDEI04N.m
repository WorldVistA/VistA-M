IBDEI04N ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1490,1,4,0)
 ;;=4^T36.95XD
 ;;^UTILITY(U,$J,358.3,1490,2)
 ;;=^5049431
 ;;^UTILITY(U,$J,358.3,1491,0)
 ;;=T36.95XS^^14^156^15
 ;;^UTILITY(U,$J,358.3,1491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1491,1,3,0)
 ;;=3^Adverse effect of unspecified systemic antibiotic, sequela
 ;;^UTILITY(U,$J,358.3,1491,1,4,0)
 ;;=4^T36.95XS
 ;;^UTILITY(U,$J,358.3,1491,2)
 ;;=^5049432
 ;;^UTILITY(U,$J,358.3,1492,0)
 ;;=S04.60XA^^14^156^16
 ;;^UTILITY(U,$J,358.3,1492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1492,1,3,0)
 ;;=3^Injury of acoustic nerve, unspecified side, init encntr
 ;;^UTILITY(U,$J,358.3,1492,1,4,0)
 ;;=4^S04.60XA
 ;;^UTILITY(U,$J,358.3,1492,2)
 ;;=^5020537
 ;;^UTILITY(U,$J,358.3,1493,0)
 ;;=S04.9XXA^^14^156^17
 ;;^UTILITY(U,$J,358.3,1493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1493,1,3,0)
 ;;=3^Injury of unspecified cranial nerve, initial encounter
 ;;^UTILITY(U,$J,358.3,1493,1,4,0)
 ;;=4^S04.9XXA
 ;;^UTILITY(U,$J,358.3,1493,2)
 ;;=^5020573
 ;;^UTILITY(U,$J,358.3,1494,0)
 ;;=R49.8^^14^156^92
 ;;^UTILITY(U,$J,358.3,1494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1494,1,3,0)
 ;;=3^Voice and Resonance Disorders NEC
 ;;^UTILITY(U,$J,358.3,1494,1,4,0)
 ;;=4^R49.8
 ;;^UTILITY(U,$J,358.3,1494,2)
 ;;=^5019505
 ;;^UTILITY(U,$J,358.3,1495,0)
 ;;=T36.5X1A^^14^156^19
 ;;^UTILITY(U,$J,358.3,1495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1495,1,3,0)
 ;;=3^Poisoning by aminoglycosides, accidental, init
 ;;^UTILITY(U,$J,358.3,1495,1,4,0)
 ;;=4^T36.5X1A
 ;;^UTILITY(U,$J,358.3,1495,2)
 ;;=^5049346
 ;;^UTILITY(U,$J,358.3,1496,0)
 ;;=T36.5X1D^^14^156^20
 ;;^UTILITY(U,$J,358.3,1496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1496,1,3,0)
 ;;=3^Poisoning by aminoglycosides, accidental, subs
 ;;^UTILITY(U,$J,358.3,1496,1,4,0)
 ;;=4^T36.5X1D
 ;;^UTILITY(U,$J,358.3,1496,2)
 ;;=^5049347
 ;;^UTILITY(U,$J,358.3,1497,0)
 ;;=T36.5X1S^^14^156^21
 ;;^UTILITY(U,$J,358.3,1497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1497,1,3,0)
 ;;=3^Poisoning by aminoglycosides, accidental, sequela
 ;;^UTILITY(U,$J,358.3,1497,1,4,0)
 ;;=4^T36.5X1S
 ;;^UTILITY(U,$J,358.3,1497,2)
 ;;=^5049348
 ;;^UTILITY(U,$J,358.3,1498,0)
 ;;=T36.5X3A^^14^156^22
 ;;^UTILITY(U,$J,358.3,1498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1498,1,3,0)
 ;;=3^Poisoning by aminoglycosides, assault, initial encounter
 ;;^UTILITY(U,$J,358.3,1498,1,4,0)
 ;;=4^T36.5X3A
 ;;^UTILITY(U,$J,358.3,1498,2)
 ;;=^5049352
 ;;^UTILITY(U,$J,358.3,1499,0)
 ;;=T36.5X3D^^14^156^23
 ;;^UTILITY(U,$J,358.3,1499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1499,1,3,0)
 ;;=3^Poisoning by aminoglycosides, assault, subsequent encounter
 ;;^UTILITY(U,$J,358.3,1499,1,4,0)
 ;;=4^T36.5X3D
 ;;^UTILITY(U,$J,358.3,1499,2)
 ;;=^5049353
 ;;^UTILITY(U,$J,358.3,1500,0)
 ;;=T36.5X3S^^14^156^24
 ;;^UTILITY(U,$J,358.3,1500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1500,1,3,0)
 ;;=3^Poisoning by aminoglycosides, assault, sequela
 ;;^UTILITY(U,$J,358.3,1500,1,4,0)
 ;;=4^T36.5X3S
 ;;^UTILITY(U,$J,358.3,1500,2)
 ;;=^5049354
 ;;^UTILITY(U,$J,358.3,1501,0)
 ;;=T36.5X2A^^14^156^25
 ;;^UTILITY(U,$J,358.3,1501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1501,1,3,0)
 ;;=3^Poisoning by aminoglycosides, intentional self-harm, init
 ;;^UTILITY(U,$J,358.3,1501,1,4,0)
 ;;=4^T36.5X2A
 ;;^UTILITY(U,$J,358.3,1501,2)
 ;;=^5049349
 ;;^UTILITY(U,$J,358.3,1502,0)
 ;;=T36.5X2D^^14^156^26
 ;;^UTILITY(U,$J,358.3,1502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1502,1,3,0)
 ;;=3^Poisoning by aminoglycosides, intentional self-harm, subs
 ;;^UTILITY(U,$J,358.3,1502,1,4,0)
 ;;=4^T36.5X2D
