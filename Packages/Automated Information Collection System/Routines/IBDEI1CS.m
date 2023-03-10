IBDEI1CS ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21869,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Bilateral Tibial Vein
 ;;^UTILITY(U,$J,358.3,21869,1,4,0)
 ;;=4^I80.233
 ;;^UTILITY(U,$J,358.3,21869,2)
 ;;=^5007841
 ;;^UTILITY(U,$J,358.3,21870,0)
 ;;=I80.12^^70^932^9
 ;;^UTILITY(U,$J,358.3,21870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21870,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Femoral Vein
 ;;^UTILITY(U,$J,358.3,21870,1,4,0)
 ;;=4^I80.12
 ;;^UTILITY(U,$J,358.3,21870,2)
 ;;=^5007826
 ;;^UTILITY(U,$J,358.3,21871,0)
 ;;=I80.212^^70^932^10
 ;;^UTILITY(U,$J,358.3,21871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21871,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Iliac Vein
 ;;^UTILITY(U,$J,358.3,21871,1,4,0)
 ;;=4^I80.212
 ;;^UTILITY(U,$J,358.3,21871,2)
 ;;=^5007832
 ;;^UTILITY(U,$J,358.3,21872,0)
 ;;=I80.222^^70^932^13
 ;;^UTILITY(U,$J,358.3,21872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21872,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Popliteal Vein
 ;;^UTILITY(U,$J,358.3,21872,1,4,0)
 ;;=4^I80.222
 ;;^UTILITY(U,$J,358.3,21872,2)
 ;;=^5007836
 ;;^UTILITY(U,$J,358.3,21873,0)
 ;;=I80.232^^70^932^14
 ;;^UTILITY(U,$J,358.3,21873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21873,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Tibial Vein
 ;;^UTILITY(U,$J,358.3,21873,1,4,0)
 ;;=4^I80.232
 ;;^UTILITY(U,$J,358.3,21873,2)
 ;;=^5007840
 ;;^UTILITY(U,$J,358.3,21874,0)
 ;;=I80.293^^70^932^5
 ;;^UTILITY(U,$J,358.3,21874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21874,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Bilateral Lower Extremity Deep Vessels
 ;;^UTILITY(U,$J,358.3,21874,1,4,0)
 ;;=4^I80.293
 ;;^UTILITY(U,$J,358.3,21874,2)
 ;;=^5007844
 ;;^UTILITY(U,$J,358.3,21875,0)
 ;;=I80.292^^70^932^11
 ;;^UTILITY(U,$J,358.3,21875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21875,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Lower Extremity Deep Vessels
 ;;^UTILITY(U,$J,358.3,21875,1,4,0)
 ;;=4^I80.292
 ;;^UTILITY(U,$J,358.3,21875,2)
 ;;=^5133623
 ;;^UTILITY(U,$J,358.3,21876,0)
 ;;=I80.291^^70^932^17
 ;;^UTILITY(U,$J,358.3,21876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21876,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Right Lower Extremity Deep Vessels
 ;;^UTILITY(U,$J,358.3,21876,1,4,0)
 ;;=4^I80.291
 ;;^UTILITY(U,$J,358.3,21876,2)
 ;;=^5007843
 ;;^UTILITY(U,$J,358.3,21877,0)
 ;;=I80.8^^70^932^22
 ;;^UTILITY(U,$J,358.3,21877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21877,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis of Other Sites
 ;;^UTILITY(U,$J,358.3,21877,1,4,0)
 ;;=4^I80.8
 ;;^UTILITY(U,$J,358.3,21877,2)
 ;;=^176957
 ;;^UTILITY(U,$J,358.3,21878,0)
 ;;=I80.11^^70^932^15
 ;;^UTILITY(U,$J,358.3,21878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21878,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Right Femoral Vein
 ;;^UTILITY(U,$J,358.3,21878,1,4,0)
 ;;=4^I80.11
 ;;^UTILITY(U,$J,358.3,21878,2)
 ;;=^5007825
 ;;^UTILITY(U,$J,358.3,21879,0)
 ;;=I80.211^^70^932^16
 ;;^UTILITY(U,$J,358.3,21879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21879,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Right Iliac Vein
 ;;^UTILITY(U,$J,358.3,21879,1,4,0)
 ;;=4^I80.211
 ;;^UTILITY(U,$J,358.3,21879,2)
 ;;=^5007831
 ;;^UTILITY(U,$J,358.3,21880,0)
 ;;=I80.221^^70^932^19
 ;;^UTILITY(U,$J,358.3,21880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21880,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Right Popliteal Vein
 ;;^UTILITY(U,$J,358.3,21880,1,4,0)
 ;;=4^I80.221
