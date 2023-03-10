IBDEI185 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19873,1,3,0)
 ;;=3^Encounter for Other Specified Aftercare
 ;;^UTILITY(U,$J,358.3,19873,1,4,0)
 ;;=4^Z51.89
 ;;^UTILITY(U,$J,358.3,19873,2)
 ;;=^5063065
 ;;^UTILITY(U,$J,358.3,19874,0)
 ;;=Z02.89^^67^881^1
 ;;^UTILITY(U,$J,358.3,19874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19874,1,3,0)
 ;;=3^Administrative Exams
 ;;^UTILITY(U,$J,358.3,19874,1,4,0)
 ;;=4^Z02.89
 ;;^UTILITY(U,$J,358.3,19874,2)
 ;;=^5062645
 ;;^UTILITY(U,$J,358.3,19875,0)
 ;;=Z02.5^^67^881^3
 ;;^UTILITY(U,$J,358.3,19875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19875,1,3,0)
 ;;=3^Exam for Sport Participation
 ;;^UTILITY(U,$J,358.3,19875,1,4,0)
 ;;=4^Z02.5
 ;;^UTILITY(U,$J,358.3,19875,2)
 ;;=^5062638
 ;;^UTILITY(U,$J,358.3,19876,0)
 ;;=S06.0X1S^^67^882^1
 ;;^UTILITY(U,$J,358.3,19876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19876,1,3,0)
 ;;=3^Concussion w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,19876,1,4,0)
 ;;=4^S06.0X1S
 ;;^UTILITY(U,$J,358.3,19876,2)
 ;;=^5020671
 ;;^UTILITY(U,$J,358.3,19877,0)
 ;;=S06.0X9S^^67^882^2
 ;;^UTILITY(U,$J,358.3,19877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19877,1,3,0)
 ;;=3^Concussion w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,19877,1,4,0)
 ;;=4^S06.0X9S
 ;;^UTILITY(U,$J,358.3,19877,2)
 ;;=^5020695
 ;;^UTILITY(U,$J,358.3,19878,0)
 ;;=S06.0X0S^^67^882^3
 ;;^UTILITY(U,$J,358.3,19878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19878,1,3,0)
 ;;=3^Concussion w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,19878,1,4,0)
 ;;=4^S06.0X0S
 ;;^UTILITY(U,$J,358.3,19878,2)
 ;;=^5020668
 ;;^UTILITY(U,$J,358.3,19879,0)
 ;;=S06.335S^^67^882^4
 ;;^UTILITY(U,$J,358.3,19879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19879,1,3,0)
 ;;=3^Contus/lac cereb, w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,19879,1,4,0)
 ;;=4^S06.335S
 ;;^UTILITY(U,$J,358.3,19879,2)
 ;;=^5020863
 ;;^UTILITY(U,$J,358.3,19880,0)
 ;;=S06.336S^^67^882^5
 ;;^UTILITY(U,$J,358.3,19880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19880,1,3,0)
 ;;=3^Contus/lac cereb, w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,19880,1,4,0)
 ;;=4^S06.336S
 ;;^UTILITY(U,$J,358.3,19880,2)
 ;;=^5020866
 ;;^UTILITY(U,$J,358.3,19881,0)
 ;;=S06.333S^^67^882^6
 ;;^UTILITY(U,$J,358.3,19881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19881,1,3,0)
 ;;=3^Contus/lac cereb, w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,19881,1,4,0)
 ;;=4^S06.333S
 ;;^UTILITY(U,$J,358.3,19881,2)
 ;;=^5020857
 ;;^UTILITY(U,$J,358.3,19882,0)
 ;;=S06.331S^^67^882^7
 ;;^UTILITY(U,$J,358.3,19882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19882,1,3,0)
 ;;=3^Contus/lac cereb, w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,19882,1,4,0)
 ;;=4^S06.331S
 ;;^UTILITY(U,$J,358.3,19882,2)
 ;;=^5020851
 ;;^UTILITY(U,$J,358.3,19883,0)
 ;;=S06.325S^^67^882^8
 ;;^UTILITY(U,$J,358.3,19883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19883,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,19883,1,4,0)
 ;;=4^S06.325S
 ;;^UTILITY(U,$J,358.3,19883,2)
 ;;=^5020833
 ;;^UTILITY(U,$J,358.3,19884,0)
 ;;=S06.326S^^67^882^9
 ;;^UTILITY(U,$J,358.3,19884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19884,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,19884,1,4,0)
 ;;=4^S06.326S
