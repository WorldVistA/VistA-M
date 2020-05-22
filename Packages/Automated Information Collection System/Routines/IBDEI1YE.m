IBDEI1YE ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31216,1,4,0)
 ;;=4^O14.15
 ;;^UTILITY(U,$J,358.3,31216,2)
 ;;=^5139017
 ;;^UTILITY(U,$J,358.3,31217,0)
 ;;=O11.5^^126^1620^30
 ;;^UTILITY(U,$J,358.3,31217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31217,1,3,0)
 ;;=3^Pre-existing HTN w/ Pre-Eclampsia Comp the Puerperium
 ;;^UTILITY(U,$J,358.3,31217,1,4,0)
 ;;=4^O11.5
 ;;^UTILITY(U,$J,358.3,31217,2)
 ;;=^5139005
 ;;^UTILITY(U,$J,358.3,31218,0)
 ;;=O14.95^^126^1620^19
 ;;^UTILITY(U,$J,358.3,31218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31218,1,3,0)
 ;;=3^Pre-Eclampsia Complicating the Puerperium
 ;;^UTILITY(U,$J,358.3,31218,1,4,0)
 ;;=4^O14.95
 ;;^UTILITY(U,$J,358.3,31218,2)
 ;;=^5139021
 ;;^UTILITY(U,$J,358.3,31219,0)
 ;;=O14.05^^126^1620^16
 ;;^UTILITY(U,$J,358.3,31219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31219,1,3,0)
 ;;=3^Mild to Moderate Pre-Eclampsia Complicating the Puerperium
 ;;^UTILITY(U,$J,358.3,31219,1,4,0)
 ;;=4^O14.05
 ;;^UTILITY(U,$J,358.3,31219,2)
 ;;=^5139015
 ;;^UTILITY(U,$J,358.3,31220,0)
 ;;=O16.5^^126^1620^12
 ;;^UTILITY(U,$J,358.3,31220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31220,1,3,0)
 ;;=3^Maternal HTN Complicating the Puerperium
 ;;^UTILITY(U,$J,358.3,31220,1,4,0)
 ;;=4^O16.5
 ;;^UTILITY(U,$J,358.3,31220,2)
 ;;=^5139028
 ;;^UTILITY(U,$J,358.3,31221,0)
 ;;=O14.25^^126^1620^9
 ;;^UTILITY(U,$J,358.3,31221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31221,1,3,0)
 ;;=3^HELLP Syndrome Complicating the Puerperium
 ;;^UTILITY(U,$J,358.3,31221,1,4,0)
 ;;=4^O14.25
 ;;^UTILITY(U,$J,358.3,31221,2)
 ;;=^5139019
 ;;^UTILITY(U,$J,358.3,31222,0)
 ;;=O13.5^^126^1620^4
 ;;^UTILITY(U,$J,358.3,31222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31222,1,3,0)
 ;;=3^Gestational HTN w/o Significant Protein Comp the Puerperium
 ;;^UTILITY(U,$J,358.3,31222,1,4,0)
 ;;=4^O13.5
 ;;^UTILITY(U,$J,358.3,31222,2)
 ;;=^5139013
 ;;^UTILITY(U,$J,358.3,31223,0)
 ;;=O21.0^^126^1621^3
 ;;^UTILITY(U,$J,358.3,31223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31223,1,3,0)
 ;;=3^Mild hyperemesis gravidarum
 ;;^UTILITY(U,$J,358.3,31223,1,4,0)
 ;;=4^O21.0
 ;;^UTILITY(U,$J,358.3,31223,2)
 ;;=^5016185
 ;;^UTILITY(U,$J,358.3,31224,0)
 ;;=O21.1^^126^1621^1
 ;;^UTILITY(U,$J,358.3,31224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31224,1,3,0)
 ;;=3^Hyperemesis gravidarum with metabolic disturbance
 ;;^UTILITY(U,$J,358.3,31224,1,4,0)
 ;;=4^O21.1
 ;;^UTILITY(U,$J,358.3,31224,2)
 ;;=^270869
 ;;^UTILITY(U,$J,358.3,31225,0)
 ;;=O21.2^^126^1621^2
 ;;^UTILITY(U,$J,358.3,31225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31225,1,3,0)
 ;;=3^Late vomiting of pregnancy
 ;;^UTILITY(U,$J,358.3,31225,1,4,0)
 ;;=4^O21.2
 ;;^UTILITY(U,$J,358.3,31225,2)
 ;;=^270873
 ;;^UTILITY(U,$J,358.3,31226,0)
 ;;=O48.0^^126^1622^1
 ;;^UTILITY(U,$J,358.3,31226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31226,1,3,0)
 ;;=3^Post-term pregnancy
 ;;^UTILITY(U,$J,358.3,31226,1,4,0)
 ;;=4^O48.0
 ;;^UTILITY(U,$J,358.3,31226,2)
 ;;=^5017495
 ;;^UTILITY(U,$J,358.3,31227,0)
 ;;=O48.1^^126^1622^2
 ;;^UTILITY(U,$J,358.3,31227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31227,1,3,0)
 ;;=3^Prolonged pregnancy
 ;;^UTILITY(U,$J,358.3,31227,1,4,0)
 ;;=4^O48.1
 ;;^UTILITY(U,$J,358.3,31227,2)
 ;;=^5017496
 ;;^UTILITY(U,$J,358.3,31228,0)
 ;;=O31.03X0^^126^1623^62
 ;;^UTILITY(U,$J,358.3,31228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31228,1,3,0)
 ;;=3^Papyraceous fetus, third trimester, not applicable or unsp
