IBDEI0EI ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6238,1,4,0)
 ;;=4^T82.190A
 ;;^UTILITY(U,$J,358.3,6238,2)
 ;;=^5054704
 ;;^UTILITY(U,$J,358.3,6239,0)
 ;;=T82.191A^^53^404^35
 ;;^UTILITY(U,$J,358.3,6239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6239,1,3,0)
 ;;=3^Mech Compl of Cardiac Pulse Generator,Init Encntr
 ;;^UTILITY(U,$J,358.3,6239,1,4,0)
 ;;=4^T82.191A
 ;;^UTILITY(U,$J,358.3,6239,2)
 ;;=^5054707
 ;;^UTILITY(U,$J,358.3,6240,0)
 ;;=Z95.0^^53^404^42
 ;;^UTILITY(U,$J,358.3,6240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6240,1,3,0)
 ;;=3^Presence of Cardiac Pacemaker
 ;;^UTILITY(U,$J,358.3,6240,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,6240,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,6241,0)
 ;;=Z95.810^^53^404^41
 ;;^UTILITY(U,$J,358.3,6241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6241,1,3,0)
 ;;=3^Presence of Automatic Cardiac Defibrillator
 ;;^UTILITY(U,$J,358.3,6241,1,4,0)
 ;;=4^Z95.810
 ;;^UTILITY(U,$J,358.3,6241,2)
 ;;=^5063674
 ;;^UTILITY(U,$J,358.3,6242,0)
 ;;=Z45.010^^53^404^23
 ;;^UTILITY(U,$J,358.3,6242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6242,1,3,0)
 ;;=3^Check/Test Cardiac Pacemaker Pulse Generator
 ;;^UTILITY(U,$J,358.3,6242,1,4,0)
 ;;=4^Z45.010
 ;;^UTILITY(U,$J,358.3,6242,2)
 ;;=^5062994
 ;;^UTILITY(U,$J,358.3,6243,0)
 ;;=Z45.018^^53^404^6
 ;;^UTILITY(U,$J,358.3,6243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6243,1,3,0)
 ;;=3^Adjust/Manage Cardiac Pacemaker Parts
 ;;^UTILITY(U,$J,358.3,6243,1,4,0)
 ;;=4^Z45.018
 ;;^UTILITY(U,$J,358.3,6243,2)
 ;;=^5062995
 ;;^UTILITY(U,$J,358.3,6244,0)
 ;;=Z45.02^^53^404^5
 ;;^UTILITY(U,$J,358.3,6244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6244,1,3,0)
 ;;=3^Adjust/Manage Automatic Implantable Cardiac Defibrillator
 ;;^UTILITY(U,$J,358.3,6244,1,4,0)
 ;;=4^Z45.02
 ;;^UTILITY(U,$J,358.3,6244,2)
 ;;=^5062996
 ;;^UTILITY(U,$J,358.3,6245,0)
 ;;=I48.3^^53^404^12
 ;;^UTILITY(U,$J,358.3,6245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6245,1,3,0)
 ;;=3^Atrial Flutter,Typical
 ;;^UTILITY(U,$J,358.3,6245,1,4,0)
 ;;=4^I48.3
 ;;^UTILITY(U,$J,358.3,6245,2)
 ;;=^5007227
 ;;^UTILITY(U,$J,358.3,6246,0)
 ;;=I48.4^^53^404^11
 ;;^UTILITY(U,$J,358.3,6246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6246,1,3,0)
 ;;=3^Atrial Flutter,Atypical
 ;;^UTILITY(U,$J,358.3,6246,1,4,0)
 ;;=4^I48.4
 ;;^UTILITY(U,$J,358.3,6246,2)
 ;;=^5007228
 ;;^UTILITY(U,$J,358.3,6247,0)
 ;;=I25.5^^53^404^22
 ;;^UTILITY(U,$J,358.3,6247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6247,1,3,0)
 ;;=3^Cardiomyopathy,Ischemic
 ;;^UTILITY(U,$J,358.3,6247,1,4,0)
 ;;=4^I25.5
 ;;^UTILITY(U,$J,358.3,6247,2)
 ;;=^5007115
 ;;^UTILITY(U,$J,358.3,6248,0)
 ;;=I42.0^^53^404^21
 ;;^UTILITY(U,$J,358.3,6248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6248,1,3,0)
 ;;=3^Cardiomyopathy,Dilated
 ;;^UTILITY(U,$J,358.3,6248,1,4,0)
 ;;=4^I42.0
 ;;^UTILITY(U,$J,358.3,6248,2)
 ;;=^5007194
 ;;^UTILITY(U,$J,358.3,6249,0)
 ;;=I48.20^^53^404^7
 ;;^UTILITY(U,$J,358.3,6249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6249,1,3,0)
 ;;=3^Atrial Fibrillation,Chronic,Unspec
 ;;^UTILITY(U,$J,358.3,6249,1,4,0)
 ;;=4^I48.20
 ;;^UTILITY(U,$J,358.3,6249,2)
 ;;=^5158048
 ;;^UTILITY(U,$J,358.3,6250,0)
 ;;=I48.11^^53^404^8
 ;;^UTILITY(U,$J,358.3,6250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6250,1,3,0)
 ;;=3^Atrial Fibrillation,Longstanding Persistent
 ;;^UTILITY(U,$J,358.3,6250,1,4,0)
 ;;=4^I48.11
 ;;^UTILITY(U,$J,358.3,6250,2)
 ;;=^5158046
