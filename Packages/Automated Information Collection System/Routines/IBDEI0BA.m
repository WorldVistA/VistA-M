IBDEI0BA ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4796,0)
 ;;=I44.2^^37^318^17
 ;;^UTILITY(U,$J,358.3,4796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4796,1,3,0)
 ;;=3^Atrioventricular Block,Complete
 ;;^UTILITY(U,$J,358.3,4796,1,4,0)
 ;;=4^I44.2
 ;;^UTILITY(U,$J,358.3,4796,2)
 ;;=^259621
 ;;^UTILITY(U,$J,358.3,4797,0)
 ;;=I95.9^^37^318^31
 ;;^UTILITY(U,$J,358.3,4797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4797,1,3,0)
 ;;=3^Hypotension,Unspec
 ;;^UTILITY(U,$J,358.3,4797,1,4,0)
 ;;=4^I95.9
 ;;^UTILITY(U,$J,358.3,4797,2)
 ;;=^5008080
 ;;^UTILITY(U,$J,358.3,4798,0)
 ;;=I31.9^^37^318^43
 ;;^UTILITY(U,$J,358.3,4798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4798,1,3,0)
 ;;=3^Pericardium Disease,Unspec
 ;;^UTILITY(U,$J,358.3,4798,1,4,0)
 ;;=4^I31.9
 ;;^UTILITY(U,$J,358.3,4798,2)
 ;;=^5007165
 ;;^UTILITY(U,$J,358.3,4799,0)
 ;;=I35.0^^37^318^38
 ;;^UTILITY(U,$J,358.3,4799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4799,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,4799,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,4799,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,4800,0)
 ;;=I35.1^^37^318^37
 ;;^UTILITY(U,$J,358.3,4800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4800,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,4800,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,4800,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,4801,0)
 ;;=I35.2^^37^318^39
 ;;^UTILITY(U,$J,358.3,4801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4801,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,4801,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,4801,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,4802,0)
 ;;=I35.8^^37^318^35
 ;;^UTILITY(U,$J,358.3,4802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4802,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorders,Oth Type
 ;;^UTILITY(U,$J,358.3,4802,1,4,0)
 ;;=4^I35.8
 ;;^UTILITY(U,$J,358.3,4802,2)
 ;;=^5007177
 ;;^UTILITY(U,$J,358.3,4803,0)
 ;;=I35.9^^37^318^36
 ;;^UTILITY(U,$J,358.3,4803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4803,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorders,Unspec
 ;;^UTILITY(U,$J,358.3,4803,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,4803,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,4804,0)
 ;;=I49.5^^37^318^47
 ;;^UTILITY(U,$J,358.3,4804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4804,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,4804,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,4804,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,4805,0)
 ;;=I49.9^^37^318^19
 ;;^UTILITY(U,$J,358.3,4805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4805,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,4805,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,4805,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,4806,0)
 ;;=I71.4^^37^318^1
 ;;^UTILITY(U,$J,358.3,4806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4806,1,3,0)
 ;;=3^AAA w/o Rupture
 ;;^UTILITY(U,$J,358.3,4806,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,4806,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,4807,0)
 ;;=I34.0^^37^318^41
 ;;^UTILITY(U,$J,358.3,4807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4807,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,4807,1,4,0)
 ;;=4^I34.0
 ;;^UTILITY(U,$J,358.3,4807,2)
 ;;=^5007169
 ;;^UTILITY(U,$J,358.3,4808,0)
 ;;=I34.8^^37^318^40
 ;;^UTILITY(U,$J,358.3,4808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4808,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Disorders,Oth Type
 ;;^UTILITY(U,$J,358.3,4808,1,4,0)
 ;;=4^I34.8
 ;;^UTILITY(U,$J,358.3,4808,2)
 ;;=^5007172
 ;;^UTILITY(U,$J,358.3,4809,0)
 ;;=I70.211^^37^318^13
 ;;^UTILITY(U,$J,358.3,4809,1,0)
 ;;=^358.31IA^4^2
