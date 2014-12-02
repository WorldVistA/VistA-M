IBDEI03F ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1243,0)
 ;;=424.90^^13^124^5
 ;;^UTILITY(U,$J,358.3,1243,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1243,1,4,0)
 ;;=4^424.90
 ;;^UTILITY(U,$J,358.3,1243,1,5,0)
 ;;=5^Endocarditis
 ;;^UTILITY(U,$J,358.3,1243,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,1244,0)
 ;;=396.1^^13^124^7
 ;;^UTILITY(U,$J,358.3,1244,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1244,1,4,0)
 ;;=4^396.1
 ;;^UTILITY(U,$J,358.3,1244,1,5,0)
 ;;=5^Mitral Sten & Aortic Insuff,Unspec Cause
 ;;^UTILITY(U,$J,358.3,1244,2)
 ;;=^269581
 ;;^UTILITY(U,$J,358.3,1245,0)
 ;;=396.2^^13^124^6
 ;;^UTILITY(U,$J,358.3,1245,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1245,1,4,0)
 ;;=4^396.2
 ;;^UTILITY(U,$J,358.3,1245,1,5,0)
 ;;=5^Mitral Insuff & Aortic Stenosis
 ;;^UTILITY(U,$J,358.3,1245,2)
 ;;=^269582
 ;;^UTILITY(U,$J,358.3,1246,0)
 ;;=396.8^^13^125^1
 ;;^UTILITY(U,$J,358.3,1246,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1246,1,4,0)
 ;;=4^396.8
 ;;^UTILITY(U,$J,358.3,1246,1,5,0)
 ;;=5^Rhem Aortic & Mitral Stenosis/Insuff
 ;;^UTILITY(U,$J,358.3,1246,2)
 ;;=^269584
 ;;^UTILITY(U,$J,358.3,1247,0)
 ;;=395.2^^13^125^2
 ;;^UTILITY(U,$J,358.3,1247,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1247,1,4,0)
 ;;=4^395.2
 ;;^UTILITY(U,$J,358.3,1247,1,5,0)
 ;;=5^Rhem Aortic Stenosis W/Insuff
 ;;^UTILITY(U,$J,358.3,1247,2)
 ;;=^269577
 ;;^UTILITY(U,$J,358.3,1248,0)
 ;;=395.9^^13^125^3
 ;;^UTILITY(U,$J,358.3,1248,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1248,1,4,0)
 ;;=4^395.9
 ;;^UTILITY(U,$J,358.3,1248,1,5,0)
 ;;=5^Rhem Aortic Disease
 ;;^UTILITY(U,$J,358.3,1248,2)
 ;;=^269578
 ;;^UTILITY(U,$J,358.3,1249,0)
 ;;=395.1^^13^125^4
 ;;^UTILITY(U,$J,358.3,1249,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1249,1,4,0)
 ;;=4^395.1
 ;;^UTILITY(U,$J,358.3,1249,1,5,0)
 ;;=5^Rhem Aortic Insuff
 ;;^UTILITY(U,$J,358.3,1249,2)
 ;;=^269575
 ;;^UTILITY(U,$J,358.3,1250,0)
 ;;=394.1^^13^125^5
 ;;^UTILITY(U,$J,358.3,1250,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1250,1,4,0)
 ;;=4^394.1
 ;;^UTILITY(U,$J,358.3,1250,1,5,0)
 ;;=5^Rhem Mitral Insuff
 ;;^UTILITY(U,$J,358.3,1250,2)
 ;;=^269568
 ;;^UTILITY(U,$J,358.3,1251,0)
 ;;=395.0^^13^125^6
 ;;^UTILITY(U,$J,358.3,1251,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1251,1,4,0)
 ;;=4^395.0
 ;;^UTILITY(U,$J,358.3,1251,1,5,0)
 ;;=5^Rhem Aortic Stenosis
 ;;^UTILITY(U,$J,358.3,1251,2)
 ;;=^269573
 ;;^UTILITY(U,$J,358.3,1252,0)
 ;;=396.3^^13^125^7
 ;;^UTILITY(U,$J,358.3,1252,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1252,1,4,0)
 ;;=4^396.3
 ;;^UTILITY(U,$J,358.3,1252,1,5,0)
 ;;=5^Aortic & Mitral Insufficiency
 ;;^UTILITY(U,$J,358.3,1252,2)
 ;;=^269583
 ;;^UTILITY(U,$J,358.3,1253,0)
 ;;=396.2^^13^125^8
 ;;^UTILITY(U,$J,358.3,1253,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1253,1,4,0)
 ;;=4^396.2
 ;;^UTILITY(U,$J,358.3,1253,1,5,0)
 ;;=5^Rhem Mitral Insuff & Aortic Stenosis
 ;;^UTILITY(U,$J,358.3,1253,2)
 ;;=^269582
 ;;^UTILITY(U,$J,358.3,1254,0)
 ;;=394.0^^13^125^9
 ;;^UTILITY(U,$J,358.3,1254,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1254,1,4,0)
 ;;=4^394.0
 ;;^UTILITY(U,$J,358.3,1254,1,5,0)
 ;;=5^Rhem Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,1254,2)
 ;;=^78404
 ;;^UTILITY(U,$J,358.3,1255,0)
 ;;=396.1^^13^125^10
 ;;^UTILITY(U,$J,358.3,1255,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1255,1,4,0)
 ;;=4^396.1
 ;;^UTILITY(U,$J,358.3,1255,1,5,0)
 ;;=5^Rhem Mitral Stenosis & Aortic Insuff
 ;;^UTILITY(U,$J,358.3,1255,2)
 ;;=^269581
 ;;^UTILITY(U,$J,358.3,1256,0)
 ;;=396.0^^13^125^11
 ;;^UTILITY(U,$J,358.3,1256,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1256,1,4,0)
 ;;=4^396.0
 ;;^UTILITY(U,$J,358.3,1256,1,5,0)
 ;;=5^Rhem Mitral & Aortic Stenosis
