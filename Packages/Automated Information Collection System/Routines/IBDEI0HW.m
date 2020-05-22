IBDEI0HW ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7795,0)
 ;;=T82.827A^^63^503^12
 ;;^UTILITY(U,$J,358.3,7795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7795,1,3,0)
 ;;=3^Fibrosis of Cardiac Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,7795,1,4,0)
 ;;=4^T82.827A
 ;;^UTILITY(U,$J,358.3,7795,2)
 ;;=^5054920
 ;;^UTILITY(U,$J,358.3,7796,0)
 ;;=T82.837A^^63^503^14
 ;;^UTILITY(U,$J,358.3,7796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7796,1,3,0)
 ;;=3^Hemorrhage of Cardiac Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,7796,1,4,0)
 ;;=4^T82.837A
 ;;^UTILITY(U,$J,358.3,7796,2)
 ;;=^5054926
 ;;^UTILITY(U,$J,358.3,7797,0)
 ;;=T82.847A^^63^503^23
 ;;^UTILITY(U,$J,358.3,7797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7797,1,3,0)
 ;;=3^Pain from Cardiac Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,7797,1,4,0)
 ;;=4^T82.847A
 ;;^UTILITY(U,$J,358.3,7797,2)
 ;;=^5054932
 ;;^UTILITY(U,$J,358.3,7798,0)
 ;;=T82.857A^^63^503^34
 ;;^UTILITY(U,$J,358.3,7798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7798,1,3,0)
 ;;=3^Stenosis of Cardiac Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,7798,1,4,0)
 ;;=4^T82.857A
 ;;^UTILITY(U,$J,358.3,7798,2)
 ;;=^5054938
 ;;^UTILITY(U,$J,358.3,7799,0)
 ;;=T82.867A^^63^503^36
 ;;^UTILITY(U,$J,358.3,7799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7799,1,3,0)
 ;;=3^Thrombosis of Cardiac Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,7799,1,4,0)
 ;;=4^T82.867A
 ;;^UTILITY(U,$J,358.3,7799,2)
 ;;=^5054944
 ;;^UTILITY(U,$J,358.3,7800,0)
 ;;=T82.897A^^63^503^9
 ;;^UTILITY(U,$J,358.3,7800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7800,1,3,0)
 ;;=3^Complications of Cardiac Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,7800,1,4,0)
 ;;=4^T82.897A
 ;;^UTILITY(U,$J,358.3,7800,2)
 ;;=^5054950
 ;;^UTILITY(U,$J,358.3,7801,0)
 ;;=T82.110A^^63^503^1
 ;;^UTILITY(U,$J,358.3,7801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7801,1,3,0)
 ;;=3^Cardiac Electrode Breakdown,Init Encntr
 ;;^UTILITY(U,$J,358.3,7801,1,4,0)
 ;;=4^T82.110A
 ;;^UTILITY(U,$J,358.3,7801,2)
 ;;=^5054680
 ;;^UTILITY(U,$J,358.3,7802,0)
 ;;=T82.111A^^63^503^4
 ;;^UTILITY(U,$J,358.3,7802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7802,1,3,0)
 ;;=3^Cardiac Pulse Generator Battery Breakdown,Init
 ;;^UTILITY(U,$J,358.3,7802,1,4,0)
 ;;=4^T82.111A
 ;;^UTILITY(U,$J,358.3,7802,2)
 ;;=^5054683
 ;;^UTILITY(U,$J,358.3,7803,0)
 ;;=T82.120A^^63^503^2
 ;;^UTILITY(U,$J,358.3,7803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7803,1,3,0)
 ;;=3^Cardiac Electrode Displacement,Init Encntr
 ;;^UTILITY(U,$J,358.3,7803,1,4,0)
 ;;=4^T82.120A
 ;;^UTILITY(U,$J,358.3,7803,2)
 ;;=^5054692
 ;;^UTILITY(U,$J,358.3,7804,0)
 ;;=T82.121A^^63^503^5
 ;;^UTILITY(U,$J,358.3,7804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7804,1,3,0)
 ;;=3^Cardiac Pulse Generator Battery Displacement,Init
 ;;^UTILITY(U,$J,358.3,7804,1,4,0)
 ;;=4^T82.121A
 ;;^UTILITY(U,$J,358.3,7804,2)
 ;;=^5054695
 ;;^UTILITY(U,$J,358.3,7805,0)
 ;;=T82.190A^^63^503^3
 ;;^UTILITY(U,$J,358.3,7805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7805,1,3,0)
 ;;=3^Cardiac Electrode Mech Complication,Init Encntr
 ;;^UTILITY(U,$J,358.3,7805,1,4,0)
 ;;=4^T82.190A
 ;;^UTILITY(U,$J,358.3,7805,2)
 ;;=^5054704
 ;;^UTILITY(U,$J,358.3,7806,0)
 ;;=T82.191A^^63^503^6
 ;;^UTILITY(U,$J,358.3,7806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7806,1,3,0)
 ;;=3^Cardiac Pulse Generator Battery Mech Complication,Init Encntr
 ;;^UTILITY(U,$J,358.3,7806,1,4,0)
 ;;=4^T82.191A
