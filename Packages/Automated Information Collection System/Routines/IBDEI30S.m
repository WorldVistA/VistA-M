IBDEI30S ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,50625,1,4,0)
 ;;=4^I80.293
 ;;^UTILITY(U,$J,358.3,50625,2)
 ;;=^5007844
 ;;^UTILITY(U,$J,358.3,50626,0)
 ;;=I80.292^^219^2458^11
 ;;^UTILITY(U,$J,358.3,50626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50626,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Lower Extremity Deep Vessels
 ;;^UTILITY(U,$J,358.3,50626,1,4,0)
 ;;=4^I80.292
 ;;^UTILITY(U,$J,358.3,50626,2)
 ;;=^5133623
 ;;^UTILITY(U,$J,358.3,50627,0)
 ;;=I80.291^^219^2458^17
 ;;^UTILITY(U,$J,358.3,50627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50627,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Right Lower Extremity Deep Vessels
 ;;^UTILITY(U,$J,358.3,50627,1,4,0)
 ;;=4^I80.291
 ;;^UTILITY(U,$J,358.3,50627,2)
 ;;=^5007843
 ;;^UTILITY(U,$J,358.3,50628,0)
 ;;=I80.8^^219^2458^22
 ;;^UTILITY(U,$J,358.3,50628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50628,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis of Other Sites
 ;;^UTILITY(U,$J,358.3,50628,1,4,0)
 ;;=4^I80.8
 ;;^UTILITY(U,$J,358.3,50628,2)
 ;;=^176957
 ;;^UTILITY(U,$J,358.3,50629,0)
 ;;=I80.11^^219^2458^15
 ;;^UTILITY(U,$J,358.3,50629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50629,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Right Femoral Vein
 ;;^UTILITY(U,$J,358.3,50629,1,4,0)
 ;;=4^I80.11
 ;;^UTILITY(U,$J,358.3,50629,2)
 ;;=^5007825
 ;;^UTILITY(U,$J,358.3,50630,0)
 ;;=I80.211^^219^2458^16
 ;;^UTILITY(U,$J,358.3,50630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50630,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Right Iliac Vein
 ;;^UTILITY(U,$J,358.3,50630,1,4,0)
 ;;=4^I80.211
 ;;^UTILITY(U,$J,358.3,50630,2)
 ;;=^5007831
 ;;^UTILITY(U,$J,358.3,50631,0)
 ;;=I80.221^^219^2458^19
 ;;^UTILITY(U,$J,358.3,50631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50631,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Right Popliteal Vein
 ;;^UTILITY(U,$J,358.3,50631,1,4,0)
 ;;=4^I80.221
 ;;^UTILITY(U,$J,358.3,50631,2)
 ;;=^5007835
 ;;^UTILITY(U,$J,358.3,50632,0)
 ;;=I80.231^^219^2458^20
 ;;^UTILITY(U,$J,358.3,50632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50632,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Right Tibial Vein
 ;;^UTILITY(U,$J,358.3,50632,1,4,0)
 ;;=4^I80.231
 ;;^UTILITY(U,$J,358.3,50632,2)
 ;;=^5007839
 ;;^UTILITY(U,$J,358.3,50633,0)
 ;;=I80.03^^219^2458^6
 ;;^UTILITY(U,$J,358.3,50633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50633,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Bilateral Lower Extremity Superfic Vessels
 ;;^UTILITY(U,$J,358.3,50633,1,4,0)
 ;;=4^I80.03
 ;;^UTILITY(U,$J,358.3,50633,2)
 ;;=^5007823
 ;;^UTILITY(U,$J,358.3,50634,0)
 ;;=I80.02^^219^2458^12
 ;;^UTILITY(U,$J,358.3,50634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50634,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Lower Extremity Superfic Vessels
 ;;^UTILITY(U,$J,358.3,50634,1,4,0)
 ;;=4^I80.02
 ;;^UTILITY(U,$J,358.3,50634,2)
 ;;=^5007822
 ;;^UTILITY(U,$J,358.3,50635,0)
 ;;=I80.01^^219^2458^18
 ;;^UTILITY(U,$J,358.3,50635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50635,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Right Lower Extremity Superfic Vessels
 ;;^UTILITY(U,$J,358.3,50635,1,4,0)
 ;;=4^I80.01
 ;;^UTILITY(U,$J,358.3,50635,2)
 ;;=^5007821
 ;;^UTILITY(U,$J,358.3,50636,0)
 ;;=I80.9^^219^2458^21
 ;;^UTILITY(U,$J,358.3,50636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50636,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Unspec Site
 ;;^UTILITY(U,$J,358.3,50636,1,4,0)
 ;;=4^I80.9
 ;;^UTILITY(U,$J,358.3,50636,2)
 ;;=^93357
 ;;^UTILITY(U,$J,358.3,50637,0)
 ;;=R91.8^^219^2459^2
 ;;^UTILITY(U,$J,358.3,50637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50637,1,3,0)
 ;;=3^Abnormal Lung Field Findings
 ;;^UTILITY(U,$J,358.3,50637,1,4,0)
 ;;=4^R91.8
