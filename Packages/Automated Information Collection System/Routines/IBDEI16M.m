IBDEI16M ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19178,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Bilateral Tibial Vein
 ;;^UTILITY(U,$J,358.3,19178,1,4,0)
 ;;=4^I80.233
 ;;^UTILITY(U,$J,358.3,19178,2)
 ;;=^5007841
 ;;^UTILITY(U,$J,358.3,19179,0)
 ;;=I80.12^^64^852^9
 ;;^UTILITY(U,$J,358.3,19179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19179,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Femoral Vein
 ;;^UTILITY(U,$J,358.3,19179,1,4,0)
 ;;=4^I80.12
 ;;^UTILITY(U,$J,358.3,19179,2)
 ;;=^5007826
 ;;^UTILITY(U,$J,358.3,19180,0)
 ;;=I80.212^^64^852^10
 ;;^UTILITY(U,$J,358.3,19180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19180,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Iliac Vein
 ;;^UTILITY(U,$J,358.3,19180,1,4,0)
 ;;=4^I80.212
 ;;^UTILITY(U,$J,358.3,19180,2)
 ;;=^5007832
 ;;^UTILITY(U,$J,358.3,19181,0)
 ;;=I80.222^^64^852^13
 ;;^UTILITY(U,$J,358.3,19181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19181,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Popliteal Vein
 ;;^UTILITY(U,$J,358.3,19181,1,4,0)
 ;;=4^I80.222
 ;;^UTILITY(U,$J,358.3,19181,2)
 ;;=^5007836
 ;;^UTILITY(U,$J,358.3,19182,0)
 ;;=I80.232^^64^852^14
 ;;^UTILITY(U,$J,358.3,19182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19182,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Tibial Vein
 ;;^UTILITY(U,$J,358.3,19182,1,4,0)
 ;;=4^I80.232
 ;;^UTILITY(U,$J,358.3,19182,2)
 ;;=^5007840
 ;;^UTILITY(U,$J,358.3,19183,0)
 ;;=I80.293^^64^852^5
 ;;^UTILITY(U,$J,358.3,19183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19183,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Bilateral Lower Extremity Deep Vessels
 ;;^UTILITY(U,$J,358.3,19183,1,4,0)
 ;;=4^I80.293
 ;;^UTILITY(U,$J,358.3,19183,2)
 ;;=^5007844
 ;;^UTILITY(U,$J,358.3,19184,0)
 ;;=I80.292^^64^852^11
 ;;^UTILITY(U,$J,358.3,19184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19184,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Lower Extremity Deep Vessels
 ;;^UTILITY(U,$J,358.3,19184,1,4,0)
 ;;=4^I80.292
 ;;^UTILITY(U,$J,358.3,19184,2)
 ;;=^5133623
 ;;^UTILITY(U,$J,358.3,19185,0)
 ;;=I80.291^^64^852^17
 ;;^UTILITY(U,$J,358.3,19185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19185,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Right Lower Extremity Deep Vessels
 ;;^UTILITY(U,$J,358.3,19185,1,4,0)
 ;;=4^I80.291
 ;;^UTILITY(U,$J,358.3,19185,2)
 ;;=^5007843
 ;;^UTILITY(U,$J,358.3,19186,0)
 ;;=I80.8^^64^852^22
 ;;^UTILITY(U,$J,358.3,19186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19186,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis of Other Sites
 ;;^UTILITY(U,$J,358.3,19186,1,4,0)
 ;;=4^I80.8
 ;;^UTILITY(U,$J,358.3,19186,2)
 ;;=^176957
 ;;^UTILITY(U,$J,358.3,19187,0)
 ;;=I80.11^^64^852^15
 ;;^UTILITY(U,$J,358.3,19187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19187,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Right Femoral Vein
 ;;^UTILITY(U,$J,358.3,19187,1,4,0)
 ;;=4^I80.11
 ;;^UTILITY(U,$J,358.3,19187,2)
 ;;=^5007825
 ;;^UTILITY(U,$J,358.3,19188,0)
 ;;=I80.211^^64^852^16
 ;;^UTILITY(U,$J,358.3,19188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19188,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Right Iliac Vein
 ;;^UTILITY(U,$J,358.3,19188,1,4,0)
 ;;=4^I80.211
 ;;^UTILITY(U,$J,358.3,19188,2)
 ;;=^5007831
 ;;^UTILITY(U,$J,358.3,19189,0)
 ;;=I80.221^^64^852^19
 ;;^UTILITY(U,$J,358.3,19189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19189,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Right Popliteal Vein
 ;;^UTILITY(U,$J,358.3,19189,1,4,0)
 ;;=4^I80.221
