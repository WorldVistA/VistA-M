IBDEI0FA ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6581,0)
 ;;=T82.867A^^53^419^10
 ;;^UTILITY(U,$J,358.3,6581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6581,1,3,0)
 ;;=3^Thrombosis of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,6581,1,4,0)
 ;;=4^T82.867A
 ;;^UTILITY(U,$J,358.3,6581,2)
 ;;=^5054944
 ;;^UTILITY(U,$J,358.3,6582,0)
 ;;=T82.897A^^53^419^3
 ;;^UTILITY(U,$J,358.3,6582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6582,1,3,0)
 ;;=3^Complications of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,6582,1,4,0)
 ;;=4^T82.897A
 ;;^UTILITY(U,$J,358.3,6582,2)
 ;;=^5054950
 ;;^UTILITY(U,$J,358.3,6583,0)
 ;;=T82.817A^^53^419^4
 ;;^UTILITY(U,$J,358.3,6583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6583,1,3,0)
 ;;=3^Ebolism of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,6583,1,4,0)
 ;;=4^T82.817A
 ;;^UTILITY(U,$J,358.3,6583,2)
 ;;=^5054914
 ;;^UTILITY(U,$J,358.3,6584,0)
 ;;=T82.827A^^53^419^5
 ;;^UTILITY(U,$J,358.3,6584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6584,1,3,0)
 ;;=3^Fibrosis of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,6584,1,4,0)
 ;;=4^T82.827A
 ;;^UTILITY(U,$J,358.3,6584,2)
 ;;=^5054920
 ;;^UTILITY(U,$J,358.3,6585,0)
 ;;=T82.837A^^53^419^6
 ;;^UTILITY(U,$J,358.3,6585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6585,1,3,0)
 ;;=3^Hemorrhage of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,6585,1,4,0)
 ;;=4^T82.837A
 ;;^UTILITY(U,$J,358.3,6585,2)
 ;;=^5054926
 ;;^UTILITY(U,$J,358.3,6586,0)
 ;;=T82.847A^^53^419^7
 ;;^UTILITY(U,$J,358.3,6586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6586,1,3,0)
 ;;=3^Pain from Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,6586,1,4,0)
 ;;=4^T82.847A
 ;;^UTILITY(U,$J,358.3,6586,2)
 ;;=^5054932
 ;;^UTILITY(U,$J,358.3,6587,0)
 ;;=Z45.09^^53^419^1
 ;;^UTILITY(U,$J,358.3,6587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6587,1,3,0)
 ;;=3^Adjustment/Management of Cardiac Device
 ;;^UTILITY(U,$J,358.3,6587,1,4,0)
 ;;=4^Z45.09
 ;;^UTILITY(U,$J,358.3,6587,2)
 ;;=^5062997
 ;;^UTILITY(U,$J,358.3,6588,0)
 ;;=Z01.810^^53^419^8
 ;;^UTILITY(U,$J,358.3,6588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6588,1,3,0)
 ;;=3^Preprocedural Cardiovascular Examination
 ;;^UTILITY(U,$J,358.3,6588,1,4,0)
 ;;=4^Z01.810
 ;;^UTILITY(U,$J,358.3,6588,2)
 ;;=^5062625
 ;;^UTILITY(U,$J,358.3,6589,0)
 ;;=G90.01^^53^420^1
 ;;^UTILITY(U,$J,358.3,6589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6589,1,3,0)
 ;;=3^Carotid Sinus Syncope
 ;;^UTILITY(U,$J,358.3,6589,1,4,0)
 ;;=4^G90.01
 ;;^UTILITY(U,$J,358.3,6589,2)
 ;;=^5004160
 ;;^UTILITY(U,$J,358.3,6590,0)
 ;;=R55.^^53^420^2
 ;;^UTILITY(U,$J,358.3,6590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6590,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,6590,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,6590,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,6591,0)
 ;;=Z91.5^^53^421^1
 ;;^UTILITY(U,$J,358.3,6591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6591,1,3,0)
 ;;=3^Personal Hx of Suicide Attempt(s)
 ;;^UTILITY(U,$J,358.3,6591,1,4,0)
 ;;=4^Z91.5
 ;;^UTILITY(U,$J,358.3,6591,2)
 ;;=^5063624
 ;;^UTILITY(U,$J,358.3,6592,0)
 ;;=R45.851^^53^421^2
 ;;^UTILITY(U,$J,358.3,6592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6592,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,6592,1,4,0)
 ;;=4^R45.851
