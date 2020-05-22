IBDEI2EN ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38381,1,3,0)
 ;;=3^Traum subrac hem w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,38381,1,4,0)
 ;;=4^S06.6X5S
 ;;^UTILITY(U,$J,358.3,38381,2)
 ;;=^5021103
 ;;^UTILITY(U,$J,358.3,38382,0)
 ;;=S06.6X6S^^149^1948^45
 ;;^UTILITY(U,$J,358.3,38382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38382,1,3,0)
 ;;=3^Traum subrac hem w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,38382,1,4,0)
 ;;=4^S06.6X6S
 ;;^UTILITY(U,$J,358.3,38382,2)
 ;;=^5021106
 ;;^UTILITY(U,$J,358.3,38383,0)
 ;;=S06.6X9S^^149^1948^54
 ;;^UTILITY(U,$J,358.3,38383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38383,1,3,0)
 ;;=3^Traum subrac hem w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,38383,1,4,0)
 ;;=4^S06.6X9S
 ;;^UTILITY(U,$J,358.3,38383,2)
 ;;=^5021115
 ;;^UTILITY(U,$J,358.3,38384,0)
 ;;=S06.890A^^149^1948^29
 ;;^UTILITY(U,$J,358.3,38384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38384,1,3,0)
 ;;=3^Intcran inj w/o LOC, init encntr
 ;;^UTILITY(U,$J,358.3,38384,1,4,0)
 ;;=4^S06.890A
 ;;^UTILITY(U,$J,358.3,38384,2)
 ;;=^5021176
 ;;^UTILITY(U,$J,358.3,38385,0)
 ;;=S06.891A^^149^1948^23
 ;;^UTILITY(U,$J,358.3,38385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38385,1,3,0)
 ;;=3^Intcran inj w LOC of 30 minutes or less, init
 ;;^UTILITY(U,$J,358.3,38385,1,4,0)
 ;;=4^S06.891A
 ;;^UTILITY(U,$J,358.3,38385,2)
 ;;=^5021179
 ;;^UTILITY(U,$J,358.3,38386,0)
 ;;=S06.892A^^149^1948^24
 ;;^UTILITY(U,$J,358.3,38386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38386,1,3,0)
 ;;=3^Intcran inj w LOC of 31-59 min, init
 ;;^UTILITY(U,$J,358.3,38386,1,4,0)
 ;;=4^S06.892A
 ;;^UTILITY(U,$J,358.3,38386,2)
 ;;=^5021182
 ;;^UTILITY(U,$J,358.3,38387,0)
 ;;=S06.894A^^149^1948^25
 ;;^UTILITY(U,$J,358.3,38387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38387,1,3,0)
 ;;=3^Intcran inj w LOC of 6 hours to 24 hours, init
 ;;^UTILITY(U,$J,358.3,38387,1,4,0)
 ;;=4^S06.894A
 ;;^UTILITY(U,$J,358.3,38387,2)
 ;;=^5021188
 ;;^UTILITY(U,$J,358.3,38388,0)
 ;;=S06.895A^^149^1948^21
 ;;^UTILITY(U,$J,358.3,38388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38388,1,3,0)
 ;;=3^Intcran inj w LOC >24 hr w ret consc lev, init
 ;;^UTILITY(U,$J,358.3,38388,1,4,0)
 ;;=4^S06.895A
 ;;^UTILITY(U,$J,358.3,38388,2)
 ;;=^5021191
 ;;^UTILITY(U,$J,358.3,38389,0)
 ;;=S06.896A^^149^1948^22
 ;;^UTILITY(U,$J,358.3,38389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38389,1,3,0)
 ;;=3^Intcran inj w LOC >24 hr w/o ret consc w surv, init
 ;;^UTILITY(U,$J,358.3,38389,1,4,0)
 ;;=4^S06.896A
 ;;^UTILITY(U,$J,358.3,38389,2)
 ;;=^5021194
 ;;^UTILITY(U,$J,358.3,38390,0)
 ;;=S06.897A^^149^1948^28
 ;;^UTILITY(U,$J,358.3,38390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38390,1,3,0)
 ;;=3^Intcran inj w LOC w death due to brain injury bf consc, init
 ;;^UTILITY(U,$J,358.3,38390,1,4,0)
 ;;=4^S06.897A
 ;;^UTILITY(U,$J,358.3,38390,2)
 ;;=^5021197
 ;;^UTILITY(U,$J,358.3,38391,0)
 ;;=S06.898A^^149^1948^27
 ;;^UTILITY(U,$J,358.3,38391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38391,1,3,0)
 ;;=3^Intcran inj w LOC w death d/t oth cause bf consc, init
 ;;^UTILITY(U,$J,358.3,38391,1,4,0)
 ;;=4^S06.898A
 ;;^UTILITY(U,$J,358.3,38391,2)
 ;;=^5021200
 ;;^UTILITY(U,$J,358.3,38392,0)
 ;;=S06.899A^^149^1948^26
 ;;^UTILITY(U,$J,358.3,38392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38392,1,3,0)
 ;;=3^Intcran inj w LOC of unsp duration, init
