IBDEI0UW ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15272,0)
 ;;=V61.02^^93^915^11
 ;;^UTILITY(U,$J,358.3,15272,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15272,1,2,0)
 ;;=2^V61.02
 ;;^UTILITY(U,$J,358.3,15272,1,5,0)
 ;;=5^Fmily Dsrpt-Ret Military
 ;;^UTILITY(U,$J,358.3,15272,2)
 ;;=^336800
 ;;^UTILITY(U,$J,358.3,15273,0)
 ;;=V61.03^^93^915^9
 ;;^UTILITY(U,$J,358.3,15273,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15273,1,2,0)
 ;;=2^V61.03
 ;;^UTILITY(U,$J,358.3,15273,1,5,0)
 ;;=5^Fmily Dsrpt-Divorce/Sep
 ;;^UTILITY(U,$J,358.3,15273,2)
 ;;=^336801
 ;;^UTILITY(U,$J,358.3,15274,0)
 ;;=V61.04^^93^915^7
 ;;^UTILITY(U,$J,358.3,15274,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15274,1,2,0)
 ;;=2^V61.04
 ;;^UTILITY(U,$J,358.3,15274,1,5,0)
 ;;=5^Family Dsrpt-Estrangment
 ;;^UTILITY(U,$J,358.3,15274,2)
 ;;=^336802
 ;;^UTILITY(U,$J,358.3,15275,0)
 ;;=V61.05^^93^915^8
 ;;^UTILITY(U,$J,358.3,15275,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15275,1,2,0)
 ;;=2^V61.05
 ;;^UTILITY(U,$J,358.3,15275,1,5,0)
 ;;=5^Fmily Dsrpt-Chld Custody
 ;;^UTILITY(U,$J,358.3,15275,2)
 ;;=^336803
 ;;^UTILITY(U,$J,358.3,15276,0)
 ;;=V61.09^^93^915^6
 ;;^UTILITY(U,$J,358.3,15276,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15276,1,2,0)
 ;;=2^V61.09
 ;;^UTILITY(U,$J,358.3,15276,1,5,0)
 ;;=5^Family Disruption NEC
 ;;^UTILITY(U,$J,358.3,15276,2)
 ;;=^336805
 ;;^UTILITY(U,$J,358.3,15277,0)
 ;;=V62.21^^93^915^13
 ;;^UTILITY(U,$J,358.3,15277,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15277,1,2,0)
 ;;=2^V62.21
 ;;^UTILITY(U,$J,358.3,15277,1,5,0)
 ;;=5^HX Military Deployment
 ;;^UTILITY(U,$J,358.3,15277,2)
 ;;=^336806
 ;;^UTILITY(U,$J,358.3,15278,0)
 ;;=V62.22^^93^915^14
 ;;^UTILITY(U,$J,358.3,15278,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15278,1,2,0)
 ;;=2^V62.22
 ;;^UTILITY(U,$J,358.3,15278,1,5,0)
 ;;=5^HX Retrn Military Deploy
 ;;^UTILITY(U,$J,358.3,15278,2)
 ;;=^336807
 ;;^UTILITY(U,$J,358.3,15279,0)
 ;;=V62.29^^93^915^26
 ;;^UTILITY(U,$J,358.3,15279,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15279,1,2,0)
 ;;=2^V62.29
 ;;^UTILITY(U,$J,358.3,15279,1,5,0)
 ;;=5^Occupationl Circumst NEC
 ;;^UTILITY(U,$J,358.3,15279,2)
 ;;=^87746
 ;;^UTILITY(U,$J,358.3,15280,0)
 ;;=V60.81^^93^915^12
 ;;^UTILITY(U,$J,358.3,15280,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15280,1,2,0)
 ;;=2^V60.81
 ;;^UTILITY(U,$J,358.3,15280,1,5,0)
 ;;=5^Foster Care (Status)
 ;;^UTILITY(U,$J,358.3,15280,2)
 ;;=^338505
 ;;^UTILITY(U,$J,358.3,15281,0)
 ;;=V60.89^^93^915^17
 ;;^UTILITY(U,$J,358.3,15281,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15281,1,2,0)
 ;;=2^V60.89
 ;;^UTILITY(U,$J,358.3,15281,1,5,0)
 ;;=5^Housing/Econom Circum NEC
 ;;^UTILITY(U,$J,358.3,15281,2)
 ;;=^295545
 ;;^UTILITY(U,$J,358.3,15282,0)
 ;;=V61.22^^93^915^34
 ;;^UTILITY(U,$J,358.3,15282,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15282,1,2,0)
 ;;=2^V61.22
 ;;^UTILITY(U,$J,358.3,15282,1,5,0)
 ;;=5^Perpetrator-Parental Child
 ;;^UTILITY(U,$J,358.3,15282,2)
 ;;=^304358
 ;;^UTILITY(U,$J,358.3,15283,0)
 ;;=V61.23^^93^915^30
 ;;^UTILITY(U,$J,358.3,15283,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15283,1,2,0)
 ;;=2^V61.23
 ;;^UTILITY(U,$J,358.3,15283,1,5,0)
 ;;=5^Parent-Biological Child Prob
 ;;^UTILITY(U,$J,358.3,15283,2)
 ;;=^338508
 ;;^UTILITY(U,$J,358.3,15284,0)
 ;;=V61.24^^93^915^29
 ;;^UTILITY(U,$J,358.3,15284,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15284,1,2,0)
 ;;=2^V61.24
 ;;^UTILITY(U,$J,358.3,15284,1,5,0)
 ;;=5^Parent-Adopted Child Prob
 ;;^UTILITY(U,$J,358.3,15284,2)
 ;;=^338509
 ;;^UTILITY(U,$J,358.3,15285,0)
 ;;=V61.25^^93^915^32
 ;;^UTILITY(U,$J,358.3,15285,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15285,1,2,0)
 ;;=2^V61.25