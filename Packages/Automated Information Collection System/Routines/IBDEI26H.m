IBDEI26H ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36945,1,4,0)
 ;;=4^I80.293
 ;;^UTILITY(U,$J,358.3,36945,2)
 ;;=^5007844
 ;;^UTILITY(U,$J,358.3,36946,0)
 ;;=I80.292^^137^1779^11
 ;;^UTILITY(U,$J,358.3,36946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36946,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Lower Extremity Deep Vessels
 ;;^UTILITY(U,$J,358.3,36946,1,4,0)
 ;;=4^I80.292
 ;;^UTILITY(U,$J,358.3,36946,2)
 ;;=^5133623
 ;;^UTILITY(U,$J,358.3,36947,0)
 ;;=I80.291^^137^1779^17
 ;;^UTILITY(U,$J,358.3,36947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36947,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Right Lower Extremity Deep Vessels
 ;;^UTILITY(U,$J,358.3,36947,1,4,0)
 ;;=4^I80.291
 ;;^UTILITY(U,$J,358.3,36947,2)
 ;;=^5007843
 ;;^UTILITY(U,$J,358.3,36948,0)
 ;;=I80.8^^137^1779^22
 ;;^UTILITY(U,$J,358.3,36948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36948,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis of Other Sites
 ;;^UTILITY(U,$J,358.3,36948,1,4,0)
 ;;=4^I80.8
 ;;^UTILITY(U,$J,358.3,36948,2)
 ;;=^176957
 ;;^UTILITY(U,$J,358.3,36949,0)
 ;;=I80.11^^137^1779^15
 ;;^UTILITY(U,$J,358.3,36949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36949,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Right Femoral Vein
 ;;^UTILITY(U,$J,358.3,36949,1,4,0)
 ;;=4^I80.11
 ;;^UTILITY(U,$J,358.3,36949,2)
 ;;=^5007825
 ;;^UTILITY(U,$J,358.3,36950,0)
 ;;=I80.211^^137^1779^16
 ;;^UTILITY(U,$J,358.3,36950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36950,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Right Iliac Vein
 ;;^UTILITY(U,$J,358.3,36950,1,4,0)
 ;;=4^I80.211
 ;;^UTILITY(U,$J,358.3,36950,2)
 ;;=^5007831
 ;;^UTILITY(U,$J,358.3,36951,0)
 ;;=I80.221^^137^1779^19
 ;;^UTILITY(U,$J,358.3,36951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36951,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Right Popliteal Vein
 ;;^UTILITY(U,$J,358.3,36951,1,4,0)
 ;;=4^I80.221
 ;;^UTILITY(U,$J,358.3,36951,2)
 ;;=^5007835
 ;;^UTILITY(U,$J,358.3,36952,0)
 ;;=I80.231^^137^1779^20
 ;;^UTILITY(U,$J,358.3,36952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36952,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Right Tibial Vein
 ;;^UTILITY(U,$J,358.3,36952,1,4,0)
 ;;=4^I80.231
 ;;^UTILITY(U,$J,358.3,36952,2)
 ;;=^5007839
 ;;^UTILITY(U,$J,358.3,36953,0)
 ;;=I80.03^^137^1779^6
 ;;^UTILITY(U,$J,358.3,36953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36953,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Bilateral Lower Extremity Superfic Vessels
 ;;^UTILITY(U,$J,358.3,36953,1,4,0)
 ;;=4^I80.03
 ;;^UTILITY(U,$J,358.3,36953,2)
 ;;=^5007823
 ;;^UTILITY(U,$J,358.3,36954,0)
 ;;=I80.02^^137^1779^12
 ;;^UTILITY(U,$J,358.3,36954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36954,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Lower Extremity Superfic Vessels
 ;;^UTILITY(U,$J,358.3,36954,1,4,0)
 ;;=4^I80.02
 ;;^UTILITY(U,$J,358.3,36954,2)
 ;;=^5007822
 ;;^UTILITY(U,$J,358.3,36955,0)
 ;;=I80.01^^137^1779^18
 ;;^UTILITY(U,$J,358.3,36955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36955,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Right Lower Extremity Superfic Vessels
 ;;^UTILITY(U,$J,358.3,36955,1,4,0)
 ;;=4^I80.01
 ;;^UTILITY(U,$J,358.3,36955,2)
 ;;=^5007821
 ;;^UTILITY(U,$J,358.3,36956,0)
 ;;=I80.9^^137^1779^21
 ;;^UTILITY(U,$J,358.3,36956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36956,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Unspec Site
 ;;^UTILITY(U,$J,358.3,36956,1,4,0)
 ;;=4^I80.9
 ;;^UTILITY(U,$J,358.3,36956,2)
 ;;=^93357
 ;;^UTILITY(U,$J,358.3,36957,0)
 ;;=R91.8^^137^1780^2
 ;;^UTILITY(U,$J,358.3,36957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36957,1,3,0)
 ;;=3^Abnormal Lung Field Findings
 ;;^UTILITY(U,$J,358.3,36957,1,4,0)
 ;;=4^R91.8
