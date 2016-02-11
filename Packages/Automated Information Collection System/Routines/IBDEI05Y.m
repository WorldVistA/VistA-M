IBDEI05Y ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2186,1,4,0)
 ;;=4^T82.120A
 ;;^UTILITY(U,$J,358.3,2186,2)
 ;;=^5054692
 ;;^UTILITY(U,$J,358.3,2187,0)
 ;;=T82.121A^^19^190^18
 ;;^UTILITY(U,$J,358.3,2187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2187,1,3,0)
 ;;=3^Displacement of Cardiac Pulse Generator,Init Encntr
 ;;^UTILITY(U,$J,358.3,2187,1,4,0)
 ;;=4^T82.121A
 ;;^UTILITY(U,$J,358.3,2187,2)
 ;;=^5054695
 ;;^UTILITY(U,$J,358.3,2188,0)
 ;;=T82.190A^^19^190^26
 ;;^UTILITY(U,$J,358.3,2188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2188,1,3,0)
 ;;=3^Mech Compl of Cardiac Electrode,Init Encntr
 ;;^UTILITY(U,$J,358.3,2188,1,4,0)
 ;;=4^T82.190A
 ;;^UTILITY(U,$J,358.3,2188,2)
 ;;=^5054704
 ;;^UTILITY(U,$J,358.3,2189,0)
 ;;=T82.191A^^19^190^27
 ;;^UTILITY(U,$J,358.3,2189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2189,1,3,0)
 ;;=3^Mech Compl of Cardiac Pulse Generator,Init Encntr
 ;;^UTILITY(U,$J,358.3,2189,1,4,0)
 ;;=4^T82.191A
 ;;^UTILITY(U,$J,358.3,2189,2)
 ;;=^5054707
 ;;^UTILITY(U,$J,358.3,2190,0)
 ;;=Z95.0^^19^190^35
 ;;^UTILITY(U,$J,358.3,2190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2190,1,3,0)
 ;;=3^Presence of Cardiac Pacemaker
 ;;^UTILITY(U,$J,358.3,2190,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,2190,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,2191,0)
 ;;=Z95.810^^19^190^34
 ;;^UTILITY(U,$J,358.3,2191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2191,1,3,0)
 ;;=3^Presence of Automatic Cardiac Defibrillator
 ;;^UTILITY(U,$J,358.3,2191,1,4,0)
 ;;=4^Z95.810
 ;;^UTILITY(U,$J,358.3,2191,2)
 ;;=^5063674
 ;;^UTILITY(U,$J,358.3,2192,0)
 ;;=Z45.010^^19^190^15
 ;;^UTILITY(U,$J,358.3,2192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2192,1,3,0)
 ;;=3^Check/Test Cardiac Pacemaker Pulse Generator
 ;;^UTILITY(U,$J,358.3,2192,1,4,0)
 ;;=4^Z45.010
 ;;^UTILITY(U,$J,358.3,2192,2)
 ;;=^5062994
 ;;^UTILITY(U,$J,358.3,2193,0)
 ;;=Z45.018^^19^190^6
 ;;^UTILITY(U,$J,358.3,2193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2193,1,3,0)
 ;;=3^Adjust/Manage Cardiac Pacemaker Parts
 ;;^UTILITY(U,$J,358.3,2193,1,4,0)
 ;;=4^Z45.018
 ;;^UTILITY(U,$J,358.3,2193,2)
 ;;=^5062995
 ;;^UTILITY(U,$J,358.3,2194,0)
 ;;=Z45.02^^19^190^5
 ;;^UTILITY(U,$J,358.3,2194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2194,1,3,0)
 ;;=3^Adjust/Manage Automatic Implantable Cardiac Defibrillator
 ;;^UTILITY(U,$J,358.3,2194,1,4,0)
 ;;=4^Z45.02
 ;;^UTILITY(U,$J,358.3,2194,2)
 ;;=^5062996
 ;;^UTILITY(U,$J,358.3,2195,0)
 ;;=I25.110^^19^191^15
 ;;^UTILITY(U,$J,358.3,2195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2195,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Cor Art w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2195,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,2195,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,2196,0)
 ;;=I25.700^^19^191^34
 ;;^UTILITY(U,$J,358.3,2196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2196,1,3,0)
 ;;=3^Athscl of CABG w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2196,1,4,0)
 ;;=4^I25.700
 ;;^UTILITY(U,$J,358.3,2196,2)
 ;;=^5007117
 ;;^UTILITY(U,$J,358.3,2197,0)
 ;;=I25.710^^19^191^10
 ;;^UTILITY(U,$J,358.3,2197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2197,1,3,0)
 ;;=3^Athscl Autologous Vein CABG w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2197,1,4,0)
 ;;=4^I25.710
 ;;^UTILITY(U,$J,358.3,2197,2)
 ;;=^5007121
 ;;^UTILITY(U,$J,358.3,2198,0)
 ;;=I25.720^^19^191^6
 ;;^UTILITY(U,$J,358.3,2198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2198,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2198,1,4,0)
 ;;=4^I25.720
 ;;^UTILITY(U,$J,358.3,2198,2)
 ;;=^5007125
 ;;^UTILITY(U,$J,358.3,2199,0)
 ;;=I25.730^^19^191^24
