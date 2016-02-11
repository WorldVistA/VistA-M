IBDEI05X ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2173,1,3,0)
 ;;=3^Persistent Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,2173,1,4,0)
 ;;=4^I48.1
 ;;^UTILITY(U,$J,358.3,2173,2)
 ;;=^5007225
 ;;^UTILITY(U,$J,358.3,2174,0)
 ;;=I49.01^^19^190^43
 ;;^UTILITY(U,$J,358.3,2174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2174,1,3,0)
 ;;=3^Ventricular Fibrillation
 ;;^UTILITY(U,$J,358.3,2174,1,4,0)
 ;;=4^I49.01
 ;;^UTILITY(U,$J,358.3,2174,2)
 ;;=^125951
 ;;^UTILITY(U,$J,358.3,2175,0)
 ;;=I49.02^^19^190^44
 ;;^UTILITY(U,$J,358.3,2175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2175,1,3,0)
 ;;=3^Ventricular Flutter
 ;;^UTILITY(U,$J,358.3,2175,1,4,0)
 ;;=4^I49.02
 ;;^UTILITY(U,$J,358.3,2175,2)
 ;;=^265315
 ;;^UTILITY(U,$J,358.3,2176,0)
 ;;=I46.9^^19^190^14
 ;;^UTILITY(U,$J,358.3,2176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2176,1,3,0)
 ;;=3^Cardiac Arrest,Cause Unspec
 ;;^UTILITY(U,$J,358.3,2176,1,4,0)
 ;;=4^I46.9
 ;;^UTILITY(U,$J,358.3,2176,2)
 ;;=^5007221
 ;;^UTILITY(U,$J,358.3,2177,0)
 ;;=I46.8^^19^190^13
 ;;^UTILITY(U,$J,358.3,2177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2177,1,3,0)
 ;;=3^Cardiac Arrest d/t Underlying Condition
 ;;^UTILITY(U,$J,358.3,2177,1,4,0)
 ;;=4^I46.8
 ;;^UTILITY(U,$J,358.3,2177,2)
 ;;=^5007220
 ;;^UTILITY(U,$J,358.3,2178,0)
 ;;=I46.2^^19^190^12
 ;;^UTILITY(U,$J,358.3,2178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2178,1,3,0)
 ;;=3^Cardiac Arrest d/t Underlying Cardiac Condition
 ;;^UTILITY(U,$J,358.3,2178,1,4,0)
 ;;=4^I46.2
 ;;^UTILITY(U,$J,358.3,2178,2)
 ;;=^5007219
 ;;^UTILITY(U,$J,358.3,2179,0)
 ;;=I49.40^^19^190^33
 ;;^UTILITY(U,$J,358.3,2179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2179,1,3,0)
 ;;=3^Premature Depolarization,Unspec
 ;;^UTILITY(U,$J,358.3,2179,1,4,0)
 ;;=4^I49.40
 ;;^UTILITY(U,$J,358.3,2179,2)
 ;;=^5007234
 ;;^UTILITY(U,$J,358.3,2180,0)
 ;;=I49.1^^19^190^7
 ;;^UTILITY(U,$J,358.3,2180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2180,1,3,0)
 ;;=3^Atrial Premature Depolarization
 ;;^UTILITY(U,$J,358.3,2180,1,4,0)
 ;;=4^I49.1
 ;;^UTILITY(U,$J,358.3,2180,2)
 ;;=^5007231
 ;;^UTILITY(U,$J,358.3,2181,0)
 ;;=I49.49^^19^190^32
 ;;^UTILITY(U,$J,358.3,2181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2181,1,3,0)
 ;;=3^Premature Depolarization NEC
 ;;^UTILITY(U,$J,358.3,2181,1,4,0)
 ;;=4^I49.49
 ;;^UTILITY(U,$J,358.3,2181,2)
 ;;=^5007235
 ;;^UTILITY(U,$J,358.3,2182,0)
 ;;=I49.5^^19^190^40
 ;;^UTILITY(U,$J,358.3,2182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2182,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,2182,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,2182,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,2183,0)
 ;;=R00.1^^19^190^9
 ;;^UTILITY(U,$J,358.3,2183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2183,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,2183,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,2183,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,2184,0)
 ;;=T82.110A^^19^190^10
 ;;^UTILITY(U,$J,358.3,2184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2184,1,3,0)
 ;;=3^Breakdown of Cardiac Electrode,Init Encntr
 ;;^UTILITY(U,$J,358.3,2184,1,4,0)
 ;;=4^T82.110A
 ;;^UTILITY(U,$J,358.3,2184,2)
 ;;=^5054680
 ;;^UTILITY(U,$J,358.3,2185,0)
 ;;=T82.111A^^19^190^11
 ;;^UTILITY(U,$J,358.3,2185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2185,1,3,0)
 ;;=3^Breakdown of Cardiac Pulse Generator,Init Encntr
 ;;^UTILITY(U,$J,358.3,2185,1,4,0)
 ;;=4^T82.111A
 ;;^UTILITY(U,$J,358.3,2185,2)
 ;;=^5054683
 ;;^UTILITY(U,$J,358.3,2186,0)
 ;;=T82.120A^^19^190^17
 ;;^UTILITY(U,$J,358.3,2186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2186,1,3,0)
 ;;=3^Displacement of Cardiac Electrode,Init Encntr
