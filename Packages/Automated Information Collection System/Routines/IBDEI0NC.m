IBDEI0NC ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10665,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,10666,0)
 ;;=I50.31^^68^673^3
 ;;^UTILITY(U,$J,358.3,10666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10666,1,3,0)
 ;;=3^Diastolic Heart Failure,Acute
 ;;^UTILITY(U,$J,358.3,10666,1,4,0)
 ;;=4^I50.31
 ;;^UTILITY(U,$J,358.3,10666,2)
 ;;=^5007244
 ;;^UTILITY(U,$J,358.3,10667,0)
 ;;=I30.0^^68^674^5
 ;;^UTILITY(U,$J,358.3,10667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10667,1,3,0)
 ;;=3^Idiopathic Pericarditis,Acute Nonspec
 ;;^UTILITY(U,$J,358.3,10667,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,10667,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,10668,0)
 ;;=I34.8^^68^674^6
 ;;^UTILITY(U,$J,358.3,10668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10668,1,3,0)
 ;;=3^Mitral Valve Disorders,Nonrheumatic Other
 ;;^UTILITY(U,$J,358.3,10668,1,4,0)
 ;;=4^I34.8
 ;;^UTILITY(U,$J,358.3,10668,2)
 ;;=^5007172
 ;;^UTILITY(U,$J,358.3,10669,0)
 ;;=I34.0^^68^674^13
 ;;^UTILITY(U,$J,358.3,10669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10669,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,10669,1,4,0)
 ;;=4^I34.0
 ;;^UTILITY(U,$J,358.3,10669,2)
 ;;=^5007169
 ;;^UTILITY(U,$J,358.3,10670,0)
 ;;=I34.9^^68^674^12
 ;;^UTILITY(U,$J,358.3,10670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10670,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,10670,1,4,0)
 ;;=4^I34.9
 ;;^UTILITY(U,$J,358.3,10670,2)
 ;;=^5007173
 ;;^UTILITY(U,$J,358.3,10671,0)
 ;;=I34.2^^68^674^7
 ;;^UTILITY(U,$J,358.3,10671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10671,1,3,0)
 ;;=3^Nonrhematic Mitral Valve Stenosis
 ;;^UTILITY(U,$J,358.3,10671,1,4,0)
 ;;=4^I34.2
 ;;^UTILITY(U,$J,358.3,10671,2)
 ;;=^5007171
 ;;^UTILITY(U,$J,358.3,10672,0)
 ;;=I35.0^^68^674^10
 ;;^UTILITY(U,$J,358.3,10672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10672,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,10672,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,10672,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,10673,0)
 ;;=I35.1^^68^674^9
 ;;^UTILITY(U,$J,358.3,10673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10673,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,10673,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,10673,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,10674,0)
 ;;=I35.2^^68^674^11
 ;;^UTILITY(U,$J,358.3,10674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10674,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,10674,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,10674,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,10675,0)
 ;;=I35.9^^68^674^8
 ;;^UTILITY(U,$J,358.3,10675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10675,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,10675,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,10675,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,10676,0)
 ;;=I38.^^68^674^4
 ;;^UTILITY(U,$J,358.3,10676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10676,1,3,0)
 ;;=3^Endocarditis,Valve Unspec
 ;;^UTILITY(U,$J,358.3,10676,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,10676,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,10677,0)
 ;;=I05.0^^68^674^18
 ;;^UTILITY(U,$J,358.3,10677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10677,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,10677,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,10677,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,10678,0)
 ;;=I05.8^^68^674^19
 ;;^UTILITY(U,$J,358.3,10678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10678,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease NEC
 ;;^UTILITY(U,$J,358.3,10678,1,4,0)
 ;;=4^I05.8
