IBDEI1S9 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30295,0)
 ;;=C92.41^^118^1505^20
 ;;^UTILITY(U,$J,358.3,30295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30295,1,3,0)
 ;;=3^Acute promyelocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,30295,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,30295,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,30296,0)
 ;;=C92.01^^118^1505^14
 ;;^UTILITY(U,$J,358.3,30296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30296,1,3,0)
 ;;=3^Acute myeloblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,30296,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,30296,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,30297,0)
 ;;=C92.02^^118^1505^13
 ;;^UTILITY(U,$J,358.3,30297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30297,1,3,0)
 ;;=3^Acute myeloblastic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,30297,1,4,0)
 ;;=4^C92.02
 ;;^UTILITY(U,$J,358.3,30297,2)
 ;;=^5001791
 ;;^UTILITY(U,$J,358.3,30298,0)
 ;;=C92.42^^118^1505^19
 ;;^UTILITY(U,$J,358.3,30298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30298,1,3,0)
 ;;=3^Acute promyelocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,30298,1,4,0)
 ;;=4^C92.42
 ;;^UTILITY(U,$J,358.3,30298,2)
 ;;=^5001803
 ;;^UTILITY(U,$J,358.3,30299,0)
 ;;=C92.52^^118^1505^16
 ;;^UTILITY(U,$J,358.3,30299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30299,1,3,0)
 ;;=3^Acute myelomonocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,30299,1,4,0)
 ;;=4^C92.52
 ;;^UTILITY(U,$J,358.3,30299,2)
 ;;=^5001806
 ;;^UTILITY(U,$J,358.3,30300,0)
 ;;=C92.10^^118^1505^28
 ;;^UTILITY(U,$J,358.3,30300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30300,1,3,0)
 ;;=3^Chronic myeloid leuk, BCR/ABL-positive, not achieve remis
 ;;^UTILITY(U,$J,358.3,30300,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,30300,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,30301,0)
 ;;=C92.11^^118^1505^29
 ;;^UTILITY(U,$J,358.3,30301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30301,1,3,0)
 ;;=3^Chronic myeloid leukemia, BCR/ABL-positive, in remission
 ;;^UTILITY(U,$J,358.3,30301,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,30301,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,30302,0)
 ;;=C92.12^^118^1505^30
 ;;^UTILITY(U,$J,358.3,30302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30302,1,3,0)
 ;;=3^Chronic myeloid leukemia, BCR/ABL-positive, in relapse
 ;;^UTILITY(U,$J,358.3,30302,1,4,0)
 ;;=4^C92.12
 ;;^UTILITY(U,$J,358.3,30302,2)
 ;;=^5001794
 ;;^UTILITY(U,$J,358.3,30303,0)
 ;;=C92.20^^118^1505^22
 ;;^UTILITY(U,$J,358.3,30303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30303,1,3,0)
 ;;=3^Atyp chronic myeloid leuk, BCR/ABL-neg, not achieve remis
 ;;^UTILITY(U,$J,358.3,30303,1,4,0)
 ;;=4^C92.20
 ;;^UTILITY(U,$J,358.3,30303,2)
 ;;=^5001795
 ;;^UTILITY(U,$J,358.3,30304,0)
 ;;=C92.21^^118^1505^23
 ;;^UTILITY(U,$J,358.3,30304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30304,1,3,0)
 ;;=3^Atypical chronic myeloid leukemia, BCR/ABL-neg, in remission
 ;;^UTILITY(U,$J,358.3,30304,1,4,0)
 ;;=4^C92.21
 ;;^UTILITY(U,$J,358.3,30304,2)
 ;;=^5001796
 ;;^UTILITY(U,$J,358.3,30305,0)
 ;;=C92.22^^118^1505^24
 ;;^UTILITY(U,$J,358.3,30305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30305,1,3,0)
 ;;=3^Atypical chronic myeloid leukemia, BCR/ABL-neg, in relapse
 ;;^UTILITY(U,$J,358.3,30305,1,4,0)
 ;;=4^C92.22
 ;;^UTILITY(U,$J,358.3,30305,2)
 ;;=^5001797
 ;;^UTILITY(U,$J,358.3,30306,0)
 ;;=C92.30^^118^1505^57
 ;;^UTILITY(U,$J,358.3,30306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30306,1,3,0)
 ;;=3^Myeloid sarcoma, not having achieved remission
 ;;^UTILITY(U,$J,358.3,30306,1,4,0)
 ;;=4^C92.30
 ;;^UTILITY(U,$J,358.3,30306,2)
 ;;=^5001798
 ;;^UTILITY(U,$J,358.3,30307,0)
 ;;=C92.31^^118^1505^56
