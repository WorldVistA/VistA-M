IBDEI063 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2249,1,4,0)
 ;;=4^I27.89
 ;;^UTILITY(U,$J,358.3,2249,2)
 ;;=^5007153
 ;;^UTILITY(U,$J,358.3,2250,0)
 ;;=I27.81^^19^192^18
 ;;^UTILITY(U,$J,358.3,2250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2250,1,3,0)
 ;;=3^Cor Pulmonale,Chronic
 ;;^UTILITY(U,$J,358.3,2250,1,4,0)
 ;;=4^I27.81
 ;;^UTILITY(U,$J,358.3,2250,2)
 ;;=^5007152
 ;;^UTILITY(U,$J,358.3,2251,0)
 ;;=I42.1^^19^192^36
 ;;^UTILITY(U,$J,358.3,2251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2251,1,3,0)
 ;;=3^Obstructive Hypertrophic Cardiomyopathy
 ;;^UTILITY(U,$J,358.3,2251,1,4,0)
 ;;=4^I42.1
 ;;^UTILITY(U,$J,358.3,2251,2)
 ;;=^340520
 ;;^UTILITY(U,$J,358.3,2252,0)
 ;;=I42.2^^19^192^31
 ;;^UTILITY(U,$J,358.3,2252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2252,1,3,0)
 ;;=3^Hypertrophic Cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,2252,1,4,0)
 ;;=4^I42.2
 ;;^UTILITY(U,$J,358.3,2252,2)
 ;;=^340521
 ;;^UTILITY(U,$J,358.3,2253,0)
 ;;=I42.5^^19^192^51
 ;;^UTILITY(U,$J,358.3,2253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2253,1,3,0)
 ;;=3^Restrictive Cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,2253,1,4,0)
 ;;=4^I42.5
 ;;^UTILITY(U,$J,358.3,2253,2)
 ;;=^5007196
 ;;^UTILITY(U,$J,358.3,2254,0)
 ;;=I42.6^^19^192^4
 ;;^UTILITY(U,$J,358.3,2254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2254,1,3,0)
 ;;=3^Alcoholic Cardiomyopathy
 ;;^UTILITY(U,$J,358.3,2254,1,4,0)
 ;;=4^I42.6
 ;;^UTILITY(U,$J,358.3,2254,2)
 ;;=^5007197
 ;;^UTILITY(U,$J,358.3,2255,0)
 ;;=I43.^^19^192^8
 ;;^UTILITY(U,$J,358.3,2255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2255,1,3,0)
 ;;=3^Cardiomyopathy in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,2255,1,4,0)
 ;;=4^I43.
 ;;^UTILITY(U,$J,358.3,2255,2)
 ;;=^5007201
 ;;^UTILITY(U,$J,358.3,2256,0)
 ;;=I42.7^^19^192^7
 ;;^UTILITY(U,$J,358.3,2256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2256,1,3,0)
 ;;=3^Cardiomyopathy d/t Drug/External Agent
 ;;^UTILITY(U,$J,358.3,2256,1,4,0)
 ;;=4^I42.7
 ;;^UTILITY(U,$J,358.3,2256,2)
 ;;=^5007198
 ;;^UTILITY(U,$J,358.3,2257,0)
 ;;=I42.9^^19^192^9
 ;;^UTILITY(U,$J,358.3,2257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2257,1,3,0)
 ;;=3^Cardiomyopathy,Unspec
 ;;^UTILITY(U,$J,358.3,2257,1,4,0)
 ;;=4^I42.9
 ;;^UTILITY(U,$J,358.3,2257,2)
 ;;=^5007200
 ;;^UTILITY(U,$J,358.3,2258,0)
 ;;=I50.9^^19^192^22
 ;;^UTILITY(U,$J,358.3,2258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2258,1,3,0)
 ;;=3^Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,2258,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,2258,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,2259,0)
 ;;=I50.1^^19^192^33
 ;;^UTILITY(U,$J,358.3,2259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2259,1,3,0)
 ;;=3^Left Ventricular Failure
 ;;^UTILITY(U,$J,358.3,2259,1,4,0)
 ;;=4^I50.1
 ;;^UTILITY(U,$J,358.3,2259,2)
 ;;=^5007238
 ;;^UTILITY(U,$J,358.3,2260,0)
 ;;=I50.20^^19^192^55
 ;;^UTILITY(U,$J,358.3,2260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2260,1,3,0)
 ;;=3^Systolic Congestive Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,2260,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,2260,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,2261,0)
 ;;=I50.30^^19^192^19
 ;;^UTILITY(U,$J,358.3,2261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2261,1,3,0)
 ;;=3^Diastolic Congestive Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,2261,1,4,0)
 ;;=4^I50.30
 ;;^UTILITY(U,$J,358.3,2261,2)
 ;;=^5007243
 ;;^UTILITY(U,$J,358.3,2262,0)
 ;;=I50.40^^19^192^54
 ;;^UTILITY(U,$J,358.3,2262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2262,1,3,0)
 ;;=3^Systolic & Diastolic Congestive Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,2262,1,4,0)
 ;;=4^I50.40
 ;;^UTILITY(U,$J,358.3,2262,2)
 ;;=^5007247
