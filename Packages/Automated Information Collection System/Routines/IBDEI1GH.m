IBDEI1GH ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24731,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,24731,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,24732,0)
 ;;=F06.0^^93^1103^6
 ;;^UTILITY(U,$J,358.3,24732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24732,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucinations d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,24732,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,24732,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,24733,0)
 ;;=F06.4^^93^1103^1
 ;;^UTILITY(U,$J,358.3,24733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24733,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,24733,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,24733,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,24734,0)
 ;;=F06.1^^93^1103^2
 ;;^UTILITY(U,$J,358.3,24734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24734,1,3,0)
 ;;=3^Catatonia Associated w/ Schizophrenia
 ;;^UTILITY(U,$J,358.3,24734,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,24734,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,24735,0)
 ;;=R41.9^^93^1103^3
 ;;^UTILITY(U,$J,358.3,24735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24735,1,3,0)
 ;;=3^Neurocognitive Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24735,1,4,0)
 ;;=4^R41.9
 ;;^UTILITY(U,$J,358.3,24735,2)
 ;;=^5019449
 ;;^UTILITY(U,$J,358.3,24736,0)
 ;;=F29.^^93^1103^7
 ;;^UTILITY(U,$J,358.3,24736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24736,1,3,0)
 ;;=3^Schizophrenia Spectrum/Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24736,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,24736,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,24737,0)
 ;;=F07.0^^93^1103^4
 ;;^UTILITY(U,$J,358.3,24737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24737,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,24737,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,24737,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,24738,0)
 ;;=Z91.49^^93^1104^12
 ;;^UTILITY(U,$J,358.3,24738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24738,1,3,0)
 ;;=3^Personal Hx of Psychological Trauma
 ;;^UTILITY(U,$J,358.3,24738,1,4,0)
 ;;=4^Z91.49
 ;;^UTILITY(U,$J,358.3,24738,2)
 ;;=^5063623
 ;;^UTILITY(U,$J,358.3,24739,0)
 ;;=Z91.5^^93^1104^13
 ;;^UTILITY(U,$J,358.3,24739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24739,1,3,0)
 ;;=3^Personal Hx of Self-Harm
 ;;^UTILITY(U,$J,358.3,24739,1,4,0)
 ;;=4^Z91.5
 ;;^UTILITY(U,$J,358.3,24739,2)
 ;;=^5063624
 ;;^UTILITY(U,$J,358.3,24740,0)
 ;;=Z91.82^^93^1104^11
 ;;^UTILITY(U,$J,358.3,24740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24740,1,3,0)
 ;;=3^Personal Hx of Military Deployment
 ;;^UTILITY(U,$J,358.3,24740,1,4,0)
 ;;=4^Z91.82
 ;;^UTILITY(U,$J,358.3,24740,2)
 ;;=^5063626
 ;;^UTILITY(U,$J,358.3,24741,0)
 ;;=Z91.89^^93^1104^14
 ;;^UTILITY(U,$J,358.3,24741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24741,1,3,0)
 ;;=3^Personal Risk Factors
 ;;^UTILITY(U,$J,358.3,24741,1,4,0)
 ;;=4^Z91.89
 ;;^UTILITY(U,$J,358.3,24741,2)
 ;;=^5063628
 ;;^UTILITY(U,$J,358.3,24742,0)
 ;;=Z72.9^^93^1104^15
 ;;^UTILITY(U,$J,358.3,24742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24742,1,3,0)
 ;;=3^Problem Related to Lifestyle
 ;;^UTILITY(U,$J,358.3,24742,1,4,0)
 ;;=4^Z72.9
 ;;^UTILITY(U,$J,358.3,24742,2)
 ;;=^5063267
 ;;^UTILITY(U,$J,358.3,24743,0)
 ;;=Z72.811^^93^1104^1
 ;;^UTILITY(U,$J,358.3,24743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24743,1,3,0)
 ;;=3^Adult Antisocial Behavior
 ;;^UTILITY(U,$J,358.3,24743,1,4,0)
 ;;=4^Z72.811
 ;;^UTILITY(U,$J,358.3,24743,2)
 ;;=^5063263
 ;;^UTILITY(U,$J,358.3,24744,0)
 ;;=Z91.19^^93^1104^5
 ;;^UTILITY(U,$J,358.3,24744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24744,1,3,0)
 ;;=3^Nonadherence to Medical Treatment
