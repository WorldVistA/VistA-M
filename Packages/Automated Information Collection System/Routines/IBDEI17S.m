IBDEI17S ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19499,1,3,0)
 ;;=3^Ortho aftercare following surgical amp
 ;;^UTILITY(U,$J,358.3,19499,1,4,0)
 ;;=4^Z47.81
 ;;^UTILITY(U,$J,358.3,19499,2)
 ;;=^5063030
 ;;^UTILITY(U,$J,358.3,19500,0)
 ;;=Z47.82^^93^993^15
 ;;^UTILITY(U,$J,358.3,19500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19500,1,3,0)
 ;;=3^Ortho aftercare following scoliosis surgery
 ;;^UTILITY(U,$J,358.3,19500,1,4,0)
 ;;=4^Z47.82
 ;;^UTILITY(U,$J,358.3,19500,2)
 ;;=^5063031
 ;;^UTILITY(U,$J,358.3,19501,0)
 ;;=Z47.89^^93^993^14
 ;;^UTILITY(U,$J,358.3,19501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19501,1,3,0)
 ;;=3^Ortho Aftercare NEC
 ;;^UTILITY(U,$J,358.3,19501,1,4,0)
 ;;=4^Z47.89
 ;;^UTILITY(U,$J,358.3,19501,2)
 ;;=^5063032
 ;;^UTILITY(U,$J,358.3,19502,0)
 ;;=Z51.89^^93^993^2
 ;;^UTILITY(U,$J,358.3,19502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19502,1,3,0)
 ;;=3^Encounter for Other Specified Aftercare
 ;;^UTILITY(U,$J,358.3,19502,1,4,0)
 ;;=4^Z51.89
 ;;^UTILITY(U,$J,358.3,19502,2)
 ;;=^5063065
 ;;^UTILITY(U,$J,358.3,19503,0)
 ;;=Z02.89^^93^993^1
 ;;^UTILITY(U,$J,358.3,19503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19503,1,3,0)
 ;;=3^Administrative Exams
 ;;^UTILITY(U,$J,358.3,19503,1,4,0)
 ;;=4^Z02.89
 ;;^UTILITY(U,$J,358.3,19503,2)
 ;;=^5062645
 ;;^UTILITY(U,$J,358.3,19504,0)
 ;;=Z02.5^^93^993^3
 ;;^UTILITY(U,$J,358.3,19504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19504,1,3,0)
 ;;=3^Exam for Sport Participation
 ;;^UTILITY(U,$J,358.3,19504,1,4,0)
 ;;=4^Z02.5
 ;;^UTILITY(U,$J,358.3,19504,2)
 ;;=^5062638
 ;;^UTILITY(U,$J,358.3,19505,0)
 ;;=S06.0X1S^^93^994^1
 ;;^UTILITY(U,$J,358.3,19505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19505,1,3,0)
 ;;=3^Concussion w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,19505,1,4,0)
 ;;=4^S06.0X1S
 ;;^UTILITY(U,$J,358.3,19505,2)
 ;;=^5020671
 ;;^UTILITY(U,$J,358.3,19506,0)
 ;;=S06.0X9S^^93^994^2
 ;;^UTILITY(U,$J,358.3,19506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19506,1,3,0)
 ;;=3^Concussion w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,19506,1,4,0)
 ;;=4^S06.0X9S
 ;;^UTILITY(U,$J,358.3,19506,2)
 ;;=^5020695
 ;;^UTILITY(U,$J,358.3,19507,0)
 ;;=S06.0X0S^^93^994^3
 ;;^UTILITY(U,$J,358.3,19507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19507,1,3,0)
 ;;=3^Concussion w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,19507,1,4,0)
 ;;=4^S06.0X0S
 ;;^UTILITY(U,$J,358.3,19507,2)
 ;;=^5020668
 ;;^UTILITY(U,$J,358.3,19508,0)
 ;;=S06.335S^^93^994^4
 ;;^UTILITY(U,$J,358.3,19508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19508,1,3,0)
 ;;=3^Contus/lac cereb, w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,19508,1,4,0)
 ;;=4^S06.335S
 ;;^UTILITY(U,$J,358.3,19508,2)
 ;;=^5020863
 ;;^UTILITY(U,$J,358.3,19509,0)
 ;;=S06.336S^^93^994^5
 ;;^UTILITY(U,$J,358.3,19509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19509,1,3,0)
 ;;=3^Contus/lac cereb, w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,19509,1,4,0)
 ;;=4^S06.336S
 ;;^UTILITY(U,$J,358.3,19509,2)
 ;;=^5020866
 ;;^UTILITY(U,$J,358.3,19510,0)
 ;;=S06.333S^^93^994^6
 ;;^UTILITY(U,$J,358.3,19510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19510,1,3,0)
 ;;=3^Contus/lac cereb, w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,19510,1,4,0)
 ;;=4^S06.333S
 ;;^UTILITY(U,$J,358.3,19510,2)
 ;;=^5020857
 ;;^UTILITY(U,$J,358.3,19511,0)
 ;;=S06.331S^^93^994^7
 ;;^UTILITY(U,$J,358.3,19511,1,0)
 ;;=^358.31IA^4^2
