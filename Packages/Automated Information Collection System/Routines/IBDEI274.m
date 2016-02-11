IBDEI274 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36864,1,3,0)
 ;;=3^Malignant neoplasm of cauda equina
 ;;^UTILITY(U,$J,358.3,36864,1,4,0)
 ;;=4^C72.1
 ;;^UTILITY(U,$J,358.3,36864,2)
 ;;=^5001298
 ;;^UTILITY(U,$J,358.3,36865,0)
 ;;=C72.0^^169^1861^26
 ;;^UTILITY(U,$J,358.3,36865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36865,1,3,0)
 ;;=3^Malignant neoplasm of spinal cord
 ;;^UTILITY(U,$J,358.3,36865,1,4,0)
 ;;=4^C72.0
 ;;^UTILITY(U,$J,358.3,36865,2)
 ;;=^267292
 ;;^UTILITY(U,$J,358.3,36866,0)
 ;;=C74.01^^169^1861^21
 ;;^UTILITY(U,$J,358.3,36866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36866,1,3,0)
 ;;=3^Malignant neoplasm of cortex of right adrenal gland
 ;;^UTILITY(U,$J,358.3,36866,1,4,0)
 ;;=4^C74.01
 ;;^UTILITY(U,$J,358.3,36866,2)
 ;;=^5001312
 ;;^UTILITY(U,$J,358.3,36867,0)
 ;;=C74.02^^169^1861^20
 ;;^UTILITY(U,$J,358.3,36867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36867,1,3,0)
 ;;=3^Malignant neoplasm of cortex of left adrenal gland
 ;;^UTILITY(U,$J,358.3,36867,1,4,0)
 ;;=4^C74.02
 ;;^UTILITY(U,$J,358.3,36867,2)
 ;;=^5001313
 ;;^UTILITY(U,$J,358.3,36868,0)
 ;;=C74.11^^169^1861^23
 ;;^UTILITY(U,$J,358.3,36868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36868,1,3,0)
 ;;=3^Malignant neoplasm of medulla of right adrenal gland
 ;;^UTILITY(U,$J,358.3,36868,1,4,0)
 ;;=4^C74.11
 ;;^UTILITY(U,$J,358.3,36868,2)
 ;;=^5001315
 ;;^UTILITY(U,$J,358.3,36869,0)
 ;;=C74.12^^169^1861^22
 ;;^UTILITY(U,$J,358.3,36869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36869,1,3,0)
 ;;=3^Malignant neoplasm of medulla of left adrenal gland
 ;;^UTILITY(U,$J,358.3,36869,1,4,0)
 ;;=4^C74.12
 ;;^UTILITY(U,$J,358.3,36869,2)
 ;;=^5001316
 ;;^UTILITY(U,$J,358.3,36870,0)
 ;;=C74.91^^169^1861^28
 ;;^UTILITY(U,$J,358.3,36870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36870,1,3,0)
 ;;=3^Malignant neoplasm of unsp part of right adrenal gland
 ;;^UTILITY(U,$J,358.3,36870,1,4,0)
 ;;=4^C74.91
 ;;^UTILITY(U,$J,358.3,36870,2)
 ;;=^5001318
 ;;^UTILITY(U,$J,358.3,36871,0)
 ;;=C74.92^^169^1861^27
 ;;^UTILITY(U,$J,358.3,36871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36871,1,3,0)
 ;;=3^Malignant neoplasm of unsp part of left adrenal gland
 ;;^UTILITY(U,$J,358.3,36871,1,4,0)
 ;;=4^C74.92
 ;;^UTILITY(U,$J,358.3,36871,2)
 ;;=^5001319
 ;;^UTILITY(U,$J,358.3,36872,0)
 ;;=C44.112^^169^1861^12
 ;;^UTILITY(U,$J,358.3,36872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36872,1,3,0)
 ;;=3^Basal cell carcinoma of skin or right eyelid,including canthus
 ;;^UTILITY(U,$J,358.3,36872,1,4,0)
 ;;=4^C44.112
 ;;^UTILITY(U,$J,358.3,36872,2)
 ;;=^5001020
 ;;^UTILITY(U,$J,358.3,36873,0)
 ;;=C44.119^^169^1861^4
 ;;^UTILITY(U,$J,358.3,36873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36873,1,3,0)
 ;;=3^Basal cell carcinoma of skin of left eyelid,including canthus
 ;;^UTILITY(U,$J,358.3,36873,1,4,0)
 ;;=4^C44.119
 ;;^UTILITY(U,$J,358.3,36873,2)
 ;;=^5001021
 ;;^UTILITY(U,$J,358.3,36874,0)
 ;;=C44.122^^169^1861^39
 ;;^UTILITY(U,$J,358.3,36874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36874,1,3,0)
 ;;=3^Squamous cell carcinoma of skin of right eyelid,including canthus
 ;;^UTILITY(U,$J,358.3,36874,1,4,0)
 ;;=4^C44.122
 ;;^UTILITY(U,$J,358.3,36874,2)
 ;;=^5001023
 ;;^UTILITY(U,$J,358.3,36875,0)
 ;;=C44.129^^169^1861^33
 ;;^UTILITY(U,$J,358.3,36875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36875,1,3,0)
 ;;=3^Squamous cell carcinoma of skin of left eyelid,including canthus
 ;;^UTILITY(U,$J,358.3,36875,1,4,0)
 ;;=4^C44.129
 ;;^UTILITY(U,$J,358.3,36875,2)
 ;;=^5001024
 ;;^UTILITY(U,$J,358.3,36876,0)
 ;;=C44.222^^169^1861^40
 ;;^UTILITY(U,$J,358.3,36876,1,0)
 ;;=^358.31IA^4^2
