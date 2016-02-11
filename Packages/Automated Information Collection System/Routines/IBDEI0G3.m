IBDEI0G3 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7136,0)
 ;;=97607^^48^478^3^^^^1
 ;;^UTILITY(U,$J,358.3,7136,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7136,1,2,0)
 ;;=2^97607
 ;;^UTILITY(U,$J,358.3,7136,1,3,0)
 ;;=3^NEG PRESS WND TX NON DME EQUIP </= 50 CM
 ;;^UTILITY(U,$J,358.3,7137,0)
 ;;=97608^^48^478^4^^^^1
 ;;^UTILITY(U,$J,358.3,7137,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7137,1,2,0)
 ;;=2^97608
 ;;^UTILITY(U,$J,358.3,7137,1,3,0)
 ;;=3^NEG PRESS WND TX NON DME EQUIP > 50 CM
 ;;^UTILITY(U,$J,358.3,7138,0)
 ;;=E11.9^^49^479^86
 ;;^UTILITY(U,$J,358.3,7138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7138,1,3,0)
 ;;=3^Diabetes Type 2 w/o Complications
 ;;^UTILITY(U,$J,358.3,7138,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,7138,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,7139,0)
 ;;=E10.9^^49^479^52
 ;;^UTILITY(U,$J,358.3,7139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7139,1,3,0)
 ;;=3^Diabetes Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,7139,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,7139,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,7140,0)
 ;;=E11.65^^49^479^68
 ;;^UTILITY(U,$J,358.3,7140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7140,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,7140,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,7140,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,7141,0)
 ;;=E11.21^^49^479^57
 ;;^UTILITY(U,$J,358.3,7141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7141,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diab Nephropathy
 ;;^UTILITY(U,$J,358.3,7141,1,4,0)
 ;;=4^E11.21
 ;;^UTILITY(U,$J,358.3,7141,2)
 ;;=^5002629
 ;;^UTILITY(U,$J,358.3,7142,0)
 ;;=E11.22^^49^479^54
 ;;^UTILITY(U,$J,358.3,7142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7142,1,3,0)
 ;;=3^Diabetes Type 2 w/ Chronic Kidney Disease
 ;;^UTILITY(U,$J,358.3,7142,1,4,0)
 ;;=4^E11.22
 ;;^UTILITY(U,$J,358.3,7142,2)
 ;;=^5002630
 ;;^UTILITY(U,$J,358.3,7143,0)
 ;;=E11.29^^49^479^71
 ;;^UTILITY(U,$J,358.3,7143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7143,1,3,0)
 ;;=3^Diabetes Type 2 w/ Kidney Complications NEC
 ;;^UTILITY(U,$J,358.3,7143,1,4,0)
 ;;=4^E11.29
 ;;^UTILITY(U,$J,358.3,7143,2)
 ;;=^5002631
 ;;^UTILITY(U,$J,358.3,7144,0)
 ;;=E11.321^^49^479^72
 ;;^UTILITY(U,$J,358.3,7144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7144,1,3,0)
 ;;=3^Diabetes Type 2 w/ Mild Nonprlf Diab Rtnop w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,7144,1,4,0)
 ;;=4^E11.321
 ;;^UTILITY(U,$J,358.3,7144,2)
 ;;=^5002634
 ;;^UTILITY(U,$J,358.3,7145,0)
 ;;=E11.329^^49^479^73
 ;;^UTILITY(U,$J,358.3,7145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7145,1,3,0)
 ;;=3^Diabetes Type 2 w/ Mild Nonprlf Diab Rtnop w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,7145,1,4,0)
 ;;=4^E11.329
 ;;^UTILITY(U,$J,358.3,7145,2)
 ;;=^5002635
 ;;^UTILITY(U,$J,358.3,7146,0)
 ;;=E11.331^^49^479^74
 ;;^UTILITY(U,$J,358.3,7146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7146,1,3,0)
 ;;=3^Diabetes Type 2 w/ Moderate Nonprlf Diab Rtnop w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,7146,1,4,0)
 ;;=4^E11.331
 ;;^UTILITY(U,$J,358.3,7146,2)
 ;;=^5002636
 ;;^UTILITY(U,$J,358.3,7147,0)
 ;;=E11.339^^49^479^75
 ;;^UTILITY(U,$J,358.3,7147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7147,1,3,0)
 ;;=3^Diabetes Type 2 w/ Moderate Nonprlf Diab Rtnop w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,7147,1,4,0)
 ;;=4^E11.339
 ;;^UTILITY(U,$J,358.3,7147,2)
 ;;=^5002637
 ;;^UTILITY(U,$J,358.3,7148,0)
 ;;=E11.341^^49^479^80
 ;;^UTILITY(U,$J,358.3,7148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7148,1,3,0)
 ;;=3^Diabetes Type 2 w/ Severe Nonprlf Diab Rtnop w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,7148,1,4,0)
 ;;=4^E11.341
