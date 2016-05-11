IBDEI2H0 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41897,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,41897,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,41897,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,41898,0)
 ;;=F03.91^^159^2011^9
 ;;^UTILITY(U,$J,358.3,41898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41898,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,41898,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,41898,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,41899,0)
 ;;=F01.50^^159^2011^12
 ;;^UTILITY(U,$J,358.3,41899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41899,1,3,0)
 ;;=3^Dementia,Vascular w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,41899,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,41899,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,41900,0)
 ;;=F10.27^^159^2011^11
 ;;^UTILITY(U,$J,358.3,41900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41900,1,3,0)
 ;;=3^Dementia,Alcohol-Induced/Persist w/ Alcohol Dependence
 ;;^UTILITY(U,$J,358.3,41900,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,41900,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,41901,0)
 ;;=F06.1^^159^2011^6
 ;;^UTILITY(U,$J,358.3,41901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41901,1,3,0)
 ;;=3^Catatonic Disorder d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,41901,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,41901,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,41902,0)
 ;;=F06.8^^159^2011^21
 ;;^UTILITY(U,$J,358.3,41902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41902,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition,Other
 ;;^UTILITY(U,$J,358.3,41902,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,41902,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,41903,0)
 ;;=F06.0^^159^2011^37
 ;;^UTILITY(U,$J,358.3,41903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41903,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucin d/t Known Physiol Condition
 ;;^UTILITY(U,$J,358.3,41903,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,41903,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,41904,0)
 ;;=G44.209^^159^2011^42
 ;;^UTILITY(U,$J,358.3,41904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41904,1,3,0)
 ;;=3^Tension-Type Headache,Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,41904,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,41904,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,41905,0)
 ;;=F09.^^159^2011^20
 ;;^UTILITY(U,$J,358.3,41905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41905,1,3,0)
 ;;=3^Mental Disorder d/t Known Physiological Condition,Unspec
 ;;^UTILITY(U,$J,358.3,41905,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,41905,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,41906,0)
 ;;=F07.9^^159^2011^35
 ;;^UTILITY(U,$J,358.3,41906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41906,1,3,0)
 ;;=3^Personality & Behavrl Disorder d/t Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,41906,1,4,0)
 ;;=4^F07.9
 ;;^UTILITY(U,$J,358.3,41906,2)
 ;;=^5003066
 ;;^UTILITY(U,$J,358.3,41907,0)
 ;;=G30.0^^159^2011^1
 ;;^UTILITY(U,$J,358.3,41907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41907,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,41907,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,41907,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,41908,0)
 ;;=G30.8^^159^2011^3
 ;;^UTILITY(U,$J,358.3,41908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41908,1,3,0)
 ;;=3^Alzheimer's Disease,Other
 ;;^UTILITY(U,$J,358.3,41908,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,41908,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,41909,0)
 ;;=G30.1^^159^2011^2
 ;;^UTILITY(U,$J,358.3,41909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41909,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
