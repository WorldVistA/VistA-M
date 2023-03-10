IBDEI10G ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16438,2)
 ;;=^5007173
 ;;^UTILITY(U,$J,358.3,16439,0)
 ;;=I34.2^^61^774^7
 ;;^UTILITY(U,$J,358.3,16439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16439,1,3,0)
 ;;=3^Nonrhematic Mitral Valve Stenosis
 ;;^UTILITY(U,$J,358.3,16439,1,4,0)
 ;;=4^I34.2
 ;;^UTILITY(U,$J,358.3,16439,2)
 ;;=^5007171
 ;;^UTILITY(U,$J,358.3,16440,0)
 ;;=I35.0^^61^774^10
 ;;^UTILITY(U,$J,358.3,16440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16440,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,16440,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,16440,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,16441,0)
 ;;=I35.1^^61^774^9
 ;;^UTILITY(U,$J,358.3,16441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16441,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,16441,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,16441,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,16442,0)
 ;;=I35.2^^61^774^11
 ;;^UTILITY(U,$J,358.3,16442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16442,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,16442,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,16442,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,16443,0)
 ;;=I35.9^^61^774^8
 ;;^UTILITY(U,$J,358.3,16443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16443,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,16443,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,16443,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,16444,0)
 ;;=I38.^^61^774^4
 ;;^UTILITY(U,$J,358.3,16444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16444,1,3,0)
 ;;=3^Endocarditis,Valve Unspec
 ;;^UTILITY(U,$J,358.3,16444,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,16444,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,16445,0)
 ;;=I05.0^^61^774^18
 ;;^UTILITY(U,$J,358.3,16445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16445,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,16445,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,16445,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,16446,0)
 ;;=I05.8^^61^774^19
 ;;^UTILITY(U,$J,358.3,16446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16446,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease NEC
 ;;^UTILITY(U,$J,358.3,16446,1,4,0)
 ;;=4^I05.8
 ;;^UTILITY(U,$J,358.3,16446,2)
 ;;=^5007043
 ;;^UTILITY(U,$J,358.3,16447,0)
 ;;=I05.9^^61^774^20
 ;;^UTILITY(U,$J,358.3,16447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16447,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,16447,1,4,0)
 ;;=4^I05.9
 ;;^UTILITY(U,$J,358.3,16447,2)
 ;;=^5007044
 ;;^UTILITY(U,$J,358.3,16448,0)
 ;;=I07.1^^61^774^21
 ;;^UTILITY(U,$J,358.3,16448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16448,1,3,0)
 ;;=3^Rheumatic Tricuspid Insufficiency
 ;;^UTILITY(U,$J,358.3,16448,1,4,0)
 ;;=4^I07.1
 ;;^UTILITY(U,$J,358.3,16448,2)
 ;;=^5007048
 ;;^UTILITY(U,$J,358.3,16449,0)
 ;;=I07.9^^61^774^22
 ;;^UTILITY(U,$J,358.3,16449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16449,1,3,0)
 ;;=3^Rheumatic Tricuspid Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,16449,1,4,0)
 ;;=4^I07.9
 ;;^UTILITY(U,$J,358.3,16449,2)
 ;;=^5007051
 ;;^UTILITY(U,$J,358.3,16450,0)
 ;;=I08.0^^61^774^16
 ;;^UTILITY(U,$J,358.3,16450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16450,1,3,0)
 ;;=3^Rheumatic Disorders of Mitral & Aortic Valves
 ;;^UTILITY(U,$J,358.3,16450,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,16450,2)
 ;;=^5007052
