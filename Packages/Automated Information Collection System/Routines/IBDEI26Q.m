IBDEI26Q ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36690,0)
 ;;=C22.7^^169^1856^2
 ;;^UTILITY(U,$J,358.3,36690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36690,1,3,0)
 ;;=3^Carcinomas of Liver NEC
 ;;^UTILITY(U,$J,358.3,36690,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,36690,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,36691,0)
 ;;=C22.2^^169^1856^3
 ;;^UTILITY(U,$J,358.3,36691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36691,1,3,0)
 ;;=3^Hepatoblastoma
 ;;^UTILITY(U,$J,358.3,36691,1,4,0)
 ;;=4^C22.2
 ;;^UTILITY(U,$J,358.3,36691,2)
 ;;=^5000935
 ;;^UTILITY(U,$J,358.3,36692,0)
 ;;=C22.0^^169^1856^4
 ;;^UTILITY(U,$J,358.3,36692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36692,1,3,0)
 ;;=3^Liver cell carcinoma
 ;;^UTILITY(U,$J,358.3,36692,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,36692,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,36693,0)
 ;;=C22.4^^169^1856^19
 ;;^UTILITY(U,$J,358.3,36693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36693,1,3,0)
 ;;=3^Sarcomas of Liver NEC
 ;;^UTILITY(U,$J,358.3,36693,1,4,0)
 ;;=4^C22.4
 ;;^UTILITY(U,$J,358.3,36693,2)
 ;;=^5000937
 ;;^UTILITY(U,$J,358.3,36694,0)
 ;;=C22.3^^169^1856^1
 ;;^UTILITY(U,$J,358.3,36694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36694,1,3,0)
 ;;=3^Angiosarcoma of liver
 ;;^UTILITY(U,$J,358.3,36694,1,4,0)
 ;;=4^C22.3
 ;;^UTILITY(U,$J,358.3,36694,2)
 ;;=^5000936
 ;;^UTILITY(U,$J,358.3,36695,0)
 ;;=C23.^^169^1856^11
 ;;^UTILITY(U,$J,358.3,36695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36695,1,3,0)
 ;;=3^Malignant neoplasm of gallbladder
 ;;^UTILITY(U,$J,358.3,36695,1,4,0)
 ;;=4^C23.
 ;;^UTILITY(U,$J,358.3,36695,2)
 ;;=^267098
 ;;^UTILITY(U,$J,358.3,36696,0)
 ;;=C24.0^^169^1856^10
 ;;^UTILITY(U,$J,358.3,36696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36696,1,3,0)
 ;;=3^Malignant neoplasm of extrahepatic bile duct
 ;;^UTILITY(U,$J,358.3,36696,1,4,0)
 ;;=4^C24.0
 ;;^UTILITY(U,$J,358.3,36696,2)
 ;;=^5000940
 ;;^UTILITY(U,$J,358.3,36697,0)
 ;;=C24.1^^169^1856^5
 ;;^UTILITY(U,$J,358.3,36697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36697,1,3,0)
 ;;=3^Malignant neoplasm of ampulla of Vater
 ;;^UTILITY(U,$J,358.3,36697,1,4,0)
 ;;=4^C24.1
 ;;^UTILITY(U,$J,358.3,36697,2)
 ;;=^267100
 ;;^UTILITY(U,$J,358.3,36698,0)
 ;;=C25.9^^169^1856^14
 ;;^UTILITY(U,$J,358.3,36698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36698,1,3,0)
 ;;=3^Malignant neoplasm of pancreas, unspecified
 ;;^UTILITY(U,$J,358.3,36698,1,4,0)
 ;;=4^C25.9
 ;;^UTILITY(U,$J,358.3,36698,2)
 ;;=^5000946
 ;;^UTILITY(U,$J,358.3,36699,0)
 ;;=C19.^^169^1856^15
 ;;^UTILITY(U,$J,358.3,36699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36699,1,3,0)
 ;;=3^Malignant neoplasm of rectosigmoid junction
 ;;^UTILITY(U,$J,358.3,36699,1,4,0)
 ;;=4^C19.
 ;;^UTILITY(U,$J,358.3,36699,2)
 ;;=^267089
 ;;^UTILITY(U,$J,358.3,36700,0)
 ;;=C24.8^^169^1856^13
 ;;^UTILITY(U,$J,358.3,36700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36700,1,3,0)
 ;;=3^Malignant neoplasm of overlapping sites of biliary tract
 ;;^UTILITY(U,$J,358.3,36700,1,4,0)
 ;;=4^C24.8
 ;;^UTILITY(U,$J,358.3,36700,2)
 ;;=^5000941
 ;;^UTILITY(U,$J,358.3,36701,0)
 ;;=C24.9^^169^1856^7
 ;;^UTILITY(U,$J,358.3,36701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36701,1,3,0)
 ;;=3^Malignant neoplasm of biliary tract,unspec
 ;;^UTILITY(U,$J,358.3,36701,1,4,0)
 ;;=4^C24.9
 ;;^UTILITY(U,$J,358.3,36701,2)
 ;;=^5000942
 ;;^UTILITY(U,$J,358.3,36702,0)
 ;;=C01.^^169^1857^2
 ;;^UTILITY(U,$J,358.3,36702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36702,1,3,0)
 ;;=3^Malignant neoplasm of base of tongue
 ;;^UTILITY(U,$J,358.3,36702,1,4,0)
 ;;=4^C01.
 ;;^UTILITY(U,$J,358.3,36702,2)
 ;;=^266996
