IBDEI2HL ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41734,1,3,0)
 ;;=3^2028F
 ;;^UTILITY(U,$J,358.3,41735,0)
 ;;=G8883^^191^2122^9^^^^1
 ;;^UTILITY(U,$J,358.3,41735,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41735,1,2,0)
 ;;=2^Bx Result RVW,Comm,Tracked
 ;;^UTILITY(U,$J,358.3,41735,1,3,0)
 ;;=3^G8883
 ;;^UTILITY(U,$J,358.3,41736,0)
 ;;=S0395^^191^2122^13^^^^1
 ;;^UTILITY(U,$J,358.3,41736,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41736,1,2,0)
 ;;=2^Impression Cast
 ;;^UTILITY(U,$J,358.3,41736,1,3,0)
 ;;=3^S0395
 ;;^UTILITY(U,$J,358.3,41737,0)
 ;;=E2402^^191^2122^15^^^^1
 ;;^UTILITY(U,$J,358.3,41737,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41737,1,2,0)
 ;;=2^Neg Press Wound Therapy Pump
 ;;^UTILITY(U,$J,358.3,41737,1,3,0)
 ;;=3^E2402
 ;;^UTILITY(U,$J,358.3,41738,0)
 ;;=28400^^191^2123^4^^^^1
 ;;^UTILITY(U,$J,358.3,41738,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41738,1,2,0)
 ;;=2^Closed TX of calcaneal fracture; without manipulation
 ;;^UTILITY(U,$J,358.3,41738,1,3,0)
 ;;=3^28400
 ;;^UTILITY(U,$J,358.3,41739,0)
 ;;=28405^^191^2123^3^^^^1
 ;;^UTILITY(U,$J,358.3,41739,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41739,1,2,0)
 ;;=2^Closed TX of calcaneal fracture; with manipulation
 ;;^UTILITY(U,$J,358.3,41739,1,3,0)
 ;;=3^28405
 ;;^UTILITY(U,$J,358.3,41740,0)
 ;;=28406^^191^2123^66^^^^1
 ;;^UTILITY(U,$J,358.3,41740,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41740,1,2,0)
 ;;=2^Perc Fixation of Calcaneous Fx
 ;;^UTILITY(U,$J,358.3,41740,1,3,0)
 ;;=3^28406
 ;;^UTILITY(U,$J,358.3,41741,0)
 ;;=28415^^191^2123^34^^^^1
 ;;^UTILITY(U,$J,358.3,41741,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41741,1,2,0)
 ;;=2^Open TX of calcaneal fracture, with or without internal or external fixation;
 ;;^UTILITY(U,$J,358.3,41741,1,3,0)
 ;;=3^28415
 ;;^UTILITY(U,$J,358.3,41742,0)
 ;;=28420^^191^2123^35^^^^1
 ;;^UTILITY(U,$J,358.3,41742,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41742,1,2,0)
 ;;=2^Open TX of calcaneal fracture, with or without internal or external fixation; with primary iliac or other autogenous bone graft
 ;;^UTILITY(U,$J,358.3,41742,1,3,0)
 ;;=3^28420
 ;;^UTILITY(U,$J,358.3,41743,0)
 ;;=28430^^191^2123^17^^^^1
 ;;^UTILITY(U,$J,358.3,41743,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41743,1,2,0)
 ;;=2^Closed TX of talus fracture; without manipulation 
 ;;^UTILITY(U,$J,358.3,41743,1,3,0)
 ;;=3^28430
 ;;^UTILITY(U,$J,358.3,41744,0)
 ;;=28435^^191^2123^16^^^^1
 ;;^UTILITY(U,$J,358.3,41744,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41744,1,2,0)
 ;;=2^Closed TX of talus fracture; with manipulation 
 ;;^UTILITY(U,$J,358.3,41744,1,3,0)
 ;;=3^28435
 ;;^UTILITY(U,$J,358.3,41745,0)
 ;;=28436^^191^2123^62^^^^1
 ;;^UTILITY(U,$J,358.3,41745,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41745,1,2,0)
 ;;=2^Perc Fixation Talus Fx
 ;;^UTILITY(U,$J,358.3,41745,1,3,0)
 ;;=3^28436
 ;;^UTILITY(U,$J,358.3,41746,0)
 ;;=28445^^191^2123^54^^^^1
 ;;^UTILITY(U,$J,358.3,41746,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41746,1,2,0)
 ;;=2^Open/Closed TX of Talus FX,w/internal fixation
 ;;^UTILITY(U,$J,358.3,41746,1,3,0)
 ;;=3^28445
 ;;^UTILITY(U,$J,358.3,41747,0)
 ;;=28450^^191^2123^68^^^^1
 ;;^UTILITY(U,$J,358.3,41747,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41747,1,2,0)
 ;;=2^TX of tarsal bone fracture; without manipulation, each 
 ;;^UTILITY(U,$J,358.3,41747,1,3,0)
 ;;=3^28450
 ;;^UTILITY(U,$J,358.3,41748,0)
 ;;=28455^^191^2123^67^^^^1
 ;;^UTILITY(U,$J,358.3,41748,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41748,1,2,0)
 ;;=2^TX of tarsal bone fracture; with manipulation, each
 ;;^UTILITY(U,$J,358.3,41748,1,3,0)
 ;;=3^28455
