IBDEI1BA ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22300,0)
 ;;=I35.1^^87^980^9
 ;;^UTILITY(U,$J,358.3,22300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22300,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,22300,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,22300,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,22301,0)
 ;;=I35.2^^87^980^11
 ;;^UTILITY(U,$J,358.3,22301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22301,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,22301,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,22301,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,22302,0)
 ;;=I35.9^^87^980^8
 ;;^UTILITY(U,$J,358.3,22302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22302,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,22302,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,22302,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,22303,0)
 ;;=I38.^^87^980^4
 ;;^UTILITY(U,$J,358.3,22303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22303,1,3,0)
 ;;=3^Endocarditis,Valve Unspec
 ;;^UTILITY(U,$J,358.3,22303,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,22303,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,22304,0)
 ;;=I05.0^^87^980^18
 ;;^UTILITY(U,$J,358.3,22304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22304,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,22304,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,22304,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,22305,0)
 ;;=I05.8^^87^980^19
 ;;^UTILITY(U,$J,358.3,22305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22305,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease NEC
 ;;^UTILITY(U,$J,358.3,22305,1,4,0)
 ;;=4^I05.8
 ;;^UTILITY(U,$J,358.3,22305,2)
 ;;=^5007043
 ;;^UTILITY(U,$J,358.3,22306,0)
 ;;=I05.9^^87^980^20
 ;;^UTILITY(U,$J,358.3,22306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22306,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,22306,1,4,0)
 ;;=4^I05.9
 ;;^UTILITY(U,$J,358.3,22306,2)
 ;;=^5007044
 ;;^UTILITY(U,$J,358.3,22307,0)
 ;;=I07.1^^87^980^21
 ;;^UTILITY(U,$J,358.3,22307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22307,1,3,0)
 ;;=3^Rheumatic Tricuspid Insufficiency
 ;;^UTILITY(U,$J,358.3,22307,1,4,0)
 ;;=4^I07.1
 ;;^UTILITY(U,$J,358.3,22307,2)
 ;;=^5007048
 ;;^UTILITY(U,$J,358.3,22308,0)
 ;;=I07.9^^87^980^22
 ;;^UTILITY(U,$J,358.3,22308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22308,1,3,0)
 ;;=3^Rheumatic Tricuspid Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,22308,1,4,0)
 ;;=4^I07.9
 ;;^UTILITY(U,$J,358.3,22308,2)
 ;;=^5007051
 ;;^UTILITY(U,$J,358.3,22309,0)
 ;;=I08.0^^87^980^16
 ;;^UTILITY(U,$J,358.3,22309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22309,1,3,0)
 ;;=3^Rheumatic Disorders of Mitral & Aortic Valves
 ;;^UTILITY(U,$J,358.3,22309,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,22309,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,22310,0)
 ;;=I09.89^^87^980^17
 ;;^UTILITY(U,$J,358.3,22310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22310,1,3,0)
 ;;=3^Rheumatic Heart Diseases NEC
 ;;^UTILITY(U,$J,358.3,22310,1,4,0)
 ;;=4^I09.89
 ;;^UTILITY(U,$J,358.3,22310,2)
 ;;=^5007060
 ;;^UTILITY(U,$J,358.3,22311,0)
 ;;=I47.1^^87^980^24
 ;;^UTILITY(U,$J,358.3,22311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22311,1,3,0)
 ;;=3^Supraventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,22311,1,4,0)
 ;;=4^I47.1
 ;;^UTILITY(U,$J,358.3,22311,2)
 ;;=^5007223
 ;;^UTILITY(U,$J,358.3,22312,0)
 ;;=I48.0^^87^980^15
 ;;^UTILITY(U,$J,358.3,22312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22312,1,3,0)
 ;;=3^Paroxysmal Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,22312,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,22312,2)
 ;;=^90473
