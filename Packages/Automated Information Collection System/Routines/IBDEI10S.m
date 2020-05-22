IBDEI10S ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16400,1,3,0)
 ;;=3^Headache Syndrome NEC
 ;;^UTILITY(U,$J,358.3,16400,1,4,0)
 ;;=4^G44.89
 ;;^UTILITY(U,$J,358.3,16400,2)
 ;;=^5003954
 ;;^UTILITY(U,$J,358.3,16401,0)
 ;;=G44.84^^88^877^7
 ;;^UTILITY(U,$J,358.3,16401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16401,1,3,0)
 ;;=3^Primary Exertional Headache
 ;;^UTILITY(U,$J,358.3,16401,1,4,0)
 ;;=4^G44.84
 ;;^UTILITY(U,$J,358.3,16401,2)
 ;;=^336563
 ;;^UTILITY(U,$J,358.3,16402,0)
 ;;=G44.301^^88^877^6
 ;;^UTILITY(U,$J,358.3,16402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16402,1,3,0)
 ;;=3^Post-Traumatic Headache,Unspec,Intractable
 ;;^UTILITY(U,$J,358.3,16402,1,4,0)
 ;;=4^G44.301
 ;;^UTILITY(U,$J,358.3,16402,2)
 ;;=^5003941
 ;;^UTILITY(U,$J,358.3,16403,0)
 ;;=G44.209^^88^877^8
 ;;^UTILITY(U,$J,358.3,16403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16403,1,3,0)
 ;;=3^Tension-Type Headache,Unspec,Not Intractable
 ;;^UTILITY(U,$J,358.3,16403,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,16403,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,16404,0)
 ;;=I30.0^^88^878^5
 ;;^UTILITY(U,$J,358.3,16404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16404,1,3,0)
 ;;=3^Idiopathic Pericarditis,Acute Nonspec
 ;;^UTILITY(U,$J,358.3,16404,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,16404,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,16405,0)
 ;;=I34.8^^88^878^6
 ;;^UTILITY(U,$J,358.3,16405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16405,1,3,0)
 ;;=3^Mitral Valve Disorders,Nonrheumatic Other
 ;;^UTILITY(U,$J,358.3,16405,1,4,0)
 ;;=4^I34.8
 ;;^UTILITY(U,$J,358.3,16405,2)
 ;;=^5007172
 ;;^UTILITY(U,$J,358.3,16406,0)
 ;;=I34.0^^88^878^13
 ;;^UTILITY(U,$J,358.3,16406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16406,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,16406,1,4,0)
 ;;=4^I34.0
 ;;^UTILITY(U,$J,358.3,16406,2)
 ;;=^5007169
 ;;^UTILITY(U,$J,358.3,16407,0)
 ;;=I34.9^^88^878^12
 ;;^UTILITY(U,$J,358.3,16407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16407,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,16407,1,4,0)
 ;;=4^I34.9
 ;;^UTILITY(U,$J,358.3,16407,2)
 ;;=^5007173
 ;;^UTILITY(U,$J,358.3,16408,0)
 ;;=I34.2^^88^878^7
 ;;^UTILITY(U,$J,358.3,16408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16408,1,3,0)
 ;;=3^Nonrhematic Mitral Valve Stenosis
 ;;^UTILITY(U,$J,358.3,16408,1,4,0)
 ;;=4^I34.2
 ;;^UTILITY(U,$J,358.3,16408,2)
 ;;=^5007171
 ;;^UTILITY(U,$J,358.3,16409,0)
 ;;=I35.0^^88^878^10
 ;;^UTILITY(U,$J,358.3,16409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16409,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,16409,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,16409,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,16410,0)
 ;;=I35.1^^88^878^9
 ;;^UTILITY(U,$J,358.3,16410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16410,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,16410,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,16410,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,16411,0)
 ;;=I35.2^^88^878^11
 ;;^UTILITY(U,$J,358.3,16411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16411,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,16411,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,16411,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,16412,0)
 ;;=I35.9^^88^878^8
 ;;^UTILITY(U,$J,358.3,16412,1,0)
 ;;=^358.31IA^4^2
