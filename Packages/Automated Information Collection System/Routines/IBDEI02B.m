IBDEI02B ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,531,1,4,0)
 ;;=4^C44.520
 ;;^UTILITY(U,$J,358.3,531,2)
 ;;=^5001057
 ;;^UTILITY(U,$J,358.3,532,0)
 ;;=C44.521^^2^23^30
 ;;^UTILITY(U,$J,358.3,532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,532,1,3,0)
 ;;=3^Squamous cell carcinoma of skin of breast
 ;;^UTILITY(U,$J,358.3,532,1,4,0)
 ;;=4^C44.521
 ;;^UTILITY(U,$J,358.3,532,2)
 ;;=^5001058
 ;;^UTILITY(U,$J,358.3,533,0)
 ;;=C44.529^^2^23^34
 ;;^UTILITY(U,$J,358.3,533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,533,1,3,0)
 ;;=3^Squamous cell carcinoma of skin of other part of trunk
 ;;^UTILITY(U,$J,358.3,533,1,4,0)
 ;;=4^C44.529
 ;;^UTILITY(U,$J,358.3,533,2)
 ;;=^5001059
 ;;^UTILITY(U,$J,358.3,534,0)
 ;;=C46.9^^2^23^11
 ;;^UTILITY(U,$J,358.3,534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,534,1,3,0)
 ;;=3^Kaposi's sarcoma, unspecified
 ;;^UTILITY(U,$J,358.3,534,1,4,0)
 ;;=4^C46.9
 ;;^UTILITY(U,$J,358.3,534,2)
 ;;=^5001108
 ;;^UTILITY(U,$J,358.3,535,0)
 ;;=C71.9^^2^23^15
 ;;^UTILITY(U,$J,358.3,535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,535,1,3,0)
 ;;=3^Malignant neoplasm of brain, unspecified
 ;;^UTILITY(U,$J,358.3,535,1,4,0)
 ;;=4^C71.9
 ;;^UTILITY(U,$J,358.3,535,2)
 ;;=^5001297
 ;;^UTILITY(U,$J,358.3,536,0)
 ;;=C72.1^^2^23^16
 ;;^UTILITY(U,$J,358.3,536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,536,1,3,0)
 ;;=3^Malignant neoplasm of cauda equina
 ;;^UTILITY(U,$J,358.3,536,1,4,0)
 ;;=4^C72.1
 ;;^UTILITY(U,$J,358.3,536,2)
 ;;=^5001298
 ;;^UTILITY(U,$J,358.3,537,0)
 ;;=C72.0^^2^23^24
 ;;^UTILITY(U,$J,358.3,537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,537,1,3,0)
 ;;=3^Malignant neoplasm of spinal cord
 ;;^UTILITY(U,$J,358.3,537,1,4,0)
 ;;=4^C72.0
 ;;^UTILITY(U,$J,358.3,537,2)
 ;;=^267292
 ;;^UTILITY(U,$J,358.3,538,0)
 ;;=C74.01^^2^23^19
 ;;^UTILITY(U,$J,358.3,538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,538,1,3,0)
 ;;=3^Malignant neoplasm of cortex of right adrenal gland
 ;;^UTILITY(U,$J,358.3,538,1,4,0)
 ;;=4^C74.01
 ;;^UTILITY(U,$J,358.3,538,2)
 ;;=^5001312
 ;;^UTILITY(U,$J,358.3,539,0)
 ;;=C74.02^^2^23^18
 ;;^UTILITY(U,$J,358.3,539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,539,1,3,0)
 ;;=3^Malignant neoplasm of cortex of left adrenal gland
 ;;^UTILITY(U,$J,358.3,539,1,4,0)
 ;;=4^C74.02
 ;;^UTILITY(U,$J,358.3,539,2)
 ;;=^5001313
 ;;^UTILITY(U,$J,358.3,540,0)
 ;;=C74.11^^2^23^21
 ;;^UTILITY(U,$J,358.3,540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,540,1,3,0)
 ;;=3^Malignant neoplasm of medulla of right adrenal gland
 ;;^UTILITY(U,$J,358.3,540,1,4,0)
 ;;=4^C74.11
 ;;^UTILITY(U,$J,358.3,540,2)
 ;;=^5001315
 ;;^UTILITY(U,$J,358.3,541,0)
 ;;=C74.12^^2^23^20
 ;;^UTILITY(U,$J,358.3,541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,541,1,3,0)
 ;;=3^Malignant neoplasm of medulla of left adrenal gland
 ;;^UTILITY(U,$J,358.3,541,1,4,0)
 ;;=4^C74.12
 ;;^UTILITY(U,$J,358.3,541,2)
 ;;=^5001316
 ;;^UTILITY(U,$J,358.3,542,0)
 ;;=C74.91^^2^23^26
 ;;^UTILITY(U,$J,358.3,542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,542,1,3,0)
 ;;=3^Malignant neoplasm of unsp part of right adrenal gland
 ;;^UTILITY(U,$J,358.3,542,1,4,0)
 ;;=4^C74.91
 ;;^UTILITY(U,$J,358.3,542,2)
 ;;=^5001318
 ;;^UTILITY(U,$J,358.3,543,0)
 ;;=C74.92^^2^23^25
 ;;^UTILITY(U,$J,358.3,543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,543,1,3,0)
 ;;=3^Malignant neoplasm of unsp part of left adrenal gland
 ;;^UTILITY(U,$J,358.3,543,1,4,0)
 ;;=4^C74.92
 ;;^UTILITY(U,$J,358.3,543,2)
 ;;=^5001319
 ;;^UTILITY(U,$J,358.3,544,0)
 ;;=C92.40^^2^24^21
 ;;^UTILITY(U,$J,358.3,544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,544,1,3,0)
 ;;=3^Acute promyelocytic leukemia, not having achieved remission
