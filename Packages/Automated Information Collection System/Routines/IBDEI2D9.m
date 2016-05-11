IBDEI2D9 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40127,1,3,0)
 ;;=3^Extramedullary plasmacytoma in relapse
 ;;^UTILITY(U,$J,358.3,40127,1,4,0)
 ;;=4^C90.22
 ;;^UTILITY(U,$J,358.3,40127,2)
 ;;=^5001758
 ;;^UTILITY(U,$J,358.3,40128,0)
 ;;=C90.32^^156^1952^49
 ;;^UTILITY(U,$J,358.3,40128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40128,1,3,0)
 ;;=3^Solitary plasmacytoma in relapse
 ;;^UTILITY(U,$J,358.3,40128,1,4,0)
 ;;=4^C90.32
 ;;^UTILITY(U,$J,358.3,40128,2)
 ;;=^5001761
 ;;^UTILITY(U,$J,358.3,40129,0)
 ;;=C91.01^^156^1952^2
 ;;^UTILITY(U,$J,358.3,40129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40129,1,3,0)
 ;;=3^Acute lymphoblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,40129,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,40129,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,40130,0)
 ;;=C91.02^^156^1952^1
 ;;^UTILITY(U,$J,358.3,40130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40130,1,3,0)
 ;;=3^Acute lymphoblastic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,40130,1,4,0)
 ;;=4^C91.02
 ;;^UTILITY(U,$J,358.3,40130,2)
 ;;=^5001764
 ;;^UTILITY(U,$J,358.3,40131,0)
 ;;=C91.11^^156^1952^16
 ;;^UTILITY(U,$J,358.3,40131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40131,1,3,0)
 ;;=3^Chronic lymphocytic leukemia of B-cell type in remission
 ;;^UTILITY(U,$J,358.3,40131,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,40131,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,40132,0)
 ;;=C91.12^^156^1952^17
 ;;^UTILITY(U,$J,358.3,40132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40132,1,3,0)
 ;;=3^Chronic lymphocytic leukemia of B-cell type in relapse
 ;;^UTILITY(U,$J,358.3,40132,1,4,0)
 ;;=4^C91.12
 ;;^UTILITY(U,$J,358.3,40132,2)
 ;;=^5001767
 ;;^UTILITY(U,$J,358.3,40133,0)
 ;;=C91.Z1^^156^1952^32
 ;;^UTILITY(U,$J,358.3,40133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40133,1,3,0)
 ;;=3^Lymphoid leukemia, in remission NEC
 ;;^UTILITY(U,$J,358.3,40133,1,4,0)
 ;;=4^C91.Z1
 ;;^UTILITY(U,$J,358.3,40133,2)
 ;;=^5001787
 ;;^UTILITY(U,$J,358.3,40134,0)
 ;;=C91.Z2^^156^1952^31
 ;;^UTILITY(U,$J,358.3,40134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40134,1,3,0)
 ;;=3^Lymphoid leukemia, in relapse NEC
 ;;^UTILITY(U,$J,358.3,40134,1,4,0)
 ;;=4^C91.Z2
 ;;^UTILITY(U,$J,358.3,40134,2)
 ;;=^5001788
 ;;^UTILITY(U,$J,358.3,40135,0)
 ;;=C92.01^^156^1952^6
 ;;^UTILITY(U,$J,358.3,40135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40135,1,3,0)
 ;;=3^Acute myeloblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,40135,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,40135,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,40136,0)
 ;;=C92.41^^156^1952^10
 ;;^UTILITY(U,$J,358.3,40136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40136,1,3,0)
 ;;=3^Acute promyelocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,40136,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,40136,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,40137,0)
 ;;=C92.51^^156^1952^8
 ;;^UTILITY(U,$J,358.3,40137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40137,1,3,0)
 ;;=3^Acute myelomonocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,40137,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,40137,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,40138,0)
 ;;=C92.02^^156^1952^5
 ;;^UTILITY(U,$J,358.3,40138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40138,1,3,0)
 ;;=3^Acute myeloblastic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,40138,1,4,0)
 ;;=4^C92.02
 ;;^UTILITY(U,$J,358.3,40138,2)
 ;;=^5001791
 ;;^UTILITY(U,$J,358.3,40139,0)
 ;;=C92.42^^156^1952^9
 ;;^UTILITY(U,$J,358.3,40139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40139,1,3,0)
 ;;=3^Acute promyelocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,40139,1,4,0)
 ;;=4^C92.42
