IBDEI066 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2651,1,4,0)
 ;;=4^19100
 ;;^UTILITY(U,$J,358.3,2652,0)
 ;;=19101^^25^214^8^^^^1
 ;;^UTILITY(U,$J,358.3,2652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2652,1,2,0)
 ;;=2^Bx,Breast,open incision
 ;;^UTILITY(U,$J,358.3,2652,1,4,0)
 ;;=4^19101
 ;;^UTILITY(U,$J,358.3,2653,0)
 ;;=11005^^25^214^11^^^^1
 ;;^UTILITY(U,$J,358.3,2653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2653,1,2,0)
 ;;=2^Debride Abdom Wall
 ;;^UTILITY(U,$J,358.3,2653,1,4,0)
 ;;=4^11005
 ;;^UTILITY(U,$J,358.3,2654,0)
 ;;=11006^^25^214^14^^^^1
 ;;^UTILITY(U,$J,358.3,2654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2654,1,2,0)
 ;;=2^Debride Genit/Per/Abdom Wall
 ;;^UTILITY(U,$J,358.3,2654,1,4,0)
 ;;=4^11006
 ;;^UTILITY(U,$J,358.3,2655,0)
 ;;=11100^^25^214^9^^^^1
 ;;^UTILITY(U,$J,358.3,2655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2655,1,2,0)
 ;;=2^Bx,Skin/Sub,1st lesion
 ;;^UTILITY(U,$J,358.3,2655,1,4,0)
 ;;=4^11100
 ;;^UTILITY(U,$J,358.3,2656,0)
 ;;=11101^^25^214^10^^^^1
 ;;^UTILITY(U,$J,358.3,2656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2656,1,2,0)
 ;;=2^Bx,Skin/Sub,Ea Addl lesion
 ;;^UTILITY(U,$J,358.3,2656,1,4,0)
 ;;=4^11101
 ;;^UTILITY(U,$J,358.3,2657,0)
 ;;=11004^^25^214^15^^^^1
 ;;^UTILITY(U,$J,358.3,2657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2657,1,2,0)
 ;;=2^Debride Genital/Perineum/Mus/Fascia
 ;;^UTILITY(U,$J,358.3,2657,1,4,0)
 ;;=4^11004
 ;;^UTILITY(U,$J,358.3,2658,0)
 ;;=11000^^25^214^16^^^^1
 ;;^UTILITY(U,$J,358.3,2658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2658,1,2,0)
 ;;=2^Debride infect skin 10% or less
 ;;^UTILITY(U,$J,358.3,2658,1,4,0)
 ;;=4^11000
 ;;^UTILITY(U,$J,358.3,2659,0)
 ;;=11042^^25^214^20^^^^1
 ;;^UTILITY(U,$J,358.3,2659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2659,1,2,0)
 ;;=2^Debride skin/SQ,20sq cm or <
 ;;^UTILITY(U,$J,358.3,2659,1,4,0)
 ;;=4^11042
 ;;^UTILITY(U,$J,358.3,2660,0)
 ;;=11043^^25^214^18^^^^1
 ;;^UTILITY(U,$J,358.3,2660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2660,1,2,0)
 ;;=2^Debride muscle,20sq cm or <
 ;;^UTILITY(U,$J,358.3,2660,1,4,0)
 ;;=4^11043
 ;;^UTILITY(U,$J,358.3,2661,0)
 ;;=11044^^25^214^12^^^^1
 ;;^UTILITY(U,$J,358.3,2661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2661,1,2,0)
 ;;=2^Debride Bone,20sq cm or <
 ;;^UTILITY(U,$J,358.3,2661,1,4,0)
 ;;=4^11044
 ;;^UTILITY(U,$J,358.3,2662,0)
 ;;=11001^^25^214^17^^^^1
 ;;^UTILITY(U,$J,358.3,2662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2662,1,2,0)
 ;;=2^Debride infect skin Ea Addl 10%
 ;;^UTILITY(U,$J,358.3,2662,1,4,0)
 ;;=4^11001
 ;;^UTILITY(U,$J,358.3,2663,0)
 ;;=11045^^25^214^21^^^^1
 ;;^UTILITY(U,$J,358.3,2663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2663,1,2,0)
 ;;=2^Debride skin/SQ,ea addl 20sq cm
 ;;^UTILITY(U,$J,358.3,2663,1,4,0)
 ;;=4^11045
 ;;^UTILITY(U,$J,358.3,2664,0)
 ;;=11046^^25^214^19^^^^1
 ;;^UTILITY(U,$J,358.3,2664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2664,1,2,0)
 ;;=2^Debride muscle,ea addl 20sq cm
 ;;^UTILITY(U,$J,358.3,2664,1,4,0)
 ;;=4^11046
 ;;^UTILITY(U,$J,358.3,2665,0)
 ;;=11047^^25^214^13^^^^1
 ;;^UTILITY(U,$J,358.3,2665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2665,1,2,0)
 ;;=2^Debride Bone,ea addl 20sq cm
 ;;^UTILITY(U,$J,358.3,2665,1,4,0)
 ;;=4^11047
 ;;^UTILITY(U,$J,358.3,2666,0)
 ;;=19081^^25^214^3^^^^1
 ;;^UTILITY(U,$J,358.3,2666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2666,1,2,0)
 ;;=2^Bx,Breast w/Device w/Stereotactic Guide,1st Lesion
 ;;^UTILITY(U,$J,358.3,2666,1,4,0)
 ;;=4^19081
 ;;^UTILITY(U,$J,358.3,2667,0)
 ;;=19082^^25^214^4^^^^1
 ;;^UTILITY(U,$J,358.3,2667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2667,1,2,0)
 ;;=2^Bx,Breast w/Device w/Stereotactic Guide,Ea Addl Lesion
