IBDEI0HI ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8470,1,4,0)
 ;;=4^695.3
 ;;^UTILITY(U,$J,358.3,8470,2)
 ;;=Acne Rosacea^107114
 ;;^UTILITY(U,$J,358.3,8471,0)
 ;;=250.00^^52^582^22
 ;;^UTILITY(U,$J,358.3,8471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8471,1,3,0)
 ;;=3^DM type II w/o Eye Disease
 ;;^UTILITY(U,$J,358.3,8471,1,4,0)
 ;;=4^250.00
 ;;^UTILITY(U,$J,358.3,8471,2)
 ;;=DM type II w/o Eye Disease^33605
 ;;^UTILITY(U,$J,358.3,8472,0)
 ;;=346.90^^52^582^41
 ;;^UTILITY(U,$J,358.3,8472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8472,1,3,0)
 ;;=3^Headache,Migraine-Not Intractable
 ;;^UTILITY(U,$J,358.3,8472,1,4,0)
 ;;=4^346.90
 ;;^UTILITY(U,$J,358.3,8472,2)
 ;;=Migraine without Intract^293880
 ;;^UTILITY(U,$J,358.3,8473,0)
 ;;=376.30^^52^582^30
 ;;^UTILITY(U,$J,358.3,8473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8473,1,3,0)
 ;;=3^Exophthalmos,NOS
 ;;^UTILITY(U,$J,358.3,8473,1,4,0)
 ;;=4^376.30
 ;;^UTILITY(U,$J,358.3,8473,2)
 ;;=Exophthalmos NOS^43683
 ;;^UTILITY(U,$J,358.3,8474,0)
 ;;=368.8^^52^582^7
 ;;^UTILITY(U,$J,358.3,8474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8474,1,3,0)
 ;;=3^Blurred Vision
 ;;^UTILITY(U,$J,358.3,8474,1,4,0)
 ;;=4^368.8
 ;;^UTILITY(U,$J,358.3,8474,2)
 ;;=Blurred Vision^88172
 ;;^UTILITY(U,$J,358.3,8475,0)
 ;;=362.34^^52^582^5
 ;;^UTILITY(U,$J,358.3,8475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8475,1,3,0)
 ;;=3^Amaurosis Fugax
 ;;^UTILITY(U,$J,358.3,8475,1,4,0)
 ;;=4^362.34
 ;;^UTILITY(U,$J,358.3,8475,2)
 ;;=^268622
 ;;^UTILITY(U,$J,358.3,8476,0)
 ;;=368.13^^52^582^88
 ;;^UTILITY(U,$J,358.3,8476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8476,1,3,0)
 ;;=3^Photophobia
 ;;^UTILITY(U,$J,358.3,8476,1,4,0)
 ;;=4^368.13
 ;;^UTILITY(U,$J,358.3,8476,2)
 ;;=^126851
 ;;^UTILITY(U,$J,358.3,8477,0)
 ;;=368.40^^52^582^113
 ;;^UTILITY(U,$J,358.3,8477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8477,1,3,0)
 ;;=3^Vis Field Defect
 ;;^UTILITY(U,$J,358.3,8477,1,4,0)
 ;;=4^368.40
 ;;^UTILITY(U,$J,358.3,8477,2)
 ;;=^126859
 ;;^UTILITY(U,$J,358.3,8478,0)
 ;;=369.4^^52^582^58
 ;;^UTILITY(U,$J,358.3,8478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8478,1,3,0)
 ;;=3^Legally Blind,USA Definition
 ;;^UTILITY(U,$J,358.3,8478,1,4,0)
 ;;=4^369.4
 ;;^UTILITY(U,$J,358.3,8478,2)
 ;;=Legal Blindness^268887
 ;;^UTILITY(U,$J,358.3,8479,0)
 ;;=250.01^^52^582^21
 ;;^UTILITY(U,$J,358.3,8479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8479,1,3,0)
 ;;=3^DM Type I w/o Eye Disease
 ;;^UTILITY(U,$J,358.3,8479,1,4,0)
 ;;=4^250.01
 ;;^UTILITY(U,$J,358.3,8479,2)
 ;;=Diabetes Mellitus Type I^33586
 ;;^UTILITY(U,$J,358.3,8480,0)
 ;;=V08.^^52^582^40
 ;;^UTILITY(U,$J,358.3,8480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8480,1,3,0)
 ;;=3^HIV Positive
 ;;^UTILITY(U,$J,358.3,8480,1,4,0)
 ;;=4^V08.
 ;;^UTILITY(U,$J,358.3,8480,2)
 ;;=Asymptomatic HIV Status^303392
 ;;^UTILITY(U,$J,358.3,8481,0)
 ;;=921.0^^52^582^16
 ;;^UTILITY(U,$J,358.3,8481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8481,1,3,0)
 ;;=3^Contusion of Eye
 ;;^UTILITY(U,$J,358.3,8481,1,4,0)
 ;;=4^921.0
 ;;^UTILITY(U,$J,358.3,8481,2)
 ;;=^15052
 ;;^UTILITY(U,$J,358.3,8482,0)
 ;;=379.91^^52^582^87
 ;;^UTILITY(U,$J,358.3,8482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8482,1,3,0)
 ;;=3^Pain in/around the Eye
 ;;^UTILITY(U,$J,358.3,8482,1,4,0)
 ;;=4^379.91
 ;;^UTILITY(U,$J,358.3,8482,2)
 ;;=Pain in or around eye^89093
 ;;^UTILITY(U,$J,358.3,8483,0)
 ;;=V58.69^^52^582^44
 ;;^UTILITY(U,$J,358.3,8483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8483,1,3,0)
 ;;=3^Hi-Risk Med,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,8483,1,4,0)
 ;;=4^V58.69
 ;;^UTILITY(U,$J,358.3,8483,2)
 ;;=^303460
