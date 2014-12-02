IBDEI01L ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,263,1,5,0)
 ;;=5^Economic Problem
 ;;^UTILITY(U,$J,358.3,263,2)
 ;;=^62174
 ;;^UTILITY(U,$J,358.3,264,0)
 ;;=V62.89^^2^19^37
 ;;^UTILITY(U,$J,358.3,264,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,264,1,2,0)
 ;;=2^V62.89
 ;;^UTILITY(U,$J,358.3,264,1,5,0)
 ;;=5^Psychological Stress
 ;;^UTILITY(U,$J,358.3,264,2)
 ;;=^87822
 ;;^UTILITY(U,$J,358.3,265,0)
 ;;=V62.9^^2^19^38
 ;;^UTILITY(U,$J,358.3,265,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,265,1,2,0)
 ;;=2^V62.9
 ;;^UTILITY(U,$J,358.3,265,1,5,0)
 ;;=5^Psychosocial Circum
 ;;^UTILITY(U,$J,358.3,265,2)
 ;;=^295551
 ;;^UTILITY(U,$J,358.3,266,0)
 ;;=V60.0^^2^19^22
 ;;^UTILITY(U,$J,358.3,266,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,266,1,2,0)
 ;;=2^V60.0
 ;;^UTILITY(U,$J,358.3,266,1,5,0)
 ;;=5^Lack Of Housing
 ;;^UTILITY(U,$J,358.3,266,2)
 ;;=^295539
 ;;^UTILITY(U,$J,358.3,267,0)
 ;;=V62.81^^2^19^21
 ;;^UTILITY(U,$J,358.3,267,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,267,1,2,0)
 ;;=2^V62.81
 ;;^UTILITY(U,$J,358.3,267,1,5,0)
 ;;=5^Interpersonal Problem
 ;;^UTILITY(U,$J,358.3,267,2)
 ;;=^276358
 ;;^UTILITY(U,$J,358.3,268,0)
 ;;=V71.01^^2^19^24
 ;;^UTILITY(U,$J,358.3,268,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,268,1,2,0)
 ;;=2^V71.01
 ;;^UTILITY(U,$J,358.3,268,1,5,0)
 ;;=5^Observ-Antisocial Behav
 ;;^UTILITY(U,$J,358.3,268,2)
 ;;=^295603
 ;;^UTILITY(U,$J,358.3,269,0)
 ;;=V71.09^^2^19^25
 ;;^UTILITY(U,$J,358.3,269,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,269,1,2,0)
 ;;=2^V71.09
 ;;^UTILITY(U,$J,358.3,269,1,5,0)
 ;;=5^Observ-Mental Condition
 ;;^UTILITY(U,$J,358.3,269,2)
 ;;=^295604
 ;;^UTILITY(U,$J,358.3,270,0)
 ;;=V15.41^^2^19^19
 ;;^UTILITY(U,$J,358.3,270,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,270,1,2,0)
 ;;=2^V15.41
 ;;^UTILITY(U,$J,358.3,270,1,5,0)
 ;;=5^Hx Of Sexual Abuse
 ;;^UTILITY(U,$J,358.3,270,2)
 ;;=^304352
 ;;^UTILITY(U,$J,358.3,271,0)
 ;;=V61.01^^2^19^10
 ;;^UTILITY(U,$J,358.3,271,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,271,1,2,0)
 ;;=2^V61.01
 ;;^UTILITY(U,$J,358.3,271,1,5,0)
 ;;=5^Fmily Dsrpt-Fam Military
 ;;^UTILITY(U,$J,358.3,271,2)
 ;;=^336799
 ;;^UTILITY(U,$J,358.3,272,0)
 ;;=V61.02^^2^19^11
 ;;^UTILITY(U,$J,358.3,272,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,272,1,2,0)
 ;;=2^V61.02
 ;;^UTILITY(U,$J,358.3,272,1,5,0)
 ;;=5^Fmily Dsrpt-Ret Military
 ;;^UTILITY(U,$J,358.3,272,2)
 ;;=^336800
 ;;^UTILITY(U,$J,358.3,273,0)
 ;;=V61.03^^2^19^9
 ;;^UTILITY(U,$J,358.3,273,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,273,1,2,0)
 ;;=2^V61.03
 ;;^UTILITY(U,$J,358.3,273,1,5,0)
 ;;=5^Fmily Dsrpt-Divorce/Sep
 ;;^UTILITY(U,$J,358.3,273,2)
 ;;=^336801
 ;;^UTILITY(U,$J,358.3,274,0)
 ;;=V61.04^^2^19^7
 ;;^UTILITY(U,$J,358.3,274,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,274,1,2,0)
 ;;=2^V61.04
 ;;^UTILITY(U,$J,358.3,274,1,5,0)
 ;;=5^Family Dsrpt-Estrangment
 ;;^UTILITY(U,$J,358.3,274,2)
 ;;=^336802
 ;;^UTILITY(U,$J,358.3,275,0)
 ;;=V61.05^^2^19^8
 ;;^UTILITY(U,$J,358.3,275,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,275,1,2,0)
 ;;=2^V61.05
 ;;^UTILITY(U,$J,358.3,275,1,5,0)
 ;;=5^Fmily Dsrpt-Chld Custody
 ;;^UTILITY(U,$J,358.3,275,2)
 ;;=^336803
 ;;^UTILITY(U,$J,358.3,276,0)
 ;;=V61.09^^2^19^6
 ;;^UTILITY(U,$J,358.3,276,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,276,1,2,0)
 ;;=2^V61.09
 ;;^UTILITY(U,$J,358.3,276,1,5,0)
 ;;=5^Family Disruption NEC
 ;;^UTILITY(U,$J,358.3,276,2)
 ;;=^336805
 ;;^UTILITY(U,$J,358.3,277,0)
 ;;=V62.21^^2^19^13
 ;;^UTILITY(U,$J,358.3,277,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,277,1,2,0)
 ;;=2^V62.21
 ;;^UTILITY(U,$J,358.3,277,1,5,0)
 ;;=5^HX Military Deployment
 ;;^UTILITY(U,$J,358.3,277,2)
 ;;=^336806
