IBDEI12A ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19019,1,5,0)
 ;;=5^Bursitis-foot/toe/ankle/calcaneal
 ;;^UTILITY(U,$J,358.3,19019,2)
 ;;=^272555
 ;;^UTILITY(U,$J,358.3,19020,0)
 ;;=266.2^^125^1219^1
 ;;^UTILITY(U,$J,358.3,19020,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19020,1,3,0)
 ;;=3^266.2
 ;;^UTILITY(U,$J,358.3,19020,1,5,0)
 ;;=5^B12 Deficiency
 ;;^UTILITY(U,$J,358.3,19020,2)
 ;;=^87347
 ;;^UTILITY(U,$J,358.3,19021,0)
 ;;=754.62^^125^1220^1
 ;;^UTILITY(U,$J,358.3,19021,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19021,1,3,0)
 ;;=3^754.62
 ;;^UTILITY(U,$J,358.3,19021,1,5,0)
 ;;=5^Calcaneovalgus, talipes
 ;;^UTILITY(U,$J,358.3,19021,2)
 ;;=^265474
 ;;^UTILITY(U,$J,358.3,19022,0)
 ;;=736.76^^125^1220^2
 ;;^UTILITY(U,$J,358.3,19022,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19022,1,3,0)
 ;;=3^736.76
 ;;^UTILITY(U,$J,358.3,19022,1,5,0)
 ;;=5^Calcaneovalgus, talipes, acquired
 ;;^UTILITY(U,$J,358.3,19022,2)
 ;;=^272748
 ;;^UTILITY(U,$J,358.3,19023,0)
 ;;=754.59^^125^1220^3
 ;;^UTILITY(U,$J,358.3,19023,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19023,1,3,0)
 ;;=3^754.59
 ;;^UTILITY(U,$J,358.3,19023,1,5,0)
 ;;=5^Calcaneovarus, talipes
 ;;^UTILITY(U,$J,358.3,19023,2)
 ;;=^273008
 ;;^UTILITY(U,$J,358.3,19024,0)
 ;;=V64.2^^125^1220^6
 ;;^UTILITY(U,$J,358.3,19024,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19024,1,3,0)
 ;;=3^V64.2
 ;;^UTILITY(U,$J,358.3,19024,1,5,0)
 ;;=5^Cancelled surgical or other procedures because of patient decision 
 ;;^UTILITY(U,$J,358.3,19024,2)
 ;;=^295559
 ;;^UTILITY(U,$J,358.3,19025,0)
 ;;=V64.1^^125^1220^5
 ;;^UTILITY(U,$J,358.3,19025,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19025,1,3,0)
 ;;=3^V64.1
 ;;^UTILITY(U,$J,358.3,19025,1,5,0)
 ;;=5^Cancelled surgical or other procedure because of contraindication
 ;;^UTILITY(U,$J,358.3,19025,2)
 ;;=^295558
 ;;^UTILITY(U,$J,358.3,19026,0)
 ;;=V64.3^^125^1220^4
 ;;^UTILITY(U,$J,358.3,19026,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19026,1,3,0)
 ;;=3^V64.3
 ;;^UTILITY(U,$J,358.3,19026,1,5,0)
 ;;=5^Cancelled procedure because of other reasons
 ;;^UTILITY(U,$J,358.3,19026,2)
 ;;=^295560
 ;;^UTILITY(U,$J,358.3,19027,0)
 ;;=726.79^^125^1220^7
 ;;^UTILITY(U,$J,358.3,19027,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19027,1,3,0)
 ;;=3^726.79
 ;;^UTILITY(U,$J,358.3,19027,1,5,0)
 ;;=5^Capsulitis of ankle/toe/foot
 ;;^UTILITY(U,$J,358.3,19027,2)
 ;;=^272555
 ;;^UTILITY(U,$J,358.3,19028,0)
 ;;=736.75^^125^1220^8
 ;;^UTILITY(U,$J,358.3,19028,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19028,1,3,0)
 ;;=3^736.75
 ;;^UTILITY(U,$J,358.3,19028,1,5,0)
 ;;=5^Cavovarus deformity of foot/ankle acquired
 ;;^UTILITY(U,$J,358.3,19028,2)
 ;;=^272747
 ;;^UTILITY(U,$J,358.3,19029,0)
 ;;=681.10^^125^1220^11
 ;;^UTILITY(U,$J,358.3,19029,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19029,1,3,0)
 ;;=3^681.10
 ;;^UTILITY(U,$J,358.3,19029,1,5,0)
 ;;=5^Cellulitis and abscess, toe, acquired
 ;;^UTILITY(U,$J,358.3,19029,2)
 ;;=^271885
 ;;^UTILITY(U,$J,358.3,19030,0)
 ;;=682.7^^125^1220^9
 ;;^UTILITY(U,$J,358.3,19030,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19030,1,3,0)
 ;;=3^682.7
 ;;^UTILITY(U,$J,358.3,19030,1,5,0)
 ;;=5^Cellulitis and abscess, foot, except toes
 ;;^UTILITY(U,$J,358.3,19030,2)
 ;;=^271895
 ;;^UTILITY(U,$J,358.3,19031,0)
 ;;=682.6^^125^1220^10
 ;;^UTILITY(U,$J,358.3,19031,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19031,1,3,0)
 ;;=3^682.6
 ;;^UTILITY(U,$J,358.3,19031,1,5,0)
 ;;=5^Cellulitis and abscess, leg, except foot
 ;;^UTILITY(U,$J,358.3,19031,2)
 ;;=^271894
 ;;^UTILITY(U,$J,358.3,19032,0)
 ;;=094.0^^125^1220^12
 ;;^UTILITY(U,$J,358.3,19032,1,0)
 ;;=^358.31IA^5^2
