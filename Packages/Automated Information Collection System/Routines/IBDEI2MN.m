IBDEI2MN ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41946,1,3,0)
 ;;=3^Administrative Exams
 ;;^UTILITY(U,$J,358.3,41946,1,4,0)
 ;;=4^Z02.89
 ;;^UTILITY(U,$J,358.3,41946,2)
 ;;=^5062645
 ;;^UTILITY(U,$J,358.3,41947,0)
 ;;=Z02.5^^155^2065^3
 ;;^UTILITY(U,$J,358.3,41947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41947,1,3,0)
 ;;=3^Exam for Sport Participation
 ;;^UTILITY(U,$J,358.3,41947,1,4,0)
 ;;=4^Z02.5
 ;;^UTILITY(U,$J,358.3,41947,2)
 ;;=^5062638
 ;;^UTILITY(U,$J,358.3,41948,0)
 ;;=S06.0X1S^^155^2066^1
 ;;^UTILITY(U,$J,358.3,41948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41948,1,3,0)
 ;;=3^Concussion w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,41948,1,4,0)
 ;;=4^S06.0X1S
 ;;^UTILITY(U,$J,358.3,41948,2)
 ;;=^5020671
 ;;^UTILITY(U,$J,358.3,41949,0)
 ;;=S06.0X9S^^155^2066^2
 ;;^UTILITY(U,$J,358.3,41949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41949,1,3,0)
 ;;=3^Concussion w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,41949,1,4,0)
 ;;=4^S06.0X9S
 ;;^UTILITY(U,$J,358.3,41949,2)
 ;;=^5020695
 ;;^UTILITY(U,$J,358.3,41950,0)
 ;;=S06.0X0S^^155^2066^3
 ;;^UTILITY(U,$J,358.3,41950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41950,1,3,0)
 ;;=3^Concussion w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,41950,1,4,0)
 ;;=4^S06.0X0S
 ;;^UTILITY(U,$J,358.3,41950,2)
 ;;=^5020668
 ;;^UTILITY(U,$J,358.3,41951,0)
 ;;=S06.335S^^155^2066^4
 ;;^UTILITY(U,$J,358.3,41951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41951,1,3,0)
 ;;=3^Contus/lac cereb, w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,41951,1,4,0)
 ;;=4^S06.335S
 ;;^UTILITY(U,$J,358.3,41951,2)
 ;;=^5020863
 ;;^UTILITY(U,$J,358.3,41952,0)
 ;;=S06.336S^^155^2066^5
 ;;^UTILITY(U,$J,358.3,41952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41952,1,3,0)
 ;;=3^Contus/lac cereb, w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,41952,1,4,0)
 ;;=4^S06.336S
 ;;^UTILITY(U,$J,358.3,41952,2)
 ;;=^5020866
 ;;^UTILITY(U,$J,358.3,41953,0)
 ;;=S06.333S^^155^2066^6
 ;;^UTILITY(U,$J,358.3,41953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41953,1,3,0)
 ;;=3^Contus/lac cereb, w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,41953,1,4,0)
 ;;=4^S06.333S
 ;;^UTILITY(U,$J,358.3,41953,2)
 ;;=^5020857
 ;;^UTILITY(U,$J,358.3,41954,0)
 ;;=S06.331S^^155^2066^7
 ;;^UTILITY(U,$J,358.3,41954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41954,1,3,0)
 ;;=3^Contus/lac cereb, w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,41954,1,4,0)
 ;;=4^S06.331S
 ;;^UTILITY(U,$J,358.3,41954,2)
 ;;=^5020851
 ;;^UTILITY(U,$J,358.3,41955,0)
 ;;=S06.325S^^155^2066^8
 ;;^UTILITY(U,$J,358.3,41955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41955,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,41955,1,4,0)
 ;;=4^S06.325S
 ;;^UTILITY(U,$J,358.3,41955,2)
 ;;=^5020833
 ;;^UTILITY(U,$J,358.3,41956,0)
 ;;=S06.326S^^155^2066^9
 ;;^UTILITY(U,$J,358.3,41956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41956,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,41956,1,4,0)
 ;;=4^S06.326S
 ;;^UTILITY(U,$J,358.3,41956,2)
 ;;=^5020836
 ;;^UTILITY(U,$J,358.3,41957,0)
 ;;=S06.323S^^155^2066^10
 ;;^UTILITY(U,$J,358.3,41957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41957,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC of 1-5 hrs 59 min, sequela
