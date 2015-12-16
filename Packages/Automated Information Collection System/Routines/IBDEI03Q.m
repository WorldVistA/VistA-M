IBDEI03Q ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1212,1,4,0)
 ;;=4^C11.9
 ;;^UTILITY(U,$J,358.3,1212,2)
 ;;=^5000911
 ;;^UTILITY(U,$J,358.3,1213,0)
 ;;=C15.9^^3^39^58
 ;;^UTILITY(U,$J,358.3,1213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1213,1,3,0)
 ;;=3^Malignant neoplasm of esophagus, unspecified
 ;;^UTILITY(U,$J,358.3,1213,1,4,0)
 ;;=4^C15.9
 ;;^UTILITY(U,$J,358.3,1213,2)
 ;;=^5000919
 ;;^UTILITY(U,$J,358.3,1214,0)
 ;;=C16.9^^3^39^78
 ;;^UTILITY(U,$J,358.3,1214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1214,1,3,0)
 ;;=3^Malignant neoplasm of stomach, unspecified
 ;;^UTILITY(U,$J,358.3,1214,1,4,0)
 ;;=4^C16.9
 ;;^UTILITY(U,$J,358.3,1214,2)
 ;;=^5000923
 ;;^UTILITY(U,$J,358.3,1215,0)
 ;;=C17.9^^3^39^77
 ;;^UTILITY(U,$J,358.3,1215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1215,1,3,0)
 ;;=3^Malignant neoplasm of small intestine, unspecified
 ;;^UTILITY(U,$J,358.3,1215,1,4,0)
 ;;=4^C17.9
 ;;^UTILITY(U,$J,358.3,1215,2)
 ;;=^5000926
 ;;^UTILITY(U,$J,358.3,1216,0)
 ;;=C18.9^^3^39^54
 ;;^UTILITY(U,$J,358.3,1216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1216,1,3,0)
 ;;=3^Malignant neoplasm of colon, unspecified
 ;;^UTILITY(U,$J,358.3,1216,1,4,0)
 ;;=4^C18.9
 ;;^UTILITY(U,$J,358.3,1216,2)
 ;;=^5000929
 ;;^UTILITY(U,$J,358.3,1217,0)
 ;;=C20.^^3^39^73
 ;;^UTILITY(U,$J,358.3,1217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1217,1,3,0)
 ;;=3^Malignant neoplasm of rectum
 ;;^UTILITY(U,$J,358.3,1217,1,4,0)
 ;;=4^C20.
 ;;^UTILITY(U,$J,358.3,1217,2)
 ;;=^267090
 ;;^UTILITY(U,$J,358.3,1218,0)
 ;;=C21.0^^3^39^51
 ;;^UTILITY(U,$J,358.3,1218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1218,1,3,0)
 ;;=3^Malignant neoplasm of anus, unspecified
 ;;^UTILITY(U,$J,358.3,1218,1,4,0)
 ;;=4^C21.0
 ;;^UTILITY(U,$J,358.3,1218,2)
 ;;=^5000930
 ;;^UTILITY(U,$J,358.3,1219,0)
 ;;=C22.8^^3^39^66
 ;;^UTILITY(U,$J,358.3,1219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1219,1,3,0)
 ;;=3^Malignant neoplasm of liver, primary, unspecified as to type
 ;;^UTILITY(U,$J,358.3,1219,1,4,0)
 ;;=4^C22.8
 ;;^UTILITY(U,$J,358.3,1219,2)
 ;;=^5000939
 ;;^UTILITY(U,$J,358.3,1220,0)
 ;;=C22.7^^3^39^22
 ;;^UTILITY(U,$J,358.3,1220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1220,1,3,0)
 ;;=3^Carcinomas of Liver NEC
 ;;^UTILITY(U,$J,358.3,1220,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,1220,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,1221,0)
 ;;=C22.2^^3^39^37
 ;;^UTILITY(U,$J,358.3,1221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1221,1,3,0)
 ;;=3^Hepatoblastoma
 ;;^UTILITY(U,$J,358.3,1221,1,4,0)
 ;;=4^C22.2
 ;;^UTILITY(U,$J,358.3,1221,2)
 ;;=^5000935
 ;;^UTILITY(U,$J,358.3,1222,0)
 ;;=C22.0^^3^39^44
 ;;^UTILITY(U,$J,358.3,1222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1222,1,3,0)
 ;;=3^Liver cell carcinoma
 ;;^UTILITY(U,$J,358.3,1222,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,1222,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,1223,0)
 ;;=C22.4^^3^39^113
 ;;^UTILITY(U,$J,358.3,1223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1223,1,3,0)
 ;;=3^Sarcomas of liver NEC
 ;;^UTILITY(U,$J,358.3,1223,1,4,0)
 ;;=4^C22.4
 ;;^UTILITY(U,$J,358.3,1223,2)
 ;;=^5000937
 ;;^UTILITY(U,$J,358.3,1224,0)
 ;;=C22.3^^3^39^15
 ;;^UTILITY(U,$J,358.3,1224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1224,1,3,0)
 ;;=3^Angiosarcoma of liver
 ;;^UTILITY(U,$J,358.3,1224,1,4,0)
 ;;=4^C22.3
 ;;^UTILITY(U,$J,358.3,1224,2)
 ;;=^5000936
 ;;^UTILITY(U,$J,358.3,1225,0)
 ;;=C23.^^3^39^60
 ;;^UTILITY(U,$J,358.3,1225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1225,1,3,0)
 ;;=3^Malignant neoplasm of gallbladder
 ;;^UTILITY(U,$J,358.3,1225,1,4,0)
 ;;=4^C23.
 ;;^UTILITY(U,$J,358.3,1225,2)
 ;;=^267098
 ;;^UTILITY(U,$J,358.3,1226,0)
 ;;=C24.0^^3^39^59
