IBDEI278 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36913,0)
 ;;=C94.20^^169^1862^7
 ;;^UTILITY(U,$J,358.3,36913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36913,1,3,0)
 ;;=3^Acute megakaryoblastic leukemia not achieve remission
 ;;^UTILITY(U,$J,358.3,36913,1,4,0)
 ;;=4^C94.20
 ;;^UTILITY(U,$J,358.3,36913,2)
 ;;=^5001837
 ;;^UTILITY(U,$J,358.3,36914,0)
 ;;=C94.21^^169^1862^9
 ;;^UTILITY(U,$J,358.3,36914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36914,1,3,0)
 ;;=3^Acute megakaryoblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,36914,1,4,0)
 ;;=4^C94.21
 ;;^UTILITY(U,$J,358.3,36914,2)
 ;;=^5001838
 ;;^UTILITY(U,$J,358.3,36915,0)
 ;;=C94.22^^169^1862^8
 ;;^UTILITY(U,$J,358.3,36915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36915,1,3,0)
 ;;=3^Acute megakaryoblastic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,36915,1,4,0)
 ;;=4^C94.22
 ;;^UTILITY(U,$J,358.3,36915,2)
 ;;=^5001839
 ;;^UTILITY(U,$J,358.3,36916,0)
 ;;=C94.30^^169^1862^45
 ;;^UTILITY(U,$J,358.3,36916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36916,1,3,0)
 ;;=3^Mast cell leukemia not having achieved remission
 ;;^UTILITY(U,$J,358.3,36916,1,4,0)
 ;;=4^C94.30
 ;;^UTILITY(U,$J,358.3,36916,2)
 ;;=^5001840
 ;;^UTILITY(U,$J,358.3,36917,0)
 ;;=C94.31^^169^1862^47
 ;;^UTILITY(U,$J,358.3,36917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36917,1,3,0)
 ;;=3^Mast cell leukemia, in remission
 ;;^UTILITY(U,$J,358.3,36917,1,4,0)
 ;;=4^C94.31
 ;;^UTILITY(U,$J,358.3,36917,2)
 ;;=^5001841
 ;;^UTILITY(U,$J,358.3,36918,0)
 ;;=C94.32^^169^1862^46
 ;;^UTILITY(U,$J,358.3,36918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36918,1,3,0)
 ;;=3^Mast cell leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,36918,1,4,0)
 ;;=4^C94.32
 ;;^UTILITY(U,$J,358.3,36918,2)
 ;;=^5001842
 ;;^UTILITY(U,$J,358.3,36919,0)
 ;;=C95.00^^169^1862^4
 ;;^UTILITY(U,$J,358.3,36919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36919,1,3,0)
 ;;=3^Acute leukemia of unsp cell type not achieve remission
 ;;^UTILITY(U,$J,358.3,36919,1,4,0)
 ;;=4^C95.00
 ;;^UTILITY(U,$J,358.3,36919,2)
 ;;=^5001850
 ;;^UTILITY(U,$J,358.3,36920,0)
 ;;=C95.01^^169^1862^5
 ;;^UTILITY(U,$J,358.3,36920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36920,1,3,0)
 ;;=3^Acute leukemia of unspecified cell type, in remission
 ;;^UTILITY(U,$J,358.3,36920,1,4,0)
 ;;=4^C95.01
 ;;^UTILITY(U,$J,358.3,36920,2)
 ;;=^5001851
 ;;^UTILITY(U,$J,358.3,36921,0)
 ;;=C95.02^^169^1862^6
 ;;^UTILITY(U,$J,358.3,36921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36921,1,3,0)
 ;;=3^Acute leukemia of unspecified cell type, in relapse
 ;;^UTILITY(U,$J,358.3,36921,1,4,0)
 ;;=4^C95.02
 ;;^UTILITY(U,$J,358.3,36921,2)
 ;;=^5001852
 ;;^UTILITY(U,$J,358.3,36922,0)
 ;;=D45.^^169^1862^58
 ;;^UTILITY(U,$J,358.3,36922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36922,1,3,0)
 ;;=3^Polycythemia vera
 ;;^UTILITY(U,$J,358.3,36922,1,4,0)
 ;;=4^D45.
 ;;^UTILITY(U,$J,358.3,36922,2)
 ;;=^96105
 ;;^UTILITY(U,$J,358.3,36923,0)
 ;;=C95.10^^169^1862^25
 ;;^UTILITY(U,$J,358.3,36923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36923,1,3,0)
 ;;=3^Chronic leukemia of unsp cell type not achieve remission
 ;;^UTILITY(U,$J,358.3,36923,1,4,0)
 ;;=4^C95.10
 ;;^UTILITY(U,$J,358.3,36923,2)
 ;;=^5001853
 ;;^UTILITY(U,$J,358.3,36924,0)
 ;;=C95.11^^169^1862^26
 ;;^UTILITY(U,$J,358.3,36924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36924,1,3,0)
 ;;=3^Chronic leukemia of unspecified cell type, in remission
 ;;^UTILITY(U,$J,358.3,36924,1,4,0)
 ;;=4^C95.11
 ;;^UTILITY(U,$J,358.3,36924,2)
 ;;=^5001854
 ;;^UTILITY(U,$J,358.3,36925,0)
 ;;=C95.12^^169^1862^27
 ;;^UTILITY(U,$J,358.3,36925,1,0)
 ;;=^358.31IA^4^2
