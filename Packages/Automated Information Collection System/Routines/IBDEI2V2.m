IBDEI2V2 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,45640,1,4,0)
 ;;=4^I80.201
 ;;^UTILITY(U,$J,358.3,45640,2)
 ;;=^5007828
 ;;^UTILITY(U,$J,358.3,45641,0)
 ;;=I80.202^^172^2274^5
 ;;^UTILITY(U,$J,358.3,45641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45641,1,3,0)
 ;;=3^Phlebitis & thrombophlebitis deep vessels, left lower extremities
 ;;^UTILITY(U,$J,358.3,45641,1,4,0)
 ;;=4^I80.202
 ;;^UTILITY(U,$J,358.3,45641,2)
 ;;=^5007829
 ;;^UTILITY(U,$J,358.3,45642,0)
 ;;=I80.203^^172^2274^6
 ;;^UTILITY(U,$J,358.3,45642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45642,1,3,0)
 ;;=3^Phlebitis & thrombophlebitis deep vessels, bilateral lower extremities
 ;;^UTILITY(U,$J,358.3,45642,1,4,0)
 ;;=4^I80.203
 ;;^UTILITY(U,$J,358.3,45642,2)
 ;;=^5007830
 ;;^UTILITY(U,$J,358.3,45643,0)
 ;;=I80.3^^172^2274^7
 ;;^UTILITY(U,$J,358.3,45643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45643,1,3,0)
 ;;=3^Phlebitis & thrombophlebitis of lower extremities, unspec
 ;;^UTILITY(U,$J,358.3,45643,1,4,0)
 ;;=4^I80.3
 ;;^UTILITY(U,$J,358.3,45643,2)
 ;;=^5007845
 ;;^UTILITY(U,$J,358.3,45644,0)
 ;;=I95.9^^172^2274^2
 ;;^UTILITY(U,$J,358.3,45644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45644,1,3,0)
 ;;=3^Hypotension, unspecified
 ;;^UTILITY(U,$J,358.3,45644,1,4,0)
 ;;=4^I95.9
 ;;^UTILITY(U,$J,358.3,45644,2)
 ;;=^5008080
 ;;^UTILITY(U,$J,358.3,45645,0)
 ;;=Z51.81^^172^2275^23
 ;;^UTILITY(U,$J,358.3,45645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45645,1,3,0)
 ;;=3^Therapeutic Drug Level Monitoring
 ;;^UTILITY(U,$J,358.3,45645,1,4,0)
 ;;=4^Z51.81
 ;;^UTILITY(U,$J,358.3,45645,2)
 ;;=^5063064
 ;;^UTILITY(U,$J,358.3,45646,0)
 ;;=D68.51^^172^2275^1
 ;;^UTILITY(U,$J,358.3,45646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45646,1,3,0)
 ;;=3^Activated Protein C Resistance
 ;;^UTILITY(U,$J,358.3,45646,1,4,0)
 ;;=4^D68.51
 ;;^UTILITY(U,$J,358.3,45646,2)
 ;;=^5002358
 ;;^UTILITY(U,$J,358.3,45647,0)
 ;;=I82.402^^172^2275^2
 ;;^UTILITY(U,$J,358.3,45647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45647,1,3,0)
 ;;=3^Acute Embolism/Thrombos Deep Veins Left Lower Extremity
 ;;^UTILITY(U,$J,358.3,45647,1,4,0)
 ;;=4^I82.402
 ;;^UTILITY(U,$J,358.3,45647,2)
 ;;=^5007855
 ;;^UTILITY(U,$J,358.3,45648,0)
 ;;=I82.401^^172^2275^3
 ;;^UTILITY(U,$J,358.3,45648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45648,1,3,0)
 ;;=3^Acute Embolism/Thrombos Deep Veins Right Lower Extremity
 ;;^UTILITY(U,$J,358.3,45648,1,4,0)
 ;;=4^I82.401
 ;;^UTILITY(U,$J,358.3,45648,2)
 ;;=^5007854
 ;;^UTILITY(U,$J,358.3,45649,0)
 ;;=I82.890^^172^2275^4
 ;;^UTILITY(U,$J,358.3,45649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45649,1,3,0)
 ;;=3^Acute Embolism/Thrombosis of Specified Veins
 ;;^UTILITY(U,$J,358.3,45649,1,4,0)
 ;;=4^I82.890
 ;;^UTILITY(U,$J,358.3,45649,2)
 ;;=^5007938
 ;;^UTILITY(U,$J,358.3,45650,0)
 ;;=D68.61^^172^2275^5
 ;;^UTILITY(U,$J,358.3,45650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45650,1,3,0)
 ;;=3^Antiphospholipid Syndrome
 ;;^UTILITY(U,$J,358.3,45650,1,4,0)
 ;;=4^D68.61
 ;;^UTILITY(U,$J,358.3,45650,2)
 ;;=^185421
 ;;^UTILITY(U,$J,358.3,45651,0)
 ;;=I63.50^^172^2275^6
 ;;^UTILITY(U,$J,358.3,45651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45651,1,3,0)
 ;;=3^Cerebral Infarction d/t Occls/Stenos of Cereb Artery
 ;;^UTILITY(U,$J,358.3,45651,1,4,0)
 ;;=4^I63.50
 ;;^UTILITY(U,$J,358.3,45651,2)
 ;;=^5007343
 ;;^UTILITY(U,$J,358.3,45652,0)
 ;;=I82.91^^172^2275^7
 ;;^UTILITY(U,$J,358.3,45652,1,0)
 ;;=^358.31IA^4^2
