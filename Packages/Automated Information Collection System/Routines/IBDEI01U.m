IBDEI01U ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,306,1,4,0)
 ;;=4^Z93.50
 ;;^UTILITY(U,$J,358.3,306,2)
 ;;=^5063647
 ;;^UTILITY(U,$J,358.3,307,0)
 ;;=Z93.6^^2^13^4
 ;;^UTILITY(U,$J,358.3,307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,307,1,3,0)
 ;;=3^Artificial openings of urinary tract status NEC
 ;;^UTILITY(U,$J,358.3,307,1,4,0)
 ;;=4^Z93.6
 ;;^UTILITY(U,$J,358.3,307,2)
 ;;=^5063651
 ;;^UTILITY(U,$J,358.3,308,0)
 ;;=Z93.8^^2^13^1
 ;;^UTILITY(U,$J,358.3,308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,308,1,3,0)
 ;;=3^Artificial opening status NEC
 ;;^UTILITY(U,$J,358.3,308,1,4,0)
 ;;=4^Z93.8
 ;;^UTILITY(U,$J,358.3,308,2)
 ;;=^5063652
 ;;^UTILITY(U,$J,358.3,309,0)
 ;;=Z93.9^^2^13^2
 ;;^UTILITY(U,$J,358.3,309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,309,1,3,0)
 ;;=3^Artificial opening status, unspecified
 ;;^UTILITY(U,$J,358.3,309,1,4,0)
 ;;=4^Z93.9
 ;;^UTILITY(U,$J,358.3,309,2)
 ;;=^5063653
 ;;^UTILITY(U,$J,358.3,310,0)
 ;;=C50.912^^2^14^13
 ;;^UTILITY(U,$J,358.3,310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,310,1,3,0)
 ;;=3^Malignant neoplasm of left female breast,unsp site
 ;;^UTILITY(U,$J,358.3,310,1,4,0)
 ;;=4^C50.912
 ;;^UTILITY(U,$J,358.3,310,2)
 ;;=^5001196
 ;;^UTILITY(U,$J,358.3,311,0)
 ;;=C50.911^^2^14^16
 ;;^UTILITY(U,$J,358.3,311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,311,1,3,0)
 ;;=3^Malignant neoplasm of right female breast,unsp site
 ;;^UTILITY(U,$J,358.3,311,1,4,0)
 ;;=4^C50.911
 ;;^UTILITY(U,$J,358.3,311,2)
 ;;=^5001195
 ;;^UTILITY(U,$J,358.3,312,0)
 ;;=C55.^^2^14^18
 ;;^UTILITY(U,$J,358.3,312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,312,1,3,0)
 ;;=3^Malignant neoplasm of uterus, part unspecified
 ;;^UTILITY(U,$J,358.3,312,1,4,0)
 ;;=4^C55.
 ;;^UTILITY(U,$J,358.3,312,2)
 ;;=^5001211
 ;;^UTILITY(U,$J,358.3,313,0)
 ;;=C53.9^^2^14^11
 ;;^UTILITY(U,$J,358.3,313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,313,1,3,0)
 ;;=3^Malignant neoplasm of cervix uteri, unspecified
 ;;^UTILITY(U,$J,358.3,313,1,4,0)
 ;;=4^C53.9
 ;;^UTILITY(U,$J,358.3,313,2)
 ;;=^5001204
 ;;^UTILITY(U,$J,358.3,314,0)
 ;;=C56.1^^2^14^17
 ;;^UTILITY(U,$J,358.3,314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,314,1,3,0)
 ;;=3^Malignant neoplasm of right ovary
 ;;^UTILITY(U,$J,358.3,314,1,4,0)
 ;;=4^C56.1
 ;;^UTILITY(U,$J,358.3,314,2)
 ;;=^5001212
 ;;^UTILITY(U,$J,358.3,315,0)
 ;;=C56.2^^2^14^14
 ;;^UTILITY(U,$J,358.3,315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,315,1,3,0)
 ;;=3^Malignant neoplasm of left ovary
 ;;^UTILITY(U,$J,358.3,315,1,4,0)
 ;;=4^C56.2
 ;;^UTILITY(U,$J,358.3,315,2)
 ;;=^5001213
 ;;^UTILITY(U,$J,358.3,316,0)
 ;;=C57.01^^2^14^15
 ;;^UTILITY(U,$J,358.3,316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,316,1,3,0)
 ;;=3^Malignant neoplasm of right fallopian tube
 ;;^UTILITY(U,$J,358.3,316,1,4,0)
 ;;=4^C57.01
 ;;^UTILITY(U,$J,358.3,316,2)
 ;;=^5001216
 ;;^UTILITY(U,$J,358.3,317,0)
 ;;=C57.02^^2^14^12
 ;;^UTILITY(U,$J,358.3,317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,317,1,3,0)
 ;;=3^Malignant neoplasm of left fallopian tube
 ;;^UTILITY(U,$J,358.3,317,1,4,0)
 ;;=4^C57.02
 ;;^UTILITY(U,$J,358.3,317,2)
 ;;=^5001217
 ;;^UTILITY(U,$J,358.3,318,0)
 ;;=C52.^^2^14^19
 ;;^UTILITY(U,$J,358.3,318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,318,1,3,0)
 ;;=3^Malignant neoplasm of vagina
 ;;^UTILITY(U,$J,358.3,318,1,4,0)
 ;;=4^C52.
 ;;^UTILITY(U,$J,358.3,318,2)
 ;;=^267232
 ;;^UTILITY(U,$J,358.3,319,0)
 ;;=C51.9^^2^14^20
 ;;^UTILITY(U,$J,358.3,319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,319,1,3,0)
 ;;=3^Malignant neoplasm of vulva, unspecified
 ;;^UTILITY(U,$J,358.3,319,1,4,0)
 ;;=4^C51.9
 ;;^UTILITY(U,$J,358.3,319,2)
 ;;=^5001202
