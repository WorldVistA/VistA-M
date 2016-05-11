IBDEI03W ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1393,1,3,0)
 ;;=3^Poisoning by antineopl and immunosup drugs, undet, sequela
 ;;^UTILITY(U,$J,358.3,1393,1,4,0)
 ;;=4^T45.1X4S
 ;;^UTILITY(U,$J,358.3,1393,2)
 ;;=^5051025
 ;;^UTILITY(U,$J,358.3,1394,0)
 ;;=T36.8X1A^^8^135^42
 ;;^UTILITY(U,$J,358.3,1394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1394,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, accidental, init
 ;;^UTILITY(U,$J,358.3,1394,1,4,0)
 ;;=4^T36.8X1A
 ;;^UTILITY(U,$J,358.3,1394,2)
 ;;=^5049400
 ;;^UTILITY(U,$J,358.3,1395,0)
 ;;=T36.8X1D^^8^135^43
 ;;^UTILITY(U,$J,358.3,1395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1395,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, accidental, subs
 ;;^UTILITY(U,$J,358.3,1395,1,4,0)
 ;;=4^T36.8X1D
 ;;^UTILITY(U,$J,358.3,1395,2)
 ;;=^5049401
 ;;^UTILITY(U,$J,358.3,1396,0)
 ;;=T36.8X1S^^8^135^44
 ;;^UTILITY(U,$J,358.3,1396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1396,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, accidental, sequela
 ;;^UTILITY(U,$J,358.3,1396,1,4,0)
 ;;=4^T36.8X1S
 ;;^UTILITY(U,$J,358.3,1396,2)
 ;;=^5049402
 ;;^UTILITY(U,$J,358.3,1397,0)
 ;;=T36.8X3A^^8^135^45
 ;;^UTILITY(U,$J,358.3,1397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1397,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, assault, init encntr
 ;;^UTILITY(U,$J,358.3,1397,1,4,0)
 ;;=4^T36.8X3A
 ;;^UTILITY(U,$J,358.3,1397,2)
 ;;=^5049406
 ;;^UTILITY(U,$J,358.3,1398,0)
 ;;=T36.8X3D^^8^135^46
 ;;^UTILITY(U,$J,358.3,1398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1398,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, assault, subs encntr
 ;;^UTILITY(U,$J,358.3,1398,1,4,0)
 ;;=4^T36.8X3D
 ;;^UTILITY(U,$J,358.3,1398,2)
 ;;=^5049407
 ;;^UTILITY(U,$J,358.3,1399,0)
 ;;=T36.8X3S^^8^135^53
 ;;^UTILITY(U,$J,358.3,1399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1399,1,3,0)
 ;;=3^Poisoning by other systemic antibiotics, assault, sequela
 ;;^UTILITY(U,$J,358.3,1399,1,4,0)
 ;;=4^T36.8X3S
 ;;^UTILITY(U,$J,358.3,1399,2)
 ;;=^5049408
 ;;^UTILITY(U,$J,358.3,1400,0)
 ;;=T36.8X2A^^8^135^47
 ;;^UTILITY(U,$J,358.3,1400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1400,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, self-harm, init
 ;;^UTILITY(U,$J,358.3,1400,1,4,0)
 ;;=4^T36.8X2A
 ;;^UTILITY(U,$J,358.3,1400,2)
 ;;=^5049403
 ;;^UTILITY(U,$J,358.3,1401,0)
 ;;=T36.8X2D^^8^135^48
 ;;^UTILITY(U,$J,358.3,1401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1401,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, self-harm, subs
 ;;^UTILITY(U,$J,358.3,1401,1,4,0)
 ;;=4^T36.8X2D
 ;;^UTILITY(U,$J,358.3,1401,2)
 ;;=^5049404
 ;;^UTILITY(U,$J,358.3,1402,0)
 ;;=T36.8X2S^^8^135^49
 ;;^UTILITY(U,$J,358.3,1402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1402,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, self-harm, sequela
 ;;^UTILITY(U,$J,358.3,1402,1,4,0)
 ;;=4^T36.8X2S
 ;;^UTILITY(U,$J,358.3,1402,2)
 ;;=^5049405
 ;;^UTILITY(U,$J,358.3,1403,0)
 ;;=T36.8X4A^^8^135^50
 ;;^UTILITY(U,$J,358.3,1403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1403,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, undetermined, init
 ;;^UTILITY(U,$J,358.3,1403,1,4,0)
 ;;=4^T36.8X4A
 ;;^UTILITY(U,$J,358.3,1403,2)
 ;;=^5049409
 ;;^UTILITY(U,$J,358.3,1404,0)
 ;;=T36.8X4D^^8^135^51
 ;;^UTILITY(U,$J,358.3,1404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1404,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, undetermined, subs
 ;;^UTILITY(U,$J,358.3,1404,1,4,0)
 ;;=4^T36.8X4D
 ;;^UTILITY(U,$J,358.3,1404,2)
 ;;=^5049410
 ;;^UTILITY(U,$J,358.3,1405,0)
 ;;=T36.8X4S^^8^135^52
