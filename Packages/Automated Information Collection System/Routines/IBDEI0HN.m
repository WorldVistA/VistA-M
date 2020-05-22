IBDEI0HN ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7682,1,3,0)
 ;;=3^Chest Pain,Other
 ;;^UTILITY(U,$J,358.3,7682,1,4,0)
 ;;=4^R07.89
 ;;^UTILITY(U,$J,358.3,7682,2)
 ;;=^5019200
 ;;^UTILITY(U,$J,358.3,7683,0)
 ;;=R07.9^^63^498^33
 ;;^UTILITY(U,$J,358.3,7683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7683,1,3,0)
 ;;=3^Chest Pain,Unspec
 ;;^UTILITY(U,$J,358.3,7683,1,4,0)
 ;;=4^R07.9
 ;;^UTILITY(U,$J,358.3,7683,2)
 ;;=^5019201
 ;;^UTILITY(U,$J,358.3,7684,0)
 ;;=I44.2^^63^498^25
 ;;^UTILITY(U,$J,358.3,7684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7684,1,3,0)
 ;;=3^Atrioventricular Block,Complete
 ;;^UTILITY(U,$J,358.3,7684,1,4,0)
 ;;=4^I44.2
 ;;^UTILITY(U,$J,358.3,7684,2)
 ;;=^259621
 ;;^UTILITY(U,$J,358.3,7685,0)
 ;;=I95.9^^63^498^53
 ;;^UTILITY(U,$J,358.3,7685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7685,1,3,0)
 ;;=3^Hypotension,Unspec
 ;;^UTILITY(U,$J,358.3,7685,1,4,0)
 ;;=4^I95.9
 ;;^UTILITY(U,$J,358.3,7685,2)
 ;;=^5008080
 ;;^UTILITY(U,$J,358.3,7686,0)
 ;;=I31.9^^63^498^66
 ;;^UTILITY(U,$J,358.3,7686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7686,1,3,0)
 ;;=3^Pericardium Disease,Unspec
 ;;^UTILITY(U,$J,358.3,7686,1,4,0)
 ;;=4^I31.9
 ;;^UTILITY(U,$J,358.3,7686,2)
 ;;=^5007165
 ;;^UTILITY(U,$J,358.3,7687,0)
 ;;=I35.0^^63^498^61
 ;;^UTILITY(U,$J,358.3,7687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7687,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,7687,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,7687,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,7688,0)
 ;;=I35.1^^63^498^60
 ;;^UTILITY(U,$J,358.3,7688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7688,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,7688,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,7688,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,7689,0)
 ;;=I35.2^^63^498^62
 ;;^UTILITY(U,$J,358.3,7689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7689,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,7689,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,7689,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,7690,0)
 ;;=I35.8^^63^498^58
 ;;^UTILITY(U,$J,358.3,7690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7690,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorders,Oth Type
 ;;^UTILITY(U,$J,358.3,7690,1,4,0)
 ;;=4^I35.8
 ;;^UTILITY(U,$J,358.3,7690,2)
 ;;=^5007177
 ;;^UTILITY(U,$J,358.3,7691,0)
 ;;=I35.9^^63^498^59
 ;;^UTILITY(U,$J,358.3,7691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7691,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorders,Unspec
 ;;^UTILITY(U,$J,358.3,7691,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,7691,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,7692,0)
 ;;=I49.5^^63^498^74
 ;;^UTILITY(U,$J,358.3,7692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7692,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,7692,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,7692,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,7693,0)
 ;;=I49.9^^63^498^28
 ;;^UTILITY(U,$J,358.3,7693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7693,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,7693,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,7693,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,7694,0)
 ;;=I71.4^^63^498^1
 ;;^UTILITY(U,$J,358.3,7694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7694,1,3,0)
 ;;=3^AAA w/o Rupture
 ;;^UTILITY(U,$J,358.3,7694,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,7694,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,7695,0)
 ;;=I34.0^^63^498^64
