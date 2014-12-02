IBDEI0GQ ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8126,1,3,0)
 ;;=3^Cataract, PSC/Post Subcapsular
 ;;^UTILITY(U,$J,358.3,8126,1,4,0)
 ;;=4^366.14
 ;;^UTILITY(U,$J,358.3,8126,2)
 ;;=Post Subcapsular Senile Cataract^268796
 ;;^UTILITY(U,$J,358.3,8127,0)
 ;;=V43.1^^58^606^28
 ;;^UTILITY(U,$J,358.3,8127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8127,1,3,0)
 ;;=3^Pseudophakos (Replacement)
 ;;^UTILITY(U,$J,358.3,8127,1,4,0)
 ;;=4^V43.1
 ;;^UTILITY(U,$J,358.3,8127,2)
 ;;=^69114^V45.61
 ;;^UTILITY(U,$J,358.3,8128,0)
 ;;=366.20^^58^606^19
 ;;^UTILITY(U,$J,358.3,8128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8128,1,3,0)
 ;;=3^Cataract, Traumatic
 ;;^UTILITY(U,$J,358.3,8128,1,4,0)
 ;;=4^366.20
 ;;^UTILITY(U,$J,358.3,8128,2)
 ;;=Traumatic Cataract, NOS^268802
 ;;^UTILITY(U,$J,358.3,8129,0)
 ;;=366.52^^58^606^13
 ;;^UTILITY(U,$J,358.3,8129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8129,1,3,0)
 ;;=3^Cataract, Post Capsular-not obscuring vision
 ;;^UTILITY(U,$J,358.3,8129,1,4,0)
 ;;=4^366.52
 ;;^UTILITY(U,$J,358.3,8129,2)
 ;;=Posterior Capsular Fibrosis Not Obscuring Vision^268822
 ;;^UTILITY(U,$J,358.3,8130,0)
 ;;=366.53^^58^606^14
 ;;^UTILITY(U,$J,358.3,8130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8130,1,3,0)
 ;;=3^Cataract, Post Capsular-obscuring vision
 ;;^UTILITY(U,$J,358.3,8130,1,4,0)
 ;;=4^366.53
 ;;^UTILITY(U,$J,358.3,8130,2)
 ;;=Post Capsular Fibrosis, Obscuring Vision^268823
 ;;^UTILITY(U,$J,358.3,8131,0)
 ;;=366.11^^58^606^15
 ;;^UTILITY(U,$J,358.3,8131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8131,1,3,0)
 ;;=3^Cataract, Pseudoexfoliation
 ;;^UTILITY(U,$J,358.3,8131,1,4,0)
 ;;=4^366.11
 ;;^UTILITY(U,$J,358.3,8131,2)
 ;;=Pseudoexfoliation^265538
 ;;^UTILITY(U,$J,358.3,8132,0)
 ;;=366.17^^58^606^8
 ;;^UTILITY(U,$J,358.3,8132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8132,1,3,0)
 ;;=3^Cataract, Mature
 ;;^UTILITY(U,$J,358.3,8132,1,4,0)
 ;;=4^366.17
 ;;^UTILITY(U,$J,358.3,8132,2)
 ;;=Mature Cataract^265530
 ;;^UTILITY(U,$J,358.3,8133,0)
 ;;=362.53^^58^606^21
 ;;^UTILITY(U,$J,358.3,8133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8133,1,3,0)
 ;;=3^Cystoid Macular Edema (CME)
 ;;^UTILITY(U,$J,358.3,8133,1,4,0)
 ;;=4^362.53
 ;;^UTILITY(U,$J,358.3,8133,2)
 ;;=^268638^996.79
 ;;^UTILITY(U,$J,358.3,8134,0)
 ;;=743.30^^58^606^3
 ;;^UTILITY(U,$J,358.3,8134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8134,1,3,0)
 ;;=3^Cataract, Congenital
 ;;^UTILITY(U,$J,358.3,8134,1,4,0)
 ;;=4^743.30
 ;;^UTILITY(U,$J,358.3,8134,2)
 ;;=Congenital Cataract^27422
 ;;^UTILITY(U,$J,358.3,8135,0)
 ;;=366.9^^58^606^20
 ;;^UTILITY(U,$J,358.3,8135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8135,1,3,0)
 ;;=3^Cataract, Unspecified
 ;;^UTILITY(U,$J,358.3,8135,1,4,0)
 ;;=4^366.9
 ;;^UTILITY(U,$J,358.3,8135,2)
 ;;=^20266
 ;;^UTILITY(U,$J,358.3,8136,0)
 ;;=996.69^^58^606^23
 ;;^UTILITY(U,$J,358.3,8136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8136,1,3,0)
 ;;=3^Post Op Endophthalmitis
 ;;^UTILITY(U,$J,358.3,8136,1,4,0)
 ;;=4^996.69
 ;;^UTILITY(U,$J,358.3,8136,2)
 ;;=Post Op Endophthalmitis^276291
 ;;^UTILITY(U,$J,358.3,8137,0)
 ;;=998.82^^58^606^6
 ;;^UTILITY(U,$J,358.3,8137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8137,1,3,0)
 ;;=3^Cataract, Fragment Following Cat Surg
 ;;^UTILITY(U,$J,358.3,8137,1,4,0)
 ;;=4^998.82
 ;;^UTILITY(U,$J,358.3,8137,2)
 ;;=^303364
 ;;^UTILITY(U,$J,358.3,8138,0)
 ;;=366.8^^58^606^11
 ;;^UTILITY(U,$J,358.3,8138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8138,1,3,0)
 ;;=3^Cataract, Other
 ;;^UTILITY(U,$J,358.3,8138,1,4,0)
 ;;=4^366.8
 ;;^UTILITY(U,$J,358.3,8138,2)
 ;;=^87370
 ;;^UTILITY(U,$J,358.3,8139,0)
 ;;=366.41^^58^606^5
