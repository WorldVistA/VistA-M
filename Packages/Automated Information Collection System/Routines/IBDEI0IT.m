IBDEI0IT ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8466,1,3,0)
 ;;=3^Migraine,Unspec,Not Intractable
 ;;^UTILITY(U,$J,358.3,8466,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,8466,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,8467,0)
 ;;=G44.009^^39^399^1
 ;;^UTILITY(U,$J,358.3,8467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8467,1,3,0)
 ;;=3^Cluster Headache,Unspec,Not Intractable
 ;;^UTILITY(U,$J,358.3,8467,1,4,0)
 ;;=4^G44.009
 ;;^UTILITY(U,$J,358.3,8467,2)
 ;;=^5003921
 ;;^UTILITY(U,$J,358.3,8468,0)
 ;;=G44.40^^39^399^5
 ;;^UTILITY(U,$J,358.3,8468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8468,1,3,0)
 ;;=3^Medication Overuse Headache,Not Intractable
 ;;^UTILITY(U,$J,358.3,8468,1,4,0)
 ;;=4^G44.40
 ;;^UTILITY(U,$J,358.3,8468,2)
 ;;=^5003947
 ;;^UTILITY(U,$J,358.3,8469,0)
 ;;=G44.89^^39^399^2
 ;;^UTILITY(U,$J,358.3,8469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8469,1,3,0)
 ;;=3^Headache Syndrome NEC
 ;;^UTILITY(U,$J,358.3,8469,1,4,0)
 ;;=4^G44.89
 ;;^UTILITY(U,$J,358.3,8469,2)
 ;;=^5003954
 ;;^UTILITY(U,$J,358.3,8470,0)
 ;;=G44.84^^39^399^8
 ;;^UTILITY(U,$J,358.3,8470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8470,1,3,0)
 ;;=3^Primary Exertional Headache
 ;;^UTILITY(U,$J,358.3,8470,1,4,0)
 ;;=4^G44.84
 ;;^UTILITY(U,$J,358.3,8470,2)
 ;;=^336563
 ;;^UTILITY(U,$J,358.3,8471,0)
 ;;=G44.301^^39^399^7
 ;;^UTILITY(U,$J,358.3,8471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8471,1,3,0)
 ;;=3^Post-Traumatic Headache,Unspec,Intractable
 ;;^UTILITY(U,$J,358.3,8471,1,4,0)
 ;;=4^G44.301
 ;;^UTILITY(U,$J,358.3,8471,2)
 ;;=^5003941
 ;;^UTILITY(U,$J,358.3,8472,0)
 ;;=G44.209^^39^399^9
 ;;^UTILITY(U,$J,358.3,8472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8472,1,3,0)
 ;;=3^Tension-Type Headache,Unspec,Not Intractable
 ;;^UTILITY(U,$J,358.3,8472,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,8472,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,8473,0)
 ;;=R51.0^^39^399^3
 ;;^UTILITY(U,$J,358.3,8473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8473,1,3,0)
 ;;=3^Headache w/ Orthostatic Component,NEC
 ;;^UTILITY(U,$J,358.3,8473,1,4,0)
 ;;=4^R51.0
 ;;^UTILITY(U,$J,358.3,8473,2)
 ;;=^5159305
 ;;^UTILITY(U,$J,358.3,8474,0)
 ;;=R51.9^^39^399^4
 ;;^UTILITY(U,$J,358.3,8474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8474,1,3,0)
 ;;=3^Headache,Unspec
 ;;^UTILITY(U,$J,358.3,8474,1,4,0)
 ;;=4^R51.9
 ;;^UTILITY(U,$J,358.3,8474,2)
 ;;=^5159306
 ;;^UTILITY(U,$J,358.3,8475,0)
 ;;=I30.0^^39^400^5
 ;;^UTILITY(U,$J,358.3,8475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8475,1,3,0)
 ;;=3^Idiopathic Pericarditis,Acute Nonspec
 ;;^UTILITY(U,$J,358.3,8475,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,8475,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,8476,0)
 ;;=I34.8^^39^400^6
 ;;^UTILITY(U,$J,358.3,8476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8476,1,3,0)
 ;;=3^Mitral Valve Disorders,Nonrheumatic Other
 ;;^UTILITY(U,$J,358.3,8476,1,4,0)
 ;;=4^I34.8
 ;;^UTILITY(U,$J,358.3,8476,2)
 ;;=^5007172
 ;;^UTILITY(U,$J,358.3,8477,0)
 ;;=I34.0^^39^400^13
 ;;^UTILITY(U,$J,358.3,8477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8477,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,8477,1,4,0)
 ;;=4^I34.0
 ;;^UTILITY(U,$J,358.3,8477,2)
 ;;=^5007169
 ;;^UTILITY(U,$J,358.3,8478,0)
 ;;=I34.9^^39^400^12
 ;;^UTILITY(U,$J,358.3,8478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8478,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Disorder,Unspec
