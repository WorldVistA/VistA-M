IBDEI1ZV ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33396,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucinations d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,33396,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,33396,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,33397,0)
 ;;=F06.4^^148^1644^1
 ;;^UTILITY(U,$J,358.3,33397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33397,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,33397,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,33397,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,33398,0)
 ;;=F06.1^^148^1644^2
 ;;^UTILITY(U,$J,358.3,33398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33398,1,3,0)
 ;;=3^Catatonia Associated w/ Schizophrenia
 ;;^UTILITY(U,$J,358.3,33398,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,33398,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,33399,0)
 ;;=R41.9^^148^1644^3
 ;;^UTILITY(U,$J,358.3,33399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33399,1,3,0)
 ;;=3^Neurocognitive Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,33399,1,4,0)
 ;;=4^R41.9
 ;;^UTILITY(U,$J,358.3,33399,2)
 ;;=^5019449
 ;;^UTILITY(U,$J,358.3,33400,0)
 ;;=F29.^^148^1644^7
 ;;^UTILITY(U,$J,358.3,33400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33400,1,3,0)
 ;;=3^Schizophrenia Spectrum/Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,33400,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,33400,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,33401,0)
 ;;=F07.0^^148^1644^4
 ;;^UTILITY(U,$J,358.3,33401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33401,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,33401,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,33401,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,33402,0)
 ;;=Z91.49^^148^1645^9
 ;;^UTILITY(U,$J,358.3,33402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33402,1,3,0)
 ;;=3^Personal Hx of Psychological Trauma
 ;;^UTILITY(U,$J,358.3,33402,1,4,0)
 ;;=4^Z91.49
 ;;^UTILITY(U,$J,358.3,33402,2)
 ;;=^5063623
 ;;^UTILITY(U,$J,358.3,33403,0)
 ;;=Z91.5^^148^1645^10
 ;;^UTILITY(U,$J,358.3,33403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33403,1,3,0)
 ;;=3^Personal Hx of Self-Harm
 ;;^UTILITY(U,$J,358.3,33403,1,4,0)
 ;;=4^Z91.5
 ;;^UTILITY(U,$J,358.3,33403,2)
 ;;=^5063624
 ;;^UTILITY(U,$J,358.3,33404,0)
 ;;=Z91.82^^148^1645^8
 ;;^UTILITY(U,$J,358.3,33404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33404,1,3,0)
 ;;=3^Personal Hx of Military Deployment
 ;;^UTILITY(U,$J,358.3,33404,1,4,0)
 ;;=4^Z91.82
 ;;^UTILITY(U,$J,358.3,33404,2)
 ;;=^5063626
 ;;^UTILITY(U,$J,358.3,33405,0)
 ;;=Z91.89^^148^1645^11
 ;;^UTILITY(U,$J,358.3,33405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33405,1,3,0)
 ;;=3^Personal Risk Factors
 ;;^UTILITY(U,$J,358.3,33405,1,4,0)
 ;;=4^Z91.89
 ;;^UTILITY(U,$J,358.3,33405,2)
 ;;=^5063628
 ;;^UTILITY(U,$J,358.3,33406,0)
 ;;=Z72.9^^148^1645^12
 ;;^UTILITY(U,$J,358.3,33406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33406,1,3,0)
 ;;=3^Problem Related to Lifestyle
 ;;^UTILITY(U,$J,358.3,33406,1,4,0)
 ;;=4^Z72.9
 ;;^UTILITY(U,$J,358.3,33406,2)
 ;;=^5063267
 ;;^UTILITY(U,$J,358.3,33407,0)
 ;;=Z72.811^^148^1645^1
 ;;^UTILITY(U,$J,358.3,33407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33407,1,3,0)
 ;;=3^Adult Antisocial Behavior
 ;;^UTILITY(U,$J,358.3,33407,1,4,0)
 ;;=4^Z72.811
 ;;^UTILITY(U,$J,358.3,33407,2)
 ;;=^5063263
 ;;^UTILITY(U,$J,358.3,33408,0)
 ;;=Z91.19^^148^1645^5
 ;;^UTILITY(U,$J,358.3,33408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33408,1,3,0)
 ;;=3^Nonadherence to Medical Treatment
 ;;^UTILITY(U,$J,358.3,33408,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,33408,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,33409,0)
 ;;=E66.9^^148^1645^6
