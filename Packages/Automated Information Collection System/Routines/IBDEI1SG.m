IBDEI1SG ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30381,1,4,0)
 ;;=4^D68.52
 ;;^UTILITY(U,$J,358.3,30381,2)
 ;;=^5002359
 ;;^UTILITY(U,$J,358.3,30382,0)
 ;;=D68.59^^118^1507^15
 ;;^UTILITY(U,$J,358.3,30382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30382,1,3,0)
 ;;=3^Primary Thrombophilia NEC
 ;;^UTILITY(U,$J,358.3,30382,1,4,0)
 ;;=4^D68.59
 ;;^UTILITY(U,$J,358.3,30382,2)
 ;;=^5002360
 ;;^UTILITY(U,$J,358.3,30383,0)
 ;;=D68.61^^118^1507^2
 ;;^UTILITY(U,$J,358.3,30383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30383,1,3,0)
 ;;=3^Antiphospholipid syndrome
 ;;^UTILITY(U,$J,358.3,30383,1,4,0)
 ;;=4^D68.61
 ;;^UTILITY(U,$J,358.3,30383,2)
 ;;=^185421
 ;;^UTILITY(U,$J,358.3,30384,0)
 ;;=D68.62^^118^1507^3
 ;;^UTILITY(U,$J,358.3,30384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30384,1,3,0)
 ;;=3^Lupus anticoagulant syndrome
 ;;^UTILITY(U,$J,358.3,30384,1,4,0)
 ;;=4^D68.62
 ;;^UTILITY(U,$J,358.3,30384,2)
 ;;=^5002361
 ;;^UTILITY(U,$J,358.3,30385,0)
 ;;=Z85.810^^118^1508^3
 ;;^UTILITY(U,$J,358.3,30385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30385,1,3,0)
 ;;=3^Personal history of malignant neoplasm of tongue
 ;;^UTILITY(U,$J,358.3,30385,1,4,0)
 ;;=4^Z85.810
 ;;^UTILITY(U,$J,358.3,30385,2)
 ;;=^5063438
 ;;^UTILITY(U,$J,358.3,30386,0)
 ;;=Z85.818^^118^1508^4
 ;;^UTILITY(U,$J,358.3,30386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30386,1,3,0)
 ;;=3^Personal history of malignant neoplasm of site of lip, oral cav, & pharynx
 ;;^UTILITY(U,$J,358.3,30386,1,4,0)
 ;;=4^Z85.818
 ;;^UTILITY(U,$J,358.3,30386,2)
 ;;=^5063439
 ;;^UTILITY(U,$J,358.3,30387,0)
 ;;=Z85.01^^118^1508^5
 ;;^UTILITY(U,$J,358.3,30387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30387,1,3,0)
 ;;=3^Personal history of malignant neoplasm of esophagus
 ;;^UTILITY(U,$J,358.3,30387,1,4,0)
 ;;=4^Z85.01
 ;;^UTILITY(U,$J,358.3,30387,2)
 ;;=^5063395
 ;;^UTILITY(U,$J,358.3,30388,0)
 ;;=Z85.028^^118^1508^6
 ;;^UTILITY(U,$J,358.3,30388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30388,1,3,0)
 ;;=3^Personal history of malignant neoplasm of stomach NEC
 ;;^UTILITY(U,$J,358.3,30388,1,4,0)
 ;;=4^Z85.028
 ;;^UTILITY(U,$J,358.3,30388,2)
 ;;=^5063397
 ;;^UTILITY(U,$J,358.3,30389,0)
 ;;=Z85.038^^118^1508^7
 ;;^UTILITY(U,$J,358.3,30389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30389,1,3,0)
 ;;=3^Personal history of malignant neoplasm of large intestine
 ;;^UTILITY(U,$J,358.3,30389,1,4,0)
 ;;=4^Z85.038
 ;;^UTILITY(U,$J,358.3,30389,2)
 ;;=^5063399
 ;;^UTILITY(U,$J,358.3,30390,0)
 ;;=Z85.048^^118^1508^8
 ;;^UTILITY(U,$J,358.3,30390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30390,1,3,0)
 ;;=3^Personal history of malignant neoplasm of rectum, rectosig junct, and anus
 ;;^UTILITY(U,$J,358.3,30390,1,4,0)
 ;;=4^Z85.048
 ;;^UTILITY(U,$J,358.3,30390,2)
 ;;=^5063401
 ;;^UTILITY(U,$J,358.3,30391,0)
 ;;=Z85.05^^118^1508^9
 ;;^UTILITY(U,$J,358.3,30391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30391,1,3,0)
 ;;=3^Personal history of malignant neoplasm of liver
 ;;^UTILITY(U,$J,358.3,30391,1,4,0)
 ;;=4^Z85.05
 ;;^UTILITY(U,$J,358.3,30391,2)
 ;;=^5063402
 ;;^UTILITY(U,$J,358.3,30392,0)
 ;;=Z85.068^^118^1508^10
 ;;^UTILITY(U,$J,358.3,30392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30392,1,3,0)
 ;;=3^Personal history of malignant neoplasm of small intestine
 ;;^UTILITY(U,$J,358.3,30392,1,4,0)
 ;;=4^Z85.068
 ;;^UTILITY(U,$J,358.3,30392,2)
 ;;=^5063404
 ;;^UTILITY(U,$J,358.3,30393,0)
 ;;=Z85.07^^118^1508^11
 ;;^UTILITY(U,$J,358.3,30393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30393,1,3,0)
 ;;=3^Personal history of malignant neoplasm of pancreas
 ;;^UTILITY(U,$J,358.3,30393,1,4,0)
 ;;=4^Z85.07
