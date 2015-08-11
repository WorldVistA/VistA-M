IBDEI0F0 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7221,1,3,0)
 ;;=3^Pseudophakos (Replacement)
 ;;^UTILITY(U,$J,358.3,7221,1,4,0)
 ;;=4^V43.1
 ;;^UTILITY(U,$J,358.3,7221,2)
 ;;=^69114^V45.61
 ;;^UTILITY(U,$J,358.3,7222,0)
 ;;=366.20^^49^555^19
 ;;^UTILITY(U,$J,358.3,7222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7222,1,3,0)
 ;;=3^Cataract, Traumatic
 ;;^UTILITY(U,$J,358.3,7222,1,4,0)
 ;;=4^366.20
 ;;^UTILITY(U,$J,358.3,7222,2)
 ;;=Traumatic Cataract, NOS^268802
 ;;^UTILITY(U,$J,358.3,7223,0)
 ;;=366.52^^49^555^13
 ;;^UTILITY(U,$J,358.3,7223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7223,1,3,0)
 ;;=3^Cataract, Post Capsular-not obscuring vision
 ;;^UTILITY(U,$J,358.3,7223,1,4,0)
 ;;=4^366.52
 ;;^UTILITY(U,$J,358.3,7223,2)
 ;;=Posterior Capsular Fibrosis Not Obscuring Vision^268822
 ;;^UTILITY(U,$J,358.3,7224,0)
 ;;=366.53^^49^555^14
 ;;^UTILITY(U,$J,358.3,7224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7224,1,3,0)
 ;;=3^Cataract, Post Capsular-obscuring vision
 ;;^UTILITY(U,$J,358.3,7224,1,4,0)
 ;;=4^366.53
 ;;^UTILITY(U,$J,358.3,7224,2)
 ;;=Post Capsular Fibrosis, Obscuring Vision^268823
 ;;^UTILITY(U,$J,358.3,7225,0)
 ;;=366.11^^49^555^15
 ;;^UTILITY(U,$J,358.3,7225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7225,1,3,0)
 ;;=3^Cataract, Pseudoexfoliation
 ;;^UTILITY(U,$J,358.3,7225,1,4,0)
 ;;=4^366.11
 ;;^UTILITY(U,$J,358.3,7225,2)
 ;;=Pseudoexfoliation^265538
 ;;^UTILITY(U,$J,358.3,7226,0)
 ;;=366.17^^49^555^8
 ;;^UTILITY(U,$J,358.3,7226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7226,1,3,0)
 ;;=3^Cataract, Mature
 ;;^UTILITY(U,$J,358.3,7226,1,4,0)
 ;;=4^366.17
 ;;^UTILITY(U,$J,358.3,7226,2)
 ;;=Mature Cataract^265530
 ;;^UTILITY(U,$J,358.3,7227,0)
 ;;=362.53^^49^555^21
 ;;^UTILITY(U,$J,358.3,7227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7227,1,3,0)
 ;;=3^Cystoid Macular Edema (CME)
 ;;^UTILITY(U,$J,358.3,7227,1,4,0)
 ;;=4^362.53
 ;;^UTILITY(U,$J,358.3,7227,2)
 ;;=^268638^996.79
 ;;^UTILITY(U,$J,358.3,7228,0)
 ;;=743.30^^49^555^3
 ;;^UTILITY(U,$J,358.3,7228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7228,1,3,0)
 ;;=3^Cataract, Congenital
 ;;^UTILITY(U,$J,358.3,7228,1,4,0)
 ;;=4^743.30
 ;;^UTILITY(U,$J,358.3,7228,2)
 ;;=Congenital Cataract^27422
 ;;^UTILITY(U,$J,358.3,7229,0)
 ;;=366.9^^49^555^20
 ;;^UTILITY(U,$J,358.3,7229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7229,1,3,0)
 ;;=3^Cataract, Unspecified
 ;;^UTILITY(U,$J,358.3,7229,1,4,0)
 ;;=4^366.9
 ;;^UTILITY(U,$J,358.3,7229,2)
 ;;=^20266
 ;;^UTILITY(U,$J,358.3,7230,0)
 ;;=996.69^^49^555^24
 ;;^UTILITY(U,$J,358.3,7230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7230,1,3,0)
 ;;=3^Post Op Endophthalmitis
 ;;^UTILITY(U,$J,358.3,7230,1,4,0)
 ;;=4^996.69
 ;;^UTILITY(U,$J,358.3,7230,2)
 ;;=Post Op Endophthalmitis^276291
 ;;^UTILITY(U,$J,358.3,7231,0)
 ;;=998.82^^49^555^6
 ;;^UTILITY(U,$J,358.3,7231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7231,1,3,0)
 ;;=3^Cataract, Fragment Following Cat Surg
 ;;^UTILITY(U,$J,358.3,7231,1,4,0)
 ;;=4^998.82
 ;;^UTILITY(U,$J,358.3,7231,2)
 ;;=^303364
 ;;^UTILITY(U,$J,358.3,7232,0)
 ;;=366.8^^49^555^11
 ;;^UTILITY(U,$J,358.3,7232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7232,1,3,0)
 ;;=3^Cataract, Other
 ;;^UTILITY(U,$J,358.3,7232,1,4,0)
 ;;=4^366.8
 ;;^UTILITY(U,$J,358.3,7232,2)
 ;;=^87370
 ;;^UTILITY(U,$J,358.3,7233,0)
 ;;=366.41^^49^555^5
 ;;^UTILITY(U,$J,358.3,7233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7233,1,3,0)
 ;;=3^Cataract, Diabetic
 ;;^UTILITY(U,$J,358.3,7233,1,4,0)
 ;;=4^366.41
 ;;^UTILITY(U,$J,358.3,7233,2)
 ;;=^33638^250.00
 ;;^UTILITY(U,$J,358.3,7234,0)
 ;;=366.00^^49^555^9
