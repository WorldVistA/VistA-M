IBDEI152 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18489,2)
 ;;=^5008351
 ;;^UTILITY(U,$J,358.3,18490,0)
 ;;=J96.12^^64^828^29
 ;;^UTILITY(U,$J,358.3,18490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18490,1,3,0)
 ;;=3^Chr Respiratory Failure w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,18490,1,4,0)
 ;;=4^J96.12
 ;;^UTILITY(U,$J,358.3,18490,2)
 ;;=^5008352
 ;;^UTILITY(U,$J,358.3,18491,0)
 ;;=J96.20^^64^828^10
 ;;^UTILITY(U,$J,358.3,18491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18491,1,3,0)
 ;;=3^Acute and Chr Respiratory Failure
 ;;^UTILITY(U,$J,358.3,18491,1,4,0)
 ;;=4^J96.20
 ;;^UTILITY(U,$J,358.3,18491,2)
 ;;=^5008353
 ;;^UTILITY(U,$J,358.3,18492,0)
 ;;=J96.21^^64^828^11
 ;;^UTILITY(U,$J,358.3,18492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18492,1,3,0)
 ;;=3^Acute and Chr Respiratory Failure w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,18492,1,4,0)
 ;;=4^J96.21
 ;;^UTILITY(U,$J,358.3,18492,2)
 ;;=^5008354
 ;;^UTILITY(U,$J,358.3,18493,0)
 ;;=J96.22^^64^828^12
 ;;^UTILITY(U,$J,358.3,18493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18493,1,3,0)
 ;;=3^Acute and Chr Respiratory Failure w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,18493,1,4,0)
 ;;=4^J96.22
 ;;^UTILITY(U,$J,358.3,18493,2)
 ;;=^5008355
 ;;^UTILITY(U,$J,358.3,18494,0)
 ;;=D86.0^^64^828^107
 ;;^UTILITY(U,$J,358.3,18494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18494,1,3,0)
 ;;=3^Sarcoidosis of the Lung
 ;;^UTILITY(U,$J,358.3,18494,1,4,0)
 ;;=4^D86.0
 ;;^UTILITY(U,$J,358.3,18494,2)
 ;;=^5002442
 ;;^UTILITY(U,$J,358.3,18495,0)
 ;;=R06.03^^64^828^4
 ;;^UTILITY(U,$J,358.3,18495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18495,1,3,0)
 ;;=3^Acute Respiratory Distress
 ;;^UTILITY(U,$J,358.3,18495,1,4,0)
 ;;=4^R06.03
 ;;^UTILITY(U,$J,358.3,18495,2)
 ;;=^5151591
 ;;^UTILITY(U,$J,358.3,18496,0)
 ;;=I27.20^^64^828^100
 ;;^UTILITY(U,$J,358.3,18496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18496,1,3,0)
 ;;=3^Pulmonary Hypertension,Unspec
 ;;^UTILITY(U,$J,358.3,18496,1,4,0)
 ;;=4^I27.20
 ;;^UTILITY(U,$J,358.3,18496,2)
 ;;=^5151376
 ;;^UTILITY(U,$J,358.3,18497,0)
 ;;=I27.21^^64^828^89
 ;;^UTILITY(U,$J,358.3,18497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18497,1,3,0)
 ;;=3^Pulmonary Arterial Hypertension,Secondary
 ;;^UTILITY(U,$J,358.3,18497,1,4,0)
 ;;=4^I27.21
 ;;^UTILITY(U,$J,358.3,18497,2)
 ;;=^5151377
 ;;^UTILITY(U,$J,358.3,18498,0)
 ;;=I27.22^^64^828^95
 ;;^UTILITY(U,$J,358.3,18498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18498,1,3,0)
 ;;=3^Pulmonary Hypertension d/t Left Heart Disease
 ;;^UTILITY(U,$J,358.3,18498,1,4,0)
 ;;=4^I27.22
 ;;^UTILITY(U,$J,358.3,18498,2)
 ;;=^5151378
 ;;^UTILITY(U,$J,358.3,18499,0)
 ;;=I27.23^^64^828^96
 ;;^UTILITY(U,$J,358.3,18499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18499,1,3,0)
 ;;=3^Pulmonary Hypertension d/t Lung Disease & Hypoxia
 ;;^UTILITY(U,$J,358.3,18499,1,4,0)
 ;;=4^I27.23
 ;;^UTILITY(U,$J,358.3,18499,2)
 ;;=^5151379
 ;;^UTILITY(U,$J,358.3,18500,0)
 ;;=I27.24^^64^828^97
 ;;^UTILITY(U,$J,358.3,18500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18500,1,3,0)
 ;;=3^Pulmonary Hypertension,Chronic Thromboembolic
 ;;^UTILITY(U,$J,358.3,18500,1,4,0)
 ;;=4^I27.24
 ;;^UTILITY(U,$J,358.3,18500,2)
 ;;=^5151380
 ;;^UTILITY(U,$J,358.3,18501,0)
 ;;=I27.29^^64^828^98
 ;;^UTILITY(U,$J,358.3,18501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18501,1,3,0)
 ;;=3^Pulmonary Hypertension,Other Secondary
 ;;^UTILITY(U,$J,358.3,18501,1,4,0)
 ;;=4^I27.29
