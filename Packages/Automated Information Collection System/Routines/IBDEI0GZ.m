IBDEI0GZ ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8213,1,3,0)
 ;;=3^Pseudophakos (Replacement)
 ;;^UTILITY(U,$J,358.3,8213,1,4,0)
 ;;=4^V43.1
 ;;^UTILITY(U,$J,358.3,8213,2)
 ;;=^69114^V45.61
 ;;^UTILITY(U,$J,358.3,8214,0)
 ;;=366.20^^52^579^19
 ;;^UTILITY(U,$J,358.3,8214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8214,1,3,0)
 ;;=3^Cataract, Traumatic
 ;;^UTILITY(U,$J,358.3,8214,1,4,0)
 ;;=4^366.20
 ;;^UTILITY(U,$J,358.3,8214,2)
 ;;=Traumatic Cataract, NOS^268802
 ;;^UTILITY(U,$J,358.3,8215,0)
 ;;=366.52^^52^579^13
 ;;^UTILITY(U,$J,358.3,8215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8215,1,3,0)
 ;;=3^Cataract, Post Capsular-not obscuring vision
 ;;^UTILITY(U,$J,358.3,8215,1,4,0)
 ;;=4^366.52
 ;;^UTILITY(U,$J,358.3,8215,2)
 ;;=Posterior Capsular Fibrosis Not Obscuring Vision^268822
 ;;^UTILITY(U,$J,358.3,8216,0)
 ;;=366.53^^52^579^14
 ;;^UTILITY(U,$J,358.3,8216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8216,1,3,0)
 ;;=3^Cataract, Post Capsular-obscuring vision
 ;;^UTILITY(U,$J,358.3,8216,1,4,0)
 ;;=4^366.53
 ;;^UTILITY(U,$J,358.3,8216,2)
 ;;=Post Capsular Fibrosis, Obscuring Vision^268823
 ;;^UTILITY(U,$J,358.3,8217,0)
 ;;=366.11^^52^579^15
 ;;^UTILITY(U,$J,358.3,8217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8217,1,3,0)
 ;;=3^Cataract, Pseudoexfoliation
 ;;^UTILITY(U,$J,358.3,8217,1,4,0)
 ;;=4^366.11
 ;;^UTILITY(U,$J,358.3,8217,2)
 ;;=Pseudoexfoliation^265538
 ;;^UTILITY(U,$J,358.3,8218,0)
 ;;=366.17^^52^579^8
 ;;^UTILITY(U,$J,358.3,8218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8218,1,3,0)
 ;;=3^Cataract, Mature
 ;;^UTILITY(U,$J,358.3,8218,1,4,0)
 ;;=4^366.17
 ;;^UTILITY(U,$J,358.3,8218,2)
 ;;=Mature Cataract^265530
 ;;^UTILITY(U,$J,358.3,8219,0)
 ;;=362.53^^52^579^21
 ;;^UTILITY(U,$J,358.3,8219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8219,1,3,0)
 ;;=3^Cystoid Macular Edema (CME)
 ;;^UTILITY(U,$J,358.3,8219,1,4,0)
 ;;=4^362.53
 ;;^UTILITY(U,$J,358.3,8219,2)
 ;;=^268638^996.79
 ;;^UTILITY(U,$J,358.3,8220,0)
 ;;=743.30^^52^579^3
 ;;^UTILITY(U,$J,358.3,8220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8220,1,3,0)
 ;;=3^Cataract, Congenital
 ;;^UTILITY(U,$J,358.3,8220,1,4,0)
 ;;=4^743.30
 ;;^UTILITY(U,$J,358.3,8220,2)
 ;;=Congenital Cataract^27422
 ;;^UTILITY(U,$J,358.3,8221,0)
 ;;=366.9^^52^579^20
 ;;^UTILITY(U,$J,358.3,8221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8221,1,3,0)
 ;;=3^Cataract, Unspecified
 ;;^UTILITY(U,$J,358.3,8221,1,4,0)
 ;;=4^366.9
 ;;^UTILITY(U,$J,358.3,8221,2)
 ;;=^20266
 ;;^UTILITY(U,$J,358.3,8222,0)
 ;;=996.69^^52^579^24
 ;;^UTILITY(U,$J,358.3,8222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8222,1,3,0)
 ;;=3^Post Op Endophthalmitis
 ;;^UTILITY(U,$J,358.3,8222,1,4,0)
 ;;=4^996.69
 ;;^UTILITY(U,$J,358.3,8222,2)
 ;;=Post Op Endophthalmitis^276291
 ;;^UTILITY(U,$J,358.3,8223,0)
 ;;=998.82^^52^579^6
 ;;^UTILITY(U,$J,358.3,8223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8223,1,3,0)
 ;;=3^Cataract, Fragment Following Cat Surg
 ;;^UTILITY(U,$J,358.3,8223,1,4,0)
 ;;=4^998.82
 ;;^UTILITY(U,$J,358.3,8223,2)
 ;;=^303364
 ;;^UTILITY(U,$J,358.3,8224,0)
 ;;=366.8^^52^579^11
 ;;^UTILITY(U,$J,358.3,8224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8224,1,3,0)
 ;;=3^Cataract, Other
 ;;^UTILITY(U,$J,358.3,8224,1,4,0)
 ;;=4^366.8
 ;;^UTILITY(U,$J,358.3,8224,2)
 ;;=^87370
 ;;^UTILITY(U,$J,358.3,8225,0)
 ;;=366.41^^52^579^5
 ;;^UTILITY(U,$J,358.3,8225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8225,1,3,0)
 ;;=3^Cataract, Diabetic
 ;;^UTILITY(U,$J,358.3,8225,1,4,0)
 ;;=4^366.41
 ;;^UTILITY(U,$J,358.3,8225,2)
 ;;=^33638^250.00
 ;;^UTILITY(U,$J,358.3,8226,0)
 ;;=366.00^^52^579^9
