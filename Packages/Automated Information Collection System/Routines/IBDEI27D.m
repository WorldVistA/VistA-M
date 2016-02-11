IBDEI27D ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36975,1,3,0)
 ;;=3^Personal history of malignant neoplasm of site of lip, oral cav, & pharynx
 ;;^UTILITY(U,$J,358.3,36975,1,4,0)
 ;;=4^Z85.818
 ;;^UTILITY(U,$J,358.3,36975,2)
 ;;=^5063439
 ;;^UTILITY(U,$J,358.3,36976,0)
 ;;=Z85.01^^169^1865^5
 ;;^UTILITY(U,$J,358.3,36976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36976,1,3,0)
 ;;=3^Personal history of malignant neoplasm of esophagus
 ;;^UTILITY(U,$J,358.3,36976,1,4,0)
 ;;=4^Z85.01
 ;;^UTILITY(U,$J,358.3,36976,2)
 ;;=^5063395
 ;;^UTILITY(U,$J,358.3,36977,0)
 ;;=Z85.028^^169^1865^6
 ;;^UTILITY(U,$J,358.3,36977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36977,1,3,0)
 ;;=3^Personal history of malignant neoplasm of stomach NEC
 ;;^UTILITY(U,$J,358.3,36977,1,4,0)
 ;;=4^Z85.028
 ;;^UTILITY(U,$J,358.3,36977,2)
 ;;=^5063397
 ;;^UTILITY(U,$J,358.3,36978,0)
 ;;=Z85.038^^169^1865^7
 ;;^UTILITY(U,$J,358.3,36978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36978,1,3,0)
 ;;=3^Personal history of malignant neoplasm of large intestine
 ;;^UTILITY(U,$J,358.3,36978,1,4,0)
 ;;=4^Z85.038
 ;;^UTILITY(U,$J,358.3,36978,2)
 ;;=^5063399
 ;;^UTILITY(U,$J,358.3,36979,0)
 ;;=Z85.048^^169^1865^8
 ;;^UTILITY(U,$J,358.3,36979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36979,1,3,0)
 ;;=3^Personal history of malignant neoplasm of rectum, rectosig junct, and anus
 ;;^UTILITY(U,$J,358.3,36979,1,4,0)
 ;;=4^Z85.048
 ;;^UTILITY(U,$J,358.3,36979,2)
 ;;=^5063401
 ;;^UTILITY(U,$J,358.3,36980,0)
 ;;=Z85.05^^169^1865^9
 ;;^UTILITY(U,$J,358.3,36980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36980,1,3,0)
 ;;=3^Personal history of malignant neoplasm of liver
 ;;^UTILITY(U,$J,358.3,36980,1,4,0)
 ;;=4^Z85.05
 ;;^UTILITY(U,$J,358.3,36980,2)
 ;;=^5063402
 ;;^UTILITY(U,$J,358.3,36981,0)
 ;;=Z85.068^^169^1865^10
 ;;^UTILITY(U,$J,358.3,36981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36981,1,3,0)
 ;;=3^Personal history of malignant neoplasm of small intestine
 ;;^UTILITY(U,$J,358.3,36981,1,4,0)
 ;;=4^Z85.068
 ;;^UTILITY(U,$J,358.3,36981,2)
 ;;=^5063404
 ;;^UTILITY(U,$J,358.3,36982,0)
 ;;=Z85.07^^169^1865^11
 ;;^UTILITY(U,$J,358.3,36982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36982,1,3,0)
 ;;=3^Personal history of malignant neoplasm of pancreas
 ;;^UTILITY(U,$J,358.3,36982,1,4,0)
 ;;=4^Z85.07
 ;;^UTILITY(U,$J,358.3,36982,2)
 ;;=^5063405
 ;;^UTILITY(U,$J,358.3,36983,0)
 ;;=Z85.09^^169^1865^12
 ;;^UTILITY(U,$J,358.3,36983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36983,1,3,0)
 ;;=3^Personal history of malignant neoplasm of digestive organs
 ;;^UTILITY(U,$J,358.3,36983,1,4,0)
 ;;=4^Z85.09
 ;;^UTILITY(U,$J,358.3,36983,2)
 ;;=^5063406
 ;;^UTILITY(U,$J,358.3,36984,0)
 ;;=Z85.118^^169^1865^13
 ;;^UTILITY(U,$J,358.3,36984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36984,1,3,0)
 ;;=3^Personal history of malignant neoplasm of bronchus and lung
 ;;^UTILITY(U,$J,358.3,36984,1,4,0)
 ;;=4^Z85.118
 ;;^UTILITY(U,$J,358.3,36984,2)
 ;;=^5063408
 ;;^UTILITY(U,$J,358.3,36985,0)
 ;;=Z85.12^^169^1865^14
 ;;^UTILITY(U,$J,358.3,36985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36985,1,3,0)
 ;;=3^Personal history of malignant neoplasm of trachea
 ;;^UTILITY(U,$J,358.3,36985,1,4,0)
 ;;=4^Z85.12
 ;;^UTILITY(U,$J,358.3,36985,2)
 ;;=^5063409
 ;;^UTILITY(U,$J,358.3,36986,0)
 ;;=Z85.21^^169^1865^15
 ;;^UTILITY(U,$J,358.3,36986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36986,1,3,0)
 ;;=3^Personal history of malignant neoplasm of larynx
 ;;^UTILITY(U,$J,358.3,36986,1,4,0)
 ;;=4^Z85.21
 ;;^UTILITY(U,$J,358.3,36986,2)
 ;;=^5063411
