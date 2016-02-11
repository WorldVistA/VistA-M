IBDEI029 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,284,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,284,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,285,0)
 ;;=F06.4^^3^36^1
 ;;^UTILITY(U,$J,358.3,285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,285,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,285,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,285,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,286,0)
 ;;=F06.1^^3^36^2
 ;;^UTILITY(U,$J,358.3,286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,286,1,3,0)
 ;;=3^Catatonia Associated w/ Schizophrenia
 ;;^UTILITY(U,$J,358.3,286,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,286,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,287,0)
 ;;=R41.9^^3^36^3
 ;;^UTILITY(U,$J,358.3,287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,287,1,3,0)
 ;;=3^Neurocognitive Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,287,1,4,0)
 ;;=4^R41.9
 ;;^UTILITY(U,$J,358.3,287,2)
 ;;=^5019449
 ;;^UTILITY(U,$J,358.3,288,0)
 ;;=F29.^^3^36^7
 ;;^UTILITY(U,$J,358.3,288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,288,1,3,0)
 ;;=3^Schizophrenia Spectrum/Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,288,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,288,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,289,0)
 ;;=F07.0^^3^36^4
 ;;^UTILITY(U,$J,358.3,289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,289,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,289,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,289,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,290,0)
 ;;=Z91.49^^3^37^9
 ;;^UTILITY(U,$J,358.3,290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,290,1,3,0)
 ;;=3^Personal Hx of Psychological Trauma
 ;;^UTILITY(U,$J,358.3,290,1,4,0)
 ;;=4^Z91.49
 ;;^UTILITY(U,$J,358.3,290,2)
 ;;=^5063623
 ;;^UTILITY(U,$J,358.3,291,0)
 ;;=Z91.5^^3^37^10
 ;;^UTILITY(U,$J,358.3,291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,291,1,3,0)
 ;;=3^Personal Hx of Self-Harm
 ;;^UTILITY(U,$J,358.3,291,1,4,0)
 ;;=4^Z91.5
 ;;^UTILITY(U,$J,358.3,291,2)
 ;;=^5063624
 ;;^UTILITY(U,$J,358.3,292,0)
 ;;=Z91.82^^3^37^8
 ;;^UTILITY(U,$J,358.3,292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,292,1,3,0)
 ;;=3^Personal Hx of Military Deployment
 ;;^UTILITY(U,$J,358.3,292,1,4,0)
 ;;=4^Z91.82
 ;;^UTILITY(U,$J,358.3,292,2)
 ;;=^5063626
 ;;^UTILITY(U,$J,358.3,293,0)
 ;;=Z91.89^^3^37^11
 ;;^UTILITY(U,$J,358.3,293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,293,1,3,0)
 ;;=3^Personal Risk Factors
 ;;^UTILITY(U,$J,358.3,293,1,4,0)
 ;;=4^Z91.89
 ;;^UTILITY(U,$J,358.3,293,2)
 ;;=^5063628
 ;;^UTILITY(U,$J,358.3,294,0)
 ;;=Z72.9^^3^37^12
 ;;^UTILITY(U,$J,358.3,294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,294,1,3,0)
 ;;=3^Problem Related to Lifestyle
 ;;^UTILITY(U,$J,358.3,294,1,4,0)
 ;;=4^Z72.9
 ;;^UTILITY(U,$J,358.3,294,2)
 ;;=^5063267
 ;;^UTILITY(U,$J,358.3,295,0)
 ;;=Z72.811^^3^37^1
 ;;^UTILITY(U,$J,358.3,295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,295,1,3,0)
 ;;=3^Adult Antisocial Behavior
 ;;^UTILITY(U,$J,358.3,295,1,4,0)
 ;;=4^Z72.811
 ;;^UTILITY(U,$J,358.3,295,2)
 ;;=^5063263
 ;;^UTILITY(U,$J,358.3,296,0)
 ;;=Z91.19^^3^37^5
 ;;^UTILITY(U,$J,358.3,296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,296,1,3,0)
 ;;=3^Nonadherence to Medical Treatment
 ;;^UTILITY(U,$J,358.3,296,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,296,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,297,0)
 ;;=E66.9^^3^37^6
 ;;^UTILITY(U,$J,358.3,297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,297,1,3,0)
 ;;=3^Obesity
 ;;^UTILITY(U,$J,358.3,297,1,4,0)
 ;;=4^E66.9
 ;;^UTILITY(U,$J,358.3,297,2)
 ;;=^5002832
 ;;^UTILITY(U,$J,358.3,298,0)
 ;;=Z76.5^^3^37^3
 ;;^UTILITY(U,$J,358.3,298,1,0)
 ;;=^358.31IA^4^2
