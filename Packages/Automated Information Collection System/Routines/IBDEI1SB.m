IBDEI1SB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29877,1,4,0)
 ;;=4^I34.8
 ;;^UTILITY(U,$J,358.3,29877,2)
 ;;=^5007172
 ;;^UTILITY(U,$J,358.3,29878,0)
 ;;=I34.0^^135^1371^13
 ;;^UTILITY(U,$J,358.3,29878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29878,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,29878,1,4,0)
 ;;=4^I34.0
 ;;^UTILITY(U,$J,358.3,29878,2)
 ;;=^5007169
 ;;^UTILITY(U,$J,358.3,29879,0)
 ;;=I34.9^^135^1371^12
 ;;^UTILITY(U,$J,358.3,29879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29879,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,29879,1,4,0)
 ;;=4^I34.9
 ;;^UTILITY(U,$J,358.3,29879,2)
 ;;=^5007173
 ;;^UTILITY(U,$J,358.3,29880,0)
 ;;=I34.2^^135^1371^7
 ;;^UTILITY(U,$J,358.3,29880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29880,1,3,0)
 ;;=3^Nonrhematic Mitral Valve Stenosis
 ;;^UTILITY(U,$J,358.3,29880,1,4,0)
 ;;=4^I34.2
 ;;^UTILITY(U,$J,358.3,29880,2)
 ;;=^5007171
 ;;^UTILITY(U,$J,358.3,29881,0)
 ;;=I35.0^^135^1371^10
 ;;^UTILITY(U,$J,358.3,29881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29881,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,29881,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,29881,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,29882,0)
 ;;=I35.1^^135^1371^9
 ;;^UTILITY(U,$J,358.3,29882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29882,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,29882,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,29882,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,29883,0)
 ;;=I35.2^^135^1371^11
 ;;^UTILITY(U,$J,358.3,29883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29883,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,29883,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,29883,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,29884,0)
 ;;=I35.9^^135^1371^8
 ;;^UTILITY(U,$J,358.3,29884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29884,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,29884,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,29884,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,29885,0)
 ;;=I38.^^135^1371^4
 ;;^UTILITY(U,$J,358.3,29885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29885,1,3,0)
 ;;=3^Endocarditis,Valve Unspec
 ;;^UTILITY(U,$J,358.3,29885,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,29885,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,29886,0)
 ;;=I05.0^^135^1371^18
 ;;^UTILITY(U,$J,358.3,29886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29886,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,29886,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,29886,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,29887,0)
 ;;=I05.8^^135^1371^19
 ;;^UTILITY(U,$J,358.3,29887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29887,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease NEC
 ;;^UTILITY(U,$J,358.3,29887,1,4,0)
 ;;=4^I05.8
 ;;^UTILITY(U,$J,358.3,29887,2)
 ;;=^5007043
 ;;^UTILITY(U,$J,358.3,29888,0)
 ;;=I05.9^^135^1371^20
 ;;^UTILITY(U,$J,358.3,29888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29888,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,29888,1,4,0)
 ;;=4^I05.9
 ;;^UTILITY(U,$J,358.3,29888,2)
 ;;=^5007044
 ;;^UTILITY(U,$J,358.3,29889,0)
 ;;=I07.1^^135^1371^21
 ;;^UTILITY(U,$J,358.3,29889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29889,1,3,0)
 ;;=3^Rheumatic Tricuspid Insufficiency
 ;;^UTILITY(U,$J,358.3,29889,1,4,0)
 ;;=4^I07.1
 ;;^UTILITY(U,$J,358.3,29889,2)
 ;;=^5007048
 ;;^UTILITY(U,$J,358.3,29890,0)
 ;;=I07.9^^135^1371^22
 ;;^UTILITY(U,$J,358.3,29890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29890,1,3,0)
 ;;=3^Rheumatic Tricuspid Valve Disease,Unspec
