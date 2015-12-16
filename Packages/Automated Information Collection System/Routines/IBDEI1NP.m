IBDEI1NP ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29431,1,3,0)
 ;;=3^Intraoperative cerebvasc infarction during cardiac surgery
 ;;^UTILITY(U,$J,358.3,29431,1,4,0)
 ;;=4^I97.810
 ;;^UTILITY(U,$J,358.3,29431,2)
 ;;=^5008107
 ;;^UTILITY(U,$J,358.3,29432,0)
 ;;=I97.811^^176^1883^16
 ;;^UTILITY(U,$J,358.3,29432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29432,1,3,0)
 ;;=3^Intraoperative cerebrovascular infarction during oth surgery
 ;;^UTILITY(U,$J,358.3,29432,1,4,0)
 ;;=4^I97.811
 ;;^UTILITY(U,$J,358.3,29432,2)
 ;;=^5008108
 ;;^UTILITY(U,$J,358.3,29433,0)
 ;;=I97.820^^176^1883^36
 ;;^UTILITY(U,$J,358.3,29433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29433,1,3,0)
 ;;=3^Postprocedural cerebvasc infarction during cardiac surgery
 ;;^UTILITY(U,$J,358.3,29433,1,4,0)
 ;;=4^I97.820
 ;;^UTILITY(U,$J,358.3,29433,2)
 ;;=^5008109
 ;;^UTILITY(U,$J,358.3,29434,0)
 ;;=I97.821^^176^1883^35
 ;;^UTILITY(U,$J,358.3,29434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29434,1,3,0)
 ;;=3^Postprocedural cerebrovascular infarction during oth surgery
 ;;^UTILITY(U,$J,358.3,29434,1,4,0)
 ;;=4^I97.821
 ;;^UTILITY(U,$J,358.3,29434,2)
 ;;=^5008110
 ;;^UTILITY(U,$J,358.3,29435,0)
 ;;=G97.2^^176^1883^15
 ;;^UTILITY(U,$J,358.3,29435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29435,1,3,0)
 ;;=3^Intracranial hypotension following ventricular shunting
 ;;^UTILITY(U,$J,358.3,29435,1,4,0)
 ;;=4^G97.2
 ;;^UTILITY(U,$J,358.3,29435,2)
 ;;=^5004203
 ;;^UTILITY(U,$J,358.3,29436,0)
 ;;=G93.82^^176^1883^3
 ;;^UTILITY(U,$J,358.3,29436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29436,1,3,0)
 ;;=3^Brain death
 ;;^UTILITY(U,$J,358.3,29436,1,4,0)
 ;;=4^G93.82
 ;;^UTILITY(U,$J,358.3,29436,2)
 ;;=^5004184
 ;;^UTILITY(U,$J,358.3,29437,0)
 ;;=S06.1X0A^^176^1883^65
 ;;^UTILITY(U,$J,358.3,29437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29437,1,3,0)
 ;;=3^Traum cereb edema w/o LOC, init
 ;;^UTILITY(U,$J,358.3,29437,1,4,0)
 ;;=4^S06.1X0A
 ;;^UTILITY(U,$J,358.3,29437,2)
 ;;=^5020696
 ;;^UTILITY(U,$J,358.3,29438,0)
 ;;=S06.1X0D^^176^1883^67
 ;;^UTILITY(U,$J,358.3,29438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29438,1,3,0)
 ;;=3^Traum cereb edema w/o LOC, subs
 ;;^UTILITY(U,$J,358.3,29438,1,4,0)
 ;;=4^S06.1X0D
 ;;^UTILITY(U,$J,358.3,29438,2)
 ;;=^5020697
 ;;^UTILITY(U,$J,358.3,29439,0)
 ;;=S06.1X0S^^176^1883^66
 ;;^UTILITY(U,$J,358.3,29439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29439,1,3,0)
 ;;=3^Traum cereb edema w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,29439,1,4,0)
 ;;=4^S06.1X0S
 ;;^UTILITY(U,$J,358.3,29439,2)
 ;;=^5020698
 ;;^UTILITY(U,$J,358.3,29440,0)
 ;;=S06.1X1A^^176^1883^47
 ;;^UTILITY(U,$J,358.3,29440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29440,1,3,0)
 ;;=3^Traum cereb edema w LOC of 30 minutes or less, init
 ;;^UTILITY(U,$J,358.3,29440,1,4,0)
 ;;=4^S06.1X1A
 ;;^UTILITY(U,$J,358.3,29440,2)
 ;;=^5020699
 ;;^UTILITY(U,$J,358.3,29441,0)
 ;;=S06.1X1D^^176^1883^48
 ;;^UTILITY(U,$J,358.3,29441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29441,1,3,0)
 ;;=3^Traum cereb edema w LOC of 30 minutes or less, subs
 ;;^UTILITY(U,$J,358.3,29441,1,4,0)
 ;;=4^S06.1X1D
 ;;^UTILITY(U,$J,358.3,29441,2)
 ;;=^5020700
 ;;^UTILITY(U,$J,358.3,29442,0)
 ;;=S06.1X1S^^176^1883^49
 ;;^UTILITY(U,$J,358.3,29442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29442,1,3,0)
 ;;=3^Traum cereb edema w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,29442,1,4,0)
 ;;=4^S06.1X1S
 ;;^UTILITY(U,$J,358.3,29442,2)
 ;;=^5020701
 ;;^UTILITY(U,$J,358.3,29443,0)
 ;;=S06.1X2A^^176^1883^50
 ;;^UTILITY(U,$J,358.3,29443,1,0)
 ;;=^358.31IA^4^2
