IBDEI16C ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19970,1,3,0)
 ;;=3^Idiopathic Pericarditis,Acute Nonspec
 ;;^UTILITY(U,$J,358.3,19970,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,19970,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,19971,0)
 ;;=I34.8^^84^928^6
 ;;^UTILITY(U,$J,358.3,19971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19971,1,3,0)
 ;;=3^Mitral Valve Disorders,Nonrheumatic Other
 ;;^UTILITY(U,$J,358.3,19971,1,4,0)
 ;;=4^I34.8
 ;;^UTILITY(U,$J,358.3,19971,2)
 ;;=^5007172
 ;;^UTILITY(U,$J,358.3,19972,0)
 ;;=I34.0^^84^928^13
 ;;^UTILITY(U,$J,358.3,19972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19972,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,19972,1,4,0)
 ;;=4^I34.0
 ;;^UTILITY(U,$J,358.3,19972,2)
 ;;=^5007169
 ;;^UTILITY(U,$J,358.3,19973,0)
 ;;=I34.9^^84^928^12
 ;;^UTILITY(U,$J,358.3,19973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19973,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,19973,1,4,0)
 ;;=4^I34.9
 ;;^UTILITY(U,$J,358.3,19973,2)
 ;;=^5007173
 ;;^UTILITY(U,$J,358.3,19974,0)
 ;;=I34.2^^84^928^7
 ;;^UTILITY(U,$J,358.3,19974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19974,1,3,0)
 ;;=3^Nonrhematic Mitral Valve Stenosis
 ;;^UTILITY(U,$J,358.3,19974,1,4,0)
 ;;=4^I34.2
 ;;^UTILITY(U,$J,358.3,19974,2)
 ;;=^5007171
 ;;^UTILITY(U,$J,358.3,19975,0)
 ;;=I35.0^^84^928^10
 ;;^UTILITY(U,$J,358.3,19975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19975,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,19975,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,19975,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,19976,0)
 ;;=I35.1^^84^928^9
 ;;^UTILITY(U,$J,358.3,19976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19976,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,19976,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,19976,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,19977,0)
 ;;=I35.2^^84^928^11
 ;;^UTILITY(U,$J,358.3,19977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19977,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,19977,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,19977,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,19978,0)
 ;;=I35.9^^84^928^8
 ;;^UTILITY(U,$J,358.3,19978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19978,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,19978,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,19978,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,19979,0)
 ;;=I38.^^84^928^4
 ;;^UTILITY(U,$J,358.3,19979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19979,1,3,0)
 ;;=3^Endocarditis,Valve Unspec
 ;;^UTILITY(U,$J,358.3,19979,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,19979,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,19980,0)
 ;;=I05.0^^84^928^18
 ;;^UTILITY(U,$J,358.3,19980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19980,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,19980,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,19980,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,19981,0)
 ;;=I05.8^^84^928^19
 ;;^UTILITY(U,$J,358.3,19981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19981,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease NEC
 ;;^UTILITY(U,$J,358.3,19981,1,4,0)
 ;;=4^I05.8
 ;;^UTILITY(U,$J,358.3,19981,2)
 ;;=^5007043
 ;;^UTILITY(U,$J,358.3,19982,0)
 ;;=I05.9^^84^928^20
 ;;^UTILITY(U,$J,358.3,19982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19982,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,19982,1,4,0)
 ;;=4^I05.9
 ;;^UTILITY(U,$J,358.3,19982,2)
 ;;=^5007044
 ;;^UTILITY(U,$J,358.3,19983,0)
 ;;=I07.1^^84^928^21
 ;;^UTILITY(U,$J,358.3,19983,1,0)
 ;;=^358.31IA^4^2
