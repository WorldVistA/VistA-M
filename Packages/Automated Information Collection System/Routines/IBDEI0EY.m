IBDEI0EY ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6436,1,3,0)
 ;;=3^Subsequent STEMI of Other Sites
 ;;^UTILITY(U,$J,358.3,6436,1,4,0)
 ;;=4^I22.8
 ;;^UTILITY(U,$J,358.3,6436,2)
 ;;=^5007092
 ;;^UTILITY(U,$J,358.3,6437,0)
 ;;=I22.9^^53^413^15
 ;;^UTILITY(U,$J,358.3,6437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6437,1,3,0)
 ;;=3^Subsequent STEMI of Unspec Site
 ;;^UTILITY(U,$J,358.3,6437,1,4,0)
 ;;=4^I22.9
 ;;^UTILITY(U,$J,358.3,6437,2)
 ;;=^5007093
 ;;^UTILITY(U,$J,358.3,6438,0)
 ;;=I34.2^^53^414^6
 ;;^UTILITY(U,$J,358.3,6438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6438,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Stenosis
 ;;^UTILITY(U,$J,358.3,6438,1,4,0)
 ;;=4^I34.2
 ;;^UTILITY(U,$J,358.3,6438,2)
 ;;=^5007171
 ;;^UTILITY(U,$J,358.3,6439,0)
 ;;=I35.0^^53^414^2
 ;;^UTILITY(U,$J,358.3,6439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6439,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,6439,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,6439,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,6440,0)
 ;;=I36.1^^53^414^9
 ;;^UTILITY(U,$J,358.3,6440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6440,1,3,0)
 ;;=3^Nonrheumatic Tricuspid Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,6440,1,4,0)
 ;;=4^I36.1
 ;;^UTILITY(U,$J,358.3,6440,2)
 ;;=^5007180
 ;;^UTILITY(U,$J,358.3,6441,0)
 ;;=I35.1^^53^414^1
 ;;^UTILITY(U,$J,358.3,6441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6441,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,6441,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,6441,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,6442,0)
 ;;=I35.2^^53^414^3
 ;;^UTILITY(U,$J,358.3,6442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6442,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,6442,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,6442,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,6443,0)
 ;;=I51.1^^53^414^11
 ;;^UTILITY(U,$J,358.3,6443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6443,1,3,0)
 ;;=3^Rupture of Chordae Tendineae NEC
 ;;^UTILITY(U,$J,358.3,6443,1,4,0)
 ;;=4^I51.1
 ;;^UTILITY(U,$J,358.3,6443,2)
 ;;=^5007253
 ;;^UTILITY(U,$J,358.3,6444,0)
 ;;=I34.0^^53^414^4
 ;;^UTILITY(U,$J,358.3,6444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6444,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,6444,1,4,0)
 ;;=4^I34.0
 ;;^UTILITY(U,$J,358.3,6444,2)
 ;;=^5007169
 ;;^UTILITY(U,$J,358.3,6445,0)
 ;;=I34.1^^53^414^5
 ;;^UTILITY(U,$J,358.3,6445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6445,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,6445,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,6445,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,6446,0)
 ;;=I36.0^^53^414^10
 ;;^UTILITY(U,$J,358.3,6446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6446,1,3,0)
 ;;=3^Nonrheumatic Tricuspid Valve Stenosis
 ;;^UTILITY(U,$J,358.3,6446,1,4,0)
 ;;=4^I36.0
 ;;^UTILITY(U,$J,358.3,6446,2)
 ;;=^5007179
 ;;^UTILITY(U,$J,358.3,6447,0)
 ;;=I37.0^^53^414^8
 ;;^UTILITY(U,$J,358.3,6447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6447,1,3,0)
 ;;=3^Nonrheumatic Pulmonary Valve Stenosis
 ;;^UTILITY(U,$J,358.3,6447,1,4,0)
 ;;=4^I37.0
 ;;^UTILITY(U,$J,358.3,6447,2)
 ;;=^5007184
 ;;^UTILITY(U,$J,358.3,6448,0)
 ;;=I37.1^^53^414^7
 ;;^UTILITY(U,$J,358.3,6448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6448,1,3,0)
 ;;=3^Nonrheumatic Pulmonary Valve Insufficiency
