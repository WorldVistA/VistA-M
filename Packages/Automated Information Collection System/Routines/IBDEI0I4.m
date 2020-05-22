IBDEI0I4 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7898,1,3,0)
 ;;=3^Dermatitis,Factitial
 ;;^UTILITY(U,$J,358.3,7898,1,4,0)
 ;;=4^L98.1
 ;;^UTILITY(U,$J,358.3,7898,2)
 ;;=^186781
 ;;^UTILITY(U,$J,358.3,7899,0)
 ;;=L30.3^^65^512^11
 ;;^UTILITY(U,$J,358.3,7899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7899,1,3,0)
 ;;=3^Dermatitis,Infective
 ;;^UTILITY(U,$J,358.3,7899,1,4,0)
 ;;=4^L30.3
 ;;^UTILITY(U,$J,358.3,7899,2)
 ;;=^5009156
 ;;^UTILITY(U,$J,358.3,7900,0)
 ;;=L56.2^^65^512^19
 ;;^UTILITY(U,$J,358.3,7900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7900,1,3,0)
 ;;=3^Dermatitis,Photocontact
 ;;^UTILITY(U,$J,358.3,7900,1,4,0)
 ;;=4^L56.2
 ;;^UTILITY(U,$J,358.3,7900,2)
 ;;=^5009216
 ;;^UTILITY(U,$J,358.3,7901,0)
 ;;=L71.0^^65^512^18
 ;;^UTILITY(U,$J,358.3,7901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7901,1,3,0)
 ;;=3^Dermatitis,Perioral
 ;;^UTILITY(U,$J,358.3,7901,1,4,0)
 ;;=4^L71.0
 ;;^UTILITY(U,$J,358.3,7901,2)
 ;;=^5009274
 ;;^UTILITY(U,$J,358.3,7902,0)
 ;;=L23.1^^65^512^2
 ;;^UTILITY(U,$J,358.3,7902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7902,1,3,0)
 ;;=3^Dermatitis,Allergic Contact d/t Adhesives
 ;;^UTILITY(U,$J,358.3,7902,1,4,0)
 ;;=4^L23.1
 ;;^UTILITY(U,$J,358.3,7902,2)
 ;;=^5009116
 ;;^UTILITY(U,$J,358.3,7903,0)
 ;;=L23.81^^65^512^3
 ;;^UTILITY(U,$J,358.3,7903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7903,1,3,0)
 ;;=3^Dermatitis,Allergic Contact d/t Animal Dander
 ;;^UTILITY(U,$J,358.3,7903,1,4,0)
 ;;=4^L23.81
 ;;^UTILITY(U,$J,358.3,7903,2)
 ;;=^5009123
 ;;^UTILITY(U,$J,358.3,7904,0)
 ;;=L23.0^^65^512^5
 ;;^UTILITY(U,$J,358.3,7904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7904,1,3,0)
 ;;=3^Dermatitis,Allergic Contact d/t Metals
 ;;^UTILITY(U,$J,358.3,7904,1,4,0)
 ;;=4^L23.0
 ;;^UTILITY(U,$J,358.3,7904,2)
 ;;=^5009115
 ;;^UTILITY(U,$J,358.3,7905,0)
 ;;=B00.1^^65^512^10
 ;;^UTILITY(U,$J,358.3,7905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7905,1,3,0)
 ;;=3^Dermatitis,Herpes Simplex
 ;;^UTILITY(U,$J,358.3,7905,1,4,0)
 ;;=4^B00.1
 ;;^UTILITY(U,$J,358.3,7905,2)
 ;;=^5000468
 ;;^UTILITY(U,$J,358.3,7906,0)
 ;;=L24.0^^65^512^13
 ;;^UTILITY(U,$J,358.3,7906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7906,1,3,0)
 ;;=3^Dermatitis,Irritant Contact d/t Detergents
 ;;^UTILITY(U,$J,358.3,7906,1,4,0)
 ;;=4^L24.0
 ;;^UTILITY(U,$J,358.3,7906,2)
 ;;=^5009126
 ;;^UTILITY(U,$J,358.3,7907,0)
 ;;=L24.81^^65^512^14
 ;;^UTILITY(U,$J,358.3,7907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7907,1,3,0)
 ;;=3^Dermatitis,Irritant Contact d/t Metals
 ;;^UTILITY(U,$J,358.3,7907,1,4,0)
 ;;=4^L24.81
 ;;^UTILITY(U,$J,358.3,7907,2)
 ;;=^5009134
 ;;^UTILITY(U,$J,358.3,7908,0)
 ;;=L24.2^^65^512^15
 ;;^UTILITY(U,$J,358.3,7908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7908,1,3,0)
 ;;=3^Dermatitis,Irritant Contact d/t Solvents
 ;;^UTILITY(U,$J,358.3,7908,1,4,0)
 ;;=4^L24.2
 ;;^UTILITY(U,$J,358.3,7908,2)
 ;;=^5009128
 ;;^UTILITY(U,$J,358.3,7909,0)
 ;;=E08.620^^65^512^22
 ;;^UTILITY(U,$J,358.3,7909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7909,1,3,0)
 ;;=3^Diabetes d/t Underlying Condition w/ DM Dermatitis
 ;;^UTILITY(U,$J,358.3,7909,1,4,0)
 ;;=4^E08.620
 ;;^UTILITY(U,$J,358.3,7909,2)
 ;;=^5002533
 ;;^UTILITY(U,$J,358.3,7910,0)
 ;;=E08.621^^65^512^24
 ;;^UTILITY(U,$J,358.3,7910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7910,1,3,0)
 ;;=3^Diabetes d/t Underlying Conditions w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,7910,1,4,0)
 ;;=4^E08.621
