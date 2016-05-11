IBDEI0BA ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5092,0)
 ;;=Q61.9^^27^328^2
 ;;^UTILITY(U,$J,358.3,5092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5092,1,3,0)
 ;;=3^Cystic Kidney Disease,Unspec
 ;;^UTILITY(U,$J,358.3,5092,1,4,0)
 ;;=4^Q61.9
 ;;^UTILITY(U,$J,358.3,5092,2)
 ;;=^5018800
 ;;^UTILITY(U,$J,358.3,5093,0)
 ;;=Q61.2^^27^328^6
 ;;^UTILITY(U,$J,358.3,5093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5093,1,3,0)
 ;;=3^Polycystic Kidney,Adult Type
 ;;^UTILITY(U,$J,358.3,5093,1,4,0)
 ;;=4^Q61.2
 ;;^UTILITY(U,$J,358.3,5093,2)
 ;;=^5018796
 ;;^UTILITY(U,$J,358.3,5094,0)
 ;;=Q61.5^^27^328^4
 ;;^UTILITY(U,$J,358.3,5094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5094,1,3,0)
 ;;=3^Medullary Cystic Kidney
 ;;^UTILITY(U,$J,358.3,5094,1,4,0)
 ;;=4^Q61.5
 ;;^UTILITY(U,$J,358.3,5094,2)
 ;;=^67073
 ;;^UTILITY(U,$J,358.3,5095,0)
 ;;=Z82.71^^27^328^3
 ;;^UTILITY(U,$J,358.3,5095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5095,1,3,0)
 ;;=3^Family Hx of Polycystic Kidney
 ;;^UTILITY(U,$J,358.3,5095,1,4,0)
 ;;=4^Z82.71
 ;;^UTILITY(U,$J,358.3,5095,2)
 ;;=^321531
 ;;^UTILITY(U,$J,358.3,5096,0)
 ;;=Q61.5^^27^328^5
 ;;^UTILITY(U,$J,358.3,5096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5096,1,3,0)
 ;;=3^Medullary Sponge Kidney
 ;;^UTILITY(U,$J,358.3,5096,1,4,0)
 ;;=4^Q61.5
 ;;^UTILITY(U,$J,358.3,5096,2)
 ;;=^67073
 ;;^UTILITY(U,$J,358.3,5097,0)
 ;;=Q61.3^^27^328^7
 ;;^UTILITY(U,$J,358.3,5097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5097,1,3,0)
 ;;=3^Polycystic Kidney,Unspec
 ;;^UTILITY(U,$J,358.3,5097,1,4,0)
 ;;=4^Q61.3
 ;;^UTILITY(U,$J,358.3,5097,2)
 ;;=^5018797
 ;;^UTILITY(U,$J,358.3,5098,0)
 ;;=E11.65^^27^329^11
 ;;^UTILITY(U,$J,358.3,5098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5098,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,5098,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,5098,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,5099,0)
 ;;=E10.65^^27^329^6
 ;;^UTILITY(U,$J,358.3,5099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5099,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,5099,1,4,0)
 ;;=4^E10.65
 ;;^UTILITY(U,$J,358.3,5099,2)
 ;;=^5002623
 ;;^UTILITY(U,$J,358.3,5100,0)
 ;;=E11.21^^27^329^9
 ;;^UTILITY(U,$J,358.3,5100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5100,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,5100,1,4,0)
 ;;=4^E11.21
 ;;^UTILITY(U,$J,358.3,5100,2)
 ;;=^5002629
 ;;^UTILITY(U,$J,358.3,5101,0)
 ;;=E10.29^^27^329^3
 ;;^UTILITY(U,$J,358.3,5101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5101,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Kidney Complication
 ;;^UTILITY(U,$J,358.3,5101,1,4,0)
 ;;=4^E10.29
 ;;^UTILITY(U,$J,358.3,5101,2)
 ;;=^5002591
 ;;^UTILITY(U,$J,358.3,5102,0)
 ;;=E10.21^^27^329^4
 ;;^UTILITY(U,$J,358.3,5102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5102,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,5102,1,4,0)
 ;;=4^E10.21
 ;;^UTILITY(U,$J,358.3,5102,2)
 ;;=^5002589
 ;;^UTILITY(U,$J,358.3,5103,0)
 ;;=E11.40^^27^329^10
 ;;^UTILITY(U,$J,358.3,5103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5103,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neuropathy
 ;;^UTILITY(U,$J,358.3,5103,1,4,0)
 ;;=4^E11.40
 ;;^UTILITY(U,$J,358.3,5103,2)
 ;;=^5002644
 ;;^UTILITY(U,$J,358.3,5104,0)
 ;;=E10.40^^27^329^5
 ;;^UTILITY(U,$J,358.3,5104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5104,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neuropathy
 ;;^UTILITY(U,$J,358.3,5104,1,4,0)
 ;;=4^E10.40
 ;;^UTILITY(U,$J,358.3,5104,2)
 ;;=^5002604
 ;;^UTILITY(U,$J,358.3,5105,0)
 ;;=E10.22^^27^329^2
 ;;^UTILITY(U,$J,358.3,5105,1,0)
 ;;=^358.31IA^4^2
