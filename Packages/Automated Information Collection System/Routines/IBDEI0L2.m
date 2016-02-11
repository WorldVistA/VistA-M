IBDEI0L2 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9539,1,3,0)
 ;;=3^Conversion Disorder w/ Seizures/Convulsions
 ;;^UTILITY(U,$J,358.3,9539,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,9539,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,9540,0)
 ;;=R40.4^^65^617^30
 ;;^UTILITY(U,$J,358.3,9540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9540,1,3,0)
 ;;=3^Transient Alteration of Awareness
 ;;^UTILITY(U,$J,358.3,9540,1,4,0)
 ;;=4^R40.4
 ;;^UTILITY(U,$J,358.3,9540,2)
 ;;=^5019435
 ;;^UTILITY(U,$J,358.3,9541,0)
 ;;=R40.1^^65^617^29
 ;;^UTILITY(U,$J,358.3,9541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9541,1,3,0)
 ;;=3^Stupor
 ;;^UTILITY(U,$J,358.3,9541,1,4,0)
 ;;=4^R40.1
 ;;^UTILITY(U,$J,358.3,9541,2)
 ;;=^5019353
 ;;^UTILITY(U,$J,358.3,9542,0)
 ;;=R40.0^^65^617^28
 ;;^UTILITY(U,$J,358.3,9542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9542,1,3,0)
 ;;=3^Somnolence
 ;;^UTILITY(U,$J,358.3,9542,1,4,0)
 ;;=4^R40.0
 ;;^UTILITY(U,$J,358.3,9542,2)
 ;;=^5019352
 ;;^UTILITY(U,$J,358.3,9543,0)
 ;;=R56.9^^65^617^9
 ;;^UTILITY(U,$J,358.3,9543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9543,1,3,0)
 ;;=3^Convulsions,Unspec
 ;;^UTILITY(U,$J,358.3,9543,1,4,0)
 ;;=4^R56.9
 ;;^UTILITY(U,$J,358.3,9543,2)
 ;;=^5019524
 ;;^UTILITY(U,$J,358.3,9544,0)
 ;;=R56.1^^65^617^24
 ;;^UTILITY(U,$J,358.3,9544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9544,1,3,0)
 ;;=3^Post Traumatic Seizures
 ;;^UTILITY(U,$J,358.3,9544,1,4,0)
 ;;=4^R56.1
 ;;^UTILITY(U,$J,358.3,9544,2)
 ;;=^5019523
 ;;^UTILITY(U,$J,358.3,9545,0)
 ;;=G45.0^^65^618^15
 ;;^UTILITY(U,$J,358.3,9545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9545,1,3,0)
 ;;=3^Vertebro-Basilar Artery Syndrome
 ;;^UTILITY(U,$J,358.3,9545,1,4,0)
 ;;=4^G45.0
 ;;^UTILITY(U,$J,358.3,9545,2)
 ;;=^5003955
 ;;^UTILITY(U,$J,358.3,9546,0)
 ;;=G45.1^^65^618^4
 ;;^UTILITY(U,$J,358.3,9546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9546,1,3,0)
 ;;=3^Carotid Artery Syndrome
 ;;^UTILITY(U,$J,358.3,9546,1,4,0)
 ;;=4^G45.1
 ;;^UTILITY(U,$J,358.3,9546,2)
 ;;=^5003956
 ;;^UTILITY(U,$J,358.3,9547,0)
 ;;=G45.3^^65^618^1
 ;;^UTILITY(U,$J,358.3,9547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9547,1,3,0)
 ;;=3^Amaurosis Fugax
 ;;^UTILITY(U,$J,358.3,9547,1,4,0)
 ;;=4^G45.3
 ;;^UTILITY(U,$J,358.3,9547,2)
 ;;=^304129
 ;;^UTILITY(U,$J,358.3,9548,0)
 ;;=G45.4^^65^618^13
 ;;^UTILITY(U,$J,358.3,9548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9548,1,3,0)
 ;;=3^Transient Global Amnesia
 ;;^UTILITY(U,$J,358.3,9548,1,4,0)
 ;;=4^G45.4
 ;;^UTILITY(U,$J,358.3,9548,2)
 ;;=^293883
 ;;^UTILITY(U,$J,358.3,9549,0)
 ;;=G45.8^^65^618^11
 ;;^UTILITY(U,$J,358.3,9549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9549,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attacks,Other
 ;;^UTILITY(U,$J,358.3,9549,1,4,0)
 ;;=4^G45.8
 ;;^UTILITY(U,$J,358.3,9549,2)
 ;;=^5003958
 ;;^UTILITY(U,$J,358.3,9550,0)
 ;;=G45.9^^65^618^12
 ;;^UTILITY(U,$J,358.3,9550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9550,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attacks,Unspec
 ;;^UTILITY(U,$J,358.3,9550,1,4,0)
 ;;=4^G45.9
 ;;^UTILITY(U,$J,358.3,9550,2)
 ;;=^5003959
 ;;^UTILITY(U,$J,358.3,9551,0)
 ;;=G46.0^^65^618^8
 ;;^UTILITY(U,$J,358.3,9551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9551,1,3,0)
 ;;=3^Middle Cerebral Artery Syndrome
 ;;^UTILITY(U,$J,358.3,9551,1,4,0)
 ;;=4^G46.0
 ;;^UTILITY(U,$J,358.3,9551,2)
 ;;=^5003960
 ;;^UTILITY(U,$J,358.3,9552,0)
 ;;=G46.1^^65^618^2
 ;;^UTILITY(U,$J,358.3,9552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9552,1,3,0)
 ;;=3^Anterior Cerebral Artery Syndrome
 ;;^UTILITY(U,$J,358.3,9552,1,4,0)
 ;;=4^G46.1
 ;;^UTILITY(U,$J,358.3,9552,2)
 ;;=^5003961
 ;;^UTILITY(U,$J,358.3,9553,0)
 ;;=G46.2^^65^618^10
