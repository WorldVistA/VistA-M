IBDEI06B ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2356,1,3,0)
 ;;=3^Hyperlipidemia NEC
 ;;^UTILITY(U,$J,358.3,2356,1,4,0)
 ;;=4^E78.4
 ;;^UTILITY(U,$J,358.3,2356,2)
 ;;=^5002968
 ;;^UTILITY(U,$J,358.3,2357,0)
 ;;=E78.5^^19^198^2
 ;;^UTILITY(U,$J,358.3,2357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2357,1,3,0)
 ;;=3^Hyperlipidemia,Unspec
 ;;^UTILITY(U,$J,358.3,2357,1,4,0)
 ;;=4^E78.5
 ;;^UTILITY(U,$J,358.3,2357,2)
 ;;=^5002969
 ;;^UTILITY(U,$J,358.3,2358,0)
 ;;=E78.6^^19^198^3
 ;;^UTILITY(U,$J,358.3,2358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2358,1,3,0)
 ;;=3^Lipoprotein Deficiency
 ;;^UTILITY(U,$J,358.3,2358,1,4,0)
 ;;=4^E78.6
 ;;^UTILITY(U,$J,358.3,2358,2)
 ;;=^5002970
 ;;^UTILITY(U,$J,358.3,2359,0)
 ;;=I22.0^^19^199^7
 ;;^UTILITY(U,$J,358.3,2359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2359,1,3,0)
 ;;=3^Subsequent STEMI of Anterior Wall
 ;;^UTILITY(U,$J,358.3,2359,1,4,0)
 ;;=4^I22.0
 ;;^UTILITY(U,$J,358.3,2359,2)
 ;;=^5007089
 ;;^UTILITY(U,$J,358.3,2360,0)
 ;;=I21.09^^19^199^2
 ;;^UTILITY(U,$J,358.3,2360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2360,1,3,0)
 ;;=3^STEMI Involving Coronary Artery of Anterior Wall
 ;;^UTILITY(U,$J,358.3,2360,1,4,0)
 ;;=4^I21.09
 ;;^UTILITY(U,$J,358.3,2360,2)
 ;;=^5007082
 ;;^UTILITY(U,$J,358.3,2361,0)
 ;;=I21.02^^19^199^4
 ;;^UTILITY(U,$J,358.3,2361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2361,1,3,0)
 ;;=3^STEMI Involving Left Anterior Descending Coronary Artery
 ;;^UTILITY(U,$J,358.3,2361,1,4,0)
 ;;=4^I21.02
 ;;^UTILITY(U,$J,358.3,2361,2)
 ;;=^5007081
 ;;^UTILITY(U,$J,358.3,2362,0)
 ;;=I21.01^^19^199^5
 ;;^UTILITY(U,$J,358.3,2362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2362,1,3,0)
 ;;=3^STEMI Involving Left Main Coronary Artery
 ;;^UTILITY(U,$J,358.3,2362,1,4,0)
 ;;=4^I21.01
 ;;^UTILITY(U,$J,358.3,2362,2)
 ;;=^5007080
 ;;^UTILITY(U,$J,358.3,2363,0)
 ;;=I21.19^^19^199^3
 ;;^UTILITY(U,$J,358.3,2363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2363,1,3,0)
 ;;=3^STEMI Involving Coronary Artery of Inferior Wall
 ;;^UTILITY(U,$J,358.3,2363,1,4,0)
 ;;=4^I21.19
 ;;^UTILITY(U,$J,358.3,2363,2)
 ;;=^5007084
 ;;^UTILITY(U,$J,358.3,2364,0)
 ;;=I22.1^^19^199^8
 ;;^UTILITY(U,$J,358.3,2364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2364,1,3,0)
 ;;=3^Subsequent STEMI of Inferior Wall
 ;;^UTILITY(U,$J,358.3,2364,1,4,0)
 ;;=4^I22.1
 ;;^UTILITY(U,$J,358.3,2364,2)
 ;;=^5007090
 ;;^UTILITY(U,$J,358.3,2365,0)
 ;;=I21.4^^19^199^1
 ;;^UTILITY(U,$J,358.3,2365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2365,1,3,0)
 ;;=3^NSTEMI
 ;;^UTILITY(U,$J,358.3,2365,1,4,0)
 ;;=4^I21.4
 ;;^UTILITY(U,$J,358.3,2365,2)
 ;;=^5007088
 ;;^UTILITY(U,$J,358.3,2366,0)
 ;;=I21.3^^19^199^6
 ;;^UTILITY(U,$J,358.3,2366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2366,1,3,0)
 ;;=3^STEMI of Unspec Site
 ;;^UTILITY(U,$J,358.3,2366,1,4,0)
 ;;=4^I21.3
 ;;^UTILITY(U,$J,358.3,2366,2)
 ;;=^5007087
 ;;^UTILITY(U,$J,358.3,2367,0)
 ;;=I34.2^^19^200^2
 ;;^UTILITY(U,$J,358.3,2367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2367,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Stenosis
 ;;^UTILITY(U,$J,358.3,2367,1,4,0)
 ;;=4^I34.2
 ;;^UTILITY(U,$J,358.3,2367,2)
 ;;=^5007171
 ;;^UTILITY(U,$J,358.3,2368,0)
 ;;=I35.0^^19^200^1
 ;;^UTILITY(U,$J,358.3,2368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2368,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,2368,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,2368,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,2369,0)
 ;;=I36.1^^19^200^4
 ;;^UTILITY(U,$J,358.3,2369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2369,1,3,0)
 ;;=3^Nonrheumatic Tricuspid Valve Insufficiency
