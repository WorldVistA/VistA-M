IBDEI2EK ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38346,1,4,0)
 ;;=4^S06.0X1S
 ;;^UTILITY(U,$J,358.3,38346,2)
 ;;=^5020671
 ;;^UTILITY(U,$J,358.3,38347,0)
 ;;=S06.4X0A^^149^1948^19
 ;;^UTILITY(U,$J,358.3,38347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38347,1,3,0)
 ;;=3^Epidural hemorrhage w/o LOC, init encntr
 ;;^UTILITY(U,$J,358.3,38347,1,4,0)
 ;;=4^S06.4X0A
 ;;^UTILITY(U,$J,358.3,38347,2)
 ;;=^5021026
 ;;^UTILITY(U,$J,358.3,38348,0)
 ;;=S06.4X1A^^149^1948^13
 ;;^UTILITY(U,$J,358.3,38348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38348,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 30 minutes or less, init
 ;;^UTILITY(U,$J,358.3,38348,1,4,0)
 ;;=4^S06.4X1A
 ;;^UTILITY(U,$J,358.3,38348,2)
 ;;=^5021029
 ;;^UTILITY(U,$J,358.3,38349,0)
 ;;=S06.4X2A^^149^1948^14
 ;;^UTILITY(U,$J,358.3,38349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38349,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 31-59 min, init
 ;;^UTILITY(U,$J,358.3,38349,1,4,0)
 ;;=4^S06.4X2A
 ;;^UTILITY(U,$J,358.3,38349,2)
 ;;=^5021032
 ;;^UTILITY(U,$J,358.3,38350,0)
 ;;=S06.4X3A^^149^1948^12
 ;;^UTILITY(U,$J,358.3,38350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38350,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 1-5 hrs 59 min, init
 ;;^UTILITY(U,$J,358.3,38350,1,4,0)
 ;;=4^S06.4X3A
 ;;^UTILITY(U,$J,358.3,38350,2)
 ;;=^5021035
 ;;^UTILITY(U,$J,358.3,38351,0)
 ;;=S06.4X5A^^149^1948^10
 ;;^UTILITY(U,$J,358.3,38351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38351,1,3,0)
 ;;=3^Epidural hemorrhage w LOC >24 hr w ret consc lev, init
 ;;^UTILITY(U,$J,358.3,38351,1,4,0)
 ;;=4^S06.4X5A
 ;;^UTILITY(U,$J,358.3,38351,2)
 ;;=^5021041
 ;;^UTILITY(U,$J,358.3,38352,0)
 ;;=S06.4X4A^^149^1948^15
 ;;^UTILITY(U,$J,358.3,38352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38352,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 6 hours to 24 hours, init
 ;;^UTILITY(U,$J,358.3,38352,1,4,0)
 ;;=4^S06.4X4A
 ;;^UTILITY(U,$J,358.3,38352,2)
 ;;=^5021038
 ;;^UTILITY(U,$J,358.3,38353,0)
 ;;=S06.4X6A^^149^1948^11
 ;;^UTILITY(U,$J,358.3,38353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38353,1,3,0)
 ;;=3^Epidural hemorrhage w LOC >24 hr w/o ret consc w surv, init
 ;;^UTILITY(U,$J,358.3,38353,1,4,0)
 ;;=4^S06.4X6A
 ;;^UTILITY(U,$J,358.3,38353,2)
 ;;=^5021044
 ;;^UTILITY(U,$J,358.3,38354,0)
 ;;=S06.4X7A^^149^1948^17
 ;;^UTILITY(U,$J,358.3,38354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38354,1,3,0)
 ;;=3^Epidural hemorrhage w LOC w death d/t brain injury bf consc, init
 ;;^UTILITY(U,$J,358.3,38354,1,4,0)
 ;;=4^S06.4X7A
 ;;^UTILITY(U,$J,358.3,38354,2)
 ;;=^5021047
 ;;^UTILITY(U,$J,358.3,38355,0)
 ;;=S06.4X8A^^149^1948^18
 ;;^UTILITY(U,$J,358.3,38355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38355,1,3,0)
 ;;=3^Epidural hemorrhage w LOC w death d/t oth causes bf consc, init
 ;;^UTILITY(U,$J,358.3,38355,1,4,0)
 ;;=4^S06.4X8A
 ;;^UTILITY(U,$J,358.3,38355,2)
 ;;=^5021050
 ;;^UTILITY(U,$J,358.3,38356,0)
 ;;=S06.4X9A^^149^1948^16
 ;;^UTILITY(U,$J,358.3,38356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38356,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of unsp duration, init
 ;;^UTILITY(U,$J,358.3,38356,1,4,0)
 ;;=4^S06.4X9A
 ;;^UTILITY(U,$J,358.3,38356,2)
 ;;=^5021053
 ;;^UTILITY(U,$J,358.3,38357,0)
 ;;=S06.4X0D^^149^1948^20
 ;;^UTILITY(U,$J,358.3,38357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38357,1,3,0)
 ;;=3^Epidural hemorrhage w/o LOC, subs encntr
 ;;^UTILITY(U,$J,358.3,38357,1,4,0)
 ;;=4^S06.4X0D
 ;;^UTILITY(U,$J,358.3,38357,2)
 ;;=^5021027
