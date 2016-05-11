IBDEI1RT ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30096,1,3,0)
 ;;=3^Malignant neoplasm of small intestine, unspecified
 ;;^UTILITY(U,$J,358.3,30096,1,4,0)
 ;;=4^C17.9
 ;;^UTILITY(U,$J,358.3,30096,2)
 ;;=^5000926
 ;;^UTILITY(U,$J,358.3,30097,0)
 ;;=C18.9^^118^1499^8
 ;;^UTILITY(U,$J,358.3,30097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30097,1,3,0)
 ;;=3^Malignant neoplasm of colon, unspecified
 ;;^UTILITY(U,$J,358.3,30097,1,4,0)
 ;;=4^C18.9
 ;;^UTILITY(U,$J,358.3,30097,2)
 ;;=^5000929
 ;;^UTILITY(U,$J,358.3,30098,0)
 ;;=C20.^^118^1499^16
 ;;^UTILITY(U,$J,358.3,30098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30098,1,3,0)
 ;;=3^Malignant neoplasm of rectum
 ;;^UTILITY(U,$J,358.3,30098,1,4,0)
 ;;=4^C20.
 ;;^UTILITY(U,$J,358.3,30098,2)
 ;;=^267090
 ;;^UTILITY(U,$J,358.3,30099,0)
 ;;=C21.0^^118^1499^6
 ;;^UTILITY(U,$J,358.3,30099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30099,1,3,0)
 ;;=3^Malignant neoplasm of anus, unspecified
 ;;^UTILITY(U,$J,358.3,30099,1,4,0)
 ;;=4^C21.0
 ;;^UTILITY(U,$J,358.3,30099,2)
 ;;=^5000930
 ;;^UTILITY(U,$J,358.3,30100,0)
 ;;=C22.8^^118^1499^12
 ;;^UTILITY(U,$J,358.3,30100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30100,1,3,0)
 ;;=3^Malignant neoplasm of liver, primary, unspecified as to type
 ;;^UTILITY(U,$J,358.3,30100,1,4,0)
 ;;=4^C22.8
 ;;^UTILITY(U,$J,358.3,30100,2)
 ;;=^5000939
 ;;^UTILITY(U,$J,358.3,30101,0)
 ;;=C22.7^^118^1499^2
 ;;^UTILITY(U,$J,358.3,30101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30101,1,3,0)
 ;;=3^Carcinomas of Liver NEC
 ;;^UTILITY(U,$J,358.3,30101,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,30101,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,30102,0)
 ;;=C22.2^^118^1499^3
 ;;^UTILITY(U,$J,358.3,30102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30102,1,3,0)
 ;;=3^Hepatoblastoma
 ;;^UTILITY(U,$J,358.3,30102,1,4,0)
 ;;=4^C22.2
 ;;^UTILITY(U,$J,358.3,30102,2)
 ;;=^5000935
 ;;^UTILITY(U,$J,358.3,30103,0)
 ;;=C22.0^^118^1499^4
 ;;^UTILITY(U,$J,358.3,30103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30103,1,3,0)
 ;;=3^Liver cell carcinoma
 ;;^UTILITY(U,$J,358.3,30103,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,30103,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,30104,0)
 ;;=C22.4^^118^1499^19
 ;;^UTILITY(U,$J,358.3,30104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30104,1,3,0)
 ;;=3^Sarcomas of Liver NEC
 ;;^UTILITY(U,$J,358.3,30104,1,4,0)
 ;;=4^C22.4
 ;;^UTILITY(U,$J,358.3,30104,2)
 ;;=^5000937
 ;;^UTILITY(U,$J,358.3,30105,0)
 ;;=C22.3^^118^1499^1
 ;;^UTILITY(U,$J,358.3,30105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30105,1,3,0)
 ;;=3^Angiosarcoma of liver
 ;;^UTILITY(U,$J,358.3,30105,1,4,0)
 ;;=4^C22.3
 ;;^UTILITY(U,$J,358.3,30105,2)
 ;;=^5000936
 ;;^UTILITY(U,$J,358.3,30106,0)
 ;;=C23.^^118^1499^11
 ;;^UTILITY(U,$J,358.3,30106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30106,1,3,0)
 ;;=3^Malignant neoplasm of gallbladder
 ;;^UTILITY(U,$J,358.3,30106,1,4,0)
 ;;=4^C23.
 ;;^UTILITY(U,$J,358.3,30106,2)
 ;;=^267098
 ;;^UTILITY(U,$J,358.3,30107,0)
 ;;=C24.0^^118^1499^10
 ;;^UTILITY(U,$J,358.3,30107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30107,1,3,0)
 ;;=3^Malignant neoplasm of extrahepatic bile duct
 ;;^UTILITY(U,$J,358.3,30107,1,4,0)
 ;;=4^C24.0
 ;;^UTILITY(U,$J,358.3,30107,2)
 ;;=^5000940
 ;;^UTILITY(U,$J,358.3,30108,0)
 ;;=C24.1^^118^1499^5
 ;;^UTILITY(U,$J,358.3,30108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30108,1,3,0)
 ;;=3^Malignant neoplasm of ampulla of Vater
 ;;^UTILITY(U,$J,358.3,30108,1,4,0)
 ;;=4^C24.1
 ;;^UTILITY(U,$J,358.3,30108,2)
 ;;=^267100
 ;;^UTILITY(U,$J,358.3,30109,0)
 ;;=C25.9^^118^1499^14
 ;;^UTILITY(U,$J,358.3,30109,1,0)
 ;;=^358.31IA^4^2
