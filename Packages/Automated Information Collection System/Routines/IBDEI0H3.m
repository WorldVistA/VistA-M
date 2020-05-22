IBDEI0H3 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7414,0)
 ;;=F01.50^^58^474^12
 ;;^UTILITY(U,$J,358.3,7414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7414,1,3,0)
 ;;=3^Dementia,Vascular w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,7414,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,7414,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,7415,0)
 ;;=F10.27^^58^474^11
 ;;^UTILITY(U,$J,358.3,7415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7415,1,3,0)
 ;;=3^Dementia,Alcohol-Induced/Persist w/ Alcohol Dependence
 ;;^UTILITY(U,$J,358.3,7415,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,7415,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,7416,0)
 ;;=F06.1^^58^474^6
 ;;^UTILITY(U,$J,358.3,7416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7416,1,3,0)
 ;;=3^Catatonic Disorder d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,7416,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,7416,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,7417,0)
 ;;=F06.8^^58^474^21
 ;;^UTILITY(U,$J,358.3,7417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7417,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition,Other
 ;;^UTILITY(U,$J,358.3,7417,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,7417,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,7418,0)
 ;;=F06.0^^58^474^37
 ;;^UTILITY(U,$J,358.3,7418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7418,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucin d/t Known Physiol Condition
 ;;^UTILITY(U,$J,358.3,7418,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,7418,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,7419,0)
 ;;=G44.209^^58^474^42
 ;;^UTILITY(U,$J,358.3,7419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7419,1,3,0)
 ;;=3^Tension-Type Headache,Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,7419,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,7419,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,7420,0)
 ;;=F09.^^58^474^20
 ;;^UTILITY(U,$J,358.3,7420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7420,1,3,0)
 ;;=3^Mental Disorder d/t Known Physiological Condition,Unspec
 ;;^UTILITY(U,$J,358.3,7420,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,7420,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,7421,0)
 ;;=F07.9^^58^474^35
 ;;^UTILITY(U,$J,358.3,7421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7421,1,3,0)
 ;;=3^Personality & Behavrl Disorder d/t Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,7421,1,4,0)
 ;;=4^F07.9
 ;;^UTILITY(U,$J,358.3,7421,2)
 ;;=^5003066
 ;;^UTILITY(U,$J,358.3,7422,0)
 ;;=G30.0^^58^474^1
 ;;^UTILITY(U,$J,358.3,7422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7422,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,7422,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,7422,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,7423,0)
 ;;=G30.8^^58^474^3
 ;;^UTILITY(U,$J,358.3,7423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7423,1,3,0)
 ;;=3^Alzheimer's Disease,Other
 ;;^UTILITY(U,$J,358.3,7423,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,7423,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,7424,0)
 ;;=G30.1^^58^474^2
 ;;^UTILITY(U,$J,358.3,7424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7424,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,7424,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,7424,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,7425,0)
 ;;=G30.9^^58^474^4
 ;;^UTILITY(U,$J,358.3,7425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7425,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,7425,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,7425,2)
 ;;=^5003808
