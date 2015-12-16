IBDEI1SZ ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31792,1,4,0)
 ;;=4^S06.4X9A
 ;;^UTILITY(U,$J,358.3,31792,2)
 ;;=^5021053
 ;;^UTILITY(U,$J,358.3,31793,0)
 ;;=S06.4X0D^^181^1968^32
 ;;^UTILITY(U,$J,358.3,31793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31793,1,3,0)
 ;;=3^Epidural hemorrhage w/o LOC, subs encntr
 ;;^UTILITY(U,$J,358.3,31793,1,4,0)
 ;;=4^S06.4X0D
 ;;^UTILITY(U,$J,358.3,31793,2)
 ;;=^5021027
 ;;^UTILITY(U,$J,358.3,31794,0)
 ;;=S06.5X0A^^181^1968^53
 ;;^UTILITY(U,$J,358.3,31794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31794,1,3,0)
 ;;=3^Traum subdr hem w/o LOC, init
 ;;^UTILITY(U,$J,358.3,31794,1,4,0)
 ;;=4^S06.5X0A
 ;;^UTILITY(U,$J,358.3,31794,2)
 ;;=^5021056
 ;;^UTILITY(U,$J,358.3,31795,0)
 ;;=S06.5X1A^^181^1968^46
 ;;^UTILITY(U,$J,358.3,31795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31795,1,3,0)
 ;;=3^Traum subdr hem w LOC of 30 minutes or less, init
 ;;^UTILITY(U,$J,358.3,31795,1,4,0)
 ;;=4^S06.5X1A
 ;;^UTILITY(U,$J,358.3,31795,2)
 ;;=^5021059
 ;;^UTILITY(U,$J,358.3,31796,0)
 ;;=S06.5X2A^^181^1968^47
 ;;^UTILITY(U,$J,358.3,31796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31796,1,3,0)
 ;;=3^Traum subdr hem w LOC of 31-59 min, init
 ;;^UTILITY(U,$J,358.3,31796,1,4,0)
 ;;=4^S06.5X2A
 ;;^UTILITY(U,$J,358.3,31796,2)
 ;;=^5021062
 ;;^UTILITY(U,$J,358.3,31797,0)
 ;;=S06.5X3A^^181^1968^45
 ;;^UTILITY(U,$J,358.3,31797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31797,1,3,0)
 ;;=3^Traum subdr hem w LOC of 1-5 hrs 59 min, init
 ;;^UTILITY(U,$J,358.3,31797,1,4,0)
 ;;=4^S06.5X3A
 ;;^UTILITY(U,$J,358.3,31797,2)
 ;;=^5021065
 ;;^UTILITY(U,$J,358.3,31798,0)
 ;;=S06.5X4A^^181^1968^48
 ;;^UTILITY(U,$J,358.3,31798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31798,1,3,0)
 ;;=3^Traum subdr hem w LOC of 6 hours to 24 hours, init
 ;;^UTILITY(U,$J,358.3,31798,1,4,0)
 ;;=4^S06.5X4A
 ;;^UTILITY(U,$J,358.3,31798,2)
 ;;=^5021068
 ;;^UTILITY(U,$J,358.3,31799,0)
 ;;=S06.5X5A^^181^1968^43
 ;;^UTILITY(U,$J,358.3,31799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31799,1,3,0)
 ;;=3^Traum subdr hem w LOC >24 hr w ret consc lev, init
 ;;^UTILITY(U,$J,358.3,31799,1,4,0)
 ;;=4^S06.5X5A
 ;;^UTILITY(U,$J,358.3,31799,2)
 ;;=^5021071
 ;;^UTILITY(U,$J,358.3,31800,0)
 ;;=S06.5X6A^^181^1968^44
 ;;^UTILITY(U,$J,358.3,31800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31800,1,3,0)
 ;;=3^Traum subdr hem w LOC >24 hr w/o ret consc w surv, init
 ;;^UTILITY(U,$J,358.3,31800,1,4,0)
 ;;=4^S06.5X6A
 ;;^UTILITY(U,$J,358.3,31800,2)
 ;;=^5021074
 ;;^UTILITY(U,$J,358.3,31801,0)
 ;;=S06.5X7A^^181^1968^50
 ;;^UTILITY(U,$J,358.3,31801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31801,1,3,0)
 ;;=3^Traum subdr hem w LOC w dth d/t brain inj bef reg consc,init
 ;;^UTILITY(U,$J,358.3,31801,1,4,0)
 ;;=4^S06.5X7A
 ;;^UTILITY(U,$J,358.3,31801,2)
 ;;=^5021077
 ;;^UTILITY(U,$J,358.3,31802,0)
 ;;=S06.5X8A^^181^1968^51
 ;;^UTILITY(U,$J,358.3,31802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31802,1,3,0)
 ;;=3^Traum subdr hem w LOC w dth d/t oth cause bef reg consc,init
 ;;^UTILITY(U,$J,358.3,31802,1,4,0)
 ;;=4^S06.5X8A
 ;;^UTILITY(U,$J,358.3,31802,2)
 ;;=^5021080
 ;;^UTILITY(U,$J,358.3,31803,0)
 ;;=S06.5X0S^^181^1968^54
 ;;^UTILITY(U,$J,358.3,31803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31803,1,3,0)
 ;;=3^Traum subdr hem w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,31803,1,4,0)
 ;;=4^S06.5X0S
 ;;^UTILITY(U,$J,358.3,31803,2)
 ;;=^5021058
 ;;^UTILITY(U,$J,358.3,31804,0)
 ;;=S06.5X8S^^181^1968^52
 ;;^UTILITY(U,$J,358.3,31804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31804,1,3,0)
 ;;=3^Traum subdr hem w LOC w dth d/t oth cause bef reg consc,sqla
