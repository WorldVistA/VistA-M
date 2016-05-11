IBDEI1QC ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29352,1,3,0)
 ;;=3^Diseases of the circ sys complicating the puerperium
 ;;^UTILITY(U,$J,358.3,29352,1,4,0)
 ;;=4^O99.43
 ;;^UTILITY(U,$J,358.3,29352,2)
 ;;=^5017975
 ;;^UTILITY(U,$J,358.3,29353,0)
 ;;=O90.0^^115^1460^2
 ;;^UTILITY(U,$J,358.3,29353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29353,1,3,0)
 ;;=3^Disruption of cesarean delivery wound
 ;;^UTILITY(U,$J,358.3,29353,1,4,0)
 ;;=4^O90.0
 ;;^UTILITY(U,$J,358.3,29353,2)
 ;;=^5017812
 ;;^UTILITY(U,$J,358.3,29354,0)
 ;;=O90.1^^115^1460^3
 ;;^UTILITY(U,$J,358.3,29354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29354,1,3,0)
 ;;=3^Disruption of perineal obstetric wound
 ;;^UTILITY(U,$J,358.3,29354,1,4,0)
 ;;=4^O90.1
 ;;^UTILITY(U,$J,358.3,29354,2)
 ;;=^5017813
 ;;^UTILITY(U,$J,358.3,29355,0)
 ;;=O90.3^^115^1460^4
 ;;^UTILITY(U,$J,358.3,29355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29355,1,3,0)
 ;;=3^Peripartum cardiomyopathy
 ;;^UTILITY(U,$J,358.3,29355,1,4,0)
 ;;=4^O90.3
 ;;^UTILITY(U,$J,358.3,29355,2)
 ;;=^5017815
 ;;^UTILITY(U,$J,358.3,29356,0)
 ;;=O91.011^^115^1461^11
 ;;^UTILITY(U,$J,358.3,29356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29356,1,3,0)
 ;;=3^Infection of nipple associated w pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,29356,1,4,0)
 ;;=4^O91.011
 ;;^UTILITY(U,$J,358.3,29356,2)
 ;;=^5017822
 ;;^UTILITY(U,$J,358.3,29357,0)
 ;;=O91.012^^115^1461^12
 ;;^UTILITY(U,$J,358.3,29357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29357,1,3,0)
 ;;=3^Infection of nipple associated w pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,29357,1,4,0)
 ;;=4^O91.012
 ;;^UTILITY(U,$J,358.3,29357,2)
 ;;=^5017823
 ;;^UTILITY(U,$J,358.3,29358,0)
 ;;=O91.013^^115^1461^13
 ;;^UTILITY(U,$J,358.3,29358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29358,1,3,0)
 ;;=3^Infection of nipple associated w pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,29358,1,4,0)
 ;;=4^O91.013
 ;;^UTILITY(U,$J,358.3,29358,2)
 ;;=^5017824
 ;;^UTILITY(U,$J,358.3,29359,0)
 ;;=O91.02^^115^1461^14
 ;;^UTILITY(U,$J,358.3,29359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29359,1,3,0)
 ;;=3^Infection of nipple associated w the puerperium
 ;;^UTILITY(U,$J,358.3,29359,1,4,0)
 ;;=4^O91.02
 ;;^UTILITY(U,$J,358.3,29359,2)
 ;;=^5017826
 ;;^UTILITY(U,$J,358.3,29360,0)
 ;;=O91.111^^115^1461^2
 ;;^UTILITY(U,$J,358.3,29360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29360,1,3,0)
 ;;=3^Abscess of breast associated with pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,29360,1,4,0)
 ;;=4^O91.111
 ;;^UTILITY(U,$J,358.3,29360,2)
 ;;=^5017828
 ;;^UTILITY(U,$J,358.3,29361,0)
 ;;=O91.112^^115^1461^1
 ;;^UTILITY(U,$J,358.3,29361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29361,1,3,0)
 ;;=3^Abscess of breast associated w pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,29361,1,4,0)
 ;;=4^O91.112
 ;;^UTILITY(U,$J,358.3,29361,2)
 ;;=^5017829
 ;;^UTILITY(U,$J,358.3,29362,0)
 ;;=O91.113^^115^1461^3
 ;;^UTILITY(U,$J,358.3,29362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29362,1,3,0)
 ;;=3^Abscess of breast associated with pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,29362,1,4,0)
 ;;=4^O91.113
 ;;^UTILITY(U,$J,358.3,29362,2)
 ;;=^5017830
 ;;^UTILITY(U,$J,358.3,29363,0)
 ;;=O91.12^^115^1461^4
 ;;^UTILITY(U,$J,358.3,29363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29363,1,3,0)
 ;;=3^Abscess of breast associated with the puerperium
 ;;^UTILITY(U,$J,358.3,29363,1,4,0)
 ;;=4^O91.12
 ;;^UTILITY(U,$J,358.3,29363,2)
 ;;=^5017832
 ;;^UTILITY(U,$J,358.3,29364,0)
 ;;=O91.211^^115^1461^17
 ;;^UTILITY(U,$J,358.3,29364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29364,1,3,0)
 ;;=3^Nonpurulent mastitis associated w pregnancy, first trimester
