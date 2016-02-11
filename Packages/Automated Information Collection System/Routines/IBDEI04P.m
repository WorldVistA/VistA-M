IBDEI04P ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1514,2)
 ;;=^5051018
 ;;^UTILITY(U,$J,358.3,1515,0)
 ;;=T45.1X2S^^14^156^18
 ;;^UTILITY(U,$J,358.3,1515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1515,1,3,0)
 ;;=3^Poisn by antineopl and immunosup drugs, self-harm, sequela
 ;;^UTILITY(U,$J,358.3,1515,1,4,0)
 ;;=4^T45.1X2S
 ;;^UTILITY(U,$J,358.3,1515,2)
 ;;=^5051019
 ;;^UTILITY(U,$J,358.3,1516,0)
 ;;=T45.1X4A^^14^156^39
 ;;^UTILITY(U,$J,358.3,1516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1516,1,3,0)
 ;;=3^Poisoning by antineopl and immunosup drugs, undet, init
 ;;^UTILITY(U,$J,358.3,1516,1,4,0)
 ;;=4^T45.1X4A
 ;;^UTILITY(U,$J,358.3,1516,2)
 ;;=^5051023
 ;;^UTILITY(U,$J,358.3,1517,0)
 ;;=T45.1X4D^^14^156^40
 ;;^UTILITY(U,$J,358.3,1517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1517,1,3,0)
 ;;=3^Poisoning by antineopl and immunosup drugs, undet, subs
 ;;^UTILITY(U,$J,358.3,1517,1,4,0)
 ;;=4^T45.1X4D
 ;;^UTILITY(U,$J,358.3,1517,2)
 ;;=^5051024
 ;;^UTILITY(U,$J,358.3,1518,0)
 ;;=T45.1X4S^^14^156^41
 ;;^UTILITY(U,$J,358.3,1518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1518,1,3,0)
 ;;=3^Poisoning by antineopl and immunosup drugs, undet, sequela
 ;;^UTILITY(U,$J,358.3,1518,1,4,0)
 ;;=4^T45.1X4S
 ;;^UTILITY(U,$J,358.3,1518,2)
 ;;=^5051025
 ;;^UTILITY(U,$J,358.3,1519,0)
 ;;=T36.8X1A^^14^156^42
 ;;^UTILITY(U,$J,358.3,1519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1519,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, accidental, init
 ;;^UTILITY(U,$J,358.3,1519,1,4,0)
 ;;=4^T36.8X1A
 ;;^UTILITY(U,$J,358.3,1519,2)
 ;;=^5049400
 ;;^UTILITY(U,$J,358.3,1520,0)
 ;;=T36.8X1D^^14^156^43
 ;;^UTILITY(U,$J,358.3,1520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1520,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, accidental, subs
 ;;^UTILITY(U,$J,358.3,1520,1,4,0)
 ;;=4^T36.8X1D
 ;;^UTILITY(U,$J,358.3,1520,2)
 ;;=^5049401
 ;;^UTILITY(U,$J,358.3,1521,0)
 ;;=T36.8X1S^^14^156^44
 ;;^UTILITY(U,$J,358.3,1521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1521,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, accidental, sequela
 ;;^UTILITY(U,$J,358.3,1521,1,4,0)
 ;;=4^T36.8X1S
 ;;^UTILITY(U,$J,358.3,1521,2)
 ;;=^5049402
 ;;^UTILITY(U,$J,358.3,1522,0)
 ;;=T36.8X3A^^14^156^45
 ;;^UTILITY(U,$J,358.3,1522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1522,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, assault, init encntr
 ;;^UTILITY(U,$J,358.3,1522,1,4,0)
 ;;=4^T36.8X3A
 ;;^UTILITY(U,$J,358.3,1522,2)
 ;;=^5049406
 ;;^UTILITY(U,$J,358.3,1523,0)
 ;;=T36.8X3D^^14^156^46
 ;;^UTILITY(U,$J,358.3,1523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1523,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, assault, subs encntr
 ;;^UTILITY(U,$J,358.3,1523,1,4,0)
 ;;=4^T36.8X3D
 ;;^UTILITY(U,$J,358.3,1523,2)
 ;;=^5049407
 ;;^UTILITY(U,$J,358.3,1524,0)
 ;;=T36.8X3S^^14^156^53
 ;;^UTILITY(U,$J,358.3,1524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1524,1,3,0)
 ;;=3^Poisoning by other systemic antibiotics, assault, sequela
 ;;^UTILITY(U,$J,358.3,1524,1,4,0)
 ;;=4^T36.8X3S
 ;;^UTILITY(U,$J,358.3,1524,2)
 ;;=^5049408
 ;;^UTILITY(U,$J,358.3,1525,0)
 ;;=T36.8X2A^^14^156^47
 ;;^UTILITY(U,$J,358.3,1525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1525,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, self-harm, init
 ;;^UTILITY(U,$J,358.3,1525,1,4,0)
 ;;=4^T36.8X2A
 ;;^UTILITY(U,$J,358.3,1525,2)
 ;;=^5049403
 ;;^UTILITY(U,$J,358.3,1526,0)
 ;;=T36.8X2D^^14^156^48
 ;;^UTILITY(U,$J,358.3,1526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1526,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, self-harm, subs
 ;;^UTILITY(U,$J,358.3,1526,1,4,0)
 ;;=4^T36.8X2D
