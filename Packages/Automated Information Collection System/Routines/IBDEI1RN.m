IBDEI1RN ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30019,0)
 ;;=Z93.3^^118^1494^5
 ;;^UTILITY(U,$J,358.3,30019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30019,1,3,0)
 ;;=3^Colostomy status
 ;;^UTILITY(U,$J,358.3,30019,1,4,0)
 ;;=4^Z93.3
 ;;^UTILITY(U,$J,358.3,30019,2)
 ;;=^5063645
 ;;^UTILITY(U,$J,358.3,30020,0)
 ;;=Z93.4^^118^1494^3
 ;;^UTILITY(U,$J,358.3,30020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30020,1,3,0)
 ;;=3^Artificial openings of gastrointestinal tract status NEC
 ;;^UTILITY(U,$J,358.3,30020,1,4,0)
 ;;=4^Z93.4
 ;;^UTILITY(U,$J,358.3,30020,2)
 ;;=^5063646
 ;;^UTILITY(U,$J,358.3,30021,0)
 ;;=Z93.50^^118^1494^6
 ;;^UTILITY(U,$J,358.3,30021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30021,1,3,0)
 ;;=3^Cystostomy Status,Unspec
 ;;^UTILITY(U,$J,358.3,30021,1,4,0)
 ;;=4^Z93.50
 ;;^UTILITY(U,$J,358.3,30021,2)
 ;;=^5063647
 ;;^UTILITY(U,$J,358.3,30022,0)
 ;;=Z93.6^^118^1494^4
 ;;^UTILITY(U,$J,358.3,30022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30022,1,3,0)
 ;;=3^Artificial openings of urinary tract status NEC
 ;;^UTILITY(U,$J,358.3,30022,1,4,0)
 ;;=4^Z93.6
 ;;^UTILITY(U,$J,358.3,30022,2)
 ;;=^5063651
 ;;^UTILITY(U,$J,358.3,30023,0)
 ;;=Z93.8^^118^1494^1
 ;;^UTILITY(U,$J,358.3,30023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30023,1,3,0)
 ;;=3^Artificial opening status NEC
 ;;^UTILITY(U,$J,358.3,30023,1,4,0)
 ;;=4^Z93.8
 ;;^UTILITY(U,$J,358.3,30023,2)
 ;;=^5063652
 ;;^UTILITY(U,$J,358.3,30024,0)
 ;;=Z93.9^^118^1494^2
 ;;^UTILITY(U,$J,358.3,30024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30024,1,3,0)
 ;;=3^Artificial opening status, unspecified
 ;;^UTILITY(U,$J,358.3,30024,1,4,0)
 ;;=4^Z93.9
 ;;^UTILITY(U,$J,358.3,30024,2)
 ;;=^5063653
 ;;^UTILITY(U,$J,358.3,30025,0)
 ;;=C50.912^^118^1495^13
 ;;^UTILITY(U,$J,358.3,30025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30025,1,3,0)
 ;;=3^Malignant neoplasm of left female breast,unsp site
 ;;^UTILITY(U,$J,358.3,30025,1,4,0)
 ;;=4^C50.912
 ;;^UTILITY(U,$J,358.3,30025,2)
 ;;=^5001196
 ;;^UTILITY(U,$J,358.3,30026,0)
 ;;=C50.911^^118^1495^16
 ;;^UTILITY(U,$J,358.3,30026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30026,1,3,0)
 ;;=3^Malignant neoplasm of right female breast,unsp site
 ;;^UTILITY(U,$J,358.3,30026,1,4,0)
 ;;=4^C50.911
 ;;^UTILITY(U,$J,358.3,30026,2)
 ;;=^5001195
 ;;^UTILITY(U,$J,358.3,30027,0)
 ;;=C55.^^118^1495^18
 ;;^UTILITY(U,$J,358.3,30027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30027,1,3,0)
 ;;=3^Malignant neoplasm of uterus, part unspecified
 ;;^UTILITY(U,$J,358.3,30027,1,4,0)
 ;;=4^C55.
 ;;^UTILITY(U,$J,358.3,30027,2)
 ;;=^5001211
 ;;^UTILITY(U,$J,358.3,30028,0)
 ;;=C53.9^^118^1495^11
 ;;^UTILITY(U,$J,358.3,30028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30028,1,3,0)
 ;;=3^Malignant neoplasm of cervix uteri, unspecified
 ;;^UTILITY(U,$J,358.3,30028,1,4,0)
 ;;=4^C53.9
 ;;^UTILITY(U,$J,358.3,30028,2)
 ;;=^5001204
 ;;^UTILITY(U,$J,358.3,30029,0)
 ;;=C56.1^^118^1495^17
 ;;^UTILITY(U,$J,358.3,30029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30029,1,3,0)
 ;;=3^Malignant neoplasm of right ovary
 ;;^UTILITY(U,$J,358.3,30029,1,4,0)
 ;;=4^C56.1
 ;;^UTILITY(U,$J,358.3,30029,2)
 ;;=^5001212
 ;;^UTILITY(U,$J,358.3,30030,0)
 ;;=C56.2^^118^1495^14
 ;;^UTILITY(U,$J,358.3,30030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30030,1,3,0)
 ;;=3^Malignant neoplasm of left ovary
 ;;^UTILITY(U,$J,358.3,30030,1,4,0)
 ;;=4^C56.2
 ;;^UTILITY(U,$J,358.3,30030,2)
 ;;=^5001213
 ;;^UTILITY(U,$J,358.3,30031,0)
 ;;=C57.01^^118^1495^15
 ;;^UTILITY(U,$J,358.3,30031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30031,1,3,0)
 ;;=3^Malignant neoplasm of right fallopian tube
