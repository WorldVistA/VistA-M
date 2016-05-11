IBDEI1SB ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30319,1,4,0)
 ;;=4^C93.91
 ;;^UTILITY(U,$J,358.3,30319,2)
 ;;=^5001829
 ;;^UTILITY(U,$J,358.3,30320,0)
 ;;=C93.92^^118^1505^49
 ;;^UTILITY(U,$J,358.3,30320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30320,1,3,0)
 ;;=3^Monocytic leukemia, unspecified in relapse
 ;;^UTILITY(U,$J,358.3,30320,1,4,0)
 ;;=4^C93.92
 ;;^UTILITY(U,$J,358.3,30320,2)
 ;;=^5001830
 ;;^UTILITY(U,$J,358.3,30321,0)
 ;;=C94.00^^118^1505^3
 ;;^UTILITY(U,$J,358.3,30321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30321,1,3,0)
 ;;=3^Acute erythroid leukemia, not having achieved remission
 ;;^UTILITY(U,$J,358.3,30321,1,4,0)
 ;;=4^C94.00
 ;;^UTILITY(U,$J,358.3,30321,2)
 ;;=^5001834
 ;;^UTILITY(U,$J,358.3,30322,0)
 ;;=C94.01^^118^1505^2
 ;;^UTILITY(U,$J,358.3,30322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30322,1,3,0)
 ;;=3^Acute erythroid leukemia, in remission
 ;;^UTILITY(U,$J,358.3,30322,1,4,0)
 ;;=4^C94.01
 ;;^UTILITY(U,$J,358.3,30322,2)
 ;;=^5001835
 ;;^UTILITY(U,$J,358.3,30323,0)
 ;;=C94.02^^118^1505^1
 ;;^UTILITY(U,$J,358.3,30323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30323,1,3,0)
 ;;=3^Acute erythroid leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,30323,1,4,0)
 ;;=4^C94.02
 ;;^UTILITY(U,$J,358.3,30323,2)
 ;;=^5001836
 ;;^UTILITY(U,$J,358.3,30324,0)
 ;;=C94.20^^118^1505^7
 ;;^UTILITY(U,$J,358.3,30324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30324,1,3,0)
 ;;=3^Acute megakaryoblastic leukemia not achieve remission
 ;;^UTILITY(U,$J,358.3,30324,1,4,0)
 ;;=4^C94.20
 ;;^UTILITY(U,$J,358.3,30324,2)
 ;;=^5001837
 ;;^UTILITY(U,$J,358.3,30325,0)
 ;;=C94.21^^118^1505^9
 ;;^UTILITY(U,$J,358.3,30325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30325,1,3,0)
 ;;=3^Acute megakaryoblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,30325,1,4,0)
 ;;=4^C94.21
 ;;^UTILITY(U,$J,358.3,30325,2)
 ;;=^5001838
 ;;^UTILITY(U,$J,358.3,30326,0)
 ;;=C94.22^^118^1505^8
 ;;^UTILITY(U,$J,358.3,30326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30326,1,3,0)
 ;;=3^Acute megakaryoblastic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,30326,1,4,0)
 ;;=4^C94.22
 ;;^UTILITY(U,$J,358.3,30326,2)
 ;;=^5001839
 ;;^UTILITY(U,$J,358.3,30327,0)
 ;;=C94.30^^118^1505^45
 ;;^UTILITY(U,$J,358.3,30327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30327,1,3,0)
 ;;=3^Mast cell leukemia not having achieved remission
 ;;^UTILITY(U,$J,358.3,30327,1,4,0)
 ;;=4^C94.30
 ;;^UTILITY(U,$J,358.3,30327,2)
 ;;=^5001840
 ;;^UTILITY(U,$J,358.3,30328,0)
 ;;=C94.31^^118^1505^47
 ;;^UTILITY(U,$J,358.3,30328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30328,1,3,0)
 ;;=3^Mast cell leukemia, in remission
 ;;^UTILITY(U,$J,358.3,30328,1,4,0)
 ;;=4^C94.31
 ;;^UTILITY(U,$J,358.3,30328,2)
 ;;=^5001841
 ;;^UTILITY(U,$J,358.3,30329,0)
 ;;=C94.32^^118^1505^46
 ;;^UTILITY(U,$J,358.3,30329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30329,1,3,0)
 ;;=3^Mast cell leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,30329,1,4,0)
 ;;=4^C94.32
 ;;^UTILITY(U,$J,358.3,30329,2)
 ;;=^5001842
 ;;^UTILITY(U,$J,358.3,30330,0)
 ;;=C95.00^^118^1505^4
 ;;^UTILITY(U,$J,358.3,30330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30330,1,3,0)
 ;;=3^Acute leukemia of unsp cell type not achieve remission
 ;;^UTILITY(U,$J,358.3,30330,1,4,0)
 ;;=4^C95.00
 ;;^UTILITY(U,$J,358.3,30330,2)
 ;;=^5001850
 ;;^UTILITY(U,$J,358.3,30331,0)
 ;;=C95.01^^118^1505^5
 ;;^UTILITY(U,$J,358.3,30331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30331,1,3,0)
 ;;=3^Acute leukemia of unspecified cell type, in remission
 ;;^UTILITY(U,$J,358.3,30331,1,4,0)
 ;;=4^C95.01
 ;;^UTILITY(U,$J,358.3,30331,2)
 ;;=^5001851
 ;;^UTILITY(U,$J,358.3,30332,0)
 ;;=C95.02^^118^1505^6
