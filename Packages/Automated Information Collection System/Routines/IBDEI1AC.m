IBDEI1AC ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21481,0)
 ;;=S06.0X2S^^101^1032^5
 ;;^UTILITY(U,$J,358.3,21481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21481,1,3,0)
 ;;=3^Concussion w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,21481,1,4,0)
 ;;=4^S06.0X2S
 ;;^UTILITY(U,$J,358.3,21481,2)
 ;;=^5020674
 ;;^UTILITY(U,$J,358.3,21482,0)
 ;;=S06.0X4S^^101^1032^6
 ;;^UTILITY(U,$J,358.3,21482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21482,1,3,0)
 ;;=3^Concussion w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,21482,1,4,0)
 ;;=4^S06.0X4S
 ;;^UTILITY(U,$J,358.3,21482,2)
 ;;=^5020680
 ;;^UTILITY(U,$J,358.3,21483,0)
 ;;=S06.0X9S^^101^1032^7
 ;;^UTILITY(U,$J,358.3,21483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21483,1,3,0)
 ;;=3^Concussion w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,21483,1,4,0)
 ;;=4^S06.0X9S
 ;;^UTILITY(U,$J,358.3,21483,2)
 ;;=^5020695
 ;;^UTILITY(U,$J,358.3,21484,0)
 ;;=S06.0X0S^^101^1032^8
 ;;^UTILITY(U,$J,358.3,21484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21484,1,3,0)
 ;;=3^Concussion w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,21484,1,4,0)
 ;;=4^S06.0X0S
 ;;^UTILITY(U,$J,358.3,21484,2)
 ;;=^5020668
 ;;^UTILITY(U,$J,358.3,21485,0)
 ;;=S06.335S^^101^1032^9
 ;;^UTILITY(U,$J,358.3,21485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21485,1,3,0)
 ;;=3^Contus/lac cereb, w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,21485,1,4,0)
 ;;=4^S06.335S
 ;;^UTILITY(U,$J,358.3,21485,2)
 ;;=^5020863
 ;;^UTILITY(U,$J,358.3,21486,0)
 ;;=S06.336S^^101^1032^10
 ;;^UTILITY(U,$J,358.3,21486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21486,1,3,0)
 ;;=3^Contus/lac cereb, w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,21486,1,4,0)
 ;;=4^S06.336S
 ;;^UTILITY(U,$J,358.3,21486,2)
 ;;=^5020866
 ;;^UTILITY(U,$J,358.3,21487,0)
 ;;=S06.333S^^101^1032^11
 ;;^UTILITY(U,$J,358.3,21487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21487,1,3,0)
 ;;=3^Contus/lac cereb, w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,21487,1,4,0)
 ;;=4^S06.333S
 ;;^UTILITY(U,$J,358.3,21487,2)
 ;;=^5020857
 ;;^UTILITY(U,$J,358.3,21488,0)
 ;;=S06.331S^^101^1032^12
 ;;^UTILITY(U,$J,358.3,21488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21488,1,3,0)
 ;;=3^Contus/lac cereb, w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,21488,1,4,0)
 ;;=4^S06.331S
 ;;^UTILITY(U,$J,358.3,21488,2)
 ;;=^5020851
 ;;^UTILITY(U,$J,358.3,21489,0)
 ;;=S06.325S^^101^1032^13
 ;;^UTILITY(U,$J,358.3,21489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21489,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,21489,1,4,0)
 ;;=4^S06.325S
 ;;^UTILITY(U,$J,358.3,21489,2)
 ;;=^5020833
 ;;^UTILITY(U,$J,358.3,21490,0)
 ;;=S06.326S^^101^1032^14
 ;;^UTILITY(U,$J,358.3,21490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21490,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,21490,1,4,0)
 ;;=4^S06.326S
 ;;^UTILITY(U,$J,358.3,21490,2)
 ;;=^5020836
 ;;^UTILITY(U,$J,358.3,21491,0)
 ;;=S06.323S^^101^1032^15
 ;;^UTILITY(U,$J,358.3,21491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21491,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,21491,1,4,0)
 ;;=4^S06.323S
 ;;^UTILITY(U,$J,358.3,21491,2)
 ;;=^5020827
 ;;^UTILITY(U,$J,358.3,21492,0)
 ;;=S06.321S^^101^1032^16
 ;;^UTILITY(U,$J,358.3,21492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21492,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,21492,1,4,0)
 ;;=4^S06.321S
