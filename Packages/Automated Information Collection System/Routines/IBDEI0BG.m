IBDEI0BG ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4875,1,4,0)
 ;;=4^T82.897A
 ;;^UTILITY(U,$J,358.3,4875,2)
 ;;=^5054950
 ;;^UTILITY(U,$J,358.3,4876,0)
 ;;=T82.110A^^37^323^1
 ;;^UTILITY(U,$J,358.3,4876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4876,1,3,0)
 ;;=3^Cardiac Electrode Breakdown,Init Encntr
 ;;^UTILITY(U,$J,358.3,4876,1,4,0)
 ;;=4^T82.110A
 ;;^UTILITY(U,$J,358.3,4876,2)
 ;;=^5054680
 ;;^UTILITY(U,$J,358.3,4877,0)
 ;;=T82.111A^^37^323^4
 ;;^UTILITY(U,$J,358.3,4877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4877,1,3,0)
 ;;=3^Cardiac Pulse Generator Battery Breakdown,Init
 ;;^UTILITY(U,$J,358.3,4877,1,4,0)
 ;;=4^T82.111A
 ;;^UTILITY(U,$J,358.3,4877,2)
 ;;=^5054683
 ;;^UTILITY(U,$J,358.3,4878,0)
 ;;=T82.120A^^37^323^2
 ;;^UTILITY(U,$J,358.3,4878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4878,1,3,0)
 ;;=3^Cardiac Electrode Displacement,Init Encntr
 ;;^UTILITY(U,$J,358.3,4878,1,4,0)
 ;;=4^T82.120A
 ;;^UTILITY(U,$J,358.3,4878,2)
 ;;=^5054692
 ;;^UTILITY(U,$J,358.3,4879,0)
 ;;=T82.121A^^37^323^5
 ;;^UTILITY(U,$J,358.3,4879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4879,1,3,0)
 ;;=3^Cardiac Pulse Generator Battery Displacement,Init
 ;;^UTILITY(U,$J,358.3,4879,1,4,0)
 ;;=4^T82.121A
 ;;^UTILITY(U,$J,358.3,4879,2)
 ;;=^5054695
 ;;^UTILITY(U,$J,358.3,4880,0)
 ;;=T82.190A^^37^323^3
 ;;^UTILITY(U,$J,358.3,4880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4880,1,3,0)
 ;;=3^Cardiac Electrode Mech Complication,Init Encntr
 ;;^UTILITY(U,$J,358.3,4880,1,4,0)
 ;;=4^T82.190A
 ;;^UTILITY(U,$J,358.3,4880,2)
 ;;=^5054704
 ;;^UTILITY(U,$J,358.3,4881,0)
 ;;=T82.191A^^37^323^6
 ;;^UTILITY(U,$J,358.3,4881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4881,1,3,0)
 ;;=3^Cardiac Pulse Generator Battery Mech Complication,Init Encntr
 ;;^UTILITY(U,$J,358.3,4881,1,4,0)
 ;;=4^T82.191A
 ;;^UTILITY(U,$J,358.3,4881,2)
 ;;=^5054707
 ;;^UTILITY(U,$J,358.3,4882,0)
 ;;=T82.818A^^37^323^11
 ;;^UTILITY(U,$J,358.3,4882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4882,1,3,0)
 ;;=3^Embolism of Vascular Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,4882,1,4,0)
 ;;=4^T82.818A
 ;;^UTILITY(U,$J,358.3,4882,2)
 ;;=^5054917
 ;;^UTILITY(U,$J,358.3,4883,0)
 ;;=T82.828A^^37^323^13
 ;;^UTILITY(U,$J,358.3,4883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4883,1,3,0)
 ;;=3^Fibrosis of Vascular Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,4883,1,4,0)
 ;;=4^T82.828A
 ;;^UTILITY(U,$J,358.3,4883,2)
 ;;=^5054923
 ;;^UTILITY(U,$J,358.3,4884,0)
 ;;=T82.838A^^37^323^15
 ;;^UTILITY(U,$J,358.3,4884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4884,1,3,0)
 ;;=3^Hemorrhage of Vascular Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,4884,1,4,0)
 ;;=4^T82.838A
 ;;^UTILITY(U,$J,358.3,4884,2)
 ;;=^5054929
 ;;^UTILITY(U,$J,358.3,4885,0)
 ;;=T82.848A^^37^323^21
 ;;^UTILITY(U,$J,358.3,4885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4885,1,3,0)
 ;;=3^Pain from Vascular Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,4885,1,4,0)
 ;;=4^T82.848A
 ;;^UTILITY(U,$J,358.3,4885,2)
 ;;=^5054935
 ;;^UTILITY(U,$J,358.3,4886,0)
 ;;=T82.858A^^37^323^26
 ;;^UTILITY(U,$J,358.3,4886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4886,1,3,0)
 ;;=3^Stenosis of Vascular Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,4886,1,4,0)
 ;;=4^T82.858A
 ;;^UTILITY(U,$J,358.3,4886,2)
 ;;=^5054941
 ;;^UTILITY(U,$J,358.3,4887,0)
 ;;=T82.868A^^37^323^28
 ;;^UTILITY(U,$J,358.3,4887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4887,1,3,0)
 ;;=3^Thrombosis of Vascular Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,4887,1,4,0)
 ;;=4^T82.868A
 ;;^UTILITY(U,$J,358.3,4887,2)
 ;;=^5054947
 ;;^UTILITY(U,$J,358.3,4888,0)
 ;;=T82.898A^^37^323^8
