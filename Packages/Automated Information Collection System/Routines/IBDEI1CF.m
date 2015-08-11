IBDEI1CF ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24088,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24088,1,2,0)
 ;;=2^Closed TX of fracture, phalanx or phalanges, other than great toe; with manipulation, each
 ;;^UTILITY(U,$J,358.3,24088,1,3,0)
 ;;=3^28515
 ;;^UTILITY(U,$J,358.3,24089,0)
 ;;=28525^^142^1497^24^^^^1
 ;;^UTILITY(U,$J,358.3,24089,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24089,1,2,0)
 ;;=2^Open TX of fracture, phalanx or phalanges, other than great toe, with or without internal or external fixation, each
 ;;^UTILITY(U,$J,358.3,24089,1,3,0)
 ;;=3^28525
 ;;^UTILITY(U,$J,358.3,24090,0)
 ;;=28530^^142^1497^25^^^^1
 ;;^UTILITY(U,$J,358.3,24090,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24090,1,2,0)
 ;;=2^Closed TX of sesamiod fracture 
 ;;^UTILITY(U,$J,358.3,24090,1,3,0)
 ;;=3^28530
 ;;^UTILITY(U,$J,358.3,24091,0)
 ;;=28531^^142^1497^26^^^^1
 ;;^UTILITY(U,$J,358.3,24091,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24091,1,2,0)
 ;;=2^Open TX of sesamiod fracture, with or without internal fixation
 ;;^UTILITY(U,$J,358.3,24091,1,3,0)
 ;;=3^28531
 ;;^UTILITY(U,$J,358.3,24092,0)
 ;;=27760^^142^1497^27^^^^1
 ;;^UTILITY(U,$J,358.3,24092,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24092,1,2,0)
 ;;=2^Closed TX of medial malleolus fracture; without manipulation 
 ;;^UTILITY(U,$J,358.3,24092,1,3,0)
 ;;=3^27760
 ;;^UTILITY(U,$J,358.3,24093,0)
 ;;=27762^^142^1497^28^^^^1
 ;;^UTILITY(U,$J,358.3,24093,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24093,1,2,0)
 ;;=2^Closed TX of medial malleolus fracture; with manipulation, with or without skin or skeletal traction
 ;;^UTILITY(U,$J,358.3,24093,1,3,0)
 ;;=3^27762
 ;;^UTILITY(U,$J,358.3,24094,0)
 ;;=27766^^142^1497^29^^^^1
 ;;^UTILITY(U,$J,358.3,24094,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24094,1,2,0)
 ;;=2^Open/Closed TX of medial matteolus FX,w/ internal fixation
 ;;^UTILITY(U,$J,358.3,24094,1,3,0)
 ;;=3^27766
 ;;^UTILITY(U,$J,358.3,24095,0)
 ;;=27786^^142^1497^30^^^^1
 ;;^UTILITY(U,$J,358.3,24095,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24095,1,2,0)
 ;;=2^Closed TX of distal fibular fracture (lateral malleolus); without manipulation
 ;;^UTILITY(U,$J,358.3,24095,1,3,0)
 ;;=3^27786
 ;;^UTILITY(U,$J,358.3,24096,0)
 ;;=27788^^142^1497^31^^^^1
 ;;^UTILITY(U,$J,358.3,24096,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24096,1,2,0)
 ;;=2^Closed TX of distal fibular (lateral malleolus); with manipulation
 ;;^UTILITY(U,$J,358.3,24096,1,3,0)
 ;;=3^27788
 ;;^UTILITY(U,$J,358.3,24097,0)
 ;;=27792^^142^1497^32^^^^1
 ;;^UTILITY(U,$J,358.3,24097,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24097,1,2,0)
 ;;=2^Open TX of distal fibular fracture (lateral malleolus), with or without internal or external fixation
 ;;^UTILITY(U,$J,358.3,24097,1,3,0)
 ;;=3^27792
 ;;^UTILITY(U,$J,358.3,24098,0)
 ;;=27808^^142^1497^33^^^^1
 ;;^UTILITY(U,$J,358.3,24098,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24098,1,2,0)
 ;;=2^Closed TX of bimalleolar ankle fracture, (including Potts); without manipulation
 ;;^UTILITY(U,$J,358.3,24098,1,3,0)
 ;;=3^27808
 ;;^UTILITY(U,$J,358.3,24099,0)
 ;;=27810^^142^1497^34^^^^1
 ;;^UTILITY(U,$J,358.3,24099,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24099,1,2,0)
 ;;=2^Closed TX of bimalleolar ankle fracture, (including Potts); with manipulation
 ;;^UTILITY(U,$J,358.3,24099,1,3,0)
 ;;=3^27810
 ;;^UTILITY(U,$J,358.3,24100,0)
 ;;=27814^^142^1497^35^^^^1
 ;;^UTILITY(U,$J,358.3,24100,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24100,1,2,0)
 ;;=2^Open TX of bimalleolar ankle fracture, with or without internal or external fixation
 ;;^UTILITY(U,$J,358.3,24100,1,3,0)
 ;;=3^27814
