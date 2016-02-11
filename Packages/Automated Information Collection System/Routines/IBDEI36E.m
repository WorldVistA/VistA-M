IBDEI36E ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,53323,0)
 ;;=I34.1^^245^2680^14
 ;;^UTILITY(U,$J,358.3,53323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53323,1,3,0)
 ;;=3^Nonrheumatic mitral valve prolapse
 ;;^UTILITY(U,$J,358.3,53323,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,53323,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,53324,0)
 ;;=I35.0^^245^2680^12
 ;;^UTILITY(U,$J,358.3,53324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53324,1,3,0)
 ;;=3^Nonrheumatic aortic valve stenosis
 ;;^UTILITY(U,$J,358.3,53324,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,53324,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,53325,0)
 ;;=I35.2^^245^2680^13
 ;;^UTILITY(U,$J,358.3,53325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53325,1,3,0)
 ;;=3^Nonrheumatic aortic valve stenosis w/ insufficiency
 ;;^UTILITY(U,$J,358.3,53325,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,53325,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,53326,0)
 ;;=I42.8^^245^2680^6
 ;;^UTILITY(U,$J,358.3,53326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53326,1,3,0)
 ;;=3^Cardiomyopathies, other
 ;;^UTILITY(U,$J,358.3,53326,1,4,0)
 ;;=4^I42.8
 ;;^UTILITY(U,$J,358.3,53326,2)
 ;;=^5007199
 ;;^UTILITY(U,$J,358.3,53327,0)
 ;;=I48.91^^245^2680^3
 ;;^UTILITY(U,$J,358.3,53327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53327,1,3,0)
 ;;=3^Atrial fibrillation, unspec
 ;;^UTILITY(U,$J,358.3,53327,1,4,0)
 ;;=4^I48.91
 ;;^UTILITY(U,$J,358.3,53327,2)
 ;;=^5007229
 ;;^UTILITY(U,$J,358.3,53328,0)
 ;;=I48.92^^245^2680^4
 ;;^UTILITY(U,$J,358.3,53328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53328,1,3,0)
 ;;=3^Atrial flutter, unspec
 ;;^UTILITY(U,$J,358.3,53328,1,4,0)
 ;;=4^I48.92
 ;;^UTILITY(U,$J,358.3,53328,2)
 ;;=^5007230
 ;;^UTILITY(U,$J,358.3,53329,0)
 ;;=I49.3^^245^2680^17
 ;;^UTILITY(U,$J,358.3,53329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53329,1,3,0)
 ;;=3^Ventricular premature depolarization
 ;;^UTILITY(U,$J,358.3,53329,1,4,0)
 ;;=4^I49.3
 ;;^UTILITY(U,$J,358.3,53329,2)
 ;;=^5007233
 ;;^UTILITY(U,$J,358.3,53330,0)
 ;;=I50.9^^245^2680^5
 ;;^UTILITY(U,$J,358.3,53330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53330,1,3,0)
 ;;=3^CHF
 ;;^UTILITY(U,$J,358.3,53330,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,53330,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,53331,0)
 ;;=I69.91^^245^2680^7
 ;;^UTILITY(U,$J,358.3,53331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53331,1,3,0)
 ;;=3^Cognitive deficits following unsp cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,53331,1,4,0)
 ;;=4^I69.91
 ;;^UTILITY(U,$J,358.3,53331,2)
 ;;=^5007552
 ;;^UTILITY(U,$J,358.3,53332,0)
 ;;=I69.928^^245^2680^16
 ;;^UTILITY(U,$J,358.3,53332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53332,1,3,0)
 ;;=3^Speech/lang deficits following unsp cerebvasc disease
 ;;^UTILITY(U,$J,358.3,53332,1,4,0)
 ;;=4^I69.928
 ;;^UTILITY(U,$J,358.3,53332,2)
 ;;=^5007557
 ;;^UTILITY(U,$J,358.3,53333,0)
 ;;=K40.90^^245^2681^5
 ;;^UTILITY(U,$J,358.3,53333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53333,1,3,0)
 ;;=3^Inguinal Hernia,Unil w/o Obst/Gangr
 ;;^UTILITY(U,$J,358.3,53333,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,53333,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,53334,0)
 ;;=K40.20^^245^2681^4
 ;;^UTILITY(U,$J,358.3,53334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53334,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst/Gangr
 ;;^UTILITY(U,$J,358.3,53334,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,53334,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,53335,0)
 ;;=K42.9^^245^2681^6
 ;;^UTILITY(U,$J,358.3,53335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53335,1,3,0)
 ;;=3^Umbilical hernia w/o obstruction/gangrene
 ;;^UTILITY(U,$J,358.3,53335,1,4,0)
 ;;=4^K42.9
