IBDEI26P ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36677,1,3,0)
 ;;=3^Malignant neoplasm of right renal pelvis
 ;;^UTILITY(U,$J,358.3,36677,1,4,0)
 ;;=4^C65.1
 ;;^UTILITY(U,$J,358.3,36677,2)
 ;;=^5001251
 ;;^UTILITY(U,$J,358.3,36678,0)
 ;;=C65.2^^169^1855^8
 ;;^UTILITY(U,$J,358.3,36678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36678,1,3,0)
 ;;=3^Malignant neoplasm of left renal pelvis
 ;;^UTILITY(U,$J,358.3,36678,1,4,0)
 ;;=4^C65.2
 ;;^UTILITY(U,$J,358.3,36678,2)
 ;;=^5001252
 ;;^UTILITY(U,$J,358.3,36679,0)
 ;;=C66.1^^169^1855^14
 ;;^UTILITY(U,$J,358.3,36679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36679,1,3,0)
 ;;=3^Malignant neoplasm of right ureter
 ;;^UTILITY(U,$J,358.3,36679,1,4,0)
 ;;=4^C66.1
 ;;^UTILITY(U,$J,358.3,36679,2)
 ;;=^5001254
 ;;^UTILITY(U,$J,358.3,36680,0)
 ;;=C66.2^^169^1855^9
 ;;^UTILITY(U,$J,358.3,36680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36680,1,3,0)
 ;;=3^Malignant neoplasm of left ureter
 ;;^UTILITY(U,$J,358.3,36680,1,4,0)
 ;;=4^C66.2
 ;;^UTILITY(U,$J,358.3,36680,2)
 ;;=^5001255
 ;;^UTILITY(U,$J,358.3,36681,0)
 ;;=C68.0^^169^1855^15
 ;;^UTILITY(U,$J,358.3,36681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36681,1,3,0)
 ;;=3^Malignant neoplasm of urethra
 ;;^UTILITY(U,$J,358.3,36681,1,4,0)
 ;;=4^C68.0
 ;;^UTILITY(U,$J,358.3,36681,2)
 ;;=^267266
 ;;^UTILITY(U,$J,358.3,36682,0)
 ;;=D09.0^^169^1855^1
 ;;^UTILITY(U,$J,358.3,36682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36682,1,3,0)
 ;;=3^Carcinoma in situ of bladder
 ;;^UTILITY(U,$J,358.3,36682,1,4,0)
 ;;=4^D09.0
 ;;^UTILITY(U,$J,358.3,36682,2)
 ;;=^267742
 ;;^UTILITY(U,$J,358.3,36683,0)
 ;;=C15.9^^169^1856^9
 ;;^UTILITY(U,$J,358.3,36683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36683,1,3,0)
 ;;=3^Malignant neoplasm of esophagus, unspecified
 ;;^UTILITY(U,$J,358.3,36683,1,4,0)
 ;;=4^C15.9
 ;;^UTILITY(U,$J,358.3,36683,2)
 ;;=^5000919
 ;;^UTILITY(U,$J,358.3,36684,0)
 ;;=C16.9^^169^1856^18
 ;;^UTILITY(U,$J,358.3,36684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36684,1,3,0)
 ;;=3^Malignant neoplasm of stomach, unspecified
 ;;^UTILITY(U,$J,358.3,36684,1,4,0)
 ;;=4^C16.9
 ;;^UTILITY(U,$J,358.3,36684,2)
 ;;=^5000923
 ;;^UTILITY(U,$J,358.3,36685,0)
 ;;=C17.9^^169^1856^17
 ;;^UTILITY(U,$J,358.3,36685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36685,1,3,0)
 ;;=3^Malignant neoplasm of small intestine, unspecified
 ;;^UTILITY(U,$J,358.3,36685,1,4,0)
 ;;=4^C17.9
 ;;^UTILITY(U,$J,358.3,36685,2)
 ;;=^5000926
 ;;^UTILITY(U,$J,358.3,36686,0)
 ;;=C18.9^^169^1856^8
 ;;^UTILITY(U,$J,358.3,36686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36686,1,3,0)
 ;;=3^Malignant neoplasm of colon, unspecified
 ;;^UTILITY(U,$J,358.3,36686,1,4,0)
 ;;=4^C18.9
 ;;^UTILITY(U,$J,358.3,36686,2)
 ;;=^5000929
 ;;^UTILITY(U,$J,358.3,36687,0)
 ;;=C20.^^169^1856^16
 ;;^UTILITY(U,$J,358.3,36687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36687,1,3,0)
 ;;=3^Malignant neoplasm of rectum
 ;;^UTILITY(U,$J,358.3,36687,1,4,0)
 ;;=4^C20.
 ;;^UTILITY(U,$J,358.3,36687,2)
 ;;=^267090
 ;;^UTILITY(U,$J,358.3,36688,0)
 ;;=C21.0^^169^1856^6
 ;;^UTILITY(U,$J,358.3,36688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36688,1,3,0)
 ;;=3^Malignant neoplasm of anus, unspecified
 ;;^UTILITY(U,$J,358.3,36688,1,4,0)
 ;;=4^C21.0
 ;;^UTILITY(U,$J,358.3,36688,2)
 ;;=^5000930
 ;;^UTILITY(U,$J,358.3,36689,0)
 ;;=C22.8^^169^1856^12
 ;;^UTILITY(U,$J,358.3,36689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36689,1,3,0)
 ;;=3^Malignant neoplasm of liver, primary, unspecified as to type
 ;;^UTILITY(U,$J,358.3,36689,1,4,0)
 ;;=4^C22.8
 ;;^UTILITY(U,$J,358.3,36689,2)
 ;;=^5000939
