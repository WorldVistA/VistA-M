IBDEI1B8 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21180,2)
 ;;=^5008351
 ;;^UTILITY(U,$J,358.3,21181,0)
 ;;=J96.12^^70^908^29
 ;;^UTILITY(U,$J,358.3,21181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21181,1,3,0)
 ;;=3^Chr Respiratory Failure w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,21181,1,4,0)
 ;;=4^J96.12
 ;;^UTILITY(U,$J,358.3,21181,2)
 ;;=^5008352
 ;;^UTILITY(U,$J,358.3,21182,0)
 ;;=J96.20^^70^908^10
 ;;^UTILITY(U,$J,358.3,21182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21182,1,3,0)
 ;;=3^Acute and Chr Respiratory Failure
 ;;^UTILITY(U,$J,358.3,21182,1,4,0)
 ;;=4^J96.20
 ;;^UTILITY(U,$J,358.3,21182,2)
 ;;=^5008353
 ;;^UTILITY(U,$J,358.3,21183,0)
 ;;=J96.21^^70^908^11
 ;;^UTILITY(U,$J,358.3,21183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21183,1,3,0)
 ;;=3^Acute and Chr Respiratory Failure w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,21183,1,4,0)
 ;;=4^J96.21
 ;;^UTILITY(U,$J,358.3,21183,2)
 ;;=^5008354
 ;;^UTILITY(U,$J,358.3,21184,0)
 ;;=J96.22^^70^908^12
 ;;^UTILITY(U,$J,358.3,21184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21184,1,3,0)
 ;;=3^Acute and Chr Respiratory Failure w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,21184,1,4,0)
 ;;=4^J96.22
 ;;^UTILITY(U,$J,358.3,21184,2)
 ;;=^5008355
 ;;^UTILITY(U,$J,358.3,21185,0)
 ;;=D86.0^^70^908^107
 ;;^UTILITY(U,$J,358.3,21185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21185,1,3,0)
 ;;=3^Sarcoidosis of the Lung
 ;;^UTILITY(U,$J,358.3,21185,1,4,0)
 ;;=4^D86.0
 ;;^UTILITY(U,$J,358.3,21185,2)
 ;;=^5002442
 ;;^UTILITY(U,$J,358.3,21186,0)
 ;;=R06.03^^70^908^4
 ;;^UTILITY(U,$J,358.3,21186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21186,1,3,0)
 ;;=3^Acute Respiratory Distress
 ;;^UTILITY(U,$J,358.3,21186,1,4,0)
 ;;=4^R06.03
 ;;^UTILITY(U,$J,358.3,21186,2)
 ;;=^5151591
 ;;^UTILITY(U,$J,358.3,21187,0)
 ;;=I27.20^^70^908^100
 ;;^UTILITY(U,$J,358.3,21187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21187,1,3,0)
 ;;=3^Pulmonary Hypertension,Unspec
 ;;^UTILITY(U,$J,358.3,21187,1,4,0)
 ;;=4^I27.20
 ;;^UTILITY(U,$J,358.3,21187,2)
 ;;=^5151376
 ;;^UTILITY(U,$J,358.3,21188,0)
 ;;=I27.21^^70^908^89
 ;;^UTILITY(U,$J,358.3,21188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21188,1,3,0)
 ;;=3^Pulmonary Arterial Hypertension,Secondary
 ;;^UTILITY(U,$J,358.3,21188,1,4,0)
 ;;=4^I27.21
 ;;^UTILITY(U,$J,358.3,21188,2)
 ;;=^5151377
 ;;^UTILITY(U,$J,358.3,21189,0)
 ;;=I27.22^^70^908^95
 ;;^UTILITY(U,$J,358.3,21189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21189,1,3,0)
 ;;=3^Pulmonary Hypertension d/t Left Heart Disease
 ;;^UTILITY(U,$J,358.3,21189,1,4,0)
 ;;=4^I27.22
 ;;^UTILITY(U,$J,358.3,21189,2)
 ;;=^5151378
 ;;^UTILITY(U,$J,358.3,21190,0)
 ;;=I27.23^^70^908^96
 ;;^UTILITY(U,$J,358.3,21190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21190,1,3,0)
 ;;=3^Pulmonary Hypertension d/t Lung Disease & Hypoxia
 ;;^UTILITY(U,$J,358.3,21190,1,4,0)
 ;;=4^I27.23
 ;;^UTILITY(U,$J,358.3,21190,2)
 ;;=^5151379
 ;;^UTILITY(U,$J,358.3,21191,0)
 ;;=I27.24^^70^908^97
 ;;^UTILITY(U,$J,358.3,21191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21191,1,3,0)
 ;;=3^Pulmonary Hypertension,Chronic Thromboembolic
 ;;^UTILITY(U,$J,358.3,21191,1,4,0)
 ;;=4^I27.24
 ;;^UTILITY(U,$J,358.3,21191,2)
 ;;=^5151380
 ;;^UTILITY(U,$J,358.3,21192,0)
 ;;=I27.29^^70^908^98
 ;;^UTILITY(U,$J,358.3,21192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21192,1,3,0)
 ;;=3^Pulmonary Hypertension,Other Secondary
 ;;^UTILITY(U,$J,358.3,21192,1,4,0)
 ;;=4^I27.29
