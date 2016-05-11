IBDEI1DY ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23545,1,3,0)
 ;;=3^Wheelchair Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,23545,1,4,0)
 ;;=4^V00.812A
 ;;^UTILITY(U,$J,358.3,23545,2)
 ;;=^5055940
 ;;^UTILITY(U,$J,358.3,23546,0)
 ;;=V00.812D^^87^1000^134
 ;;^UTILITY(U,$J,358.3,23546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23546,1,3,0)
 ;;=3^Wheelchair Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23546,1,4,0)
 ;;=4^V00.812D
 ;;^UTILITY(U,$J,358.3,23546,2)
 ;;=^5055941
 ;;^UTILITY(U,$J,358.3,23547,0)
 ;;=V00.818A^^87^1000^131
 ;;^UTILITY(U,$J,358.3,23547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23547,1,3,0)
 ;;=3^Wheelchair Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,23547,1,4,0)
 ;;=4^V00.818A
 ;;^UTILITY(U,$J,358.3,23547,2)
 ;;=^5055943
 ;;^UTILITY(U,$J,358.3,23548,0)
 ;;=V00.818D^^87^1000^132
 ;;^UTILITY(U,$J,358.3,23548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23548,1,3,0)
 ;;=3^Wheelchair Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23548,1,4,0)
 ;;=4^V00.818D
 ;;^UTILITY(U,$J,358.3,23548,2)
 ;;=^5055944
 ;;^UTILITY(U,$J,358.3,23549,0)
 ;;=V00.831A^^87^1000^43
 ;;^UTILITY(U,$J,358.3,23549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23549,1,3,0)
 ;;=3^Fall from Mobility Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,23549,1,4,0)
 ;;=4^V00.831A
 ;;^UTILITY(U,$J,358.3,23549,2)
 ;;=^5055955
 ;;^UTILITY(U,$J,358.3,23550,0)
 ;;=V00.831D^^87^1000^44
 ;;^UTILITY(U,$J,358.3,23550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23550,1,3,0)
 ;;=3^Fall from Mobility Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23550,1,4,0)
 ;;=4^V00.831D
 ;;^UTILITY(U,$J,358.3,23550,2)
 ;;=^5055956
 ;;^UTILITY(U,$J,358.3,23551,0)
 ;;=V00.832A^^87^1000^95
 ;;^UTILITY(U,$J,358.3,23551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23551,1,3,0)
 ;;=3^Mobility Scooter Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,23551,1,4,0)
 ;;=4^V00.832A
 ;;^UTILITY(U,$J,358.3,23551,2)
 ;;=^5055958
 ;;^UTILITY(U,$J,358.3,23552,0)
 ;;=V00.832D^^87^1000^96
 ;;^UTILITY(U,$J,358.3,23552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23552,1,3,0)
 ;;=3^Mobility Scooter Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23552,1,4,0)
 ;;=4^V00.832D
 ;;^UTILITY(U,$J,358.3,23552,2)
 ;;=^5055959
 ;;^UTILITY(U,$J,358.3,23553,0)
 ;;=V00.838A^^87^1000^93
 ;;^UTILITY(U,$J,358.3,23553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23553,1,3,0)
 ;;=3^Mobility Scooter Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,23553,1,4,0)
 ;;=4^V00.838A
 ;;^UTILITY(U,$J,358.3,23553,2)
 ;;=^5055961
 ;;^UTILITY(U,$J,358.3,23554,0)
 ;;=V00.838D^^87^1000^94
 ;;^UTILITY(U,$J,358.3,23554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23554,1,3,0)
 ;;=3^Mobility Scooter Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23554,1,4,0)
 ;;=4^V00.838D
 ;;^UTILITY(U,$J,358.3,23554,2)
 ;;=^5055962
 ;;^UTILITY(U,$J,358.3,23555,0)
 ;;=V00.891A^^87^1000^57
 ;;^UTILITY(U,$J,358.3,23555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23555,1,3,0)
 ;;=3^Fall from Pedestrian Conveyance,Init Encntr
 ;;^UTILITY(U,$J,358.3,23555,1,4,0)
 ;;=4^V00.891A
 ;;^UTILITY(U,$J,358.3,23555,2)
 ;;=^5055964
 ;;^UTILITY(U,$J,358.3,23556,0)
 ;;=V00.891D^^87^1000^58
 ;;^UTILITY(U,$J,358.3,23556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23556,1,3,0)
 ;;=3^Fall from Pedestrian Conveyance,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23556,1,4,0)
 ;;=4^V00.891D
 ;;^UTILITY(U,$J,358.3,23556,2)
 ;;=^5055965
 ;;^UTILITY(U,$J,358.3,23557,0)
 ;;=V00.892A^^87^1000^99
 ;;^UTILITY(U,$J,358.3,23557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23557,1,3,0)
 ;;=3^Pedestrian Conveyance Colliding w/ Stationary Obj,Init Encntr
