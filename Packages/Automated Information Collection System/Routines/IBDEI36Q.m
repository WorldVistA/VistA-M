IBDEI36Q ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,53482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53482,1,3,0)
 ;;=3^Varicose Veins,Asymptomatic,Left Lower Extremity
 ;;^UTILITY(U,$J,358.3,53482,1,4,0)
 ;;=4^I83.92
 ;;^UTILITY(U,$J,358.3,53482,2)
 ;;=^5008021
 ;;^UTILITY(U,$J,358.3,53483,0)
 ;;=I83.93^^245^2688^10
 ;;^UTILITY(U,$J,358.3,53483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53483,1,3,0)
 ;;=3^Varicose Veins,Asymptomatic,Bilateral Lower Extremities
 ;;^UTILITY(U,$J,358.3,53483,1,4,0)
 ;;=4^I83.93
 ;;^UTILITY(U,$J,358.3,53483,2)
 ;;=^5008022
 ;;^UTILITY(U,$J,358.3,53484,0)
 ;;=I83.019^^245^2688^9
 ;;^UTILITY(U,$J,358.3,53484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53484,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer Unspec Site
 ;;^UTILITY(U,$J,358.3,53484,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,53484,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,53485,0)
 ;;=I83.029^^245^2688^8
 ;;^UTILITY(U,$J,358.3,53485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53485,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer Unspec Site
 ;;^UTILITY(U,$J,358.3,53485,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,53485,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,53486,0)
 ;;=I71.4^^245^2688^1
 ;;^UTILITY(U,$J,358.3,53486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53486,1,3,0)
 ;;=3^AAA w/o rupture
 ;;^UTILITY(U,$J,358.3,53486,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,53486,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,53487,0)
 ;;=I73.9^^245^2688^3
 ;;^UTILITY(U,$J,358.3,53487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53487,1,3,0)
 ;;=3^PVD, unspec
 ;;^UTILITY(U,$J,358.3,53487,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,53487,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,53488,0)
 ;;=I80.201^^245^2688^4
 ;;^UTILITY(U,$J,358.3,53488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53488,1,3,0)
 ;;=3^Phlebitis & thrombophlebitis deep vessels, right lower extremity
 ;;^UTILITY(U,$J,358.3,53488,1,4,0)
 ;;=4^I80.201
 ;;^UTILITY(U,$J,358.3,53488,2)
 ;;=^5007828
 ;;^UTILITY(U,$J,358.3,53489,0)
 ;;=I80.202^^245^2688^5
 ;;^UTILITY(U,$J,358.3,53489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53489,1,3,0)
 ;;=3^Phlebitis & thrombophlebitis deep vessels, left lower extremities
 ;;^UTILITY(U,$J,358.3,53489,1,4,0)
 ;;=4^I80.202
 ;;^UTILITY(U,$J,358.3,53489,2)
 ;;=^5007829
 ;;^UTILITY(U,$J,358.3,53490,0)
 ;;=I80.203^^245^2688^6
 ;;^UTILITY(U,$J,358.3,53490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53490,1,3,0)
 ;;=3^Phlebitis & thrombophlebitis deep vessels, bilateral lower extremities
 ;;^UTILITY(U,$J,358.3,53490,1,4,0)
 ;;=4^I80.203
 ;;^UTILITY(U,$J,358.3,53490,2)
 ;;=^5007830
 ;;^UTILITY(U,$J,358.3,53491,0)
 ;;=I80.3^^245^2688^7
 ;;^UTILITY(U,$J,358.3,53491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53491,1,3,0)
 ;;=3^Phlebitis & thrombophlebitis of lower extremities, unspec
 ;;^UTILITY(U,$J,358.3,53491,1,4,0)
 ;;=4^I80.3
 ;;^UTILITY(U,$J,358.3,53491,2)
 ;;=^5007845
 ;;^UTILITY(U,$J,358.3,53492,0)
 ;;=I95.9^^245^2688^2
 ;;^UTILITY(U,$J,358.3,53492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53492,1,3,0)
 ;;=3^Hypotension, unspecified
 ;;^UTILITY(U,$J,358.3,53492,1,4,0)
 ;;=4^I95.9
 ;;^UTILITY(U,$J,358.3,53492,2)
 ;;=^5008080
 ;;^UTILITY(U,$J,358.3,53493,0)
 ;;=99441^^246^2689^1^^^^1
 ;;^UTILITY(U,$J,358.3,53493,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,53493,1,1,0)
 ;;=1^99441
 ;;^UTILITY(U,$J,358.3,53493,1,2,0)
 ;;=2^PHONE E/M 5-10 MIN
 ;;^UTILITY(U,$J,358.3,53494,0)
 ;;=99443^^246^2689^3^^^^1
 ;;^UTILITY(U,$J,358.3,53494,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,53494,1,1,0)
 ;;=1^99443
 ;;^UTILITY(U,$J,358.3,53494,1,2,0)
 ;;=2^PHONE E/M 21-30 MIN
