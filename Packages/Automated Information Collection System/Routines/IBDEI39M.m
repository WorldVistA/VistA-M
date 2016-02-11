IBDEI39M ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,54874,1,4,0)
 ;;=4^I34.8
 ;;^UTILITY(U,$J,358.3,54874,2)
 ;;=^5007172
 ;;^UTILITY(U,$J,358.3,54875,0)
 ;;=I34.0^^256^2774^13
 ;;^UTILITY(U,$J,358.3,54875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54875,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,54875,1,4,0)
 ;;=4^I34.0
 ;;^UTILITY(U,$J,358.3,54875,2)
 ;;=^5007169
 ;;^UTILITY(U,$J,358.3,54876,0)
 ;;=I34.9^^256^2774^12
 ;;^UTILITY(U,$J,358.3,54876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54876,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,54876,1,4,0)
 ;;=4^I34.9
 ;;^UTILITY(U,$J,358.3,54876,2)
 ;;=^5007173
 ;;^UTILITY(U,$J,358.3,54877,0)
 ;;=I34.2^^256^2774^7
 ;;^UTILITY(U,$J,358.3,54877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54877,1,3,0)
 ;;=3^Nonrhematic Mitral Valve Stenosis
 ;;^UTILITY(U,$J,358.3,54877,1,4,0)
 ;;=4^I34.2
 ;;^UTILITY(U,$J,358.3,54877,2)
 ;;=^5007171
 ;;^UTILITY(U,$J,358.3,54878,0)
 ;;=I35.0^^256^2774^10
 ;;^UTILITY(U,$J,358.3,54878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54878,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,54878,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,54878,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,54879,0)
 ;;=I35.1^^256^2774^9
 ;;^UTILITY(U,$J,358.3,54879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54879,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,54879,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,54879,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,54880,0)
 ;;=I35.2^^256^2774^11
 ;;^UTILITY(U,$J,358.3,54880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54880,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,54880,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,54880,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,54881,0)
 ;;=I35.9^^256^2774^8
 ;;^UTILITY(U,$J,358.3,54881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54881,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,54881,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,54881,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,54882,0)
 ;;=I38.^^256^2774^4
 ;;^UTILITY(U,$J,358.3,54882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54882,1,3,0)
 ;;=3^Endocarditis,Valve Unspec
 ;;^UTILITY(U,$J,358.3,54882,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,54882,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,54883,0)
 ;;=I05.0^^256^2774^18
 ;;^UTILITY(U,$J,358.3,54883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54883,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,54883,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,54883,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,54884,0)
 ;;=I05.8^^256^2774^19
 ;;^UTILITY(U,$J,358.3,54884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54884,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease NEC
 ;;^UTILITY(U,$J,358.3,54884,1,4,0)
 ;;=4^I05.8
 ;;^UTILITY(U,$J,358.3,54884,2)
 ;;=^5007043
 ;;^UTILITY(U,$J,358.3,54885,0)
 ;;=I05.9^^256^2774^20
 ;;^UTILITY(U,$J,358.3,54885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54885,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,54885,1,4,0)
 ;;=4^I05.9
 ;;^UTILITY(U,$J,358.3,54885,2)
 ;;=^5007044
 ;;^UTILITY(U,$J,358.3,54886,0)
 ;;=I07.1^^256^2774^21
 ;;^UTILITY(U,$J,358.3,54886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54886,1,3,0)
 ;;=3^Rheumatic Tricuspid Insufficiency
 ;;^UTILITY(U,$J,358.3,54886,1,4,0)
 ;;=4^I07.1
 ;;^UTILITY(U,$J,358.3,54886,2)
 ;;=^5007048
 ;;^UTILITY(U,$J,358.3,54887,0)
 ;;=I07.9^^256^2774^22
 ;;^UTILITY(U,$J,358.3,54887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54887,1,3,0)
 ;;=3^Rheumatic Tricuspid Valve Disease,Unspec
