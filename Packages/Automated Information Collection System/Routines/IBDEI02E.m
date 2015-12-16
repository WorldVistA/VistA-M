IBDEI02E ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,570,1,4,0)
 ;;=4^C93.12
 ;;^UTILITY(U,$J,358.3,570,2)
 ;;=^5001824
 ;;^UTILITY(U,$J,358.3,571,0)
 ;;=C93.90^^2^24^45
 ;;^UTILITY(U,$J,358.3,571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,571,1,3,0)
 ;;=3^Monocytic leukemia, unsp, not having achieved remission
 ;;^UTILITY(U,$J,358.3,571,1,4,0)
 ;;=4^C93.90
 ;;^UTILITY(U,$J,358.3,571,2)
 ;;=^5001828
 ;;^UTILITY(U,$J,358.3,572,0)
 ;;=C93.91^^2^24^47
 ;;^UTILITY(U,$J,358.3,572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,572,1,3,0)
 ;;=3^Monocytic leukemia, unspecified in remission
 ;;^UTILITY(U,$J,358.3,572,1,4,0)
 ;;=4^C93.91
 ;;^UTILITY(U,$J,358.3,572,2)
 ;;=^5001829
 ;;^UTILITY(U,$J,358.3,573,0)
 ;;=C93.92^^2^24^46
 ;;^UTILITY(U,$J,358.3,573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,573,1,3,0)
 ;;=3^Monocytic leukemia, unspecified in relapse
 ;;^UTILITY(U,$J,358.3,573,1,4,0)
 ;;=4^C93.92
 ;;^UTILITY(U,$J,358.3,573,2)
 ;;=^5001830
 ;;^UTILITY(U,$J,358.3,574,0)
 ;;=C94.00^^2^24^3
 ;;^UTILITY(U,$J,358.3,574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,574,1,3,0)
 ;;=3^Acute erythroid leukemia, not having achieved remission
 ;;^UTILITY(U,$J,358.3,574,1,4,0)
 ;;=4^C94.00
 ;;^UTILITY(U,$J,358.3,574,2)
 ;;=^5001834
 ;;^UTILITY(U,$J,358.3,575,0)
 ;;=C94.01^^2^24^2
 ;;^UTILITY(U,$J,358.3,575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,575,1,3,0)
 ;;=3^Acute erythroid leukemia, in remission
 ;;^UTILITY(U,$J,358.3,575,1,4,0)
 ;;=4^C94.01
 ;;^UTILITY(U,$J,358.3,575,2)
 ;;=^5001835
 ;;^UTILITY(U,$J,358.3,576,0)
 ;;=C94.02^^2^24^1
 ;;^UTILITY(U,$J,358.3,576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,576,1,3,0)
 ;;=3^Acute erythroid leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,576,1,4,0)
 ;;=4^C94.02
 ;;^UTILITY(U,$J,358.3,576,2)
 ;;=^5001836
 ;;^UTILITY(U,$J,358.3,577,0)
 ;;=C94.20^^2^24^7
 ;;^UTILITY(U,$J,358.3,577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,577,1,3,0)
 ;;=3^Acute megakaryoblastic leukemia not achieve remission
 ;;^UTILITY(U,$J,358.3,577,1,4,0)
 ;;=4^C94.20
 ;;^UTILITY(U,$J,358.3,577,2)
 ;;=^5001837
 ;;^UTILITY(U,$J,358.3,578,0)
 ;;=C94.21^^2^24^9
 ;;^UTILITY(U,$J,358.3,578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,578,1,3,0)
 ;;=3^Acute megakaryoblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,578,1,4,0)
 ;;=4^C94.21
 ;;^UTILITY(U,$J,358.3,578,2)
 ;;=^5001838
 ;;^UTILITY(U,$J,358.3,579,0)
 ;;=C94.22^^2^24^8
 ;;^UTILITY(U,$J,358.3,579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,579,1,3,0)
 ;;=3^Acute megakaryoblastic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,579,1,4,0)
 ;;=4^C94.22
 ;;^UTILITY(U,$J,358.3,579,2)
 ;;=^5001839
 ;;^UTILITY(U,$J,358.3,580,0)
 ;;=C94.30^^2^24^42
 ;;^UTILITY(U,$J,358.3,580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,580,1,3,0)
 ;;=3^Mast cell leukemia not having achieved remission
 ;;^UTILITY(U,$J,358.3,580,1,4,0)
 ;;=4^C94.30
 ;;^UTILITY(U,$J,358.3,580,2)
 ;;=^5001840
 ;;^UTILITY(U,$J,358.3,581,0)
 ;;=C94.31^^2^24^44
 ;;^UTILITY(U,$J,358.3,581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,581,1,3,0)
 ;;=3^Mast cell leukemia, in remission
 ;;^UTILITY(U,$J,358.3,581,1,4,0)
 ;;=4^C94.31
 ;;^UTILITY(U,$J,358.3,581,2)
 ;;=^5001841
 ;;^UTILITY(U,$J,358.3,582,0)
 ;;=C94.32^^2^24^43
 ;;^UTILITY(U,$J,358.3,582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,582,1,3,0)
 ;;=3^Mast cell leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,582,1,4,0)
 ;;=4^C94.32
 ;;^UTILITY(U,$J,358.3,582,2)
 ;;=^5001842
 ;;^UTILITY(U,$J,358.3,583,0)
 ;;=C95.00^^2^24^4
 ;;^UTILITY(U,$J,358.3,583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,583,1,3,0)
 ;;=3^Acute leukemia of unsp cell type not achieve remission
