IBDEI04L ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1465,0)
 ;;=H91.93^^14^153^8
 ;;^UTILITY(U,$J,358.3,1465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1465,1,3,0)
 ;;=3^Hearing Loss,Bilateral,Unspec
 ;;^UTILITY(U,$J,358.3,1465,1,4,0)
 ;;=4^H91.93
 ;;^UTILITY(U,$J,358.3,1465,2)
 ;;=^5006944
 ;;^UTILITY(U,$J,358.3,1466,0)
 ;;=H91.91^^14^153^12
 ;;^UTILITY(U,$J,358.3,1466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1466,1,3,0)
 ;;=3^Hearing Loss,Right Ear,Unspec
 ;;^UTILITY(U,$J,358.3,1466,1,4,0)
 ;;=4^H91.91
 ;;^UTILITY(U,$J,358.3,1466,2)
 ;;=^5133553
 ;;^UTILITY(U,$J,358.3,1467,0)
 ;;=H91.92^^14^153^10
 ;;^UTILITY(U,$J,358.3,1467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1467,1,3,0)
 ;;=3^Hearing Loss,Left Ear,Unspec
 ;;^UTILITY(U,$J,358.3,1467,1,4,0)
 ;;=4^H91.92
 ;;^UTILITY(U,$J,358.3,1467,2)
 ;;=^5133554
 ;;^UTILITY(U,$J,358.3,1468,0)
 ;;=H83.3X1^^14^154^3
 ;;^UTILITY(U,$J,358.3,1468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1468,1,3,0)
 ;;=3^Noise effects on right inner ear
 ;;^UTILITY(U,$J,358.3,1468,1,4,0)
 ;;=4^H83.3X1
 ;;^UTILITY(U,$J,358.3,1468,2)
 ;;=^5006906
 ;;^UTILITY(U,$J,358.3,1469,0)
 ;;=H83.3X2^^14^154^2
 ;;^UTILITY(U,$J,358.3,1469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1469,1,3,0)
 ;;=3^Noise effects on left inner ear
 ;;^UTILITY(U,$J,358.3,1469,1,4,0)
 ;;=4^H83.3X2
 ;;^UTILITY(U,$J,358.3,1469,2)
 ;;=^5006907
 ;;^UTILITY(U,$J,358.3,1470,0)
 ;;=H83.3X3^^14^154^1
 ;;^UTILITY(U,$J,358.3,1470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1470,1,3,0)
 ;;=3^Noise effects on bilateral inner ear
 ;;^UTILITY(U,$J,358.3,1470,1,4,0)
 ;;=4^H83.3X3
 ;;^UTILITY(U,$J,358.3,1470,2)
 ;;=^5006908
 ;;^UTILITY(U,$J,358.3,1471,0)
 ;;=H55.01^^14^155^1
 ;;^UTILITY(U,$J,358.3,1471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1471,1,3,0)
 ;;=3^Congenital nystagmus
 ;;^UTILITY(U,$J,358.3,1471,1,4,0)
 ;;=4^H55.01
 ;;^UTILITY(U,$J,358.3,1471,2)
 ;;=^5006371
 ;;^UTILITY(U,$J,358.3,1472,0)
 ;;=H55.04^^14^155^2
 ;;^UTILITY(U,$J,358.3,1472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1472,1,3,0)
 ;;=3^Dissociated nystagmus
 ;;^UTILITY(U,$J,358.3,1472,1,4,0)
 ;;=4^H55.04
 ;;^UTILITY(U,$J,358.3,1472,2)
 ;;=^269325
 ;;^UTILITY(U,$J,358.3,1473,0)
 ;;=H55.02^^14^155^3
 ;;^UTILITY(U,$J,358.3,1473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1473,1,3,0)
 ;;=3^Latent nystagmus
 ;;^UTILITY(U,$J,358.3,1473,1,4,0)
 ;;=4^H55.02
 ;;^UTILITY(U,$J,358.3,1473,2)
 ;;=^5006372
 ;;^UTILITY(U,$J,358.3,1474,0)
 ;;=H55.09^^14^155^4
 ;;^UTILITY(U,$J,358.3,1474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1474,1,3,0)
 ;;=3^Nystagmus NEC
 ;;^UTILITY(U,$J,358.3,1474,1,4,0)
 ;;=4^H55.09
 ;;^UTILITY(U,$J,358.3,1474,2)
 ;;=^87599
 ;;^UTILITY(U,$J,358.3,1475,0)
 ;;=H55.81^^14^155^5
 ;;^UTILITY(U,$J,358.3,1475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1475,1,3,0)
 ;;=3^Saccadic eye movements
 ;;^UTILITY(U,$J,358.3,1475,1,4,0)
 ;;=4^H55.81
 ;;^UTILITY(U,$J,358.3,1475,2)
 ;;=^5006373
 ;;^UTILITY(U,$J,358.3,1476,0)
 ;;=H55.03^^14^155^6
 ;;^UTILITY(U,$J,358.3,1476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1476,1,3,0)
 ;;=3^Visual deprivation nystagmus
 ;;^UTILITY(U,$J,358.3,1476,1,4,0)
 ;;=4^H55.03
 ;;^UTILITY(U,$J,358.3,1476,2)
 ;;=^269322
 ;;^UTILITY(U,$J,358.3,1477,0)
 ;;=T36.5X5A^^14^156^1
 ;;^UTILITY(U,$J,358.3,1477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1477,1,3,0)
 ;;=3^Adverse effect of aminoglycosides, initial encounter
 ;;^UTILITY(U,$J,358.3,1477,1,4,0)
 ;;=4^T36.5X5A
 ;;^UTILITY(U,$J,358.3,1477,2)
 ;;=^5049358
 ;;^UTILITY(U,$J,358.3,1478,0)
 ;;=T36.5X5S^^14^156^2
 ;;^UTILITY(U,$J,358.3,1478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1478,1,3,0)
 ;;=3^Adverse effect of aminoglycosides, sequela
