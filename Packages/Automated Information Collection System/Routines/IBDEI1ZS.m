IBDEI1ZS ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33803,1,3,0)
 ;;=3^Diastolic Heart Failure,Acute
 ;;^UTILITY(U,$J,358.3,33803,1,4,0)
 ;;=4^I50.31
 ;;^UTILITY(U,$J,358.3,33803,2)
 ;;=^5007244
 ;;^UTILITY(U,$J,358.3,33804,0)
 ;;=I30.0^^131^1679^5
 ;;^UTILITY(U,$J,358.3,33804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33804,1,3,0)
 ;;=3^Idiopathic Pericarditis,Acute Nonspec
 ;;^UTILITY(U,$J,358.3,33804,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,33804,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,33805,0)
 ;;=I34.8^^131^1679^6
 ;;^UTILITY(U,$J,358.3,33805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33805,1,3,0)
 ;;=3^Mitral Valve Disorders,Nonrheumatic Other
 ;;^UTILITY(U,$J,358.3,33805,1,4,0)
 ;;=4^I34.8
 ;;^UTILITY(U,$J,358.3,33805,2)
 ;;=^5007172
 ;;^UTILITY(U,$J,358.3,33806,0)
 ;;=I34.0^^131^1679^13
 ;;^UTILITY(U,$J,358.3,33806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33806,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,33806,1,4,0)
 ;;=4^I34.0
 ;;^UTILITY(U,$J,358.3,33806,2)
 ;;=^5007169
 ;;^UTILITY(U,$J,358.3,33807,0)
 ;;=I34.9^^131^1679^12
 ;;^UTILITY(U,$J,358.3,33807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33807,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,33807,1,4,0)
 ;;=4^I34.9
 ;;^UTILITY(U,$J,358.3,33807,2)
 ;;=^5007173
 ;;^UTILITY(U,$J,358.3,33808,0)
 ;;=I34.2^^131^1679^7
 ;;^UTILITY(U,$J,358.3,33808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33808,1,3,0)
 ;;=3^Nonrhematic Mitral Valve Stenosis
 ;;^UTILITY(U,$J,358.3,33808,1,4,0)
 ;;=4^I34.2
 ;;^UTILITY(U,$J,358.3,33808,2)
 ;;=^5007171
 ;;^UTILITY(U,$J,358.3,33809,0)
 ;;=I35.0^^131^1679^10
 ;;^UTILITY(U,$J,358.3,33809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33809,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,33809,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,33809,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,33810,0)
 ;;=I35.1^^131^1679^9
 ;;^UTILITY(U,$J,358.3,33810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33810,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,33810,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,33810,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,33811,0)
 ;;=I35.2^^131^1679^11
 ;;^UTILITY(U,$J,358.3,33811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33811,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,33811,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,33811,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,33812,0)
 ;;=I35.9^^131^1679^8
 ;;^UTILITY(U,$J,358.3,33812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33812,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,33812,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,33812,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,33813,0)
 ;;=I38.^^131^1679^4
 ;;^UTILITY(U,$J,358.3,33813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33813,1,3,0)
 ;;=3^Endocarditis,Valve Unspec
 ;;^UTILITY(U,$J,358.3,33813,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,33813,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,33814,0)
 ;;=I05.0^^131^1679^18
 ;;^UTILITY(U,$J,358.3,33814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33814,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,33814,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,33814,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,33815,0)
 ;;=I05.8^^131^1679^19
 ;;^UTILITY(U,$J,358.3,33815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33815,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease NEC
 ;;^UTILITY(U,$J,358.3,33815,1,4,0)
 ;;=4^I05.8
 ;;^UTILITY(U,$J,358.3,33815,2)
 ;;=^5007043
 ;;^UTILITY(U,$J,358.3,33816,0)
 ;;=I05.9^^131^1679^20
