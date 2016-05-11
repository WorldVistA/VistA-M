IBDEI2FH ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41187,1,3,0)
 ;;=3^Diastolic Heart Failure,Acute
 ;;^UTILITY(U,$J,358.3,41187,1,4,0)
 ;;=4^I50.31
 ;;^UTILITY(U,$J,358.3,41187,2)
 ;;=^5007244
 ;;^UTILITY(U,$J,358.3,41188,0)
 ;;=I30.0^^159^2003^5
 ;;^UTILITY(U,$J,358.3,41188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41188,1,3,0)
 ;;=3^Idiopathic Pericarditis,Acute Nonspec
 ;;^UTILITY(U,$J,358.3,41188,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,41188,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,41189,0)
 ;;=I34.8^^159^2003^6
 ;;^UTILITY(U,$J,358.3,41189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41189,1,3,0)
 ;;=3^Mitral Valve Disorders,Nonrheumatic Other
 ;;^UTILITY(U,$J,358.3,41189,1,4,0)
 ;;=4^I34.8
 ;;^UTILITY(U,$J,358.3,41189,2)
 ;;=^5007172
 ;;^UTILITY(U,$J,358.3,41190,0)
 ;;=I34.0^^159^2003^13
 ;;^UTILITY(U,$J,358.3,41190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41190,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,41190,1,4,0)
 ;;=4^I34.0
 ;;^UTILITY(U,$J,358.3,41190,2)
 ;;=^5007169
 ;;^UTILITY(U,$J,358.3,41191,0)
 ;;=I34.9^^159^2003^12
 ;;^UTILITY(U,$J,358.3,41191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41191,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,41191,1,4,0)
 ;;=4^I34.9
 ;;^UTILITY(U,$J,358.3,41191,2)
 ;;=^5007173
 ;;^UTILITY(U,$J,358.3,41192,0)
 ;;=I34.2^^159^2003^7
 ;;^UTILITY(U,$J,358.3,41192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41192,1,3,0)
 ;;=3^Nonrhematic Mitral Valve Stenosis
 ;;^UTILITY(U,$J,358.3,41192,1,4,0)
 ;;=4^I34.2
 ;;^UTILITY(U,$J,358.3,41192,2)
 ;;=^5007171
 ;;^UTILITY(U,$J,358.3,41193,0)
 ;;=I35.0^^159^2003^10
 ;;^UTILITY(U,$J,358.3,41193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41193,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,41193,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,41193,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,41194,0)
 ;;=I35.1^^159^2003^9
 ;;^UTILITY(U,$J,358.3,41194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41194,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,41194,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,41194,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,41195,0)
 ;;=I35.2^^159^2003^11
 ;;^UTILITY(U,$J,358.3,41195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41195,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,41195,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,41195,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,41196,0)
 ;;=I35.9^^159^2003^8
 ;;^UTILITY(U,$J,358.3,41196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41196,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,41196,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,41196,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,41197,0)
 ;;=I38.^^159^2003^4
 ;;^UTILITY(U,$J,358.3,41197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41197,1,3,0)
 ;;=3^Endocarditis,Valve Unspec
 ;;^UTILITY(U,$J,358.3,41197,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,41197,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,41198,0)
 ;;=I05.0^^159^2003^18
 ;;^UTILITY(U,$J,358.3,41198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41198,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,41198,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,41198,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,41199,0)
 ;;=I05.8^^159^2003^19
 ;;^UTILITY(U,$J,358.3,41199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41199,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease NEC
 ;;^UTILITY(U,$J,358.3,41199,1,4,0)
 ;;=4^I05.8
 ;;^UTILITY(U,$J,358.3,41199,2)
 ;;=^5007043
 ;;^UTILITY(U,$J,358.3,41200,0)
 ;;=I05.9^^159^2003^20
