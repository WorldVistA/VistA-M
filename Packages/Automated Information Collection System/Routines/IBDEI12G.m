IBDEI12G ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17135,1,4,0)
 ;;=4^M48.062
 ;;^UTILITY(U,$J,358.3,17135,2)
 ;;=^5151514
 ;;^UTILITY(U,$J,358.3,17136,0)
 ;;=M79.10^^88^885^65
 ;;^UTILITY(U,$J,358.3,17136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17136,1,3,0)
 ;;=3^Myalgia,Unspec Site
 ;;^UTILITY(U,$J,358.3,17136,1,4,0)
 ;;=4^M79.10
 ;;^UTILITY(U,$J,358.3,17136,2)
 ;;=^5157394
 ;;^UTILITY(U,$J,358.3,17137,0)
 ;;=B02.0^^88^886^47
 ;;^UTILITY(U,$J,358.3,17137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17137,1,3,0)
 ;;=3^Zoster Encephalitis
 ;;^UTILITY(U,$J,358.3,17137,1,4,0)
 ;;=4^B02.0
 ;;^UTILITY(U,$J,358.3,17137,2)
 ;;=^5000488
 ;;^UTILITY(U,$J,358.3,17138,0)
 ;;=B02.29^^88^886^37
 ;;^UTILITY(U,$J,358.3,17138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17138,1,3,0)
 ;;=3^Postherpetic Nervous System Involvement,Other
 ;;^UTILITY(U,$J,358.3,17138,1,4,0)
 ;;=4^B02.29
 ;;^UTILITY(U,$J,358.3,17138,2)
 ;;=^5000492
 ;;^UTILITY(U,$J,358.3,17139,0)
 ;;=F03.90^^88^886^11
 ;;^UTILITY(U,$J,358.3,17139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17139,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,17139,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,17139,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,17140,0)
 ;;=F03.91^^88^886^10
 ;;^UTILITY(U,$J,358.3,17140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17140,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,17140,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,17140,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,17141,0)
 ;;=F01.50^^88^886^13
 ;;^UTILITY(U,$J,358.3,17141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17141,1,3,0)
 ;;=3^Dementia,Vascular w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,17141,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,17141,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,17142,0)
 ;;=F10.27^^88^886^12
 ;;^UTILITY(U,$J,358.3,17142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17142,1,3,0)
 ;;=3^Dementia,Alcohol-Induced/Persist w/ Alcohol Dependence
 ;;^UTILITY(U,$J,358.3,17142,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,17142,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,17143,0)
 ;;=F06.1^^88^886^7
 ;;^UTILITY(U,$J,358.3,17143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17143,1,3,0)
 ;;=3^Catatonic Disorder d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,17143,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,17143,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,17144,0)
 ;;=F06.8^^88^886^22
 ;;^UTILITY(U,$J,358.3,17144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17144,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition,Other
 ;;^UTILITY(U,$J,358.3,17144,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,17144,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,17145,0)
 ;;=F06.0^^88^886^38
 ;;^UTILITY(U,$J,358.3,17145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17145,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucin d/t Known Physiol Condition
 ;;^UTILITY(U,$J,358.3,17145,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,17145,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,17146,0)
 ;;=G44.209^^88^886^43
 ;;^UTILITY(U,$J,358.3,17146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17146,1,3,0)
 ;;=3^Tension-Type Headache,Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,17146,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,17146,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,17147,0)
 ;;=F09.^^88^886^21
 ;;^UTILITY(U,$J,358.3,17147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17147,1,3,0)
 ;;=3^Mental Disorder d/t Known Physiological Condition,Unspec
