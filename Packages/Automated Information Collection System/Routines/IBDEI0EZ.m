IBDEI0EZ ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6448,1,4,0)
 ;;=4^I37.1
 ;;^UTILITY(U,$J,358.3,6448,2)
 ;;=^5007185
 ;;^UTILITY(U,$J,358.3,6449,0)
 ;;=I51.1^^53^415^1
 ;;^UTILITY(U,$J,358.3,6449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6449,1,3,0)
 ;;=3^Rupture of Chordae Tendineae NEC
 ;;^UTILITY(U,$J,358.3,6449,1,4,0)
 ;;=4^I51.1
 ;;^UTILITY(U,$J,358.3,6449,2)
 ;;=^5007253
 ;;^UTILITY(U,$J,358.3,6450,0)
 ;;=I51.2^^53^415^2
 ;;^UTILITY(U,$J,358.3,6450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6450,1,3,0)
 ;;=3^Rupture of Papillary Muscle NEC
 ;;^UTILITY(U,$J,358.3,6450,1,4,0)
 ;;=4^I51.2
 ;;^UTILITY(U,$J,358.3,6450,2)
 ;;=^5007254
 ;;^UTILITY(U,$J,358.3,6451,0)
 ;;=I38.^^53^416^4
 ;;^UTILITY(U,$J,358.3,6451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6451,1,3,0)
 ;;=3^Endocarditis Valve,Unspec
 ;;^UTILITY(U,$J,358.3,6451,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,6451,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,6452,0)
 ;;=T82.01XA^^53^416^1
 ;;^UTILITY(U,$J,358.3,6452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6452,1,3,0)
 ;;=3^Breakdown of Heart Valve Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,6452,1,4,0)
 ;;=4^T82.01XA
 ;;^UTILITY(U,$J,358.3,6452,2)
 ;;=^5054668
 ;;^UTILITY(U,$J,358.3,6453,0)
 ;;=T82.02XA^^53^416^2
 ;;^UTILITY(U,$J,358.3,6453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6453,1,3,0)
 ;;=3^Displacement of Heart Valve Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,6453,1,4,0)
 ;;=4^T82.02XA
 ;;^UTILITY(U,$J,358.3,6453,2)
 ;;=^5054671
 ;;^UTILITY(U,$J,358.3,6454,0)
 ;;=T82.03XA^^53^416^5
 ;;^UTILITY(U,$J,358.3,6454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6454,1,3,0)
 ;;=3^Leakage of Heart Valve Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,6454,1,4,0)
 ;;=4^T82.03XA
 ;;^UTILITY(U,$J,358.3,6454,2)
 ;;=^5054674
 ;;^UTILITY(U,$J,358.3,6455,0)
 ;;=T82.09XA^^53^416^7
 ;;^UTILITY(U,$J,358.3,6455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6455,1,3,0)
 ;;=3^Mech Compl of Heart Valve Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,6455,1,4,0)
 ;;=4^T82.09XA
 ;;^UTILITY(U,$J,358.3,6455,2)
 ;;=^5054677
 ;;^UTILITY(U,$J,358.3,6456,0)
 ;;=T82.817A^^53^416^3
 ;;^UTILITY(U,$J,358.3,6456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6456,1,3,0)
 ;;=3^Embolism of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,6456,1,4,0)
 ;;=4^T82.817A
 ;;^UTILITY(U,$J,358.3,6456,2)
 ;;=^5054914
 ;;^UTILITY(U,$J,358.3,6457,0)
 ;;=T82.867A^^53^416^9
 ;;^UTILITY(U,$J,358.3,6457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6457,1,3,0)
 ;;=3^Thrombosis of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,6457,1,4,0)
 ;;=4^T82.867A
 ;;^UTILITY(U,$J,358.3,6457,2)
 ;;=^5054944
 ;;^UTILITY(U,$J,358.3,6458,0)
 ;;=Z95.2^^53^416^8
 ;;^UTILITY(U,$J,358.3,6458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6458,1,3,0)
 ;;=3^Presence of Prosthetic Heart Valve
 ;;^UTILITY(U,$J,358.3,6458,1,4,0)
 ;;=4^Z95.2
 ;;^UTILITY(U,$J,358.3,6458,2)
 ;;=^5063670
 ;;^UTILITY(U,$J,358.3,6459,0)
 ;;=Z79.01^^53^416^6
 ;;^UTILITY(U,$J,358.3,6459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6459,1,3,0)
 ;;=3^Long Term Current Use of Anticoagulants
 ;;^UTILITY(U,$J,358.3,6459,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,6459,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,6460,0)
 ;;=I65.1^^53^417^85
 ;;^UTILITY(U,$J,358.3,6460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6460,1,3,0)
 ;;=3^Occlusion/Stenosis of Basilar Artery
