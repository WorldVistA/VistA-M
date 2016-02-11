IBDEI276 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36888,1,3,0)
 ;;=3^Acute myelomonocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,36888,1,4,0)
 ;;=4^C92.52
 ;;^UTILITY(U,$J,358.3,36888,2)
 ;;=^5001806
 ;;^UTILITY(U,$J,358.3,36889,0)
 ;;=C92.10^^169^1862^28
 ;;^UTILITY(U,$J,358.3,36889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36889,1,3,0)
 ;;=3^Chronic myeloid leuk, BCR/ABL-positive, not achieve remis
 ;;^UTILITY(U,$J,358.3,36889,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,36889,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,36890,0)
 ;;=C92.11^^169^1862^29
 ;;^UTILITY(U,$J,358.3,36890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36890,1,3,0)
 ;;=3^Chronic myeloid leukemia, BCR/ABL-positive, in remission
 ;;^UTILITY(U,$J,358.3,36890,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,36890,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,36891,0)
 ;;=C92.12^^169^1862^30
 ;;^UTILITY(U,$J,358.3,36891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36891,1,3,0)
 ;;=3^Chronic myeloid leukemia, BCR/ABL-positive, in relapse
 ;;^UTILITY(U,$J,358.3,36891,1,4,0)
 ;;=4^C92.12
 ;;^UTILITY(U,$J,358.3,36891,2)
 ;;=^5001794
 ;;^UTILITY(U,$J,358.3,36892,0)
 ;;=C92.20^^169^1862^22
 ;;^UTILITY(U,$J,358.3,36892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36892,1,3,0)
 ;;=3^Atyp chronic myeloid leuk, BCR/ABL-neg, not achieve remis
 ;;^UTILITY(U,$J,358.3,36892,1,4,0)
 ;;=4^C92.20
 ;;^UTILITY(U,$J,358.3,36892,2)
 ;;=^5001795
 ;;^UTILITY(U,$J,358.3,36893,0)
 ;;=C92.21^^169^1862^23
 ;;^UTILITY(U,$J,358.3,36893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36893,1,3,0)
 ;;=3^Atypical chronic myeloid leukemia, BCR/ABL-neg, in remission
 ;;^UTILITY(U,$J,358.3,36893,1,4,0)
 ;;=4^C92.21
 ;;^UTILITY(U,$J,358.3,36893,2)
 ;;=^5001796
 ;;^UTILITY(U,$J,358.3,36894,0)
 ;;=C92.22^^169^1862^24
 ;;^UTILITY(U,$J,358.3,36894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36894,1,3,0)
 ;;=3^Atypical chronic myeloid leukemia, BCR/ABL-neg, in relapse
 ;;^UTILITY(U,$J,358.3,36894,1,4,0)
 ;;=4^C92.22
 ;;^UTILITY(U,$J,358.3,36894,2)
 ;;=^5001797
 ;;^UTILITY(U,$J,358.3,36895,0)
 ;;=C92.30^^169^1862^57
 ;;^UTILITY(U,$J,358.3,36895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36895,1,3,0)
 ;;=3^Myeloid sarcoma, not having achieved remission
 ;;^UTILITY(U,$J,358.3,36895,1,4,0)
 ;;=4^C92.30
 ;;^UTILITY(U,$J,358.3,36895,2)
 ;;=^5001798
 ;;^UTILITY(U,$J,358.3,36896,0)
 ;;=C92.31^^169^1862^56
 ;;^UTILITY(U,$J,358.3,36896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36896,1,3,0)
 ;;=3^Myeloid sarcoma, in remission
 ;;^UTILITY(U,$J,358.3,36896,1,4,0)
 ;;=4^C92.31
 ;;^UTILITY(U,$J,358.3,36896,2)
 ;;=^5001799
 ;;^UTILITY(U,$J,358.3,36897,0)
 ;;=C92.32^^169^1862^55
 ;;^UTILITY(U,$J,358.3,36897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36897,1,3,0)
 ;;=3^Myeloid sarcoma, in relapse
 ;;^UTILITY(U,$J,358.3,36897,1,4,0)
 ;;=4^C92.32
 ;;^UTILITY(U,$J,358.3,36897,2)
 ;;=^5001800
 ;;^UTILITY(U,$J,358.3,36898,0)
 ;;=C92.90^^169^1862^54
 ;;^UTILITY(U,$J,358.3,36898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36898,1,3,0)
 ;;=3^Myeloid leukemia, unspecified, not having achieved remission
 ;;^UTILITY(U,$J,358.3,36898,1,4,0)
 ;;=4^C92.90
 ;;^UTILITY(U,$J,358.3,36898,2)
 ;;=^5001810
 ;;^UTILITY(U,$J,358.3,36899,0)
 ;;=C92.91^^169^1862^53
 ;;^UTILITY(U,$J,358.3,36899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36899,1,3,0)
 ;;=3^Myeloid leukemia, unspecified in remission
 ;;^UTILITY(U,$J,358.3,36899,1,4,0)
 ;;=4^C92.91
 ;;^UTILITY(U,$J,358.3,36899,2)
 ;;=^5001811
 ;;^UTILITY(U,$J,358.3,36900,0)
 ;;=C92.92^^169^1862^52
 ;;^UTILITY(U,$J,358.3,36900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36900,1,3,0)
 ;;=3^Myeloid leukemia, unspecified in relapse
