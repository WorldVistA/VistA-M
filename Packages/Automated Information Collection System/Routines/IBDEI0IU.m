IBDEI0IU ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8478,1,4,0)
 ;;=4^I34.9
 ;;^UTILITY(U,$J,358.3,8478,2)
 ;;=^5007173
 ;;^UTILITY(U,$J,358.3,8479,0)
 ;;=I34.2^^39^400^7
 ;;^UTILITY(U,$J,358.3,8479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8479,1,3,0)
 ;;=3^Nonrhematic Mitral Valve Stenosis
 ;;^UTILITY(U,$J,358.3,8479,1,4,0)
 ;;=4^I34.2
 ;;^UTILITY(U,$J,358.3,8479,2)
 ;;=^5007171
 ;;^UTILITY(U,$J,358.3,8480,0)
 ;;=I35.0^^39^400^10
 ;;^UTILITY(U,$J,358.3,8480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8480,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,8480,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,8480,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,8481,0)
 ;;=I35.1^^39^400^9
 ;;^UTILITY(U,$J,358.3,8481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8481,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,8481,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,8481,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,8482,0)
 ;;=I35.2^^39^400^11
 ;;^UTILITY(U,$J,358.3,8482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8482,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,8482,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,8482,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,8483,0)
 ;;=I35.9^^39^400^8
 ;;^UTILITY(U,$J,358.3,8483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8483,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,8483,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,8483,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,8484,0)
 ;;=I38.^^39^400^4
 ;;^UTILITY(U,$J,358.3,8484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8484,1,3,0)
 ;;=3^Endocarditis,Valve Unspec
 ;;^UTILITY(U,$J,358.3,8484,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,8484,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,8485,0)
 ;;=I05.0^^39^400^18
 ;;^UTILITY(U,$J,358.3,8485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8485,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,8485,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,8485,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,8486,0)
 ;;=I05.8^^39^400^19
 ;;^UTILITY(U,$J,358.3,8486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8486,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease NEC
 ;;^UTILITY(U,$J,358.3,8486,1,4,0)
 ;;=4^I05.8
 ;;^UTILITY(U,$J,358.3,8486,2)
 ;;=^5007043
 ;;^UTILITY(U,$J,358.3,8487,0)
 ;;=I05.9^^39^400^20
 ;;^UTILITY(U,$J,358.3,8487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8487,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,8487,1,4,0)
 ;;=4^I05.9
 ;;^UTILITY(U,$J,358.3,8487,2)
 ;;=^5007044
 ;;^UTILITY(U,$J,358.3,8488,0)
 ;;=I07.1^^39^400^21
 ;;^UTILITY(U,$J,358.3,8488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8488,1,3,0)
 ;;=3^Rheumatic Tricuspid Insufficiency
 ;;^UTILITY(U,$J,358.3,8488,1,4,0)
 ;;=4^I07.1
 ;;^UTILITY(U,$J,358.3,8488,2)
 ;;=^5007048
 ;;^UTILITY(U,$J,358.3,8489,0)
 ;;=I07.9^^39^400^22
 ;;^UTILITY(U,$J,358.3,8489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8489,1,3,0)
 ;;=3^Rheumatic Tricuspid Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,8489,1,4,0)
 ;;=4^I07.9
 ;;^UTILITY(U,$J,358.3,8489,2)
 ;;=^5007051
 ;;^UTILITY(U,$J,358.3,8490,0)
 ;;=I08.0^^39^400^16
 ;;^UTILITY(U,$J,358.3,8490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8490,1,3,0)
 ;;=3^Rheumatic Disorders of Mitral & Aortic Valves
 ;;^UTILITY(U,$J,358.3,8490,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,8490,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,8491,0)
 ;;=I09.89^^39^400^17
