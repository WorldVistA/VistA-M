IBDEI0K0 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8821,0)
 ;;=N28.1^^69^601^1
 ;;^UTILITY(U,$J,358.3,8821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8821,1,3,0)
 ;;=3^Cyst of Kidney,Acquired
 ;;^UTILITY(U,$J,358.3,8821,1,4,0)
 ;;=4^N28.1
 ;;^UTILITY(U,$J,358.3,8821,2)
 ;;=^270380
 ;;^UTILITY(U,$J,358.3,8822,0)
 ;;=Q61.9^^69^601^2
 ;;^UTILITY(U,$J,358.3,8822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8822,1,3,0)
 ;;=3^Cystic Kidney Disease,Unspec
 ;;^UTILITY(U,$J,358.3,8822,1,4,0)
 ;;=4^Q61.9
 ;;^UTILITY(U,$J,358.3,8822,2)
 ;;=^5018800
 ;;^UTILITY(U,$J,358.3,8823,0)
 ;;=Q61.2^^69^601^6
 ;;^UTILITY(U,$J,358.3,8823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8823,1,3,0)
 ;;=3^Polycystic Kidney,Adult Type
 ;;^UTILITY(U,$J,358.3,8823,1,4,0)
 ;;=4^Q61.2
 ;;^UTILITY(U,$J,358.3,8823,2)
 ;;=^5018796
 ;;^UTILITY(U,$J,358.3,8824,0)
 ;;=Q61.5^^69^601^4
 ;;^UTILITY(U,$J,358.3,8824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8824,1,3,0)
 ;;=3^Medullary Cystic Kidney
 ;;^UTILITY(U,$J,358.3,8824,1,4,0)
 ;;=4^Q61.5
 ;;^UTILITY(U,$J,358.3,8824,2)
 ;;=^67073
 ;;^UTILITY(U,$J,358.3,8825,0)
 ;;=Z82.71^^69^601^3
 ;;^UTILITY(U,$J,358.3,8825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8825,1,3,0)
 ;;=3^Family Hx of Polycystic Kidney
 ;;^UTILITY(U,$J,358.3,8825,1,4,0)
 ;;=4^Z82.71
 ;;^UTILITY(U,$J,358.3,8825,2)
 ;;=^321531
 ;;^UTILITY(U,$J,358.3,8826,0)
 ;;=Q61.5^^69^601^5
 ;;^UTILITY(U,$J,358.3,8826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8826,1,3,0)
 ;;=3^Medullary Sponge Kidney
 ;;^UTILITY(U,$J,358.3,8826,1,4,0)
 ;;=4^Q61.5
 ;;^UTILITY(U,$J,358.3,8826,2)
 ;;=^67073
 ;;^UTILITY(U,$J,358.3,8827,0)
 ;;=Q61.3^^69^601^7
 ;;^UTILITY(U,$J,358.3,8827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8827,1,3,0)
 ;;=3^Polycystic Kidney,Unspec
 ;;^UTILITY(U,$J,358.3,8827,1,4,0)
 ;;=4^Q61.3
 ;;^UTILITY(U,$J,358.3,8827,2)
 ;;=^5018797
 ;;^UTILITY(U,$J,358.3,8828,0)
 ;;=E11.65^^69^602^11
 ;;^UTILITY(U,$J,358.3,8828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8828,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,8828,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,8828,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,8829,0)
 ;;=E10.65^^69^602^6
 ;;^UTILITY(U,$J,358.3,8829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8829,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,8829,1,4,0)
 ;;=4^E10.65
 ;;^UTILITY(U,$J,358.3,8829,2)
 ;;=^5002623
 ;;^UTILITY(U,$J,358.3,8830,0)
 ;;=E11.21^^69^602^9
 ;;^UTILITY(U,$J,358.3,8830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8830,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,8830,1,4,0)
 ;;=4^E11.21
 ;;^UTILITY(U,$J,358.3,8830,2)
 ;;=^5002629
 ;;^UTILITY(U,$J,358.3,8831,0)
 ;;=E10.29^^69^602^3
 ;;^UTILITY(U,$J,358.3,8831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8831,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Kidney Complication
 ;;^UTILITY(U,$J,358.3,8831,1,4,0)
 ;;=4^E10.29
 ;;^UTILITY(U,$J,358.3,8831,2)
 ;;=^5002591
 ;;^UTILITY(U,$J,358.3,8832,0)
 ;;=E10.21^^69^602^4
 ;;^UTILITY(U,$J,358.3,8832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8832,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,8832,1,4,0)
 ;;=4^E10.21
 ;;^UTILITY(U,$J,358.3,8832,2)
 ;;=^5002589
 ;;^UTILITY(U,$J,358.3,8833,0)
 ;;=E11.40^^69^602^10
 ;;^UTILITY(U,$J,358.3,8833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8833,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neuropathy
