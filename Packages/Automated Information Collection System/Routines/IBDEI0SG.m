IBDEI0SG ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13344,1,3,0)
 ;;=3^Idiopathic Pericarditis,Acute Nonspec
 ;;^UTILITY(U,$J,358.3,13344,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,13344,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,13345,0)
 ;;=I34.8^^53^592^6
 ;;^UTILITY(U,$J,358.3,13345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13345,1,3,0)
 ;;=3^Mitral Valve Disorders,Nonrheumatic Other
 ;;^UTILITY(U,$J,358.3,13345,1,4,0)
 ;;=4^I34.8
 ;;^UTILITY(U,$J,358.3,13345,2)
 ;;=^5007172
 ;;^UTILITY(U,$J,358.3,13346,0)
 ;;=I34.0^^53^592^13
 ;;^UTILITY(U,$J,358.3,13346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13346,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,13346,1,4,0)
 ;;=4^I34.0
 ;;^UTILITY(U,$J,358.3,13346,2)
 ;;=^5007169
 ;;^UTILITY(U,$J,358.3,13347,0)
 ;;=I34.9^^53^592^12
 ;;^UTILITY(U,$J,358.3,13347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13347,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,13347,1,4,0)
 ;;=4^I34.9
 ;;^UTILITY(U,$J,358.3,13347,2)
 ;;=^5007173
 ;;^UTILITY(U,$J,358.3,13348,0)
 ;;=I34.2^^53^592^7
 ;;^UTILITY(U,$J,358.3,13348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13348,1,3,0)
 ;;=3^Nonrhematic Mitral Valve Stenosis
 ;;^UTILITY(U,$J,358.3,13348,1,4,0)
 ;;=4^I34.2
 ;;^UTILITY(U,$J,358.3,13348,2)
 ;;=^5007171
 ;;^UTILITY(U,$J,358.3,13349,0)
 ;;=I35.0^^53^592^10
 ;;^UTILITY(U,$J,358.3,13349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13349,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,13349,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,13349,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,13350,0)
 ;;=I35.1^^53^592^9
 ;;^UTILITY(U,$J,358.3,13350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13350,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,13350,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,13350,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,13351,0)
 ;;=I35.2^^53^592^11
 ;;^UTILITY(U,$J,358.3,13351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13351,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,13351,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,13351,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,13352,0)
 ;;=I35.9^^53^592^8
 ;;^UTILITY(U,$J,358.3,13352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13352,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,13352,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,13352,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,13353,0)
 ;;=I38.^^53^592^4
 ;;^UTILITY(U,$J,358.3,13353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13353,1,3,0)
 ;;=3^Endocarditis,Valve Unspec
 ;;^UTILITY(U,$J,358.3,13353,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,13353,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,13354,0)
 ;;=I05.0^^53^592^18
 ;;^UTILITY(U,$J,358.3,13354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13354,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,13354,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,13354,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,13355,0)
 ;;=I05.8^^53^592^19
 ;;^UTILITY(U,$J,358.3,13355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13355,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease NEC
 ;;^UTILITY(U,$J,358.3,13355,1,4,0)
 ;;=4^I05.8
 ;;^UTILITY(U,$J,358.3,13355,2)
 ;;=^5007043
 ;;^UTILITY(U,$J,358.3,13356,0)
 ;;=I05.9^^53^592^20
 ;;^UTILITY(U,$J,358.3,13356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13356,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,13356,1,4,0)
 ;;=4^I05.9
 ;;^UTILITY(U,$J,358.3,13356,2)
 ;;=^5007044
 ;;^UTILITY(U,$J,358.3,13357,0)
 ;;=I07.1^^53^592^21
 ;;^UTILITY(U,$J,358.3,13357,1,0)
 ;;=^358.31IA^4^2
