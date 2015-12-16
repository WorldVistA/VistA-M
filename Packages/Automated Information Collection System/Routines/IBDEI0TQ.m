IBDEI0TQ ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14396,1,2,0)
 ;;=2^Arthroscopy, subtalar jt,w/ debridement
 ;;^UTILITY(U,$J,358.3,14396,1,3,0)
 ;;=3^29906
 ;;^UTILITY(U,$J,358.3,14397,0)
 ;;=29907^^75^887^7^^^^1
 ;;^UTILITY(U,$J,358.3,14397,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14397,1,2,0)
 ;;=2^Arthroscopy,subtalar w/ fusion
 ;;^UTILITY(U,$J,358.3,14397,1,3,0)
 ;;=3^29907
 ;;^UTILITY(U,$J,358.3,14398,0)
 ;;=97605^^75^887^16^^^^1
 ;;^UTILITY(U,$J,358.3,14398,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14398,1,2,0)
 ;;=2^Neg Press Wound Tx <= 50 cm
 ;;^UTILITY(U,$J,358.3,14398,1,3,0)
 ;;=3^97605
 ;;^UTILITY(U,$J,358.3,14399,0)
 ;;=97606^^75^887^17^^^^1
 ;;^UTILITY(U,$J,358.3,14399,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14399,1,2,0)
 ;;=2^Neg Press Wound Tx > 50 cm
 ;;^UTILITY(U,$J,358.3,14399,1,3,0)
 ;;=3^97606
 ;;^UTILITY(U,$J,358.3,14400,0)
 ;;=2028F^^75^887^12^^^^1
 ;;^UTILITY(U,$J,358.3,14400,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14400,1,2,0)
 ;;=2^Foot Exam Performed
 ;;^UTILITY(U,$J,358.3,14400,1,3,0)
 ;;=3^2028F
 ;;^UTILITY(U,$J,358.3,14401,0)
 ;;=G8883^^75^887^9^^^^1
 ;;^UTILITY(U,$J,358.3,14401,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14401,1,2,0)
 ;;=2^Bx Result RVW,Comm,Tracked
 ;;^UTILITY(U,$J,358.3,14401,1,3,0)
 ;;=3^G8883
 ;;^UTILITY(U,$J,358.3,14402,0)
 ;;=S0395^^75^887^13^^^^1
 ;;^UTILITY(U,$J,358.3,14402,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14402,1,2,0)
 ;;=2^Impression Cast
 ;;^UTILITY(U,$J,358.3,14402,1,3,0)
 ;;=3^S0395
 ;;^UTILITY(U,$J,358.3,14403,0)
 ;;=E2402^^75^887^15^^^^1
 ;;^UTILITY(U,$J,358.3,14403,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14403,1,2,0)
 ;;=2^Neg Press Wound Therapy Pump
 ;;^UTILITY(U,$J,358.3,14403,1,3,0)
 ;;=3^E2402
 ;;^UTILITY(U,$J,358.3,14404,0)
 ;;=28400^^75^888^4^^^^1
 ;;^UTILITY(U,$J,358.3,14404,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14404,1,2,0)
 ;;=2^Closed TX of calcaneal fracture; without manipulation
 ;;^UTILITY(U,$J,358.3,14404,1,3,0)
 ;;=3^28400
 ;;^UTILITY(U,$J,358.3,14405,0)
 ;;=28405^^75^888^3^^^^1
 ;;^UTILITY(U,$J,358.3,14405,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14405,1,2,0)
 ;;=2^Closed TX of calcaneal fracture; with manipulation
 ;;^UTILITY(U,$J,358.3,14405,1,3,0)
 ;;=3^28405
 ;;^UTILITY(U,$J,358.3,14406,0)
 ;;=28406^^75^888^66^^^^1
 ;;^UTILITY(U,$J,358.3,14406,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14406,1,2,0)
 ;;=2^Perc Fixation of Calcaneous Fx
 ;;^UTILITY(U,$J,358.3,14406,1,3,0)
 ;;=3^28406
 ;;^UTILITY(U,$J,358.3,14407,0)
 ;;=28415^^75^888^34^^^^1
 ;;^UTILITY(U,$J,358.3,14407,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14407,1,2,0)
 ;;=2^Open TX of calcaneal fracture, with or without internal or external fixation;
 ;;^UTILITY(U,$J,358.3,14407,1,3,0)
 ;;=3^28415
 ;;^UTILITY(U,$J,358.3,14408,0)
 ;;=28420^^75^888^35^^^^1
 ;;^UTILITY(U,$J,358.3,14408,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14408,1,2,0)
 ;;=2^Open TX of calcaneal fracture, with or without internal or external fixation; with primary iliac or other autogenous bone graft
 ;;^UTILITY(U,$J,358.3,14408,1,3,0)
 ;;=3^28420
 ;;^UTILITY(U,$J,358.3,14409,0)
 ;;=28430^^75^888^17^^^^1
 ;;^UTILITY(U,$J,358.3,14409,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14409,1,2,0)
 ;;=2^Closed TX of talus fracture; without manipulation 
 ;;^UTILITY(U,$J,358.3,14409,1,3,0)
 ;;=3^28430
 ;;^UTILITY(U,$J,358.3,14410,0)
 ;;=28435^^75^888^16^^^^1
 ;;^UTILITY(U,$J,358.3,14410,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14410,1,2,0)
 ;;=2^Closed TX of talus fracture; with manipulation 
 ;;^UTILITY(U,$J,358.3,14410,1,3,0)
 ;;=3^28435
 ;;^UTILITY(U,$J,358.3,14411,0)
 ;;=28436^^75^888^62^^^^1
