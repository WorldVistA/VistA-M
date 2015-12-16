IBDEI1SY ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31780,1,4,0)
 ;;=4^S06.0X4S
 ;;^UTILITY(U,$J,358.3,31780,2)
 ;;=^5020680
 ;;^UTILITY(U,$J,358.3,31781,0)
 ;;=S06.0X5S^^181^1968^3
 ;;^UTILITY(U,$J,358.3,31781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31781,1,3,0)
 ;;=3^Concussion w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,31781,1,4,0)
 ;;=4^S06.0X5S
 ;;^UTILITY(U,$J,358.3,31781,2)
 ;;=^5020683
 ;;^UTILITY(U,$J,358.3,31782,0)
 ;;=S06.0X6S^^181^1968^6
 ;;^UTILITY(U,$J,358.3,31782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31782,1,3,0)
 ;;=3^Concussion w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,31782,1,4,0)
 ;;=4^S06.0X6S
 ;;^UTILITY(U,$J,358.3,31782,2)
 ;;=^5020686
 ;;^UTILITY(U,$J,358.3,31783,0)
 ;;=S06.4X0A^^181^1968^31
 ;;^UTILITY(U,$J,358.3,31783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31783,1,3,0)
 ;;=3^Epidural hemorrhage w/o LOC, init encntr
 ;;^UTILITY(U,$J,358.3,31783,1,4,0)
 ;;=4^S06.4X0A
 ;;^UTILITY(U,$J,358.3,31783,2)
 ;;=^5021026
 ;;^UTILITY(U,$J,358.3,31784,0)
 ;;=S06.4X1A^^181^1968^25
 ;;^UTILITY(U,$J,358.3,31784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31784,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 30 minutes or less, init
 ;;^UTILITY(U,$J,358.3,31784,1,4,0)
 ;;=4^S06.4X1A
 ;;^UTILITY(U,$J,358.3,31784,2)
 ;;=^5021029
 ;;^UTILITY(U,$J,358.3,31785,0)
 ;;=S06.4X2A^^181^1968^26
 ;;^UTILITY(U,$J,358.3,31785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31785,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 31-59 min, init
 ;;^UTILITY(U,$J,358.3,31785,1,4,0)
 ;;=4^S06.4X2A
 ;;^UTILITY(U,$J,358.3,31785,2)
 ;;=^5021032
 ;;^UTILITY(U,$J,358.3,31786,0)
 ;;=S06.4X3A^^181^1968^24
 ;;^UTILITY(U,$J,358.3,31786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31786,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 1-5 hrs 59 min, init
 ;;^UTILITY(U,$J,358.3,31786,1,4,0)
 ;;=4^S06.4X3A
 ;;^UTILITY(U,$J,358.3,31786,2)
 ;;=^5021035
 ;;^UTILITY(U,$J,358.3,31787,0)
 ;;=S06.4X5A^^181^1968^22
 ;;^UTILITY(U,$J,358.3,31787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31787,1,3,0)
 ;;=3^Epidural hemorrhage w LOC >24 hr w ret consc lev, init
 ;;^UTILITY(U,$J,358.3,31787,1,4,0)
 ;;=4^S06.4X5A
 ;;^UTILITY(U,$J,358.3,31787,2)
 ;;=^5021041
 ;;^UTILITY(U,$J,358.3,31788,0)
 ;;=S06.4X4A^^181^1968^27
 ;;^UTILITY(U,$J,358.3,31788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31788,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 6 hours to 24 hours, init
 ;;^UTILITY(U,$J,358.3,31788,1,4,0)
 ;;=4^S06.4X4A
 ;;^UTILITY(U,$J,358.3,31788,2)
 ;;=^5021038
 ;;^UTILITY(U,$J,358.3,31789,0)
 ;;=S06.4X6A^^181^1968^23
 ;;^UTILITY(U,$J,358.3,31789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31789,1,3,0)
 ;;=3^Epidural hemorrhage w LOC >24 hr w/o ret consc w surv, init
 ;;^UTILITY(U,$J,358.3,31789,1,4,0)
 ;;=4^S06.4X6A
 ;;^UTILITY(U,$J,358.3,31789,2)
 ;;=^5021044
 ;;^UTILITY(U,$J,358.3,31790,0)
 ;;=S06.4X7A^^181^1968^29
 ;;^UTILITY(U,$J,358.3,31790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31790,1,3,0)
 ;;=3^Epidural hemorrhage w LOC w death d/t brain injury bf consc, init
 ;;^UTILITY(U,$J,358.3,31790,1,4,0)
 ;;=4^S06.4X7A
 ;;^UTILITY(U,$J,358.3,31790,2)
 ;;=^5021047
 ;;^UTILITY(U,$J,358.3,31791,0)
 ;;=S06.4X8A^^181^1968^30
 ;;^UTILITY(U,$J,358.3,31791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31791,1,3,0)
 ;;=3^Epidural hemorrhage w LOC w death d/t oth causes bf consc, init
 ;;^UTILITY(U,$J,358.3,31791,1,4,0)
 ;;=4^S06.4X8A
 ;;^UTILITY(U,$J,358.3,31791,2)
 ;;=^5021050
 ;;^UTILITY(U,$J,358.3,31792,0)
 ;;=S06.4X9A^^181^1968^28
 ;;^UTILITY(U,$J,358.3,31792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31792,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of unsp duration, init
