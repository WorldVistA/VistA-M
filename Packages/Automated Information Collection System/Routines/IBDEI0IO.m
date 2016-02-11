IBDEI0IO ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8389,1,4,0)
 ;;=4^C91.40
 ;;^UTILITY(U,$J,358.3,8389,2)
 ;;=^5001771
 ;;^UTILITY(U,$J,358.3,8390,0)
 ;;=C90.00^^55^538^88
 ;;^UTILITY(U,$J,358.3,8390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8390,1,3,0)
 ;;=3^Multiple myeloma not having achieved remission
 ;;^UTILITY(U,$J,358.3,8390,1,4,0)
 ;;=4^C90.00
 ;;^UTILITY(U,$J,358.3,8390,2)
 ;;=^5001752
 ;;^UTILITY(U,$J,358.3,8391,0)
 ;;=C90.01^^55^538^87
 ;;^UTILITY(U,$J,358.3,8391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8391,1,3,0)
 ;;=3^Multiple myeloma in remission
 ;;^UTILITY(U,$J,358.3,8391,1,4,0)
 ;;=4^C90.01
 ;;^UTILITY(U,$J,358.3,8391,2)
 ;;=^267515
 ;;^UTILITY(U,$J,358.3,8392,0)
 ;;=C91.00^^55^538^3
 ;;^UTILITY(U,$J,358.3,8392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8392,1,3,0)
 ;;=3^Acute lymphoblastic leukemia not having achieved remission
 ;;^UTILITY(U,$J,358.3,8392,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,8392,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,8393,0)
 ;;=C91.01^^55^538^4
 ;;^UTILITY(U,$J,358.3,8393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8393,1,3,0)
 ;;=3^Acute lymphoblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,8393,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,8393,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,8394,0)
 ;;=C91.10^^55^538^23
 ;;^UTILITY(U,$J,358.3,8394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8394,1,3,0)
 ;;=3^Chronic lymphocytic leuk of B-cell type not achieve remis
 ;;^UTILITY(U,$J,358.3,8394,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,8394,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,8395,0)
 ;;=C91.11^^55^538^24
 ;;^UTILITY(U,$J,358.3,8395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8395,1,3,0)
 ;;=3^Chronic lymphocytic leukemia of B-cell type in remission
 ;;^UTILITY(U,$J,358.3,8395,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,8395,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,8396,0)
 ;;=C92.00^^55^538^6
 ;;^UTILITY(U,$J,358.3,8396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8396,1,3,0)
 ;;=3^Acute myeloblastic leukemia, not having achieved remission
 ;;^UTILITY(U,$J,358.3,8396,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,8396,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,8397,0)
 ;;=C92.01^^55^538^5
 ;;^UTILITY(U,$J,358.3,8397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8397,1,3,0)
 ;;=3^Acute myeloblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,8397,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,8397,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,8398,0)
 ;;=C92.10^^55^538^25
 ;;^UTILITY(U,$J,358.3,8398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8398,1,3,0)
 ;;=3^Chronic myeloid leuk, BCR/ABL-positive, not achieve remis
 ;;^UTILITY(U,$J,358.3,8398,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,8398,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,8399,0)
 ;;=C92.11^^55^538^26
 ;;^UTILITY(U,$J,358.3,8399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8399,1,3,0)
 ;;=3^Chronic myeloid leukemia, BCR/ABL-positive, in remission
 ;;^UTILITY(U,$J,358.3,8399,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,8399,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,8400,0)
 ;;=D04.9^^55^538^21
 ;;^UTILITY(U,$J,358.3,8400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8400,1,3,0)
 ;;=3^Carcinoma in situ of skin, unspecified
 ;;^UTILITY(U,$J,358.3,8400,1,4,0)
 ;;=4^D04.9
 ;;^UTILITY(U,$J,358.3,8400,2)
 ;;=^5001925
 ;;^UTILITY(U,$J,358.3,8401,0)
 ;;=D06.9^^55^538^20
 ;;^UTILITY(U,$J,358.3,8401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8401,1,3,0)
 ;;=3^Carcinoma in situ of cervix, unspecified
 ;;^UTILITY(U,$J,358.3,8401,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,8401,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,8402,0)
 ;;=D09.0^^55^538^19
