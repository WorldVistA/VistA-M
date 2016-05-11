IBDEI21B ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34513,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,34513,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,34513,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,34514,0)
 ;;=F03.91^^131^1687^9
 ;;^UTILITY(U,$J,358.3,34514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34514,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,34514,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,34514,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,34515,0)
 ;;=F01.50^^131^1687^12
 ;;^UTILITY(U,$J,358.3,34515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34515,1,3,0)
 ;;=3^Dementia,Vascular w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,34515,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,34515,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,34516,0)
 ;;=F10.27^^131^1687^11
 ;;^UTILITY(U,$J,358.3,34516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34516,1,3,0)
 ;;=3^Dementia,Alcohol-Induced/Persist w/ Alcohol Dependence
 ;;^UTILITY(U,$J,358.3,34516,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,34516,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,34517,0)
 ;;=F06.1^^131^1687^6
 ;;^UTILITY(U,$J,358.3,34517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34517,1,3,0)
 ;;=3^Catatonic Disorder d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,34517,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,34517,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,34518,0)
 ;;=F06.8^^131^1687^21
 ;;^UTILITY(U,$J,358.3,34518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34518,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition,Other
 ;;^UTILITY(U,$J,358.3,34518,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,34518,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,34519,0)
 ;;=F06.0^^131^1687^37
 ;;^UTILITY(U,$J,358.3,34519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34519,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucin d/t Known Physiol Condition
 ;;^UTILITY(U,$J,358.3,34519,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,34519,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,34520,0)
 ;;=G44.209^^131^1687^42
 ;;^UTILITY(U,$J,358.3,34520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34520,1,3,0)
 ;;=3^Tension-Type Headache,Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,34520,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,34520,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,34521,0)
 ;;=F09.^^131^1687^20
 ;;^UTILITY(U,$J,358.3,34521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34521,1,3,0)
 ;;=3^Mental Disorder d/t Known Physiological Condition,Unspec
 ;;^UTILITY(U,$J,358.3,34521,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,34521,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,34522,0)
 ;;=F07.9^^131^1687^35
 ;;^UTILITY(U,$J,358.3,34522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34522,1,3,0)
 ;;=3^Personality & Behavrl Disorder d/t Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,34522,1,4,0)
 ;;=4^F07.9
 ;;^UTILITY(U,$J,358.3,34522,2)
 ;;=^5003066
 ;;^UTILITY(U,$J,358.3,34523,0)
 ;;=G30.0^^131^1687^1
 ;;^UTILITY(U,$J,358.3,34523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34523,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,34523,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,34523,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,34524,0)
 ;;=G30.8^^131^1687^3
 ;;^UTILITY(U,$J,358.3,34524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34524,1,3,0)
 ;;=3^Alzheimer's Disease,Other
 ;;^UTILITY(U,$J,358.3,34524,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,34524,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,34525,0)
 ;;=G30.1^^131^1687^2
 ;;^UTILITY(U,$J,358.3,34525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34525,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
