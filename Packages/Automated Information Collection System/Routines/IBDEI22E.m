IBDEI22E ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34622,0)
 ;;=S06.1X3A^^160^1761^44
 ;;^UTILITY(U,$J,358.3,34622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34622,1,3,0)
 ;;=3^Traum cereb edema w LOC of 1-5 hrs 59 min, init
 ;;^UTILITY(U,$J,358.3,34622,1,4,0)
 ;;=4^S06.1X3A
 ;;^UTILITY(U,$J,358.3,34622,2)
 ;;=^5020705
 ;;^UTILITY(U,$J,358.3,34623,0)
 ;;=S06.1X3D^^160^1761^45
 ;;^UTILITY(U,$J,358.3,34623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34623,1,3,0)
 ;;=3^Traum cereb edema w LOC of 1-5 hrs 59 min, subs
 ;;^UTILITY(U,$J,358.3,34623,1,4,0)
 ;;=4^S06.1X3D
 ;;^UTILITY(U,$J,358.3,34623,2)
 ;;=^5020706
 ;;^UTILITY(U,$J,358.3,34624,0)
 ;;=S06.1X3S^^160^1761^46
 ;;^UTILITY(U,$J,358.3,34624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34624,1,3,0)
 ;;=3^Traum cereb edema w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,34624,1,4,0)
 ;;=4^S06.1X3S
 ;;^UTILITY(U,$J,358.3,34624,2)
 ;;=^5020707
 ;;^UTILITY(U,$J,358.3,34625,0)
 ;;=S06.1X4A^^160^1761^53
 ;;^UTILITY(U,$J,358.3,34625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34625,1,3,0)
 ;;=3^Traum cereb edema w LOC of 6 hours to 24 hours, init
 ;;^UTILITY(U,$J,358.3,34625,1,4,0)
 ;;=4^S06.1X4A
 ;;^UTILITY(U,$J,358.3,34625,2)
 ;;=^5020708
 ;;^UTILITY(U,$J,358.3,34626,0)
 ;;=S06.1X4D^^160^1761^54
 ;;^UTILITY(U,$J,358.3,34626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34626,1,3,0)
 ;;=3^Traum cereb edema w LOC of 6 hours to 24 hours, subs
 ;;^UTILITY(U,$J,358.3,34626,1,4,0)
 ;;=4^S06.1X4D
 ;;^UTILITY(U,$J,358.3,34626,2)
 ;;=^5020709
 ;;^UTILITY(U,$J,358.3,34627,0)
 ;;=S06.1X4S^^160^1761^55
 ;;^UTILITY(U,$J,358.3,34627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34627,1,3,0)
 ;;=3^Traum cereb edema w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,34627,1,4,0)
 ;;=4^S06.1X4S
 ;;^UTILITY(U,$J,358.3,34627,2)
 ;;=^5020710
 ;;^UTILITY(U,$J,358.3,34628,0)
 ;;=S06.1X5A^^160^1761^38
 ;;^UTILITY(U,$J,358.3,34628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34628,1,3,0)
 ;;=3^Traum cereb edema w LOC >24 hr w ret consc lev, init
 ;;^UTILITY(U,$J,358.3,34628,1,4,0)
 ;;=4^S06.1X5A
 ;;^UTILITY(U,$J,358.3,34628,2)
 ;;=^5020711
 ;;^UTILITY(U,$J,358.3,34629,0)
 ;;=S06.1X5D^^160^1761^39
 ;;^UTILITY(U,$J,358.3,34629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34629,1,3,0)
 ;;=3^Traum cereb edema w LOC >24 hr w ret consc lev, subs
 ;;^UTILITY(U,$J,358.3,34629,1,4,0)
 ;;=4^S06.1X5D
 ;;^UTILITY(U,$J,358.3,34629,2)
 ;;=^5020712
 ;;^UTILITY(U,$J,358.3,34630,0)
 ;;=S06.1X5S^^160^1761^40
 ;;^UTILITY(U,$J,358.3,34630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34630,1,3,0)
 ;;=3^Traum cereb edema w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,34630,1,4,0)
 ;;=4^S06.1X5S
 ;;^UTILITY(U,$J,358.3,34630,2)
 ;;=^5020713
 ;;^UTILITY(U,$J,358.3,34631,0)
 ;;=S06.1X6A^^160^1761^41
 ;;^UTILITY(U,$J,358.3,34631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34631,1,3,0)
 ;;=3^Traum cereb edema w LOC >24 hr w/o ret consc w surv, init
 ;;^UTILITY(U,$J,358.3,34631,1,4,0)
 ;;=4^S06.1X6A
 ;;^UTILITY(U,$J,358.3,34631,2)
 ;;=^5020714
 ;;^UTILITY(U,$J,358.3,34632,0)
 ;;=S06.1X6D^^160^1761^42
 ;;^UTILITY(U,$J,358.3,34632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34632,1,3,0)
 ;;=3^Traum cereb edema w LOC >24 hr w/o ret consc w surv, subs
 ;;^UTILITY(U,$J,358.3,34632,1,4,0)
 ;;=4^S06.1X6D
 ;;^UTILITY(U,$J,358.3,34632,2)
 ;;=^5020715
 ;;^UTILITY(U,$J,358.3,34633,0)
 ;;=S06.1X6S^^160^1761^43
 ;;^UTILITY(U,$J,358.3,34633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34633,1,3,0)
 ;;=3^Traum cereb edema w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,34633,1,4,0)
 ;;=4^S06.1X6S
