IBDEI1OV ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28257,1,4,0)
 ;;=4^B02.29
 ;;^UTILITY(U,$J,358.3,28257,2)
 ;;=^5000492
 ;;^UTILITY(U,$J,358.3,28258,0)
 ;;=F03.90^^132^1327^10
 ;;^UTILITY(U,$J,358.3,28258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28258,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,28258,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,28258,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,28259,0)
 ;;=F03.91^^132^1327^9
 ;;^UTILITY(U,$J,358.3,28259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28259,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,28259,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,28259,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,28260,0)
 ;;=F01.50^^132^1327^12
 ;;^UTILITY(U,$J,358.3,28260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28260,1,3,0)
 ;;=3^Dementia,Vascular w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,28260,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,28260,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,28261,0)
 ;;=F10.27^^132^1327^11
 ;;^UTILITY(U,$J,358.3,28261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28261,1,3,0)
 ;;=3^Dementia,Alcohol-Induced/Persist w/ Alcohol Dependence
 ;;^UTILITY(U,$J,358.3,28261,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,28261,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,28262,0)
 ;;=F06.1^^132^1327^6
 ;;^UTILITY(U,$J,358.3,28262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28262,1,3,0)
 ;;=3^Catatonic Disorder d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,28262,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,28262,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,28263,0)
 ;;=F06.8^^132^1327^19
 ;;^UTILITY(U,$J,358.3,28263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28263,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition,Other
 ;;^UTILITY(U,$J,358.3,28263,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,28263,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,28264,0)
 ;;=F06.0^^132^1327^35
 ;;^UTILITY(U,$J,358.3,28264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28264,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucin d/t Known Physiol Condition
 ;;^UTILITY(U,$J,358.3,28264,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,28264,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,28265,0)
 ;;=G44.209^^132^1327^37
 ;;^UTILITY(U,$J,358.3,28265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28265,1,3,0)
 ;;=3^Tension-Type Headache,Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,28265,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,28265,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,28266,0)
 ;;=F09.^^132^1327^18
 ;;^UTILITY(U,$J,358.3,28266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28266,1,3,0)
 ;;=3^Mental Disorder d/t Known Physiological Condition,Unspec
 ;;^UTILITY(U,$J,358.3,28266,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,28266,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,28267,0)
 ;;=F07.9^^132^1327^33
 ;;^UTILITY(U,$J,358.3,28267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28267,1,3,0)
 ;;=3^Personality & Behavrl Disorder d/t Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,28267,1,4,0)
 ;;=4^F07.9
 ;;^UTILITY(U,$J,358.3,28267,2)
 ;;=^5003066
 ;;^UTILITY(U,$J,358.3,28268,0)
 ;;=G30.0^^132^1327^1
 ;;^UTILITY(U,$J,358.3,28268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28268,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,28268,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,28268,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,28269,0)
 ;;=G30.8^^132^1327^3
 ;;^UTILITY(U,$J,358.3,28269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28269,1,3,0)
 ;;=3^Alzheimer's Disease,Other
 ;;^UTILITY(U,$J,358.3,28269,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,28269,2)
 ;;=^5003807
