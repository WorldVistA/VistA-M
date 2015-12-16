IBDEI02C ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,544,1,4,0)
 ;;=4^C92.40
 ;;^UTILITY(U,$J,358.3,544,2)
 ;;=^5001801
 ;;^UTILITY(U,$J,358.3,545,0)
 ;;=C92.50^^2^24^18
 ;;^UTILITY(U,$J,358.3,545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,545,1,3,0)
 ;;=3^Acute myelomonocytic leukemia, not having achieved remission
 ;;^UTILITY(U,$J,358.3,545,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,545,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,546,0)
 ;;=C92.00^^2^24^15
 ;;^UTILITY(U,$J,358.3,546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,546,1,3,0)
 ;;=3^Acute myeloblastic leukemia, not having achieved remission
 ;;^UTILITY(U,$J,358.3,546,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,546,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,547,0)
 ;;=C92.51^^2^24^17
 ;;^UTILITY(U,$J,358.3,547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,547,1,3,0)
 ;;=3^Acute myelomonocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,547,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,547,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,548,0)
 ;;=C92.41^^2^24^20
 ;;^UTILITY(U,$J,358.3,548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,548,1,3,0)
 ;;=3^Acute promyelocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,548,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,548,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,549,0)
 ;;=C92.01^^2^24^14
 ;;^UTILITY(U,$J,358.3,549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,549,1,3,0)
 ;;=3^Acute myeloblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,549,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,549,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,550,0)
 ;;=C92.02^^2^24^13
 ;;^UTILITY(U,$J,358.3,550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,550,1,3,0)
 ;;=3^Acute myeloblastic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,550,1,4,0)
 ;;=4^C92.02
 ;;^UTILITY(U,$J,358.3,550,2)
 ;;=^5001791
 ;;^UTILITY(U,$J,358.3,551,0)
 ;;=C92.42^^2^24^19
 ;;^UTILITY(U,$J,358.3,551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,551,1,3,0)
 ;;=3^Acute promyelocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,551,1,4,0)
 ;;=4^C92.42
 ;;^UTILITY(U,$J,358.3,551,2)
 ;;=^5001803
 ;;^UTILITY(U,$J,358.3,552,0)
 ;;=C92.52^^2^24^16
 ;;^UTILITY(U,$J,358.3,552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,552,1,3,0)
 ;;=3^Acute myelomonocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,552,1,4,0)
 ;;=4^C92.52
 ;;^UTILITY(U,$J,358.3,552,2)
 ;;=^5001806
 ;;^UTILITY(U,$J,358.3,553,0)
 ;;=C92.10^^2^24^28
 ;;^UTILITY(U,$J,358.3,553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,553,1,3,0)
 ;;=3^Chronic myeloid leuk, BCR/ABL-positive, not achieve remis
 ;;^UTILITY(U,$J,358.3,553,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,553,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,554,0)
 ;;=C92.11^^2^24^29
 ;;^UTILITY(U,$J,358.3,554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,554,1,3,0)
 ;;=3^Chronic myeloid leukemia, BCR/ABL-positive, in remission
 ;;^UTILITY(U,$J,358.3,554,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,554,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,555,0)
 ;;=C92.12^^2^24^30
 ;;^UTILITY(U,$J,358.3,555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,555,1,3,0)
 ;;=3^Chronic myeloid leukemia, BCR/ABL-positive, in relapse
 ;;^UTILITY(U,$J,358.3,555,1,4,0)
 ;;=4^C92.12
 ;;^UTILITY(U,$J,358.3,555,2)
 ;;=^5001794
 ;;^UTILITY(U,$J,358.3,556,0)
 ;;=C92.20^^2^24^22
 ;;^UTILITY(U,$J,358.3,556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,556,1,3,0)
 ;;=3^Atyp chronic myeloid leuk, BCR/ABL-neg, not achieve remis
 ;;^UTILITY(U,$J,358.3,556,1,4,0)
 ;;=4^C92.20
 ;;^UTILITY(U,$J,358.3,556,2)
 ;;=^5001795
 ;;^UTILITY(U,$J,358.3,557,0)
 ;;=C92.21^^2^24^23
 ;;^UTILITY(U,$J,358.3,557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,557,1,3,0)
 ;;=3^Atypical chronic myeloid leukemia, BCR/ABL-neg, in remission
