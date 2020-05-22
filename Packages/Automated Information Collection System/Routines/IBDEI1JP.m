IBDEI1JP ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24704,0)
 ;;=G44.301^^107^1209^6
 ;;^UTILITY(U,$J,358.3,24704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24704,1,3,0)
 ;;=3^Post-Traumatic Headache,Unspec,Intractable
 ;;^UTILITY(U,$J,358.3,24704,1,4,0)
 ;;=4^G44.301
 ;;^UTILITY(U,$J,358.3,24704,2)
 ;;=^5003941
 ;;^UTILITY(U,$J,358.3,24705,0)
 ;;=G44.209^^107^1209^8
 ;;^UTILITY(U,$J,358.3,24705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24705,1,3,0)
 ;;=3^Tension-Type Headache,Unspec,Not Intractable
 ;;^UTILITY(U,$J,358.3,24705,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,24705,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,24706,0)
 ;;=I30.0^^107^1210^5
 ;;^UTILITY(U,$J,358.3,24706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24706,1,3,0)
 ;;=3^Idiopathic Pericarditis,Acute Nonspec
 ;;^UTILITY(U,$J,358.3,24706,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,24706,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,24707,0)
 ;;=I34.8^^107^1210^6
 ;;^UTILITY(U,$J,358.3,24707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24707,1,3,0)
 ;;=3^Mitral Valve Disorders,Nonrheumatic Other
 ;;^UTILITY(U,$J,358.3,24707,1,4,0)
 ;;=4^I34.8
 ;;^UTILITY(U,$J,358.3,24707,2)
 ;;=^5007172
 ;;^UTILITY(U,$J,358.3,24708,0)
 ;;=I34.0^^107^1210^13
 ;;^UTILITY(U,$J,358.3,24708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24708,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,24708,1,4,0)
 ;;=4^I34.0
 ;;^UTILITY(U,$J,358.3,24708,2)
 ;;=^5007169
 ;;^UTILITY(U,$J,358.3,24709,0)
 ;;=I34.9^^107^1210^12
 ;;^UTILITY(U,$J,358.3,24709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24709,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24709,1,4,0)
 ;;=4^I34.9
 ;;^UTILITY(U,$J,358.3,24709,2)
 ;;=^5007173
 ;;^UTILITY(U,$J,358.3,24710,0)
 ;;=I34.2^^107^1210^7
 ;;^UTILITY(U,$J,358.3,24710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24710,1,3,0)
 ;;=3^Nonrhematic Mitral Valve Stenosis
 ;;^UTILITY(U,$J,358.3,24710,1,4,0)
 ;;=4^I34.2
 ;;^UTILITY(U,$J,358.3,24710,2)
 ;;=^5007171
 ;;^UTILITY(U,$J,358.3,24711,0)
 ;;=I35.0^^107^1210^10
 ;;^UTILITY(U,$J,358.3,24711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24711,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,24711,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,24711,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,24712,0)
 ;;=I35.1^^107^1210^9
 ;;^UTILITY(U,$J,358.3,24712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24712,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,24712,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,24712,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,24713,0)
 ;;=I35.2^^107^1210^11
 ;;^UTILITY(U,$J,358.3,24713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24713,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,24713,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,24713,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,24714,0)
 ;;=I35.9^^107^1210^8
 ;;^UTILITY(U,$J,358.3,24714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24714,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24714,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,24714,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,24715,0)
 ;;=I38.^^107^1210^4
 ;;^UTILITY(U,$J,358.3,24715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24715,1,3,0)
 ;;=3^Endocarditis,Valve Unspec
 ;;^UTILITY(U,$J,358.3,24715,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,24715,2)
 ;;=^40327
