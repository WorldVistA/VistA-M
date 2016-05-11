IBDEI0AR ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4816,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer,Right Lower Leg Oth Part
 ;;^UTILITY(U,$J,358.3,4816,1,4,0)
 ;;=4^L97.819
 ;;^UTILITY(U,$J,358.3,4816,2)
 ;;=^5009564
 ;;^UTILITY(U,$J,358.3,4817,0)
 ;;=L97.829^^24^305^119
 ;;^UTILITY(U,$J,358.3,4817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4817,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer,Left Lower Leg Oth Part
 ;;^UTILITY(U,$J,358.3,4817,1,4,0)
 ;;=4^L97.829
 ;;^UTILITY(U,$J,358.3,4817,2)
 ;;=^5009569
 ;;^UTILITY(U,$J,358.3,4818,0)
 ;;=L98.419^^24^305^114
 ;;^UTILITY(U,$J,358.3,4818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4818,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer,Buttock
 ;;^UTILITY(U,$J,358.3,4818,1,4,0)
 ;;=4^L98.419
 ;;^UTILITY(U,$J,358.3,4818,2)
 ;;=^5009581
 ;;^UTILITY(U,$J,358.3,4819,0)
 ;;=L98.429^^24^305^113
 ;;^UTILITY(U,$J,358.3,4819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4819,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer,Back
 ;;^UTILITY(U,$J,358.3,4819,1,4,0)
 ;;=4^L98.429
 ;;^UTILITY(U,$J,358.3,4819,2)
 ;;=^5009586
 ;;^UTILITY(U,$J,358.3,4820,0)
 ;;=L98.499^^24^305^127
 ;;^UTILITY(U,$J,358.3,4820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4820,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer,Skin
 ;;^UTILITY(U,$J,358.3,4820,1,4,0)
 ;;=4^L98.499
 ;;^UTILITY(U,$J,358.3,4820,2)
 ;;=^5009591
 ;;^UTILITY(U,$J,358.3,4821,0)
 ;;=M90.80^^24^305^128
 ;;^UTILITY(U,$J,358.3,4821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4821,1,3,0)
 ;;=3^Osteopathy in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,4821,1,4,0)
 ;;=4^M90.80
 ;;^UTILITY(U,$J,358.3,4821,2)
 ;;=^5015168
 ;;^UTILITY(U,$J,358.3,4822,0)
 ;;=Z83.3^^24^305^89
 ;;^UTILITY(U,$J,358.3,4822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4822,1,3,0)
 ;;=3^Family Hx of Diabetes Mellitus
 ;;^UTILITY(U,$J,358.3,4822,1,4,0)
 ;;=4^Z83.3
 ;;^UTILITY(U,$J,358.3,4822,2)
 ;;=^5063379
 ;;^UTILITY(U,$J,358.3,4823,0)
 ;;=Z79.4^^24^305^95
 ;;^UTILITY(U,$J,358.3,4823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4823,1,3,0)
 ;;=3^Long Term (Current) Use of Insulin
 ;;^UTILITY(U,$J,358.3,4823,1,4,0)
 ;;=4^Z79.4
 ;;^UTILITY(U,$J,358.3,4823,2)
 ;;=^5063334
 ;;^UTILITY(U,$J,358.3,4824,0)
 ;;=Z09.^^24^305^88
 ;;^UTILITY(U,$J,358.3,4824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4824,1,3,0)
 ;;=3^F/U Exam After Treatment,Not Malig Neop
 ;;^UTILITY(U,$J,358.3,4824,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,4824,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,4825,0)
 ;;=Z76.0^^24^305^92
 ;;^UTILITY(U,$J,358.3,4825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4825,1,3,0)
 ;;=3^Issue of Repeat Prescription
 ;;^UTILITY(U,$J,358.3,4825,1,4,0)
 ;;=4^Z76.0
 ;;^UTILITY(U,$J,358.3,4825,2)
 ;;=^5063297
 ;;^UTILITY(U,$J,358.3,4826,0)
 ;;=E10.11^^24^305^36
 ;;^UTILITY(U,$J,358.3,4826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4826,1,3,0)
 ;;=3^Diabetes Type 1 w/ Ketacidosis w/ Coma
 ;;^UTILITY(U,$J,358.3,4826,1,4,0)
 ;;=4^E10.11
 ;;^UTILITY(U,$J,358.3,4826,2)
 ;;=^5002588
 ;;^UTILITY(U,$J,358.3,4827,0)
 ;;=E10.22^^24^305^18
 ;;^UTILITY(U,$J,358.3,4827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4827,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Chr Kidney Disease
 ;;^UTILITY(U,$J,358.3,4827,1,4,0)
 ;;=4^E10.22
 ;;^UTILITY(U,$J,358.3,4827,2)
 ;;=^5002590
 ;;^UTILITY(U,$J,358.3,4828,0)
 ;;=E10.29^^24^305^20
 ;;^UTILITY(U,$J,358.3,4828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4828,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Kidney Complication NEC
 ;;^UTILITY(U,$J,358.3,4828,1,4,0)
 ;;=4^E10.29
 ;;^UTILITY(U,$J,358.3,4828,2)
 ;;=^5002591
 ;;^UTILITY(U,$J,358.3,4829,0)
 ;;=E10.331^^24^305^40
