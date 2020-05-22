IBDEI0F7 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6544,1,4,0)
 ;;=4^I77.3
 ;;^UTILITY(U,$J,358.3,6544,2)
 ;;=^5007812
 ;;^UTILITY(U,$J,358.3,6545,0)
 ;;=I77.6^^53^417^15
 ;;^UTILITY(U,$J,358.3,6545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6545,1,3,0)
 ;;=3^Arteritis,Unspec
 ;;^UTILITY(U,$J,358.3,6545,1,4,0)
 ;;=4^I77.6
 ;;^UTILITY(U,$J,358.3,6545,2)
 ;;=^5007813
 ;;^UTILITY(U,$J,358.3,6546,0)
 ;;=I82.90^^53^417^81
 ;;^UTILITY(U,$J,358.3,6546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6546,1,3,0)
 ;;=3^Embolism/Thrombosis of Unspec Vein,Acute
 ;;^UTILITY(U,$J,358.3,6546,1,4,0)
 ;;=4^I82.90
 ;;^UTILITY(U,$J,358.3,6546,2)
 ;;=^5007940
 ;;^UTILITY(U,$J,358.3,6547,0)
 ;;=I82.91^^53^417^82
 ;;^UTILITY(U,$J,358.3,6547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6547,1,3,0)
 ;;=3^Embolism/Thrombosis of Unspec Vein,Chronic
 ;;^UTILITY(U,$J,358.3,6547,1,4,0)
 ;;=4^I82.91
 ;;^UTILITY(U,$J,358.3,6547,2)
 ;;=^5007941
 ;;^UTILITY(U,$J,358.3,6548,0)
 ;;=I87.2^^53^417^108
 ;;^UTILITY(U,$J,358.3,6548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6548,1,3,0)
 ;;=3^Venous Insufficiency
 ;;^UTILITY(U,$J,358.3,6548,1,4,0)
 ;;=4^I87.2
 ;;^UTILITY(U,$J,358.3,6548,2)
 ;;=^5008047
 ;;^UTILITY(U,$J,358.3,6549,0)
 ;;=I82.0^^53^417^53
 ;;^UTILITY(U,$J,358.3,6549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6549,1,3,0)
 ;;=3^Budd-Chiari Syndrome
 ;;^UTILITY(U,$J,358.3,6549,1,4,0)
 ;;=4^I82.0
 ;;^UTILITY(U,$J,358.3,6549,2)
 ;;=^5007846
 ;;^UTILITY(U,$J,358.3,6550,0)
 ;;=I82.1^^53^417^104
 ;;^UTILITY(U,$J,358.3,6550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6550,1,3,0)
 ;;=3^Thrombophlebitis Migrans
 ;;^UTILITY(U,$J,358.3,6550,1,4,0)
 ;;=4^I82.1
 ;;^UTILITY(U,$J,358.3,6550,2)
 ;;=^5007847
 ;;^UTILITY(U,$J,358.3,6551,0)
 ;;=I82.3^^53^417^79
 ;;^UTILITY(U,$J,358.3,6551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6551,1,3,0)
 ;;=3^Embolism/Thrombosis of Renal Vein
 ;;^UTILITY(U,$J,358.3,6551,1,4,0)
 ;;=4^I82.3
 ;;^UTILITY(U,$J,358.3,6551,2)
 ;;=^269818
 ;;^UTILITY(U,$J,358.3,6552,0)
 ;;=I87.1^^53^417^107
 ;;^UTILITY(U,$J,358.3,6552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6552,1,3,0)
 ;;=3^Vein Compression
 ;;^UTILITY(U,$J,358.3,6552,1,4,0)
 ;;=4^I87.1
 ;;^UTILITY(U,$J,358.3,6552,2)
 ;;=^269850
 ;;^UTILITY(U,$J,358.3,6553,0)
 ;;=T82.818A^^53^417^75
 ;;^UTILITY(U,$J,358.3,6553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6553,1,3,0)
 ;;=3^Embolism of Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,6553,1,4,0)
 ;;=4^T82.818A
 ;;^UTILITY(U,$J,358.3,6553,2)
 ;;=^5054917
 ;;^UTILITY(U,$J,358.3,6554,0)
 ;;=T82.828A^^53^417^84
 ;;^UTILITY(U,$J,358.3,6554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6554,1,3,0)
 ;;=3^Fibrosis of Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,6554,1,4,0)
 ;;=4^T82.828A
 ;;^UTILITY(U,$J,358.3,6554,2)
 ;;=^5054923
 ;;^UTILITY(U,$J,358.3,6555,0)
 ;;=T82.868A^^53^417^105
 ;;^UTILITY(U,$J,358.3,6555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6555,1,3,0)
 ;;=3^Thrombosis of Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,6555,1,4,0)
 ;;=4^T82.868A
 ;;^UTILITY(U,$J,358.3,6555,2)
 ;;=^5054947
 ;;^UTILITY(U,$J,358.3,6556,0)
 ;;=I72.5^^53^417^7
 ;;^UTILITY(U,$J,358.3,6556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6556,1,3,0)
 ;;=3^Aneurysm of Other Precerebral Arteries
 ;;^UTILITY(U,$J,358.3,6556,1,4,0)
 ;;=4^I72.5
 ;;^UTILITY(U,$J,358.3,6556,2)
 ;;=^5138668
