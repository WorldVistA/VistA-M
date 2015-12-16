IBDEI03V ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1277,1,3,0)
 ;;=3^Multiple myeloma in remission
 ;;^UTILITY(U,$J,358.3,1277,1,4,0)
 ;;=4^C90.01
 ;;^UTILITY(U,$J,358.3,1277,2)
 ;;=^267515
 ;;^UTILITY(U,$J,358.3,1278,0)
 ;;=C91.00^^3^39^3
 ;;^UTILITY(U,$J,358.3,1278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1278,1,3,0)
 ;;=3^Acute lymphoblastic leukemia not having achieved remission
 ;;^UTILITY(U,$J,358.3,1278,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,1278,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,1279,0)
 ;;=C91.01^^3^39^4
 ;;^UTILITY(U,$J,358.3,1279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1279,1,3,0)
 ;;=3^Acute lymphoblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,1279,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,1279,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,1280,0)
 ;;=C91.10^^3^39^23
 ;;^UTILITY(U,$J,358.3,1280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1280,1,3,0)
 ;;=3^Chronic lymphocytic leuk of B-cell type not achieve remis
 ;;^UTILITY(U,$J,358.3,1280,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,1280,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,1281,0)
 ;;=C91.11^^3^39^24
 ;;^UTILITY(U,$J,358.3,1281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1281,1,3,0)
 ;;=3^Chronic lymphocytic leukemia of B-cell type in remission
 ;;^UTILITY(U,$J,358.3,1281,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,1281,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,1282,0)
 ;;=C92.00^^3^39^6
 ;;^UTILITY(U,$J,358.3,1282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1282,1,3,0)
 ;;=3^Acute myeloblastic leukemia, not having achieved remission
 ;;^UTILITY(U,$J,358.3,1282,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,1282,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,1283,0)
 ;;=C92.01^^3^39^5
 ;;^UTILITY(U,$J,358.3,1283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1283,1,3,0)
 ;;=3^Acute myeloblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,1283,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,1283,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,1284,0)
 ;;=C92.10^^3^39^25
 ;;^UTILITY(U,$J,358.3,1284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1284,1,3,0)
 ;;=3^Chronic myeloid leuk, BCR/ABL-positive, not achieve remis
 ;;^UTILITY(U,$J,358.3,1284,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,1284,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,1285,0)
 ;;=C92.11^^3^39^26
 ;;^UTILITY(U,$J,358.3,1285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1285,1,3,0)
 ;;=3^Chronic myeloid leukemia, BCR/ABL-positive, in remission
 ;;^UTILITY(U,$J,358.3,1285,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,1285,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,1286,0)
 ;;=D04.9^^3^39^21
 ;;^UTILITY(U,$J,358.3,1286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1286,1,3,0)
 ;;=3^Carcinoma in situ of skin, unspecified
 ;;^UTILITY(U,$J,358.3,1286,1,4,0)
 ;;=4^D04.9
 ;;^UTILITY(U,$J,358.3,1286,2)
 ;;=^5001925
 ;;^UTILITY(U,$J,358.3,1287,0)
 ;;=D06.9^^3^39^20
 ;;^UTILITY(U,$J,358.3,1287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1287,1,3,0)
 ;;=3^Carcinoma in situ of cervix, unspecified
 ;;^UTILITY(U,$J,358.3,1287,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,1287,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,1288,0)
 ;;=D09.0^^3^39^19
 ;;^UTILITY(U,$J,358.3,1288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1288,1,3,0)
 ;;=3^Carcinoma in situ of bladder
 ;;^UTILITY(U,$J,358.3,1288,1,4,0)
 ;;=4^D09.0
 ;;^UTILITY(U,$J,358.3,1288,2)
 ;;=^267742
 ;;^UTILITY(U,$J,358.3,1289,0)
 ;;=D45.^^3^39^93
 ;;^UTILITY(U,$J,358.3,1289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1289,1,3,0)
 ;;=3^Polycythemia vera
 ;;^UTILITY(U,$J,358.3,1289,1,4,0)
 ;;=4^D45.
 ;;^UTILITY(U,$J,358.3,1289,2)
 ;;=^96105
