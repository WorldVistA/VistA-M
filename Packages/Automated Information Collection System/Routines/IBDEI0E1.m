IBDEI0E1 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6452,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,6452,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,6453,0)
 ;;=I50.31^^30^394^3
 ;;^UTILITY(U,$J,358.3,6453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6453,1,3,0)
 ;;=3^Diastolic Heart Failure,Acute
 ;;^UTILITY(U,$J,358.3,6453,1,4,0)
 ;;=4^I50.31
 ;;^UTILITY(U,$J,358.3,6453,2)
 ;;=^5007244
 ;;^UTILITY(U,$J,358.3,6454,0)
 ;;=I30.0^^30^395^5
 ;;^UTILITY(U,$J,358.3,6454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6454,1,3,0)
 ;;=3^Idiopathic Pericarditis,Acute Nonspec
 ;;^UTILITY(U,$J,358.3,6454,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,6454,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,6455,0)
 ;;=I34.8^^30^395^6
 ;;^UTILITY(U,$J,358.3,6455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6455,1,3,0)
 ;;=3^Mitral Valve Disorders,Nonrheumatic Other
 ;;^UTILITY(U,$J,358.3,6455,1,4,0)
 ;;=4^I34.8
 ;;^UTILITY(U,$J,358.3,6455,2)
 ;;=^5007172
 ;;^UTILITY(U,$J,358.3,6456,0)
 ;;=I34.0^^30^395^13
 ;;^UTILITY(U,$J,358.3,6456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6456,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,6456,1,4,0)
 ;;=4^I34.0
 ;;^UTILITY(U,$J,358.3,6456,2)
 ;;=^5007169
 ;;^UTILITY(U,$J,358.3,6457,0)
 ;;=I34.9^^30^395^12
 ;;^UTILITY(U,$J,358.3,6457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6457,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,6457,1,4,0)
 ;;=4^I34.9
 ;;^UTILITY(U,$J,358.3,6457,2)
 ;;=^5007173
 ;;^UTILITY(U,$J,358.3,6458,0)
 ;;=I34.2^^30^395^7
 ;;^UTILITY(U,$J,358.3,6458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6458,1,3,0)
 ;;=3^Nonrhematic Mitral Valve Stenosis
 ;;^UTILITY(U,$J,358.3,6458,1,4,0)
 ;;=4^I34.2
 ;;^UTILITY(U,$J,358.3,6458,2)
 ;;=^5007171
 ;;^UTILITY(U,$J,358.3,6459,0)
 ;;=I35.0^^30^395^10
 ;;^UTILITY(U,$J,358.3,6459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6459,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,6459,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,6459,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,6460,0)
 ;;=I35.1^^30^395^9
 ;;^UTILITY(U,$J,358.3,6460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6460,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,6460,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,6460,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,6461,0)
 ;;=I35.2^^30^395^11
 ;;^UTILITY(U,$J,358.3,6461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6461,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,6461,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,6461,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,6462,0)
 ;;=I35.9^^30^395^8
 ;;^UTILITY(U,$J,358.3,6462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6462,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,6462,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,6462,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,6463,0)
 ;;=I38.^^30^395^4
 ;;^UTILITY(U,$J,358.3,6463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6463,1,3,0)
 ;;=3^Endocarditis,Valve Unspec
 ;;^UTILITY(U,$J,358.3,6463,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,6463,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,6464,0)
 ;;=I05.0^^30^395^18
 ;;^UTILITY(U,$J,358.3,6464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6464,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,6464,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,6464,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,6465,0)
 ;;=I05.8^^30^395^19
 ;;^UTILITY(U,$J,358.3,6465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6465,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease NEC
 ;;^UTILITY(U,$J,358.3,6465,1,4,0)
 ;;=4^I05.8
