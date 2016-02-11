IBDEI0GS ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7490,1,3,0)
 ;;=3^Thrombosis of Vascular Graft,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7490,1,4,0)
 ;;=4^T82.868D
 ;;^UTILITY(U,$J,358.3,7490,2)
 ;;=^5054948
 ;;^UTILITY(U,$J,358.3,7491,0)
 ;;=N28.1^^52^502^1
 ;;^UTILITY(U,$J,358.3,7491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7491,1,3,0)
 ;;=3^Cyst of Kidney,Acquired
 ;;^UTILITY(U,$J,358.3,7491,1,4,0)
 ;;=4^N28.1
 ;;^UTILITY(U,$J,358.3,7491,2)
 ;;=^270380
 ;;^UTILITY(U,$J,358.3,7492,0)
 ;;=Q61.9^^52^502^2
 ;;^UTILITY(U,$J,358.3,7492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7492,1,3,0)
 ;;=3^Cystic Kidney Disease,Unspec
 ;;^UTILITY(U,$J,358.3,7492,1,4,0)
 ;;=4^Q61.9
 ;;^UTILITY(U,$J,358.3,7492,2)
 ;;=^5018800
 ;;^UTILITY(U,$J,358.3,7493,0)
 ;;=Q61.2^^52^502^6
 ;;^UTILITY(U,$J,358.3,7493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7493,1,3,0)
 ;;=3^Polycystic Kidney,Adult Type
 ;;^UTILITY(U,$J,358.3,7493,1,4,0)
 ;;=4^Q61.2
 ;;^UTILITY(U,$J,358.3,7493,2)
 ;;=^5018796
 ;;^UTILITY(U,$J,358.3,7494,0)
 ;;=Q61.5^^52^502^4
 ;;^UTILITY(U,$J,358.3,7494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7494,1,3,0)
 ;;=3^Medullary Cystic Kidney
 ;;^UTILITY(U,$J,358.3,7494,1,4,0)
 ;;=4^Q61.5
 ;;^UTILITY(U,$J,358.3,7494,2)
 ;;=^67073
 ;;^UTILITY(U,$J,358.3,7495,0)
 ;;=Z82.71^^52^502^3
 ;;^UTILITY(U,$J,358.3,7495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7495,1,3,0)
 ;;=3^Family Hx of Polycystic Kidney
 ;;^UTILITY(U,$J,358.3,7495,1,4,0)
 ;;=4^Z82.71
 ;;^UTILITY(U,$J,358.3,7495,2)
 ;;=^321531
 ;;^UTILITY(U,$J,358.3,7496,0)
 ;;=Q61.5^^52^502^5
 ;;^UTILITY(U,$J,358.3,7496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7496,1,3,0)
 ;;=3^Medullary Sponge Kidney
 ;;^UTILITY(U,$J,358.3,7496,1,4,0)
 ;;=4^Q61.5
 ;;^UTILITY(U,$J,358.3,7496,2)
 ;;=^67073
 ;;^UTILITY(U,$J,358.3,7497,0)
 ;;=Q61.3^^52^502^7
 ;;^UTILITY(U,$J,358.3,7497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7497,1,3,0)
 ;;=3^Polycystic Kidney,Unspec
 ;;^UTILITY(U,$J,358.3,7497,1,4,0)
 ;;=4^Q61.3
 ;;^UTILITY(U,$J,358.3,7497,2)
 ;;=^5018797
 ;;^UTILITY(U,$J,358.3,7498,0)
 ;;=E11.65^^52^503^11
 ;;^UTILITY(U,$J,358.3,7498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7498,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,7498,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,7498,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,7499,0)
 ;;=E10.65^^52^503^6
 ;;^UTILITY(U,$J,358.3,7499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7499,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,7499,1,4,0)
 ;;=4^E10.65
 ;;^UTILITY(U,$J,358.3,7499,2)
 ;;=^5002623
 ;;^UTILITY(U,$J,358.3,7500,0)
 ;;=E11.21^^52^503^9
 ;;^UTILITY(U,$J,358.3,7500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7500,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,7500,1,4,0)
 ;;=4^E11.21
 ;;^UTILITY(U,$J,358.3,7500,2)
 ;;=^5002629
 ;;^UTILITY(U,$J,358.3,7501,0)
 ;;=E10.29^^52^503^3
 ;;^UTILITY(U,$J,358.3,7501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7501,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Kidney Complication
 ;;^UTILITY(U,$J,358.3,7501,1,4,0)
 ;;=4^E10.29
 ;;^UTILITY(U,$J,358.3,7501,2)
 ;;=^5002591
 ;;^UTILITY(U,$J,358.3,7502,0)
 ;;=E10.21^^52^503^4
 ;;^UTILITY(U,$J,358.3,7502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7502,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,7502,1,4,0)
 ;;=4^E10.21
 ;;^UTILITY(U,$J,358.3,7502,2)
 ;;=^5002589
 ;;^UTILITY(U,$J,358.3,7503,0)
 ;;=E11.40^^52^503^10
 ;;^UTILITY(U,$J,358.3,7503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7503,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neuropathy
