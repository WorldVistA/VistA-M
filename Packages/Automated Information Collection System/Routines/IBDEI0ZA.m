IBDEI0ZA ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16583,1,3,0)
 ;;=3^Pleural Effusion in Oth Conditions Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,16583,1,4,0)
 ;;=4^J91.8
 ;;^UTILITY(U,$J,358.3,16583,2)
 ;;=^5008311
 ;;^UTILITY(U,$J,358.3,16584,0)
 ;;=J84.10^^67^766^14
 ;;^UTILITY(U,$J,358.3,16584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16584,1,3,0)
 ;;=3^Pulmonary Fibrosis,Unspec
 ;;^UTILITY(U,$J,358.3,16584,1,4,0)
 ;;=4^J84.10
 ;;^UTILITY(U,$J,358.3,16584,2)
 ;;=^5008300
 ;;^UTILITY(U,$J,358.3,16585,0)
 ;;=R22.2^^67^766^20
 ;;^UTILITY(U,$J,358.3,16585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16585,1,3,0)
 ;;=3^Swelling,Mass & Lump,Trunk
 ;;^UTILITY(U,$J,358.3,16585,1,4,0)
 ;;=4^R22.2
 ;;^UTILITY(U,$J,358.3,16585,2)
 ;;=^5019286
 ;;^UTILITY(U,$J,358.3,16586,0)
 ;;=R06.02^^67^766^19
 ;;^UTILITY(U,$J,358.3,16586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16586,1,3,0)
 ;;=3^Shortness of Breath
 ;;^UTILITY(U,$J,358.3,16586,1,4,0)
 ;;=4^R06.02
 ;;^UTILITY(U,$J,358.3,16586,2)
 ;;=^5019181
 ;;^UTILITY(U,$J,358.3,16587,0)
 ;;=J96.10^^67^766^8
 ;;^UTILITY(U,$J,358.3,16587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16587,1,3,0)
 ;;=3^Chronic Respiratory Failure
 ;;^UTILITY(U,$J,358.3,16587,1,4,0)
 ;;=4^J96.10
 ;;^UTILITY(U,$J,358.3,16587,2)
 ;;=^5008350
 ;;^UTILITY(U,$J,358.3,16588,0)
 ;;=J96.01^^67^766^3
 ;;^UTILITY(U,$J,358.3,16588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16588,1,3,0)
 ;;=3^Acute Respiratory Failure w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,16588,1,4,0)
 ;;=4^J96.01
 ;;^UTILITY(U,$J,358.3,16588,2)
 ;;=^5008348
 ;;^UTILITY(U,$J,358.3,16589,0)
 ;;=J96.02^^67^766^2
 ;;^UTILITY(U,$J,358.3,16589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16589,1,3,0)
 ;;=3^Acute Respiratory Failure w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,16589,1,4,0)
 ;;=4^J96.02
 ;;^UTILITY(U,$J,358.3,16589,2)
 ;;=^5008349
 ;;^UTILITY(U,$J,358.3,16590,0)
 ;;=J96.21^^67^766^6
 ;;^UTILITY(U,$J,358.3,16590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16590,1,3,0)
 ;;=3^Acute/Chr Respiratory Failure w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,16590,1,4,0)
 ;;=4^J96.21
 ;;^UTILITY(U,$J,358.3,16590,2)
 ;;=^5008354
 ;;^UTILITY(U,$J,358.3,16591,0)
 ;;=J96.22^^67^766^5
 ;;^UTILITY(U,$J,358.3,16591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16591,1,3,0)
 ;;=3^Acute/Chr Respiratory Failure w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,16591,1,4,0)
 ;;=4^J96.22
 ;;^UTILITY(U,$J,358.3,16591,2)
 ;;=^5008355
 ;;^UTILITY(U,$J,358.3,16592,0)
 ;;=J96.11^^67^766^10
 ;;^UTILITY(U,$J,358.3,16592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16592,1,3,0)
 ;;=3^Chronic Respiratory Failure w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,16592,1,4,0)
 ;;=4^J96.11
 ;;^UTILITY(U,$J,358.3,16592,2)
 ;;=^5008351
 ;;^UTILITY(U,$J,358.3,16593,0)
 ;;=J96.12^^67^766^9
 ;;^UTILITY(U,$J,358.3,16593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16593,1,3,0)
 ;;=3^Chronic Respiratory Failure w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,16593,1,4,0)
 ;;=4^J96.12
 ;;^UTILITY(U,$J,358.3,16593,2)
 ;;=^5008352
 ;;^UTILITY(U,$J,358.3,16594,0)
 ;;=J96.91^^67^766^18
 ;;^UTILITY(U,$J,358.3,16594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16594,1,3,0)
 ;;=3^Respiratory Failure,Unspec w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,16594,1,4,0)
 ;;=4^J96.91
 ;;^UTILITY(U,$J,358.3,16594,2)
 ;;=^5008357
 ;;^UTILITY(U,$J,358.3,16595,0)
 ;;=J96.92^^67^766^17
 ;;^UTILITY(U,$J,358.3,16595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16595,1,3,0)
 ;;=3^Respiratory Failure,Unspec w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,16595,1,4,0)
 ;;=4^J96.92
 ;;^UTILITY(U,$J,358.3,16595,2)
 ;;=^5008358
