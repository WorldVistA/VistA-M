IBDEI0RG ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12359,1,3,0)
 ;;=3^Hypertension
 ;;^UTILITY(U,$J,358.3,12359,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,12359,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,12360,0)
 ;;=I20.0^^49^598^37
 ;;^UTILITY(U,$J,358.3,12360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12360,1,3,0)
 ;;=3^Unstable Angina w/o Athscl Hrt Disease
 ;;^UTILITY(U,$J,358.3,12360,1,4,0)
 ;;=4^I20.0
 ;;^UTILITY(U,$J,358.3,12360,2)
 ;;=^5007076
 ;;^UTILITY(U,$J,358.3,12361,0)
 ;;=I20.9^^49^598^1
 ;;^UTILITY(U,$J,358.3,12361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12361,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,12361,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,12361,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,12362,0)
 ;;=I25.10^^49^598^2
 ;;^UTILITY(U,$J,358.3,12362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12362,1,3,0)
 ;;=3^Athscl Hrt Disease,Native Coronary Artery w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,12362,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,12362,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,12363,0)
 ;;=I25.9^^49^598^13
 ;;^UTILITY(U,$J,358.3,12363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12363,1,3,0)
 ;;=3^Chronic Ischemic Heart Disease,Unspec
 ;;^UTILITY(U,$J,358.3,12363,1,4,0)
 ;;=4^I25.9
 ;;^UTILITY(U,$J,358.3,12363,2)
 ;;=^5007144
 ;;^UTILITY(U,$J,358.3,12364,0)
 ;;=I35.0^^49^598^29
 ;;^UTILITY(U,$J,358.3,12364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12364,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,12364,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,12364,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,12365,0)
 ;;=I35.1^^49^598^28
 ;;^UTILITY(U,$J,358.3,12365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12365,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,12365,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,12365,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,12366,0)
 ;;=I35.2^^49^598^30
 ;;^UTILITY(U,$J,358.3,12366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12366,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,12366,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,12366,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,12367,0)
 ;;=I35.8^^49^598^26
 ;;^UTILITY(U,$J,358.3,12367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12367,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorders,Other
 ;;^UTILITY(U,$J,358.3,12367,1,4,0)
 ;;=4^I35.8
 ;;^UTILITY(U,$J,358.3,12367,2)
 ;;=^5007177
 ;;^UTILITY(U,$J,358.3,12368,0)
 ;;=I35.9^^49^598^27
 ;;^UTILITY(U,$J,358.3,12368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12368,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorders,Unspec
 ;;^UTILITY(U,$J,358.3,12368,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,12368,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,12369,0)
 ;;=I48.91^^49^598^9
 ;;^UTILITY(U,$J,358.3,12369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12369,1,3,0)
 ;;=3^Atrial Fibrillation,Unspec
 ;;^UTILITY(U,$J,358.3,12369,1,4,0)
 ;;=4^I48.91
 ;;^UTILITY(U,$J,358.3,12369,2)
 ;;=^5007229
 ;;^UTILITY(U,$J,358.3,12370,0)
 ;;=I49.9^^49^598^12
 ;;^UTILITY(U,$J,358.3,12370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12370,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,12370,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,12370,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,12371,0)
 ;;=I50.9^^49^598^21
 ;;^UTILITY(U,$J,358.3,12371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12371,1,3,0)
 ;;=3^Heart Failure,Unspec
