IBDEI1WZ ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32053,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucinations d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,32053,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,32053,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,32054,0)
 ;;=F06.4^^141^1487^1
 ;;^UTILITY(U,$J,358.3,32054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32054,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,32054,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,32054,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,32055,0)
 ;;=F06.1^^141^1487^2
 ;;^UTILITY(U,$J,358.3,32055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32055,1,3,0)
 ;;=3^Catatonia Associated w/ Schizophrenia
 ;;^UTILITY(U,$J,358.3,32055,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,32055,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,32056,0)
 ;;=R41.9^^141^1487^3
 ;;^UTILITY(U,$J,358.3,32056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32056,1,3,0)
 ;;=3^Neurocognitive Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,32056,1,4,0)
 ;;=4^R41.9
 ;;^UTILITY(U,$J,358.3,32056,2)
 ;;=^5019449
 ;;^UTILITY(U,$J,358.3,32057,0)
 ;;=F29.^^141^1487^7
 ;;^UTILITY(U,$J,358.3,32057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32057,1,3,0)
 ;;=3^Schizophrenia Spectrum/Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,32057,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,32057,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,32058,0)
 ;;=F07.0^^141^1487^4
 ;;^UTILITY(U,$J,358.3,32058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32058,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,32058,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,32058,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,32059,0)
 ;;=Z91.49^^141^1488^9
 ;;^UTILITY(U,$J,358.3,32059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32059,1,3,0)
 ;;=3^Personal Hx of Psychological Trauma
 ;;^UTILITY(U,$J,358.3,32059,1,4,0)
 ;;=4^Z91.49
 ;;^UTILITY(U,$J,358.3,32059,2)
 ;;=^5063623
 ;;^UTILITY(U,$J,358.3,32060,0)
 ;;=Z91.5^^141^1488^10
 ;;^UTILITY(U,$J,358.3,32060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32060,1,3,0)
 ;;=3^Personal Hx of Self-Harm
 ;;^UTILITY(U,$J,358.3,32060,1,4,0)
 ;;=4^Z91.5
 ;;^UTILITY(U,$J,358.3,32060,2)
 ;;=^5063624
 ;;^UTILITY(U,$J,358.3,32061,0)
 ;;=Z91.82^^141^1488^8
 ;;^UTILITY(U,$J,358.3,32061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32061,1,3,0)
 ;;=3^Personal Hx of Military Deployment
 ;;^UTILITY(U,$J,358.3,32061,1,4,0)
 ;;=4^Z91.82
 ;;^UTILITY(U,$J,358.3,32061,2)
 ;;=^5063626
 ;;^UTILITY(U,$J,358.3,32062,0)
 ;;=Z91.89^^141^1488^11
 ;;^UTILITY(U,$J,358.3,32062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32062,1,3,0)
 ;;=3^Personal Risk Factors
 ;;^UTILITY(U,$J,358.3,32062,1,4,0)
 ;;=4^Z91.89
 ;;^UTILITY(U,$J,358.3,32062,2)
 ;;=^5063628
 ;;^UTILITY(U,$J,358.3,32063,0)
 ;;=Z72.9^^141^1488^12
 ;;^UTILITY(U,$J,358.3,32063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32063,1,3,0)
 ;;=3^Problem Related to Lifestyle
 ;;^UTILITY(U,$J,358.3,32063,1,4,0)
 ;;=4^Z72.9
 ;;^UTILITY(U,$J,358.3,32063,2)
 ;;=^5063267
 ;;^UTILITY(U,$J,358.3,32064,0)
 ;;=Z72.811^^141^1488^1
 ;;^UTILITY(U,$J,358.3,32064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32064,1,3,0)
 ;;=3^Adult Antisocial Behavior
 ;;^UTILITY(U,$J,358.3,32064,1,4,0)
 ;;=4^Z72.811
 ;;^UTILITY(U,$J,358.3,32064,2)
 ;;=^5063263
 ;;^UTILITY(U,$J,358.3,32065,0)
 ;;=Z91.19^^141^1488^5
 ;;^UTILITY(U,$J,358.3,32065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32065,1,3,0)
 ;;=3^Nonadherence to Medical Treatment
 ;;^UTILITY(U,$J,358.3,32065,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,32065,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,32066,0)
 ;;=E66.9^^141^1488^6
