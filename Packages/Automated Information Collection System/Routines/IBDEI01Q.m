IBDEI01Q ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,313,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,313,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,314,0)
 ;;=R41.9^^3^36^3
 ;;^UTILITY(U,$J,358.3,314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,314,1,3,0)
 ;;=3^Neurocognitive Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,314,1,4,0)
 ;;=4^R41.9
 ;;^UTILITY(U,$J,358.3,314,2)
 ;;=^5019449
 ;;^UTILITY(U,$J,358.3,315,0)
 ;;=F29.^^3^36^7
 ;;^UTILITY(U,$J,358.3,315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,315,1,3,0)
 ;;=3^Schizophrenia Spectrum/Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,315,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,315,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,316,0)
 ;;=F07.0^^3^36^4
 ;;^UTILITY(U,$J,358.3,316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,316,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,316,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,316,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,317,0)
 ;;=Z91.49^^3^37^12
 ;;^UTILITY(U,$J,358.3,317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,317,1,3,0)
 ;;=3^Personal Hx of Psychological Trauma
 ;;^UTILITY(U,$J,358.3,317,1,4,0)
 ;;=4^Z91.49
 ;;^UTILITY(U,$J,358.3,317,2)
 ;;=^5063623
 ;;^UTILITY(U,$J,358.3,318,0)
 ;;=Z91.5^^3^37^13
 ;;^UTILITY(U,$J,358.3,318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,318,1,3,0)
 ;;=3^Personal Hx of Self-Harm
 ;;^UTILITY(U,$J,358.3,318,1,4,0)
 ;;=4^Z91.5
 ;;^UTILITY(U,$J,358.3,318,2)
 ;;=^5063624
 ;;^UTILITY(U,$J,358.3,319,0)
 ;;=Z91.82^^3^37^11
 ;;^UTILITY(U,$J,358.3,319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,319,1,3,0)
 ;;=3^Personal Hx of Military Deployment
 ;;^UTILITY(U,$J,358.3,319,1,4,0)
 ;;=4^Z91.82
 ;;^UTILITY(U,$J,358.3,319,2)
 ;;=^5063626
 ;;^UTILITY(U,$J,358.3,320,0)
 ;;=Z91.89^^3^37^14
 ;;^UTILITY(U,$J,358.3,320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,320,1,3,0)
 ;;=3^Personal Risk Factors
 ;;^UTILITY(U,$J,358.3,320,1,4,0)
 ;;=4^Z91.89
 ;;^UTILITY(U,$J,358.3,320,2)
 ;;=^5063628
 ;;^UTILITY(U,$J,358.3,321,0)
 ;;=Z72.9^^3^37^15
 ;;^UTILITY(U,$J,358.3,321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,321,1,3,0)
 ;;=3^Problem Related to Lifestyle
 ;;^UTILITY(U,$J,358.3,321,1,4,0)
 ;;=4^Z72.9
 ;;^UTILITY(U,$J,358.3,321,2)
 ;;=^5063267
 ;;^UTILITY(U,$J,358.3,322,0)
 ;;=Z72.811^^3^37^1
 ;;^UTILITY(U,$J,358.3,322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,322,1,3,0)
 ;;=3^Adult Antisocial Behavior
 ;;^UTILITY(U,$J,358.3,322,1,4,0)
 ;;=4^Z72.811
 ;;^UTILITY(U,$J,358.3,322,2)
 ;;=^5063263
 ;;^UTILITY(U,$J,358.3,323,0)
 ;;=Z91.19^^3^37^5
 ;;^UTILITY(U,$J,358.3,323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,323,1,3,0)
 ;;=3^Nonadherence to Medical Treatment
 ;;^UTILITY(U,$J,358.3,323,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,323,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,324,0)
 ;;=E66.9^^3^37^6
 ;;^UTILITY(U,$J,358.3,324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,324,1,3,0)
 ;;=3^Obesity
 ;;^UTILITY(U,$J,358.3,324,1,4,0)
 ;;=4^E66.9
 ;;^UTILITY(U,$J,358.3,324,2)
 ;;=^5002832
 ;;^UTILITY(U,$J,358.3,325,0)
 ;;=Z76.5^^3^37^3
 ;;^UTILITY(U,$J,358.3,325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,325,1,3,0)
 ;;=3^Malingering
 ;;^UTILITY(U,$J,358.3,325,1,4,0)
 ;;=4^Z76.5
 ;;^UTILITY(U,$J,358.3,325,2)
 ;;=^5063302
 ;;^UTILITY(U,$J,358.3,326,0)
 ;;=R41.83^^3^37^2
 ;;^UTILITY(U,$J,358.3,326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,326,1,3,0)
 ;;=3^Borderline Intellectual Functioning
 ;;^UTILITY(U,$J,358.3,326,1,4,0)
 ;;=4^R41.83
 ;;^UTILITY(U,$J,358.3,326,2)
 ;;=^5019442
 ;;^UTILITY(U,$J,358.3,327,0)
 ;;=Z56.82^^3^37^4
 ;;^UTILITY(U,$J,358.3,327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,327,1,3,0)
 ;;=3^Military Deployment Status,Current
