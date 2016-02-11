IBDEI277 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36900,1,4,0)
 ;;=4^C92.92
 ;;^UTILITY(U,$J,358.3,36900,2)
 ;;=^5001812
 ;;^UTILITY(U,$J,358.3,36901,0)
 ;;=C93.00^^169^1862^12
 ;;^UTILITY(U,$J,358.3,36901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36901,1,3,0)
 ;;=3^Acute monoblastic/monocytic leukemia, not achieve remission
 ;;^UTILITY(U,$J,358.3,36901,1,4,0)
 ;;=4^C93.00
 ;;^UTILITY(U,$J,358.3,36901,2)
 ;;=^5001819
 ;;^UTILITY(U,$J,358.3,36902,0)
 ;;=C93.01^^169^1862^10
 ;;^UTILITY(U,$J,358.3,36902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36902,1,3,0)
 ;;=3^Acute monoblastic/monocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,36902,1,4,0)
 ;;=4^C93.01
 ;;^UTILITY(U,$J,358.3,36902,2)
 ;;=^5001820
 ;;^UTILITY(U,$J,358.3,36903,0)
 ;;=C93.02^^169^1862^11
 ;;^UTILITY(U,$J,358.3,36903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36903,1,3,0)
 ;;=3^Acute monoblastic/monocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,36903,1,4,0)
 ;;=4^C93.02
 ;;^UTILITY(U,$J,358.3,36903,2)
 ;;=^5001821
 ;;^UTILITY(U,$J,358.3,36904,0)
 ;;=C93.10^^169^1862^31
 ;;^UTILITY(U,$J,358.3,36904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36904,1,3,0)
 ;;=3^Chronic myelomonocytic leukemia not achieve remission
 ;;^UTILITY(U,$J,358.3,36904,1,4,0)
 ;;=4^C93.10
 ;;^UTILITY(U,$J,358.3,36904,2)
 ;;=^5001822
 ;;^UTILITY(U,$J,358.3,36905,0)
 ;;=C93.11^^169^1862^33
 ;;^UTILITY(U,$J,358.3,36905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36905,1,3,0)
 ;;=3^Chronic myelomonocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,36905,1,4,0)
 ;;=4^C93.11
 ;;^UTILITY(U,$J,358.3,36905,2)
 ;;=^5001823
 ;;^UTILITY(U,$J,358.3,36906,0)
 ;;=C93.12^^169^1862^32
 ;;^UTILITY(U,$J,358.3,36906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36906,1,3,0)
 ;;=3^Chronic myelomonocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,36906,1,4,0)
 ;;=4^C93.12
 ;;^UTILITY(U,$J,358.3,36906,2)
 ;;=^5001824
 ;;^UTILITY(U,$J,358.3,36907,0)
 ;;=C93.90^^169^1862^48
 ;;^UTILITY(U,$J,358.3,36907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36907,1,3,0)
 ;;=3^Monocytic leukemia, unsp, not having achieved remission
 ;;^UTILITY(U,$J,358.3,36907,1,4,0)
 ;;=4^C93.90
 ;;^UTILITY(U,$J,358.3,36907,2)
 ;;=^5001828
 ;;^UTILITY(U,$J,358.3,36908,0)
 ;;=C93.91^^169^1862^50
 ;;^UTILITY(U,$J,358.3,36908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36908,1,3,0)
 ;;=3^Monocytic leukemia, unspecified in remission
 ;;^UTILITY(U,$J,358.3,36908,1,4,0)
 ;;=4^C93.91
 ;;^UTILITY(U,$J,358.3,36908,2)
 ;;=^5001829
 ;;^UTILITY(U,$J,358.3,36909,0)
 ;;=C93.92^^169^1862^49
 ;;^UTILITY(U,$J,358.3,36909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36909,1,3,0)
 ;;=3^Monocytic leukemia, unspecified in relapse
 ;;^UTILITY(U,$J,358.3,36909,1,4,0)
 ;;=4^C93.92
 ;;^UTILITY(U,$J,358.3,36909,2)
 ;;=^5001830
 ;;^UTILITY(U,$J,358.3,36910,0)
 ;;=C94.00^^169^1862^3
 ;;^UTILITY(U,$J,358.3,36910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36910,1,3,0)
 ;;=3^Acute erythroid leukemia, not having achieved remission
 ;;^UTILITY(U,$J,358.3,36910,1,4,0)
 ;;=4^C94.00
 ;;^UTILITY(U,$J,358.3,36910,2)
 ;;=^5001834
 ;;^UTILITY(U,$J,358.3,36911,0)
 ;;=C94.01^^169^1862^2
 ;;^UTILITY(U,$J,358.3,36911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36911,1,3,0)
 ;;=3^Acute erythroid leukemia, in remission
 ;;^UTILITY(U,$J,358.3,36911,1,4,0)
 ;;=4^C94.01
 ;;^UTILITY(U,$J,358.3,36911,2)
 ;;=^5001835
 ;;^UTILITY(U,$J,358.3,36912,0)
 ;;=C94.02^^169^1862^1
 ;;^UTILITY(U,$J,358.3,36912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36912,1,3,0)
 ;;=3^Acute erythroid leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,36912,1,4,0)
 ;;=4^C94.02
 ;;^UTILITY(U,$J,358.3,36912,2)
 ;;=^5001836
