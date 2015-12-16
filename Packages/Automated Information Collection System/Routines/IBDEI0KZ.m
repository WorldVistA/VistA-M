IBDEI0KZ ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9942,0)
 ;;=366.20^^44^559^19
 ;;^UTILITY(U,$J,358.3,9942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9942,1,3,0)
 ;;=3^Cataract, Traumatic
 ;;^UTILITY(U,$J,358.3,9942,1,4,0)
 ;;=4^366.20
 ;;^UTILITY(U,$J,358.3,9942,2)
 ;;=Traumatic Cataract, NOS^268802
 ;;^UTILITY(U,$J,358.3,9943,0)
 ;;=366.52^^44^559^13
 ;;^UTILITY(U,$J,358.3,9943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9943,1,3,0)
 ;;=3^Cataract, Post Capsular-not obscuring vision
 ;;^UTILITY(U,$J,358.3,9943,1,4,0)
 ;;=4^366.52
 ;;^UTILITY(U,$J,358.3,9943,2)
 ;;=Posterior Capsular Fibrosis Not Obscuring Vision^268822
 ;;^UTILITY(U,$J,358.3,9944,0)
 ;;=366.53^^44^559^14
 ;;^UTILITY(U,$J,358.3,9944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9944,1,3,0)
 ;;=3^Cataract, Post Capsular-obscuring vision
 ;;^UTILITY(U,$J,358.3,9944,1,4,0)
 ;;=4^366.53
 ;;^UTILITY(U,$J,358.3,9944,2)
 ;;=Post Capsular Fibrosis, Obscuring Vision^268823
 ;;^UTILITY(U,$J,358.3,9945,0)
 ;;=366.11^^44^559^15
 ;;^UTILITY(U,$J,358.3,9945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9945,1,3,0)
 ;;=3^Cataract, Pseudoexfoliation
 ;;^UTILITY(U,$J,358.3,9945,1,4,0)
 ;;=4^366.11
 ;;^UTILITY(U,$J,358.3,9945,2)
 ;;=Pseudoexfoliation^265538
 ;;^UTILITY(U,$J,358.3,9946,0)
 ;;=366.17^^44^559^8
 ;;^UTILITY(U,$J,358.3,9946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9946,1,3,0)
 ;;=3^Cataract, Mature
 ;;^UTILITY(U,$J,358.3,9946,1,4,0)
 ;;=4^366.17
 ;;^UTILITY(U,$J,358.3,9946,2)
 ;;=Mature Cataract^265530
 ;;^UTILITY(U,$J,358.3,9947,0)
 ;;=362.53^^44^559^21
 ;;^UTILITY(U,$J,358.3,9947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9947,1,3,0)
 ;;=3^Cystoid Macular Edema (CME)
 ;;^UTILITY(U,$J,358.3,9947,1,4,0)
 ;;=4^362.53
 ;;^UTILITY(U,$J,358.3,9947,2)
 ;;=^268638^996.79
 ;;^UTILITY(U,$J,358.3,9948,0)
 ;;=743.30^^44^559^3
 ;;^UTILITY(U,$J,358.3,9948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9948,1,3,0)
 ;;=3^Cataract, Congenital
 ;;^UTILITY(U,$J,358.3,9948,1,4,0)
 ;;=4^743.30
 ;;^UTILITY(U,$J,358.3,9948,2)
 ;;=Congenital Cataract^27422
 ;;^UTILITY(U,$J,358.3,9949,0)
 ;;=366.9^^44^559^20
 ;;^UTILITY(U,$J,358.3,9949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9949,1,3,0)
 ;;=3^Cataract, Unspecified
 ;;^UTILITY(U,$J,358.3,9949,1,4,0)
 ;;=4^366.9
 ;;^UTILITY(U,$J,358.3,9949,2)
 ;;=^20266
 ;;^UTILITY(U,$J,358.3,9950,0)
 ;;=996.69^^44^559^24
 ;;^UTILITY(U,$J,358.3,9950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9950,1,3,0)
 ;;=3^Post Op Endophthalmitis
 ;;^UTILITY(U,$J,358.3,9950,1,4,0)
 ;;=4^996.69
 ;;^UTILITY(U,$J,358.3,9950,2)
 ;;=Post Op Endophthalmitis^276291
 ;;^UTILITY(U,$J,358.3,9951,0)
 ;;=998.82^^44^559^6
 ;;^UTILITY(U,$J,358.3,9951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9951,1,3,0)
 ;;=3^Cataract, Fragment Following Cat Surg
 ;;^UTILITY(U,$J,358.3,9951,1,4,0)
 ;;=4^998.82
 ;;^UTILITY(U,$J,358.3,9951,2)
 ;;=^303364
 ;;^UTILITY(U,$J,358.3,9952,0)
 ;;=366.8^^44^559^11
 ;;^UTILITY(U,$J,358.3,9952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9952,1,3,0)
 ;;=3^Cataract, Other
 ;;^UTILITY(U,$J,358.3,9952,1,4,0)
 ;;=4^366.8
 ;;^UTILITY(U,$J,358.3,9952,2)
 ;;=^87370
 ;;^UTILITY(U,$J,358.3,9953,0)
 ;;=366.41^^44^559^5
 ;;^UTILITY(U,$J,358.3,9953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9953,1,3,0)
 ;;=3^Cataract, Diabetic
 ;;^UTILITY(U,$J,358.3,9953,1,4,0)
 ;;=4^366.41
 ;;^UTILITY(U,$J,358.3,9953,2)
 ;;=^33638^250.00
 ;;^UTILITY(U,$J,358.3,9954,0)
 ;;=366.00^^44^559^9
 ;;^UTILITY(U,$J,358.3,9954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9954,1,3,0)
 ;;=3^Cataract, Nonsenile NOS
 ;;^UTILITY(U,$J,358.3,9954,1,4,0)
 ;;=4^366.00
 ;;^UTILITY(U,$J,358.3,9954,2)
 ;;=^268786
