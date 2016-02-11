IBDEI2WO ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,48780,1,3,0)
 ;;=3^Concussion w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,48780,1,4,0)
 ;;=4^S06.0X5S
 ;;^UTILITY(U,$J,358.3,48780,2)
 ;;=^5020683
 ;;^UTILITY(U,$J,358.3,48781,0)
 ;;=S06.0X6S^^216^2412^2
 ;;^UTILITY(U,$J,358.3,48781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48781,1,3,0)
 ;;=3^Concussion w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,48781,1,4,0)
 ;;=4^S06.0X6S
 ;;^UTILITY(U,$J,358.3,48781,2)
 ;;=^5020686
 ;;^UTILITY(U,$J,358.3,48782,0)
 ;;=S06.0X3S^^216^2412^3
 ;;^UTILITY(U,$J,358.3,48782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48782,1,3,0)
 ;;=3^Concussion w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,48782,1,4,0)
 ;;=4^S06.0X3S
 ;;^UTILITY(U,$J,358.3,48782,2)
 ;;=^5020677
 ;;^UTILITY(U,$J,358.3,48783,0)
 ;;=S06.0X1S^^216^2412^4
 ;;^UTILITY(U,$J,358.3,48783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48783,1,3,0)
 ;;=3^Concussion w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,48783,1,4,0)
 ;;=4^S06.0X1S
 ;;^UTILITY(U,$J,358.3,48783,2)
 ;;=^5020671
 ;;^UTILITY(U,$J,358.3,48784,0)
 ;;=S06.0X2S^^216^2412^5
 ;;^UTILITY(U,$J,358.3,48784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48784,1,3,0)
 ;;=3^Concussion w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,48784,1,4,0)
 ;;=4^S06.0X2S
 ;;^UTILITY(U,$J,358.3,48784,2)
 ;;=^5020674
 ;;^UTILITY(U,$J,358.3,48785,0)
 ;;=S06.0X4S^^216^2412^6
 ;;^UTILITY(U,$J,358.3,48785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48785,1,3,0)
 ;;=3^Concussion w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,48785,1,4,0)
 ;;=4^S06.0X4S
 ;;^UTILITY(U,$J,358.3,48785,2)
 ;;=^5020680
 ;;^UTILITY(U,$J,358.3,48786,0)
 ;;=S06.0X9S^^216^2412^7
 ;;^UTILITY(U,$J,358.3,48786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48786,1,3,0)
 ;;=3^Concussion w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,48786,1,4,0)
 ;;=4^S06.0X9S
 ;;^UTILITY(U,$J,358.3,48786,2)
 ;;=^5020695
 ;;^UTILITY(U,$J,358.3,48787,0)
 ;;=S06.0X0S^^216^2412^8
 ;;^UTILITY(U,$J,358.3,48787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48787,1,3,0)
 ;;=3^Concussion w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,48787,1,4,0)
 ;;=4^S06.0X0S
 ;;^UTILITY(U,$J,358.3,48787,2)
 ;;=^5020668
 ;;^UTILITY(U,$J,358.3,48788,0)
 ;;=S06.335S^^216^2412^9
 ;;^UTILITY(U,$J,358.3,48788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48788,1,3,0)
 ;;=3^Contus/lac cereb, w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,48788,1,4,0)
 ;;=4^S06.335S
 ;;^UTILITY(U,$J,358.3,48788,2)
 ;;=^5020863
 ;;^UTILITY(U,$J,358.3,48789,0)
 ;;=S06.336S^^216^2412^10
 ;;^UTILITY(U,$J,358.3,48789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48789,1,3,0)
 ;;=3^Contus/lac cereb, w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,48789,1,4,0)
 ;;=4^S06.336S
 ;;^UTILITY(U,$J,358.3,48789,2)
 ;;=^5020866
 ;;^UTILITY(U,$J,358.3,48790,0)
 ;;=S06.333S^^216^2412^11
 ;;^UTILITY(U,$J,358.3,48790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48790,1,3,0)
 ;;=3^Contus/lac cereb, w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,48790,1,4,0)
 ;;=4^S06.333S
 ;;^UTILITY(U,$J,358.3,48790,2)
 ;;=^5020857
 ;;^UTILITY(U,$J,358.3,48791,0)
 ;;=S06.331S^^216^2412^12
 ;;^UTILITY(U,$J,358.3,48791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48791,1,3,0)
 ;;=3^Contus/lac cereb, w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,48791,1,4,0)
 ;;=4^S06.331S
 ;;^UTILITY(U,$J,358.3,48791,2)
 ;;=^5020851
 ;;^UTILITY(U,$J,358.3,48792,0)
 ;;=S06.325S^^216^2412^13
 ;;^UTILITY(U,$J,358.3,48792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48792,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC >24 hr w ret consc lev, sequela
