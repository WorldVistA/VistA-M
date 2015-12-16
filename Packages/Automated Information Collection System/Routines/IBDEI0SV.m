IBDEI0SV ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13976,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13976,1,3,0)
 ;;=3^782.0
 ;;^UTILITY(U,$J,358.3,13976,1,5,0)
 ;;=5^Burning skin sensation
 ;;^UTILITY(U,$J,358.3,13976,2)
 ;;=^35757
 ;;^UTILITY(U,$J,358.3,13977,0)
 ;;=726.79^^74^850^28
 ;;^UTILITY(U,$J,358.3,13977,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13977,1,3,0)
 ;;=3^726.79
 ;;^UTILITY(U,$J,358.3,13977,1,5,0)
 ;;=5^Bursitis-foot/toe/ankle/calcaneal
 ;;^UTILITY(U,$J,358.3,13977,2)
 ;;=^272555
 ;;^UTILITY(U,$J,358.3,13978,0)
 ;;=266.2^^74^850^1
 ;;^UTILITY(U,$J,358.3,13978,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13978,1,3,0)
 ;;=3^266.2
 ;;^UTILITY(U,$J,358.3,13978,1,5,0)
 ;;=5^B12 Deficiency
 ;;^UTILITY(U,$J,358.3,13978,2)
 ;;=^87347
 ;;^UTILITY(U,$J,358.3,13979,0)
 ;;=754.62^^74^851^1
 ;;^UTILITY(U,$J,358.3,13979,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13979,1,3,0)
 ;;=3^754.62
 ;;^UTILITY(U,$J,358.3,13979,1,5,0)
 ;;=5^Calcaneovalgus, talipes
 ;;^UTILITY(U,$J,358.3,13979,2)
 ;;=^265474
 ;;^UTILITY(U,$J,358.3,13980,0)
 ;;=736.76^^74^851^2
 ;;^UTILITY(U,$J,358.3,13980,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13980,1,3,0)
 ;;=3^736.76
 ;;^UTILITY(U,$J,358.3,13980,1,5,0)
 ;;=5^Calcaneovalgus, talipes, acquired
 ;;^UTILITY(U,$J,358.3,13980,2)
 ;;=^272748
 ;;^UTILITY(U,$J,358.3,13981,0)
 ;;=754.59^^74^851^3
 ;;^UTILITY(U,$J,358.3,13981,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13981,1,3,0)
 ;;=3^754.59
 ;;^UTILITY(U,$J,358.3,13981,1,5,0)
 ;;=5^Calcaneovarus, talipes
 ;;^UTILITY(U,$J,358.3,13981,2)
 ;;=^273008
 ;;^UTILITY(U,$J,358.3,13982,0)
 ;;=V64.2^^74^851^6
 ;;^UTILITY(U,$J,358.3,13982,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13982,1,3,0)
 ;;=3^V64.2
 ;;^UTILITY(U,$J,358.3,13982,1,5,0)
 ;;=5^Cancelled surgical or other procedures because of patient decision 
 ;;^UTILITY(U,$J,358.3,13982,2)
 ;;=^295559
 ;;^UTILITY(U,$J,358.3,13983,0)
 ;;=V64.1^^74^851^5
 ;;^UTILITY(U,$J,358.3,13983,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13983,1,3,0)
 ;;=3^V64.1
 ;;^UTILITY(U,$J,358.3,13983,1,5,0)
 ;;=5^Cancelled surgical or other procedure because of contraindication
 ;;^UTILITY(U,$J,358.3,13983,2)
 ;;=^295558
 ;;^UTILITY(U,$J,358.3,13984,0)
 ;;=V64.3^^74^851^4
 ;;^UTILITY(U,$J,358.3,13984,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13984,1,3,0)
 ;;=3^V64.3
 ;;^UTILITY(U,$J,358.3,13984,1,5,0)
 ;;=5^Cancelled procedure because of other reasons
 ;;^UTILITY(U,$J,358.3,13984,2)
 ;;=^295560
 ;;^UTILITY(U,$J,358.3,13985,0)
 ;;=726.79^^74^851^7
 ;;^UTILITY(U,$J,358.3,13985,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13985,1,3,0)
 ;;=3^726.79
 ;;^UTILITY(U,$J,358.3,13985,1,5,0)
 ;;=5^Capsulitis of ankle/toe/foot
 ;;^UTILITY(U,$J,358.3,13985,2)
 ;;=^272555
 ;;^UTILITY(U,$J,358.3,13986,0)
 ;;=736.75^^74^851^8
 ;;^UTILITY(U,$J,358.3,13986,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13986,1,3,0)
 ;;=3^736.75
 ;;^UTILITY(U,$J,358.3,13986,1,5,0)
 ;;=5^Cavovarus deformity of foot/ankle acquired
 ;;^UTILITY(U,$J,358.3,13986,2)
 ;;=^272747
 ;;^UTILITY(U,$J,358.3,13987,0)
 ;;=681.10^^74^851^11
 ;;^UTILITY(U,$J,358.3,13987,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13987,1,3,0)
 ;;=3^681.10
 ;;^UTILITY(U,$J,358.3,13987,1,5,0)
 ;;=5^Cellulitis and abscess, toe, acquired
 ;;^UTILITY(U,$J,358.3,13987,2)
 ;;=^271885
 ;;^UTILITY(U,$J,358.3,13988,0)
 ;;=682.7^^74^851^9
 ;;^UTILITY(U,$J,358.3,13988,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13988,1,3,0)
 ;;=3^682.7
 ;;^UTILITY(U,$J,358.3,13988,1,5,0)
 ;;=5^Cellulitis and abscess, foot, except toes
 ;;^UTILITY(U,$J,358.3,13988,2)
 ;;=^271895
 ;;^UTILITY(U,$J,358.3,13989,0)
 ;;=682.6^^74^851^10
