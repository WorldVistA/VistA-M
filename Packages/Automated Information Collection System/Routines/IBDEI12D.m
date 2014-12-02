IBDEI12D ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19058,1,5,0)
 ;;=5^Dermatitis, Stasis (w/o varicose veins) 
 ;;^UTILITY(U,$J,358.3,19058,2)
 ;;=^125826
 ;;^UTILITY(U,$J,358.3,19059,0)
 ;;=454.1^^125^1221^14
 ;;^UTILITY(U,$J,358.3,19059,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19059,1,3,0)
 ;;=3^454.1
 ;;^UTILITY(U,$J,358.3,19059,1,5,0)
 ;;=5^Dermatitis, Status due to varicose veins 
 ;;^UTILITY(U,$J,358.3,19059,2)
 ;;=^125435
 ;;^UTILITY(U,$J,358.3,19060,0)
 ;;=454.2^^125^1221^13
 ;;^UTILITY(U,$J,358.3,19060,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19060,1,3,0)
 ;;=3^454.2
 ;;^UTILITY(U,$J,358.3,19060,1,5,0)
 ;;=5^Dermatitis, Stasis with ulcer/ulcerated
 ;;^UTILITY(U,$J,358.3,19060,2)
 ;;=^269821
 ;;^UTILITY(U,$J,358.3,19061,0)
 ;;=110.4^^125^1221^15
 ;;^UTILITY(U,$J,358.3,19061,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19061,1,3,0)
 ;;=3^110.4
 ;;^UTILITY(U,$J,358.3,19061,1,5,0)
 ;;=5^Dermatophytosis of foot
 ;;^UTILITY(U,$J,358.3,19061,2)
 ;;=^33168
 ;;^UTILITY(U,$J,358.3,19062,0)
 ;;=250.00^^125^1221^4
 ;;^UTILITY(U,$J,358.3,19062,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19062,1,3,0)
 ;;=3^250.00
 ;;^UTILITY(U,$J,358.3,19062,1,5,0)
 ;;=5^DM II w/o complication 
 ;;^UTILITY(U,$J,358.3,19062,2)
 ;;=^33605
 ;;^UTILITY(U,$J,358.3,19063,0)
 ;;=250.01^^125^1221^3
 ;;^UTILITY(U,$J,358.3,19063,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19063,1,3,0)
 ;;=3^250.01
 ;;^UTILITY(U,$J,358.3,19063,1,5,0)
 ;;=5^DM I w/o complication 
 ;;^UTILITY(U,$J,358.3,19063,2)
 ;;=^33586
 ;;^UTILITY(U,$J,358.3,19064,0)
 ;;=838.00^^125^1221^20
 ;;^UTILITY(U,$J,358.3,19064,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19064,1,3,0)
 ;;=3^838.00
 ;;^UTILITY(U,$J,358.3,19064,1,5,0)
 ;;=5^Dislocation of foot, closed dislocation; foot, unspecified
 ;;^UTILITY(U,$J,358.3,19064,2)
 ;;=^274391
 ;;^UTILITY(U,$J,358.3,19065,0)
 ;;=838.01^^125^1221^21
 ;;^UTILITY(U,$J,358.3,19065,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19065,1,3,0)
 ;;=3^838.01
 ;;^UTILITY(U,$J,358.3,19065,1,5,0)
 ;;=5^Dislocation of foot, closed dislocation; tarsal(bone), joint unspecified 
 ;;^UTILITY(U,$J,358.3,19065,2)
 ;;=^274394
 ;;^UTILITY(U,$J,358.3,19066,0)
 ;;=838.02^^125^1221^22
 ;;^UTILITY(U,$J,358.3,19066,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19066,1,3,0)
 ;;=3^838.02
 ;;^UTILITY(U,$J,358.3,19066,1,5,0)
 ;;=5^Dislocation of foot, closed dislocation; midtarsal (joint)
 ;;^UTILITY(U,$J,358.3,19066,2)
 ;;=^274395
 ;;^UTILITY(U,$J,358.3,19067,0)
 ;;=838.03^^125^1221^23
 ;;^UTILITY(U,$J,358.3,19067,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19067,1,3,0)
 ;;=3^838.03
 ;;^UTILITY(U,$J,358.3,19067,1,5,0)
 ;;=5^Dislocation of foot, closed dislocation; tarsometatarsal (joint)
 ;;^UTILITY(U,$J,358.3,19067,2)
 ;;=^274396
 ;;^UTILITY(U,$J,358.3,19068,0)
 ;;=838.04^^125^1221^24
 ;;^UTILITY(U,$J,358.3,19068,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19068,1,3,0)
 ;;=3^838.04
 ;;^UTILITY(U,$J,358.3,19068,1,5,0)
 ;;=5^Dislocation of foot, closed dislocation; metatarsal(bone), joint unspecified
 ;;^UTILITY(U,$J,358.3,19068,2)
 ;;=^274397
 ;;^UTILITY(U,$J,358.3,19069,0)
 ;;=838.05^^125^1221^25
 ;;^UTILITY(U,$J,358.3,19069,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19069,1,3,0)
 ;;=3^838.05
 ;;^UTILITY(U,$J,358.3,19069,1,5,0)
 ;;=5^Dislocation of foot, closed dislocation; metatarsophalangeal(joint)
 ;;^UTILITY(U,$J,358.3,19069,2)
 ;;=^274398
 ;;^UTILITY(U,$J,358.3,19070,0)
 ;;=838.06^^125^1221^26
 ;;^UTILITY(U,$J,358.3,19070,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19070,1,3,0)
 ;;=3^838.06
 ;;^UTILITY(U,$J,358.3,19070,1,5,0)
 ;;=5^Dislocation of foot, closed dislocation; interphalangeal(joint) foot
