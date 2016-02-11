IBDEI0AC ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4309,2)
 ;;=^5059820
 ;;^UTILITY(U,$J,358.3,4310,0)
 ;;=W10.9XXD^^28^265^20
 ;;^UTILITY(U,$J,358.3,4310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4310,1,3,0)
 ;;=3^Fall from Stairs/Steps,Subsequent
 ;;^UTILITY(U,$J,358.3,4310,1,4,0)
 ;;=4^W10.9XXD
 ;;^UTILITY(U,$J,358.3,4310,2)
 ;;=^5059593
 ;;^UTILITY(U,$J,358.3,4311,0)
 ;;=W10.0XXD^^28^265^11
 ;;^UTILITY(U,$J,358.3,4311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4311,1,3,0)
 ;;=3^Fall from Escalator,Subsequent
 ;;^UTILITY(U,$J,358.3,4311,1,4,0)
 ;;=4^W10.0XXD
 ;;^UTILITY(U,$J,358.3,4311,2)
 ;;=^5059581
 ;;^UTILITY(U,$J,358.3,4312,0)
 ;;=W10.2XXD^^28^265^13
 ;;^UTILITY(U,$J,358.3,4312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4312,1,3,0)
 ;;=3^Fall from Incline,Subsequent
 ;;^UTILITY(U,$J,358.3,4312,1,4,0)
 ;;=4^W10.2XXD
 ;;^UTILITY(U,$J,358.3,4312,2)
 ;;=^5059587
 ;;^UTILITY(U,$J,358.3,4313,0)
 ;;=W10.1XXD^^28^265^19
 ;;^UTILITY(U,$J,358.3,4313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4313,1,3,0)
 ;;=3^Fall from Sidewalk/Curb,Subsequent
 ;;^UTILITY(U,$J,358.3,4313,1,4,0)
 ;;=4^W10.1XXD
 ;;^UTILITY(U,$J,358.3,4313,2)
 ;;=^5059584
 ;;^UTILITY(U,$J,358.3,4314,0)
 ;;=W06.XXXD^^28^265^9
 ;;^UTILITY(U,$J,358.3,4314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4314,1,3,0)
 ;;=3^Fall from Bed,Subsequent
 ;;^UTILITY(U,$J,358.3,4314,1,4,0)
 ;;=4^W06.XXXD
 ;;^UTILITY(U,$J,358.3,4314,2)
 ;;=^5059560
 ;;^UTILITY(U,$J,358.3,4315,0)
 ;;=W07.XXXD^^28^265^10
 ;;^UTILITY(U,$J,358.3,4315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4315,1,3,0)
 ;;=3^Fall from Chair,Subsequent
 ;;^UTILITY(U,$J,358.3,4315,1,4,0)
 ;;=4^W07.XXXD
 ;;^UTILITY(U,$J,358.3,4315,2)
 ;;=^5059563
 ;;^UTILITY(U,$J,358.3,4316,0)
 ;;=W05.2XXD^^28^265^15
 ;;^UTILITY(U,$J,358.3,4316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4316,1,3,0)
 ;;=3^Fall from Non-Moving Motorized Scooter,Subsequent
 ;;^UTILITY(U,$J,358.3,4316,1,4,0)
 ;;=4^W05.2XXD
 ;;^UTILITY(U,$J,358.3,4316,2)
 ;;=^5059557
 ;;^UTILITY(U,$J,358.3,4317,0)
 ;;=W05.1XXD^^28^265^16
 ;;^UTILITY(U,$J,358.3,4317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4317,1,3,0)
 ;;=3^Fall from Non-Moving Nonmotorized Scooter,Subsequent
 ;;^UTILITY(U,$J,358.3,4317,1,4,0)
 ;;=4^W05.1XXD
 ;;^UTILITY(U,$J,358.3,4317,2)
 ;;=^5059554
 ;;^UTILITY(U,$J,358.3,4318,0)
 ;;=W05.0XXD^^28^265^17
 ;;^UTILITY(U,$J,358.3,4318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4318,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Subsequent
 ;;^UTILITY(U,$J,358.3,4318,1,4,0)
 ;;=4^W05.0XXD
 ;;^UTILITY(U,$J,358.3,4318,2)
 ;;=^5059551
 ;;^UTILITY(U,$J,358.3,4319,0)
 ;;=W18.12XD^^28^265^21
 ;;^UTILITY(U,$J,358.3,4319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4319,1,3,0)
 ;;=3^Fall from Toilet w/ Strike Against Object,Subsequent
 ;;^UTILITY(U,$J,358.3,4319,1,4,0)
 ;;=4^W18.12XD
 ;;^UTILITY(U,$J,358.3,4319,2)
 ;;=^5137984
 ;;^UTILITY(U,$J,358.3,4320,0)
 ;;=W18.11XD^^28^265^22
 ;;^UTILITY(U,$J,358.3,4320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4320,1,3,0)
 ;;=3^Fall from Toilet,Subsequent
 ;;^UTILITY(U,$J,358.3,4320,1,4,0)
 ;;=4^W18.11XD
 ;;^UTILITY(U,$J,358.3,4320,2)
 ;;=^5059802
 ;;^UTILITY(U,$J,358.3,4321,0)
 ;;=W08.XXXD^^28^265^12
 ;;^UTILITY(U,$J,358.3,4321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4321,1,3,0)
 ;;=3^Fall from Furniture,Subsequent
 ;;^UTILITY(U,$J,358.3,4321,1,4,0)
 ;;=4^W08.XXXD
 ;;^UTILITY(U,$J,358.3,4321,2)
 ;;=^5059566
 ;;^UTILITY(U,$J,358.3,4322,0)
 ;;=W18.2XXD^^28^265^23
 ;;^UTILITY(U,$J,358.3,4322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4322,1,3,0)
 ;;=3^Fall in Shower/Bathtub,Subsequent
 ;;^UTILITY(U,$J,358.3,4322,1,4,0)
 ;;=4^W18.2XXD
