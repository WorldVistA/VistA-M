IBDEI0CP ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5819,1,4,0)
 ;;=4^H05.013
 ;;^UTILITY(U,$J,358.3,5819,2)
 ;;=^5004562
 ;;^UTILITY(U,$J,358.3,5820,0)
 ;;=I70.331^^30^385^50
 ;;^UTILITY(U,$J,358.3,5820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5820,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,5820,1,4,0)
 ;;=4^I70.331
 ;;^UTILITY(U,$J,358.3,5820,2)
 ;;=^5007626
 ;;^UTILITY(U,$J,358.3,5821,0)
 ;;=I70.332^^30^385^51
 ;;^UTILITY(U,$J,358.3,5821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5821,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,5821,1,4,0)
 ;;=4^I70.332
 ;;^UTILITY(U,$J,358.3,5821,2)
 ;;=^5007627
 ;;^UTILITY(U,$J,358.3,5822,0)
 ;;=I70.333^^30^385^52
 ;;^UTILITY(U,$J,358.3,5822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5822,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,5822,1,4,0)
 ;;=4^I70.333
 ;;^UTILITY(U,$J,358.3,5822,2)
 ;;=^5007628
 ;;^UTILITY(U,$J,358.3,5823,0)
 ;;=I70.334^^30^385^53
 ;;^UTILITY(U,$J,358.3,5823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5823,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,5823,1,4,0)
 ;;=4^I70.334
 ;;^UTILITY(U,$J,358.3,5823,2)
 ;;=^5007629
 ;;^UTILITY(U,$J,358.3,5824,0)
 ;;=I70.335^^30^385^54
 ;;^UTILITY(U,$J,358.3,5824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5824,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,5824,1,4,0)
 ;;=4^I70.335
 ;;^UTILITY(U,$J,358.3,5824,2)
 ;;=^5007630
 ;;^UTILITY(U,$J,358.3,5825,0)
 ;;=I70.341^^30^385^49
 ;;^UTILITY(U,$J,358.3,5825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5825,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,5825,1,4,0)
 ;;=4^I70.341
 ;;^UTILITY(U,$J,358.3,5825,2)
 ;;=^5007633
 ;;^UTILITY(U,$J,358.3,5826,0)
 ;;=I70.342^^30^385^46
 ;;^UTILITY(U,$J,358.3,5826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5826,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,5826,1,4,0)
 ;;=4^I70.342
 ;;^UTILITY(U,$J,358.3,5826,2)
 ;;=^5007634
 ;;^UTILITY(U,$J,358.3,5827,0)
 ;;=I70.343^^30^385^45
 ;;^UTILITY(U,$J,358.3,5827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5827,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,5827,1,4,0)
 ;;=4^I70.343
 ;;^UTILITY(U,$J,358.3,5827,2)
 ;;=^5007635
 ;;^UTILITY(U,$J,358.3,5828,0)
 ;;=I70.344^^30^385^47
 ;;^UTILITY(U,$J,358.3,5828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5828,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,5828,1,4,0)
 ;;=4^I70.344
 ;;^UTILITY(U,$J,358.3,5828,2)
 ;;=^5007636
 ;;^UTILITY(U,$J,358.3,5829,0)
 ;;=I70.345^^30^385^48
 ;;^UTILITY(U,$J,358.3,5829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5829,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,5829,1,4,0)
 ;;=4^I70.345
 ;;^UTILITY(U,$J,358.3,5829,2)
 ;;=^5007637
 ;;^UTILITY(U,$J,358.3,5830,0)
 ;;=I70.431^^30^385^40
 ;;^UTILITY(U,$J,358.3,5830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5830,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,5830,1,4,0)
 ;;=4^I70.431
 ;;^UTILITY(U,$J,358.3,5830,2)
 ;;=^5007664
 ;;^UTILITY(U,$J,358.3,5831,0)
 ;;=I70.432^^30^385^41
 ;;^UTILITY(U,$J,358.3,5831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5831,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,5831,1,4,0)
 ;;=4^I70.432
 ;;^UTILITY(U,$J,358.3,5831,2)
 ;;=^5007665
 ;;^UTILITY(U,$J,358.3,5832,0)
 ;;=I70.433^^30^385^42
