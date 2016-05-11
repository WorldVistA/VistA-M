IBDEI03S ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1343,1,3,0)
 ;;=3^Noise effects on right inner ear
 ;;^UTILITY(U,$J,358.3,1343,1,4,0)
 ;;=4^H83.3X1
 ;;^UTILITY(U,$J,358.3,1343,2)
 ;;=^5006906
 ;;^UTILITY(U,$J,358.3,1344,0)
 ;;=H83.3X2^^8^133^2
 ;;^UTILITY(U,$J,358.3,1344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1344,1,3,0)
 ;;=3^Noise effects on left inner ear
 ;;^UTILITY(U,$J,358.3,1344,1,4,0)
 ;;=4^H83.3X2
 ;;^UTILITY(U,$J,358.3,1344,2)
 ;;=^5006907
 ;;^UTILITY(U,$J,358.3,1345,0)
 ;;=H83.3X3^^8^133^1
 ;;^UTILITY(U,$J,358.3,1345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1345,1,3,0)
 ;;=3^Noise effects on bilateral inner ear
 ;;^UTILITY(U,$J,358.3,1345,1,4,0)
 ;;=4^H83.3X3
 ;;^UTILITY(U,$J,358.3,1345,2)
 ;;=^5006908
 ;;^UTILITY(U,$J,358.3,1346,0)
 ;;=H55.01^^8^134^1
 ;;^UTILITY(U,$J,358.3,1346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1346,1,3,0)
 ;;=3^Congenital nystagmus
 ;;^UTILITY(U,$J,358.3,1346,1,4,0)
 ;;=4^H55.01
 ;;^UTILITY(U,$J,358.3,1346,2)
 ;;=^5006371
 ;;^UTILITY(U,$J,358.3,1347,0)
 ;;=H55.04^^8^134^2
 ;;^UTILITY(U,$J,358.3,1347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1347,1,3,0)
 ;;=3^Dissociated nystagmus
 ;;^UTILITY(U,$J,358.3,1347,1,4,0)
 ;;=4^H55.04
 ;;^UTILITY(U,$J,358.3,1347,2)
 ;;=^269325
 ;;^UTILITY(U,$J,358.3,1348,0)
 ;;=H55.02^^8^134^3
 ;;^UTILITY(U,$J,358.3,1348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1348,1,3,0)
 ;;=3^Latent nystagmus
 ;;^UTILITY(U,$J,358.3,1348,1,4,0)
 ;;=4^H55.02
 ;;^UTILITY(U,$J,358.3,1348,2)
 ;;=^5006372
 ;;^UTILITY(U,$J,358.3,1349,0)
 ;;=H55.09^^8^134^4
 ;;^UTILITY(U,$J,358.3,1349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1349,1,3,0)
 ;;=3^Nystagmus NEC
 ;;^UTILITY(U,$J,358.3,1349,1,4,0)
 ;;=4^H55.09
 ;;^UTILITY(U,$J,358.3,1349,2)
 ;;=^87599
 ;;^UTILITY(U,$J,358.3,1350,0)
 ;;=H55.81^^8^134^5
 ;;^UTILITY(U,$J,358.3,1350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1350,1,3,0)
 ;;=3^Saccadic eye movements
 ;;^UTILITY(U,$J,358.3,1350,1,4,0)
 ;;=4^H55.81
 ;;^UTILITY(U,$J,358.3,1350,2)
 ;;=^5006373
 ;;^UTILITY(U,$J,358.3,1351,0)
 ;;=H55.03^^8^134^6
 ;;^UTILITY(U,$J,358.3,1351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1351,1,3,0)
 ;;=3^Visual deprivation nystagmus
 ;;^UTILITY(U,$J,358.3,1351,1,4,0)
 ;;=4^H55.03
 ;;^UTILITY(U,$J,358.3,1351,2)
 ;;=^269322
 ;;^UTILITY(U,$J,358.3,1352,0)
 ;;=T36.5X5A^^8^135^1
 ;;^UTILITY(U,$J,358.3,1352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1352,1,3,0)
 ;;=3^Adverse effect of aminoglycosides, initial encounter
 ;;^UTILITY(U,$J,358.3,1352,1,4,0)
 ;;=4^T36.5X5A
 ;;^UTILITY(U,$J,358.3,1352,2)
 ;;=^5049358
 ;;^UTILITY(U,$J,358.3,1353,0)
 ;;=T36.5X5S^^8^135^2
 ;;^UTILITY(U,$J,358.3,1353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1353,1,3,0)
 ;;=3^Adverse effect of aminoglycosides, sequela
 ;;^UTILITY(U,$J,358.3,1353,1,4,0)
 ;;=4^T36.5X5S
 ;;^UTILITY(U,$J,358.3,1353,2)
 ;;=^5049360
 ;;^UTILITY(U,$J,358.3,1354,0)
 ;;=T36.5X5D^^8^135^3
 ;;^UTILITY(U,$J,358.3,1354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1354,1,3,0)
 ;;=3^Adverse effect of aminoglycosides, subsequent encounter
 ;;^UTILITY(U,$J,358.3,1354,1,4,0)
 ;;=4^T36.5X5D
 ;;^UTILITY(U,$J,358.3,1354,2)
 ;;=^5049359
 ;;^UTILITY(U,$J,358.3,1355,0)
 ;;=T45.1X5A^^8^135^5
 ;;^UTILITY(U,$J,358.3,1355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1355,1,3,0)
 ;;=3^Adverse effect of antineoplastic and immunosup drugs, init
 ;;^UTILITY(U,$J,358.3,1355,1,4,0)
 ;;=4^T45.1X5A
 ;;^UTILITY(U,$J,358.3,1355,2)
 ;;=^5051026
 ;;^UTILITY(U,$J,358.3,1356,0)
 ;;=T45.1X5D^^8^135^6
 ;;^UTILITY(U,$J,358.3,1356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1356,1,3,0)
 ;;=3^Adverse effect of antineoplastic and immunosup drugs, subs
