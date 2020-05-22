IBDEI1ZR ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31781,1,3,0)
 ;;=3^Diseases of the circ sys complicating the puerperium
 ;;^UTILITY(U,$J,358.3,31781,1,4,0)
 ;;=4^O99.43
 ;;^UTILITY(U,$J,358.3,31781,2)
 ;;=^5017975
 ;;^UTILITY(U,$J,358.3,31782,0)
 ;;=O90.0^^126^1631^2
 ;;^UTILITY(U,$J,358.3,31782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31782,1,3,0)
 ;;=3^Disruption of cesarean delivery wound
 ;;^UTILITY(U,$J,358.3,31782,1,4,0)
 ;;=4^O90.0
 ;;^UTILITY(U,$J,358.3,31782,2)
 ;;=^5017812
 ;;^UTILITY(U,$J,358.3,31783,0)
 ;;=O90.1^^126^1631^3
 ;;^UTILITY(U,$J,358.3,31783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31783,1,3,0)
 ;;=3^Disruption of perineal obstetric wound
 ;;^UTILITY(U,$J,358.3,31783,1,4,0)
 ;;=4^O90.1
 ;;^UTILITY(U,$J,358.3,31783,2)
 ;;=^5017813
 ;;^UTILITY(U,$J,358.3,31784,0)
 ;;=O90.3^^126^1631^4
 ;;^UTILITY(U,$J,358.3,31784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31784,1,3,0)
 ;;=3^Peripartum cardiomyopathy
 ;;^UTILITY(U,$J,358.3,31784,1,4,0)
 ;;=4^O90.3
 ;;^UTILITY(U,$J,358.3,31784,2)
 ;;=^5017815
 ;;^UTILITY(U,$J,358.3,31785,0)
 ;;=O91.011^^126^1632^11
 ;;^UTILITY(U,$J,358.3,31785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31785,1,3,0)
 ;;=3^Infection of nipple associated w pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,31785,1,4,0)
 ;;=4^O91.011
 ;;^UTILITY(U,$J,358.3,31785,2)
 ;;=^5017822
 ;;^UTILITY(U,$J,358.3,31786,0)
 ;;=O91.012^^126^1632^12
 ;;^UTILITY(U,$J,358.3,31786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31786,1,3,0)
 ;;=3^Infection of nipple associated w pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,31786,1,4,0)
 ;;=4^O91.012
 ;;^UTILITY(U,$J,358.3,31786,2)
 ;;=^5017823
 ;;^UTILITY(U,$J,358.3,31787,0)
 ;;=O91.013^^126^1632^13
 ;;^UTILITY(U,$J,358.3,31787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31787,1,3,0)
 ;;=3^Infection of nipple associated w pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,31787,1,4,0)
 ;;=4^O91.013
 ;;^UTILITY(U,$J,358.3,31787,2)
 ;;=^5017824
 ;;^UTILITY(U,$J,358.3,31788,0)
 ;;=O91.02^^126^1632^14
 ;;^UTILITY(U,$J,358.3,31788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31788,1,3,0)
 ;;=3^Infection of nipple associated w the puerperium
 ;;^UTILITY(U,$J,358.3,31788,1,4,0)
 ;;=4^O91.02
 ;;^UTILITY(U,$J,358.3,31788,2)
 ;;=^5017826
 ;;^UTILITY(U,$J,358.3,31789,0)
 ;;=O91.111^^126^1632^2
 ;;^UTILITY(U,$J,358.3,31789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31789,1,3,0)
 ;;=3^Abscess of breast associated with pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,31789,1,4,0)
 ;;=4^O91.111
 ;;^UTILITY(U,$J,358.3,31789,2)
 ;;=^5017828
 ;;^UTILITY(U,$J,358.3,31790,0)
 ;;=O91.112^^126^1632^1
 ;;^UTILITY(U,$J,358.3,31790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31790,1,3,0)
 ;;=3^Abscess of breast associated w pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,31790,1,4,0)
 ;;=4^O91.112
 ;;^UTILITY(U,$J,358.3,31790,2)
 ;;=^5017829
 ;;^UTILITY(U,$J,358.3,31791,0)
 ;;=O91.113^^126^1632^3
 ;;^UTILITY(U,$J,358.3,31791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31791,1,3,0)
 ;;=3^Abscess of breast associated with pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,31791,1,4,0)
 ;;=4^O91.113
 ;;^UTILITY(U,$J,358.3,31791,2)
 ;;=^5017830
 ;;^UTILITY(U,$J,358.3,31792,0)
 ;;=O91.12^^126^1632^4
 ;;^UTILITY(U,$J,358.3,31792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31792,1,3,0)
 ;;=3^Abscess of breast associated with the puerperium
 ;;^UTILITY(U,$J,358.3,31792,1,4,0)
 ;;=4^O91.12
