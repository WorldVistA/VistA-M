IBDEI1I6 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25116,1,3,0)
 ;;=3^Complications of Surgical/Medical Care NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,25116,1,4,0)
 ;;=4^T88.8XXA
 ;;^UTILITY(U,$J,358.3,25116,2)
 ;;=^5055814
 ;;^UTILITY(U,$J,358.3,25117,0)
 ;;=T81.4XXA^^124^1239^91
 ;;^UTILITY(U,$J,358.3,25117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25117,1,3,0)
 ;;=3^Infection Following a Procedure,Init Encntr
 ;;^UTILITY(U,$J,358.3,25117,1,4,0)
 ;;=4^T81.4XXA
 ;;^UTILITY(U,$J,358.3,25117,2)
 ;;=^5054479
 ;;^UTILITY(U,$J,358.3,25118,0)
 ;;=T81.83XA^^124^1239^163
 ;;^UTILITY(U,$J,358.3,25118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25118,1,3,0)
 ;;=3^Persistent Postprocedural Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,25118,1,4,0)
 ;;=4^T81.83XA
 ;;^UTILITY(U,$J,358.3,25118,2)
 ;;=^5054659
 ;;^UTILITY(U,$J,358.3,25119,0)
 ;;=T81.89XA^^124^1239^30
 ;;^UTILITY(U,$J,358.3,25119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25119,1,3,0)
 ;;=3^Complications of Procedures NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,25119,1,4,0)
 ;;=4^T81.89XA
 ;;^UTILITY(U,$J,358.3,25119,2)
 ;;=^5054662
 ;;^UTILITY(U,$J,358.3,25120,0)
 ;;=T81.9XXA^^124^1239^29
 ;;^UTILITY(U,$J,358.3,25120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25120,1,3,0)
 ;;=3^Complications of Procedure Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,25120,1,4,0)
 ;;=4^T81.9XXA
 ;;^UTILITY(U,$J,358.3,25120,2)
 ;;=^5054665
 ;;^UTILITY(U,$J,358.3,25121,0)
 ;;=I05.0^^124^1240^38
 ;;^UTILITY(U,$J,358.3,25121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25121,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,25121,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,25121,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,25122,0)
 ;;=I08.0^^124^1240^39
 ;;^UTILITY(U,$J,358.3,25122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25122,1,3,0)
 ;;=3^Rheumatic Mitral/Aortic Valve Disorders
 ;;^UTILITY(U,$J,358.3,25122,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,25122,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,25123,0)
 ;;=I25.10^^124^1240^10
 ;;^UTILITY(U,$J,358.3,25123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25123,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,25123,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,25123,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,25124,0)
 ;;=I31.9^^124^1240^32
 ;;^UTILITY(U,$J,358.3,25124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25124,1,3,0)
 ;;=3^Pericardium Disease,Unspec
 ;;^UTILITY(U,$J,358.3,25124,1,4,0)
 ;;=4^I31.9
 ;;^UTILITY(U,$J,358.3,25124,2)
 ;;=^5007165
 ;;^UTILITY(U,$J,358.3,25125,0)
 ;;=I34.1^^124^1240^26
 ;;^UTILITY(U,$J,358.3,25125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25125,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,25125,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,25125,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,25126,0)
 ;;=I35.0^^124^1240^25
 ;;^UTILITY(U,$J,358.3,25126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25126,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,25126,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,25126,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,25127,0)
 ;;=I35.1^^124^1240^24
 ;;^UTILITY(U,$J,358.3,25127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25127,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,25127,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,25127,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,25128,0)
 ;;=I42.1^^124^1240^27
 ;;^UTILITY(U,$J,358.3,25128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25128,1,3,0)
 ;;=3^Obstructive Hypertrophic Cardiomyopathy
