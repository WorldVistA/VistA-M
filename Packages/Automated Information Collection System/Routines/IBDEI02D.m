IBDEI02D ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,557,1,4,0)
 ;;=4^C92.21
 ;;^UTILITY(U,$J,358.3,557,2)
 ;;=^5001796
 ;;^UTILITY(U,$J,358.3,558,0)
 ;;=C92.22^^2^24^24
 ;;^UTILITY(U,$J,358.3,558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,558,1,3,0)
 ;;=3^Atypical chronic myeloid leukemia, BCR/ABL-neg, in relapse
 ;;^UTILITY(U,$J,358.3,558,1,4,0)
 ;;=4^C92.22
 ;;^UTILITY(U,$J,358.3,558,2)
 ;;=^5001797
 ;;^UTILITY(U,$J,358.3,559,0)
 ;;=C92.30^^2^24^54
 ;;^UTILITY(U,$J,358.3,559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,559,1,3,0)
 ;;=3^Myeloid sarcoma, not having achieved remission
 ;;^UTILITY(U,$J,358.3,559,1,4,0)
 ;;=4^C92.30
 ;;^UTILITY(U,$J,358.3,559,2)
 ;;=^5001798
 ;;^UTILITY(U,$J,358.3,560,0)
 ;;=C92.31^^2^24^53
 ;;^UTILITY(U,$J,358.3,560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,560,1,3,0)
 ;;=3^Myeloid sarcoma, in remission
 ;;^UTILITY(U,$J,358.3,560,1,4,0)
 ;;=4^C92.31
 ;;^UTILITY(U,$J,358.3,560,2)
 ;;=^5001799
 ;;^UTILITY(U,$J,358.3,561,0)
 ;;=C92.32^^2^24^52
 ;;^UTILITY(U,$J,358.3,561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,561,1,3,0)
 ;;=3^Myeloid sarcoma, in relapse
 ;;^UTILITY(U,$J,358.3,561,1,4,0)
 ;;=4^C92.32
 ;;^UTILITY(U,$J,358.3,561,2)
 ;;=^5001800
 ;;^UTILITY(U,$J,358.3,562,0)
 ;;=C92.90^^2^24^51
 ;;^UTILITY(U,$J,358.3,562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,562,1,3,0)
 ;;=3^Myeloid leukemia, unspecified, not having achieved remission
 ;;^UTILITY(U,$J,358.3,562,1,4,0)
 ;;=4^C92.90
 ;;^UTILITY(U,$J,358.3,562,2)
 ;;=^5001810
 ;;^UTILITY(U,$J,358.3,563,0)
 ;;=C92.91^^2^24^50
 ;;^UTILITY(U,$J,358.3,563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,563,1,3,0)
 ;;=3^Myeloid leukemia, unspecified in remission
 ;;^UTILITY(U,$J,358.3,563,1,4,0)
 ;;=4^C92.91
 ;;^UTILITY(U,$J,358.3,563,2)
 ;;=^5001811
 ;;^UTILITY(U,$J,358.3,564,0)
 ;;=C92.92^^2^24^49
 ;;^UTILITY(U,$J,358.3,564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,564,1,3,0)
 ;;=3^Myeloid leukemia, unspecified in relapse
 ;;^UTILITY(U,$J,358.3,564,1,4,0)
 ;;=4^C92.92
 ;;^UTILITY(U,$J,358.3,564,2)
 ;;=^5001812
 ;;^UTILITY(U,$J,358.3,565,0)
 ;;=C93.00^^2^24^12
 ;;^UTILITY(U,$J,358.3,565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,565,1,3,0)
 ;;=3^Acute monoblastic/monocytic leukemia, not achieve remission
 ;;^UTILITY(U,$J,358.3,565,1,4,0)
 ;;=4^C93.00
 ;;^UTILITY(U,$J,358.3,565,2)
 ;;=^5001819
 ;;^UTILITY(U,$J,358.3,566,0)
 ;;=C93.01^^2^24^10
 ;;^UTILITY(U,$J,358.3,566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,566,1,3,0)
 ;;=3^Acute monoblastic/monocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,566,1,4,0)
 ;;=4^C93.01
 ;;^UTILITY(U,$J,358.3,566,2)
 ;;=^5001820
 ;;^UTILITY(U,$J,358.3,567,0)
 ;;=C93.02^^2^24^11
 ;;^UTILITY(U,$J,358.3,567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,567,1,3,0)
 ;;=3^Acute monoblastic/monocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,567,1,4,0)
 ;;=4^C93.02
 ;;^UTILITY(U,$J,358.3,567,2)
 ;;=^5001821
 ;;^UTILITY(U,$J,358.3,568,0)
 ;;=C93.10^^2^24^31
 ;;^UTILITY(U,$J,358.3,568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,568,1,3,0)
 ;;=3^Chronic myelomonocytic leukemia not achieve remission
 ;;^UTILITY(U,$J,358.3,568,1,4,0)
 ;;=4^C93.10
 ;;^UTILITY(U,$J,358.3,568,2)
 ;;=^5001822
 ;;^UTILITY(U,$J,358.3,569,0)
 ;;=C93.11^^2^24^33
 ;;^UTILITY(U,$J,358.3,569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,569,1,3,0)
 ;;=3^Chronic myelomonocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,569,1,4,0)
 ;;=4^C93.11
 ;;^UTILITY(U,$J,358.3,569,2)
 ;;=^5001823
 ;;^UTILITY(U,$J,358.3,570,0)
 ;;=C93.12^^2^24^32
 ;;^UTILITY(U,$J,358.3,570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,570,1,3,0)
 ;;=3^Chronic myelomonocytic leukemia, in relapse
