IBDEI0TS ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14425,1,2,0)
 ;;=2^Closed TX of fracture, phalanx or phalanges, other than great toe; without manipulation, each
 ;;^UTILITY(U,$J,358.3,14425,1,3,0)
 ;;=3^28510
 ;;^UTILITY(U,$J,358.3,14426,0)
 ;;=28515^^75^888^10^^^^1
 ;;^UTILITY(U,$J,358.3,14426,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14426,1,2,0)
 ;;=2^Closed TX of fracture, phalanx or phalanges, other than great toe; with manipulation, each
 ;;^UTILITY(U,$J,358.3,14426,1,3,0)
 ;;=3^28515
 ;;^UTILITY(U,$J,358.3,14427,0)
 ;;=28525^^75^888^38^^^^1
 ;;^UTILITY(U,$J,358.3,14427,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14427,1,2,0)
 ;;=2^Open TX of fracture, phalanx or phalanges, other than great toe, with or without internal or external fixation, each
 ;;^UTILITY(U,$J,358.3,14427,1,3,0)
 ;;=3^28525
 ;;^UTILITY(U,$J,358.3,14428,0)
 ;;=28530^^75^888^15^^^^1
 ;;^UTILITY(U,$J,358.3,14428,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14428,1,2,0)
 ;;=2^Closed TX of sesamiod fracture 
 ;;^UTILITY(U,$J,358.3,14428,1,3,0)
 ;;=3^28530
 ;;^UTILITY(U,$J,358.3,14429,0)
 ;;=28531^^75^888^39^^^^1
 ;;^UTILITY(U,$J,358.3,14429,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14429,1,2,0)
 ;;=2^Open TX of sesamiod fracture, with or without internal fixation
 ;;^UTILITY(U,$J,358.3,14429,1,3,0)
 ;;=3^28531
 ;;^UTILITY(U,$J,358.3,14430,0)
 ;;=27760^^75^888^11^^^^1
 ;;^UTILITY(U,$J,358.3,14430,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14430,1,2,0)
 ;;=2^Closed TX of medial malleolus fracture; without manipulation 
 ;;^UTILITY(U,$J,358.3,14430,1,3,0)
 ;;=3^27760
 ;;^UTILITY(U,$J,358.3,14431,0)
 ;;=27762^^75^888^12^^^^1
 ;;^UTILITY(U,$J,358.3,14431,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14431,1,2,0)
 ;;=2^Closed TX of medial malleolus fracture; with manipulation, with or without skin or skeletal traction
 ;;^UTILITY(U,$J,358.3,14431,1,3,0)
 ;;=3^27762
 ;;^UTILITY(U,$J,358.3,14432,0)
 ;;=27766^^75^888^55^^^^1
 ;;^UTILITY(U,$J,358.3,14432,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14432,1,2,0)
 ;;=2^Open/Closed TX of medial matteolus FX,w/ internal fixation
 ;;^UTILITY(U,$J,358.3,14432,1,3,0)
 ;;=3^27766
 ;;^UTILITY(U,$J,358.3,14433,0)
 ;;=27786^^75^888^6^^^^1
 ;;^UTILITY(U,$J,358.3,14433,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14433,1,2,0)
 ;;=2^Closed TX of distal fibular fracture (lateral malleolus); without manipulation
 ;;^UTILITY(U,$J,358.3,14433,1,3,0)
 ;;=3^27786
 ;;^UTILITY(U,$J,358.3,14434,0)
 ;;=27788^^75^888^5^^^^1
 ;;^UTILITY(U,$J,358.3,14434,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14434,1,2,0)
 ;;=2^Closed TX of distal fibular (lateral malleolus); with manipulation
 ;;^UTILITY(U,$J,358.3,14434,1,3,0)
 ;;=3^27788
 ;;^UTILITY(U,$J,358.3,14435,0)
 ;;=27792^^75^888^36^^^^1
 ;;^UTILITY(U,$J,358.3,14435,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14435,1,2,0)
 ;;=2^Open TX of distal fibular fracture (lateral malleolus), with or without internal or external fixation
 ;;^UTILITY(U,$J,358.3,14435,1,3,0)
 ;;=3^27792
 ;;^UTILITY(U,$J,358.3,14436,0)
 ;;=27808^^75^888^1^^^^1
 ;;^UTILITY(U,$J,358.3,14436,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14436,1,2,0)
 ;;=2^Closed TX of bimalleolar ankle fracture, (including Potts); without manipulation
 ;;^UTILITY(U,$J,358.3,14436,1,3,0)
 ;;=3^27808
 ;;^UTILITY(U,$J,358.3,14437,0)
 ;;=27810^^75^888^2^^^^1
 ;;^UTILITY(U,$J,358.3,14437,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14437,1,2,0)
 ;;=2^Closed TX of bimalleolar ankle fracture, (including Potts); with manipulation
 ;;^UTILITY(U,$J,358.3,14437,1,3,0)
 ;;=3^27810
 ;;^UTILITY(U,$J,358.3,14438,0)
 ;;=27814^^75^888^33^^^^1
