IBDEI2N3 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,44299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44299,1,3,0)
 ;;=3^Systolic Heart Failure,Chronic
 ;;^UTILITY(U,$J,358.3,44299,1,4,0)
 ;;=4^I50.22
 ;;^UTILITY(U,$J,358.3,44299,2)
 ;;=^5007241
 ;;^UTILITY(U,$J,358.3,44300,0)
 ;;=I50.23^^200^2226^11
 ;;^UTILITY(U,$J,358.3,44300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44300,1,3,0)
 ;;=3^Systolic Heart Failure,Acute on Chronic
 ;;^UTILITY(U,$J,358.3,44300,1,4,0)
 ;;=4^I50.23
 ;;^UTILITY(U,$J,358.3,44300,2)
 ;;=^5007242
 ;;^UTILITY(U,$J,358.3,44301,0)
 ;;=I50.30^^200^2226^6
 ;;^UTILITY(U,$J,358.3,44301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44301,1,3,0)
 ;;=3^Diastolic Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,44301,1,4,0)
 ;;=4^I50.30
 ;;^UTILITY(U,$J,358.3,44301,2)
 ;;=^5007243
 ;;^UTILITY(U,$J,358.3,44302,0)
 ;;=I50.9^^200^2226^7
 ;;^UTILITY(U,$J,358.3,44302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44302,1,3,0)
 ;;=3^Heart Failure,Unspec (CHF Unspec)
 ;;^UTILITY(U,$J,358.3,44302,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,44302,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,44303,0)
 ;;=I50.31^^200^2226^3
 ;;^UTILITY(U,$J,358.3,44303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44303,1,3,0)
 ;;=3^Diastolic Heart Failure,Acute
 ;;^UTILITY(U,$J,358.3,44303,1,4,0)
 ;;=4^I50.31
 ;;^UTILITY(U,$J,358.3,44303,2)
 ;;=^5007244
 ;;^UTILITY(U,$J,358.3,44304,0)
 ;;=I30.0^^200^2227^5
 ;;^UTILITY(U,$J,358.3,44304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44304,1,3,0)
 ;;=3^Idiopathic Pericarditis,Acute Nonspec
 ;;^UTILITY(U,$J,358.3,44304,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,44304,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,44305,0)
 ;;=I34.8^^200^2227^6
 ;;^UTILITY(U,$J,358.3,44305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44305,1,3,0)
 ;;=3^Mitral Valve Disorders,Nonrheumatic Other
 ;;^UTILITY(U,$J,358.3,44305,1,4,0)
 ;;=4^I34.8
 ;;^UTILITY(U,$J,358.3,44305,2)
 ;;=^5007172
 ;;^UTILITY(U,$J,358.3,44306,0)
 ;;=I34.0^^200^2227^13
 ;;^UTILITY(U,$J,358.3,44306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44306,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,44306,1,4,0)
 ;;=4^I34.0
 ;;^UTILITY(U,$J,358.3,44306,2)
 ;;=^5007169
 ;;^UTILITY(U,$J,358.3,44307,0)
 ;;=I34.9^^200^2227^12
 ;;^UTILITY(U,$J,358.3,44307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44307,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,44307,1,4,0)
 ;;=4^I34.9
 ;;^UTILITY(U,$J,358.3,44307,2)
 ;;=^5007173
 ;;^UTILITY(U,$J,358.3,44308,0)
 ;;=I34.2^^200^2227^7
 ;;^UTILITY(U,$J,358.3,44308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44308,1,3,0)
 ;;=3^Nonrhematic Mitral Valve Stenosis
 ;;^UTILITY(U,$J,358.3,44308,1,4,0)
 ;;=4^I34.2
 ;;^UTILITY(U,$J,358.3,44308,2)
 ;;=^5007171
 ;;^UTILITY(U,$J,358.3,44309,0)
 ;;=I35.0^^200^2227^10
 ;;^UTILITY(U,$J,358.3,44309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44309,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,44309,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,44309,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,44310,0)
 ;;=I35.1^^200^2227^9
 ;;^UTILITY(U,$J,358.3,44310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44310,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,44310,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,44310,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,44311,0)
 ;;=I35.2^^200^2227^11
 ;;^UTILITY(U,$J,358.3,44311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44311,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,44311,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,44311,2)
 ;;=^5007176
