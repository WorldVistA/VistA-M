IBDEI2UG ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,45365,1,3,0)
 ;;=3^Myocardial infarctions (STEMI), unspec site
 ;;^UTILITY(U,$J,358.3,45365,1,4,0)
 ;;=4^I21.3
 ;;^UTILITY(U,$J,358.3,45365,2)
 ;;=^5007087
 ;;^UTILITY(U,$J,358.3,45366,0)
 ;;=I25.10^^172^2266^2
 ;;^UTILITY(U,$J,358.3,45366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45366,1,3,0)
 ;;=3^Athscl hrt disease w/o angina pectoris
 ;;^UTILITY(U,$J,358.3,45366,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,45366,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,45367,0)
 ;;=I25.2^^172^2266^20
 ;;^UTILITY(U,$J,358.3,45367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45367,1,3,0)
 ;;=3^Old myocardial infarction
 ;;^UTILITY(U,$J,358.3,45367,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,45367,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,45368,0)
 ;;=I30.0^^172^2266^14
 ;;^UTILITY(U,$J,358.3,45368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45368,1,3,0)
 ;;=3^Idiopathic pericarditis, acute
 ;;^UTILITY(U,$J,358.3,45368,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,45368,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,45369,0)
 ;;=I34.1^^172^2266^19
 ;;^UTILITY(U,$J,358.3,45369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45369,1,3,0)
 ;;=3^Nonrheumatic mitral valve prolapse
 ;;^UTILITY(U,$J,358.3,45369,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,45369,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,45370,0)
 ;;=I35.0^^172^2266^17
 ;;^UTILITY(U,$J,358.3,45370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45370,1,3,0)
 ;;=3^Nonrheumatic aortic valve stenosis
 ;;^UTILITY(U,$J,358.3,45370,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,45370,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,45371,0)
 ;;=I35.2^^172^2266^18
 ;;^UTILITY(U,$J,358.3,45371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45371,1,3,0)
 ;;=3^Nonrheumatic aortic valve stenosis w/ insufficiency
 ;;^UTILITY(U,$J,358.3,45371,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,45371,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,45372,0)
 ;;=I42.8^^172^2266^7
 ;;^UTILITY(U,$J,358.3,45372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45372,1,3,0)
 ;;=3^Cardiomyopathies, other
 ;;^UTILITY(U,$J,358.3,45372,1,4,0)
 ;;=4^I42.8
 ;;^UTILITY(U,$J,358.3,45372,2)
 ;;=^5007199
 ;;^UTILITY(U,$J,358.3,45373,0)
 ;;=I48.91^^172^2266^3
 ;;^UTILITY(U,$J,358.3,45373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45373,1,3,0)
 ;;=3^Atrial fibrillation, unspec
 ;;^UTILITY(U,$J,358.3,45373,1,4,0)
 ;;=4^I48.91
 ;;^UTILITY(U,$J,358.3,45373,2)
 ;;=^5007229
 ;;^UTILITY(U,$J,358.3,45374,0)
 ;;=I48.92^^172^2266^4
 ;;^UTILITY(U,$J,358.3,45374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45374,1,3,0)
 ;;=3^Atrial flutter, unspec
 ;;^UTILITY(U,$J,358.3,45374,1,4,0)
 ;;=4^I48.92
 ;;^UTILITY(U,$J,358.3,45374,2)
 ;;=^5007230
 ;;^UTILITY(U,$J,358.3,45375,0)
 ;;=I49.3^^172^2266^23
 ;;^UTILITY(U,$J,358.3,45375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45375,1,3,0)
 ;;=3^Ventricular premature depolarization
 ;;^UTILITY(U,$J,358.3,45375,1,4,0)
 ;;=4^I49.3
 ;;^UTILITY(U,$J,358.3,45375,2)
 ;;=^5007233
 ;;^UTILITY(U,$J,358.3,45376,0)
 ;;=I50.9^^172^2266^6
 ;;^UTILITY(U,$J,358.3,45376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45376,1,3,0)
 ;;=3^CHF
 ;;^UTILITY(U,$J,358.3,45376,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,45376,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,45377,0)
 ;;=I69.928^^172^2266^22
 ;;^UTILITY(U,$J,358.3,45377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45377,1,3,0)
 ;;=3^Speech/lang deficits following unsp cerebvasc disease
