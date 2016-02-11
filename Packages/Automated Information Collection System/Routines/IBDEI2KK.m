IBDEI2KK ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,43095,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 31-59 min, init
 ;;^UTILITY(U,$J,358.3,43095,1,4,0)
 ;;=4^S06.4X2A
 ;;^UTILITY(U,$J,358.3,43095,2)
 ;;=^5021032
 ;;^UTILITY(U,$J,358.3,43096,0)
 ;;=S06.4X3A^^195^2167^24
 ;;^UTILITY(U,$J,358.3,43096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43096,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 1-5 hrs 59 min, init
 ;;^UTILITY(U,$J,358.3,43096,1,4,0)
 ;;=4^S06.4X3A
 ;;^UTILITY(U,$J,358.3,43096,2)
 ;;=^5021035
 ;;^UTILITY(U,$J,358.3,43097,0)
 ;;=S06.4X5A^^195^2167^22
 ;;^UTILITY(U,$J,358.3,43097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43097,1,3,0)
 ;;=3^Epidural hemorrhage w LOC >24 hr w ret consc lev, init
 ;;^UTILITY(U,$J,358.3,43097,1,4,0)
 ;;=4^S06.4X5A
 ;;^UTILITY(U,$J,358.3,43097,2)
 ;;=^5021041
 ;;^UTILITY(U,$J,358.3,43098,0)
 ;;=S06.4X4A^^195^2167^27
 ;;^UTILITY(U,$J,358.3,43098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43098,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 6 hours to 24 hours, init
 ;;^UTILITY(U,$J,358.3,43098,1,4,0)
 ;;=4^S06.4X4A
 ;;^UTILITY(U,$J,358.3,43098,2)
 ;;=^5021038
 ;;^UTILITY(U,$J,358.3,43099,0)
 ;;=S06.4X6A^^195^2167^23
 ;;^UTILITY(U,$J,358.3,43099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43099,1,3,0)
 ;;=3^Epidural hemorrhage w LOC >24 hr w/o ret consc w surv, init
 ;;^UTILITY(U,$J,358.3,43099,1,4,0)
 ;;=4^S06.4X6A
 ;;^UTILITY(U,$J,358.3,43099,2)
 ;;=^5021044
 ;;^UTILITY(U,$J,358.3,43100,0)
 ;;=S06.4X7A^^195^2167^29
 ;;^UTILITY(U,$J,358.3,43100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43100,1,3,0)
 ;;=3^Epidural hemorrhage w LOC w death d/t brain injury bf consc, init
 ;;^UTILITY(U,$J,358.3,43100,1,4,0)
 ;;=4^S06.4X7A
 ;;^UTILITY(U,$J,358.3,43100,2)
 ;;=^5021047
 ;;^UTILITY(U,$J,358.3,43101,0)
 ;;=S06.4X8A^^195^2167^30
 ;;^UTILITY(U,$J,358.3,43101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43101,1,3,0)
 ;;=3^Epidural hemorrhage w LOC w death d/t oth causes bf consc, init
 ;;^UTILITY(U,$J,358.3,43101,1,4,0)
 ;;=4^S06.4X8A
 ;;^UTILITY(U,$J,358.3,43101,2)
 ;;=^5021050
 ;;^UTILITY(U,$J,358.3,43102,0)
 ;;=S06.4X9A^^195^2167^28
 ;;^UTILITY(U,$J,358.3,43102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43102,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of unsp duration, init
 ;;^UTILITY(U,$J,358.3,43102,1,4,0)
 ;;=4^S06.4X9A
 ;;^UTILITY(U,$J,358.3,43102,2)
 ;;=^5021053
 ;;^UTILITY(U,$J,358.3,43103,0)
 ;;=S06.4X0D^^195^2167^32
 ;;^UTILITY(U,$J,358.3,43103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43103,1,3,0)
 ;;=3^Epidural hemorrhage w/o LOC, subs encntr
 ;;^UTILITY(U,$J,358.3,43103,1,4,0)
 ;;=4^S06.4X0D
 ;;^UTILITY(U,$J,358.3,43103,2)
 ;;=^5021027
 ;;^UTILITY(U,$J,358.3,43104,0)
 ;;=S06.5X0A^^195^2167^53
 ;;^UTILITY(U,$J,358.3,43104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43104,1,3,0)
 ;;=3^Traum subdr hem w/o LOC, init
 ;;^UTILITY(U,$J,358.3,43104,1,4,0)
 ;;=4^S06.5X0A
 ;;^UTILITY(U,$J,358.3,43104,2)
 ;;=^5021056
 ;;^UTILITY(U,$J,358.3,43105,0)
 ;;=S06.5X1A^^195^2167^46
 ;;^UTILITY(U,$J,358.3,43105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43105,1,3,0)
 ;;=3^Traum subdr hem w LOC of 30 minutes or less, init
 ;;^UTILITY(U,$J,358.3,43105,1,4,0)
 ;;=4^S06.5X1A
 ;;^UTILITY(U,$J,358.3,43105,2)
 ;;=^5021059
 ;;^UTILITY(U,$J,358.3,43106,0)
 ;;=S06.5X2A^^195^2167^47
 ;;^UTILITY(U,$J,358.3,43106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43106,1,3,0)
 ;;=3^Traum subdr hem w LOC of 31-59 min, init
 ;;^UTILITY(U,$J,358.3,43106,1,4,0)
 ;;=4^S06.5X2A
 ;;^UTILITY(U,$J,358.3,43106,2)
 ;;=^5021062
 ;;^UTILITY(U,$J,358.3,43107,0)
 ;;=S06.5X3A^^195^2167^45
 ;;^UTILITY(U,$J,358.3,43107,1,0)
 ;;=^358.31IA^4^2
