IBDEI0TR ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14411,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14411,1,2,0)
 ;;=2^Perc Fixation Talus Fx
 ;;^UTILITY(U,$J,358.3,14411,1,3,0)
 ;;=3^28436
 ;;^UTILITY(U,$J,358.3,14412,0)
 ;;=28445^^75^888^54^^^^1
 ;;^UTILITY(U,$J,358.3,14412,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14412,1,2,0)
 ;;=2^Open/Closed TX of Talus FX,w/internal fixation
 ;;^UTILITY(U,$J,358.3,14412,1,3,0)
 ;;=3^28445
 ;;^UTILITY(U,$J,358.3,14413,0)
 ;;=28450^^75^888^68^^^^1
 ;;^UTILITY(U,$J,358.3,14413,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14413,1,2,0)
 ;;=2^TX of tarsal bone fracture; without manipulation, each 
 ;;^UTILITY(U,$J,358.3,14413,1,3,0)
 ;;=3^28450
 ;;^UTILITY(U,$J,358.3,14414,0)
 ;;=28455^^75^888^67^^^^1
 ;;^UTILITY(U,$J,358.3,14414,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14414,1,2,0)
 ;;=2^TX of tarsal bone fracture; with manipulation, each
 ;;^UTILITY(U,$J,358.3,14414,1,3,0)
 ;;=3^28455
 ;;^UTILITY(U,$J,358.3,14415,0)
 ;;=28456^^75^888^64^^^^1
 ;;^UTILITY(U,$J,358.3,14415,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14415,1,2,0)
 ;;=2^Perc Fixation Tarsal Fx
 ;;^UTILITY(U,$J,358.3,14415,1,3,0)
 ;;=3^28456
 ;;^UTILITY(U,$J,358.3,14416,0)
 ;;=28465^^75^888^56^^^^1
 ;;^UTILITY(U,$J,358.3,14416,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14416,1,2,0)
 ;;=2^Open/Closed TX of tarsal FX,w/ internal fixation
 ;;^UTILITY(U,$J,358.3,14416,1,3,0)
 ;;=3^28465
 ;;^UTILITY(U,$J,358.3,14417,0)
 ;;=28470^^75^888^14^^^^1
 ;;^UTILITY(U,$J,358.3,14417,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14417,1,2,0)
 ;;=2^Closed TX of metatarsal fracture; without manipulation, eachnt of me
 ;;^UTILITY(U,$J,358.3,14417,1,3,0)
 ;;=3^28470
 ;;^UTILITY(U,$J,358.3,14418,0)
 ;;=28475^^75^888^13^^^^1
 ;;^UTILITY(U,$J,358.3,14418,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14418,1,2,0)
 ;;=2^Closed TX of metatarsal fracture; with manipulation, each
 ;;^UTILITY(U,$J,358.3,14418,1,3,0)
 ;;=3^28475
 ;;^UTILITY(U,$J,358.3,14419,0)
 ;;=28476^^75^888^59^^^^1
 ;;^UTILITY(U,$J,358.3,14419,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14419,1,2,0)
 ;;=2^Perc Fixation Metatarsal Fx
 ;;^UTILITY(U,$J,358.3,14419,1,3,0)
 ;;=3^28476
 ;;^UTILITY(U,$J,358.3,14420,0)
 ;;=28485^^75^888^53^^^^1
 ;;^UTILITY(U,$J,358.3,14420,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14420,1,2,0)
 ;;=2^Open/Closed TX of Metatarsal FX,w/internal fixation
 ;;^UTILITY(U,$J,358.3,14420,1,3,0)
 ;;=3^28485
 ;;^UTILITY(U,$J,358.3,14421,0)
 ;;=28490^^75^888^7^^^^1
 ;;^UTILITY(U,$J,358.3,14421,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14421,1,2,0)
 ;;=2^Closed TX of fracture great toe, phalanx or phalanges; without manipulation
 ;;^UTILITY(U,$J,358.3,14421,1,3,0)
 ;;=3^28490
 ;;^UTILITY(U,$J,358.3,14422,0)
 ;;=28495^^75^888^8^^^^1
 ;;^UTILITY(U,$J,358.3,14422,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14422,1,2,0)
 ;;=2^Closed TX of fracture great toe, phalanx or phalanges; with manipulation
 ;;^UTILITY(U,$J,358.3,14422,1,3,0)
 ;;=3^28495
 ;;^UTILITY(U,$J,358.3,14423,0)
 ;;=28496^^75^888^57^^^^1
 ;;^UTILITY(U,$J,358.3,14423,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14423,1,2,0)
 ;;=2^Perc Fixation Great Toe Fx
 ;;^UTILITY(U,$J,358.3,14423,1,3,0)
 ;;=3^28496
 ;;^UTILITY(U,$J,358.3,14424,0)
 ;;=28505^^75^888^37^^^^1
 ;;^UTILITY(U,$J,358.3,14424,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14424,1,2,0)
 ;;=2^Open TX of fracture great toe, phalanx or phalanges, with or without internal or external fixation
 ;;^UTILITY(U,$J,358.3,14424,1,3,0)
 ;;=3^28505
 ;;^UTILITY(U,$J,358.3,14425,0)
 ;;=28510^^75^888^9^^^^1
 ;;^UTILITY(U,$J,358.3,14425,1,0)
 ;;=^358.31IA^3^2
