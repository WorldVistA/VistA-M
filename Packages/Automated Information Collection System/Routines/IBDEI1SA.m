IBDEI1SA ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30307,1,3,0)
 ;;=3^Myeloid sarcoma, in remission
 ;;^UTILITY(U,$J,358.3,30307,1,4,0)
 ;;=4^C92.31
 ;;^UTILITY(U,$J,358.3,30307,2)
 ;;=^5001799
 ;;^UTILITY(U,$J,358.3,30308,0)
 ;;=C92.32^^118^1505^55
 ;;^UTILITY(U,$J,358.3,30308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30308,1,3,0)
 ;;=3^Myeloid sarcoma, in relapse
 ;;^UTILITY(U,$J,358.3,30308,1,4,0)
 ;;=4^C92.32
 ;;^UTILITY(U,$J,358.3,30308,2)
 ;;=^5001800
 ;;^UTILITY(U,$J,358.3,30309,0)
 ;;=C92.90^^118^1505^54
 ;;^UTILITY(U,$J,358.3,30309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30309,1,3,0)
 ;;=3^Myeloid leukemia, unspecified, not having achieved remission
 ;;^UTILITY(U,$J,358.3,30309,1,4,0)
 ;;=4^C92.90
 ;;^UTILITY(U,$J,358.3,30309,2)
 ;;=^5001810
 ;;^UTILITY(U,$J,358.3,30310,0)
 ;;=C92.91^^118^1505^53
 ;;^UTILITY(U,$J,358.3,30310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30310,1,3,0)
 ;;=3^Myeloid leukemia, unspecified in remission
 ;;^UTILITY(U,$J,358.3,30310,1,4,0)
 ;;=4^C92.91
 ;;^UTILITY(U,$J,358.3,30310,2)
 ;;=^5001811
 ;;^UTILITY(U,$J,358.3,30311,0)
 ;;=C92.92^^118^1505^52
 ;;^UTILITY(U,$J,358.3,30311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30311,1,3,0)
 ;;=3^Myeloid leukemia, unspecified in relapse
 ;;^UTILITY(U,$J,358.3,30311,1,4,0)
 ;;=4^C92.92
 ;;^UTILITY(U,$J,358.3,30311,2)
 ;;=^5001812
 ;;^UTILITY(U,$J,358.3,30312,0)
 ;;=C93.00^^118^1505^12
 ;;^UTILITY(U,$J,358.3,30312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30312,1,3,0)
 ;;=3^Acute monoblastic/monocytic leukemia, not achieve remission
 ;;^UTILITY(U,$J,358.3,30312,1,4,0)
 ;;=4^C93.00
 ;;^UTILITY(U,$J,358.3,30312,2)
 ;;=^5001819
 ;;^UTILITY(U,$J,358.3,30313,0)
 ;;=C93.01^^118^1505^10
 ;;^UTILITY(U,$J,358.3,30313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30313,1,3,0)
 ;;=3^Acute monoblastic/monocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,30313,1,4,0)
 ;;=4^C93.01
 ;;^UTILITY(U,$J,358.3,30313,2)
 ;;=^5001820
 ;;^UTILITY(U,$J,358.3,30314,0)
 ;;=C93.02^^118^1505^11
 ;;^UTILITY(U,$J,358.3,30314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30314,1,3,0)
 ;;=3^Acute monoblastic/monocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,30314,1,4,0)
 ;;=4^C93.02
 ;;^UTILITY(U,$J,358.3,30314,2)
 ;;=^5001821
 ;;^UTILITY(U,$J,358.3,30315,0)
 ;;=C93.10^^118^1505^31
 ;;^UTILITY(U,$J,358.3,30315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30315,1,3,0)
 ;;=3^Chronic myelomonocytic leukemia not achieve remission
 ;;^UTILITY(U,$J,358.3,30315,1,4,0)
 ;;=4^C93.10
 ;;^UTILITY(U,$J,358.3,30315,2)
 ;;=^5001822
 ;;^UTILITY(U,$J,358.3,30316,0)
 ;;=C93.11^^118^1505^33
 ;;^UTILITY(U,$J,358.3,30316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30316,1,3,0)
 ;;=3^Chronic myelomonocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,30316,1,4,0)
 ;;=4^C93.11
 ;;^UTILITY(U,$J,358.3,30316,2)
 ;;=^5001823
 ;;^UTILITY(U,$J,358.3,30317,0)
 ;;=C93.12^^118^1505^32
 ;;^UTILITY(U,$J,358.3,30317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30317,1,3,0)
 ;;=3^Chronic myelomonocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,30317,1,4,0)
 ;;=4^C93.12
 ;;^UTILITY(U,$J,358.3,30317,2)
 ;;=^5001824
 ;;^UTILITY(U,$J,358.3,30318,0)
 ;;=C93.90^^118^1505^48
 ;;^UTILITY(U,$J,358.3,30318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30318,1,3,0)
 ;;=3^Monocytic leukemia, unsp, not having achieved remission
 ;;^UTILITY(U,$J,358.3,30318,1,4,0)
 ;;=4^C93.90
 ;;^UTILITY(U,$J,358.3,30318,2)
 ;;=^5001828
 ;;^UTILITY(U,$J,358.3,30319,0)
 ;;=C93.91^^118^1505^50
 ;;^UTILITY(U,$J,358.3,30319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30319,1,3,0)
 ;;=3^Monocytic leukemia, unspecified in remission
