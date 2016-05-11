IBDEI1S8 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30283,1,3,0)
 ;;=3^Basal cell carcinoma of skin or right eyelid,including canthus
 ;;^UTILITY(U,$J,358.3,30283,1,4,0)
 ;;=4^C44.112
 ;;^UTILITY(U,$J,358.3,30283,2)
 ;;=^5001020
 ;;^UTILITY(U,$J,358.3,30284,0)
 ;;=C44.119^^118^1504^4
 ;;^UTILITY(U,$J,358.3,30284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30284,1,3,0)
 ;;=3^Basal cell carcinoma of skin of left eyelid,including canthus
 ;;^UTILITY(U,$J,358.3,30284,1,4,0)
 ;;=4^C44.119
 ;;^UTILITY(U,$J,358.3,30284,2)
 ;;=^5001021
 ;;^UTILITY(U,$J,358.3,30285,0)
 ;;=C44.122^^118^1504^39
 ;;^UTILITY(U,$J,358.3,30285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30285,1,3,0)
 ;;=3^Squamous cell carcinoma of skin of right eyelid,including canthus
 ;;^UTILITY(U,$J,358.3,30285,1,4,0)
 ;;=4^C44.122
 ;;^UTILITY(U,$J,358.3,30285,2)
 ;;=^5001023
 ;;^UTILITY(U,$J,358.3,30286,0)
 ;;=C44.129^^118^1504^33
 ;;^UTILITY(U,$J,358.3,30286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30286,1,3,0)
 ;;=3^Squamous cell carcinoma of skin of left eyelid,including canthus
 ;;^UTILITY(U,$J,358.3,30286,1,4,0)
 ;;=4^C44.129
 ;;^UTILITY(U,$J,358.3,30286,2)
 ;;=^5001024
 ;;^UTILITY(U,$J,358.3,30287,0)
 ;;=C44.222^^118^1504^40
 ;;^UTILITY(U,$J,358.3,30287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30287,1,3,0)
 ;;=3^Squamous cell carcinoma of skin of right ear/external auric canal
 ;;^UTILITY(U,$J,358.3,30287,1,4,0)
 ;;=4^C44.222
 ;;^UTILITY(U,$J,358.3,30287,2)
 ;;=^5001035
 ;;^UTILITY(U,$J,358.3,30288,0)
 ;;=C44.229^^118^1504^34
 ;;^UTILITY(U,$J,358.3,30288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30288,1,3,0)
 ;;=3^Squamous cell carcinoma of skin of left ear/external auric canal
 ;;^UTILITY(U,$J,358.3,30288,1,4,0)
 ;;=4^C44.229
 ;;^UTILITY(U,$J,358.3,30288,2)
 ;;=^5001036
 ;;^UTILITY(U,$J,358.3,30289,0)
 ;;=C44.212^^118^1504^9
 ;;^UTILITY(U,$J,358.3,30289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30289,1,3,0)
 ;;=3^Basal cell carcinoma of skin of right ear/external auric canal
 ;;^UTILITY(U,$J,358.3,30289,1,4,0)
 ;;=4^C44.212
 ;;^UTILITY(U,$J,358.3,30289,2)
 ;;=^5001032
 ;;^UTILITY(U,$J,358.3,30290,0)
 ;;=C44.219^^118^1504^3
 ;;^UTILITY(U,$J,358.3,30290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30290,1,3,0)
 ;;=3^Basal cell carcinoma of skin of left ear/external auric canal
 ;;^UTILITY(U,$J,358.3,30290,1,4,0)
 ;;=4^C44.219
 ;;^UTILITY(U,$J,358.3,30290,2)
 ;;=^5001033
 ;;^UTILITY(U,$J,358.3,30291,0)
 ;;=C92.40^^118^1505^21
 ;;^UTILITY(U,$J,358.3,30291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30291,1,3,0)
 ;;=3^Acute promyelocytic leukemia, not having achieved remission
 ;;^UTILITY(U,$J,358.3,30291,1,4,0)
 ;;=4^C92.40
 ;;^UTILITY(U,$J,358.3,30291,2)
 ;;=^5001801
 ;;^UTILITY(U,$J,358.3,30292,0)
 ;;=C92.50^^118^1505^18
 ;;^UTILITY(U,$J,358.3,30292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30292,1,3,0)
 ;;=3^Acute myelomonocytic leukemia, not having achieved remission
 ;;^UTILITY(U,$J,358.3,30292,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,30292,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,30293,0)
 ;;=C92.00^^118^1505^15
 ;;^UTILITY(U,$J,358.3,30293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30293,1,3,0)
 ;;=3^Acute myeloblastic leukemia, not having achieved remission
 ;;^UTILITY(U,$J,358.3,30293,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,30293,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,30294,0)
 ;;=C92.51^^118^1505^17
 ;;^UTILITY(U,$J,358.3,30294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30294,1,3,0)
 ;;=3^Acute myelomonocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,30294,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,30294,2)
 ;;=^5001805
