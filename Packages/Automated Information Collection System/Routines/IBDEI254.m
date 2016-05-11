IBDEI254 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36314,0)
 ;;=I26.01^^137^1755^93
 ;;^UTILITY(U,$J,358.3,36314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36314,1,3,0)
 ;;=3^Septic Pulmonary Embolism w/ Acute Cor Pulmonale
 ;;^UTILITY(U,$J,358.3,36314,1,4,0)
 ;;=4^I26.01
 ;;^UTILITY(U,$J,358.3,36314,2)
 ;;=^5007145
 ;;^UTILITY(U,$J,358.3,36315,0)
 ;;=I26.90^^137^1755^94
 ;;^UTILITY(U,$J,358.3,36315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36315,1,3,0)
 ;;=3^Septic Pulmonary Embolism w/o Acute Cor Pulmonale
 ;;^UTILITY(U,$J,358.3,36315,1,4,0)
 ;;=4^I26.90
 ;;^UTILITY(U,$J,358.3,36315,2)
 ;;=^5007148
 ;;^UTILITY(U,$J,358.3,36316,0)
 ;;=J06.9^^137^1755^1
 ;;^UTILITY(U,$J,358.3,36316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36316,1,3,0)
 ;;=3^AC Upper Respiratory Infection,Unspec
 ;;^UTILITY(U,$J,358.3,36316,1,4,0)
 ;;=4^J06.9
 ;;^UTILITY(U,$J,358.3,36316,2)
 ;;=^5008143
 ;;^UTILITY(U,$J,358.3,36317,0)
 ;;=E66.01^^137^1755^52
 ;;^UTILITY(U,$J,358.3,36317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36317,1,3,0)
 ;;=3^Morbid Obesity
 ;;^UTILITY(U,$J,358.3,36317,1,4,0)
 ;;=4^E66.01
 ;;^UTILITY(U,$J,358.3,36317,2)
 ;;=^5002826
 ;;^UTILITY(U,$J,358.3,36318,0)
 ;;=E66.2^^137^1755^53
 ;;^UTILITY(U,$J,358.3,36318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36318,1,3,0)
 ;;=3^Morbid Obesity w/ Alveolar Hypoventilation
 ;;^UTILITY(U,$J,358.3,36318,1,4,0)
 ;;=4^E66.2
 ;;^UTILITY(U,$J,358.3,36318,2)
 ;;=^5002829
 ;;^UTILITY(U,$J,358.3,36319,0)
 ;;=J96.01^^137^1755^5
 ;;^UTILITY(U,$J,358.3,36319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36319,1,3,0)
 ;;=3^Acute Respiratory Failure w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,36319,1,4,0)
 ;;=4^J96.01
 ;;^UTILITY(U,$J,358.3,36319,2)
 ;;=^5008348
 ;;^UTILITY(U,$J,358.3,36320,0)
 ;;=J96.02^^137^1755^4
 ;;^UTILITY(U,$J,358.3,36320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36320,1,3,0)
 ;;=3^Acute Respiratory Failure w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,36320,1,4,0)
 ;;=4^J96.02
 ;;^UTILITY(U,$J,358.3,36320,2)
 ;;=^5008349
 ;;^UTILITY(U,$J,358.3,36321,0)
 ;;=J96.10^^137^1755^25
 ;;^UTILITY(U,$J,358.3,36321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36321,1,3,0)
 ;;=3^Chr Respiratory Failure
 ;;^UTILITY(U,$J,358.3,36321,1,4,0)
 ;;=4^J96.10
 ;;^UTILITY(U,$J,358.3,36321,2)
 ;;=^5008350
 ;;^UTILITY(U,$J,358.3,36322,0)
 ;;=J96.11^^137^1755^27
 ;;^UTILITY(U,$J,358.3,36322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36322,1,3,0)
 ;;=3^Chr Respiratory Failure w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,36322,1,4,0)
 ;;=4^J96.11
 ;;^UTILITY(U,$J,358.3,36322,2)
 ;;=^5008351
 ;;^UTILITY(U,$J,358.3,36323,0)
 ;;=J96.12^^137^1755^26
 ;;^UTILITY(U,$J,358.3,36323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36323,1,3,0)
 ;;=3^Chr Respiratory Failure w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,36323,1,4,0)
 ;;=4^J96.12
 ;;^UTILITY(U,$J,358.3,36323,2)
 ;;=^5008352
 ;;^UTILITY(U,$J,358.3,36324,0)
 ;;=J96.20^^137^1755^7
 ;;^UTILITY(U,$J,358.3,36324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36324,1,3,0)
 ;;=3^Acute and Chr Respiratory Failure
 ;;^UTILITY(U,$J,358.3,36324,1,4,0)
 ;;=4^J96.20
 ;;^UTILITY(U,$J,358.3,36324,2)
 ;;=^5008353
 ;;^UTILITY(U,$J,358.3,36325,0)
 ;;=J96.21^^137^1755^8
 ;;^UTILITY(U,$J,358.3,36325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36325,1,3,0)
 ;;=3^Acute and Chr Respiratory Failure w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,36325,1,4,0)
 ;;=4^J96.21
 ;;^UTILITY(U,$J,358.3,36325,2)
 ;;=^5008354
 ;;^UTILITY(U,$J,358.3,36326,0)
 ;;=J96.22^^137^1755^9
 ;;^UTILITY(U,$J,358.3,36326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36326,1,3,0)
 ;;=3^Acute and Chr Respiratory Failure w/ Hypercapnia
