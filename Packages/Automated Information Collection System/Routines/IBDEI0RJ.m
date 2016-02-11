IBDEI0RJ ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12634,1,4,0)
 ;;=4^C04.9
 ;;^UTILITY(U,$J,358.3,12634,2)
 ;;=^5000896
 ;;^UTILITY(U,$J,358.3,12635,0)
 ;;=C05.2^^77^735^32
 ;;^UTILITY(U,$J,358.3,12635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12635,1,3,0)
 ;;=3^Malignant neoplasm of uvula
 ;;^UTILITY(U,$J,358.3,12635,1,4,0)
 ;;=4^C05.2
 ;;^UTILITY(U,$J,358.3,12635,2)
 ;;=^267023
 ;;^UTILITY(U,$J,358.3,12636,0)
 ;;=C06.9^^77^735^20
 ;;^UTILITY(U,$J,358.3,12636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12636,1,3,0)
 ;;=3^Malignant neoplasm of mouth, unspecified
 ;;^UTILITY(U,$J,358.3,12636,1,4,0)
 ;;=4^C06.9
 ;;^UTILITY(U,$J,358.3,12636,2)
 ;;=^5000901
 ;;^UTILITY(U,$J,358.3,12637,0)
 ;;=C09.9^^77^735^31
 ;;^UTILITY(U,$J,358.3,12637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12637,1,3,0)
 ;;=3^Malignant neoplasm of tonsil, unspecified
 ;;^UTILITY(U,$J,358.3,12637,1,4,0)
 ;;=4^C09.9
 ;;^UTILITY(U,$J,358.3,12637,2)
 ;;=^5000905
 ;;^UTILITY(U,$J,358.3,12638,0)
 ;;=C10.9^^77^735^23
 ;;^UTILITY(U,$J,358.3,12638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12638,1,3,0)
 ;;=3^Malignant neoplasm of oropharynx, unspecified
 ;;^UTILITY(U,$J,358.3,12638,1,4,0)
 ;;=4^C10.9
 ;;^UTILITY(U,$J,358.3,12638,2)
 ;;=^5000909
 ;;^UTILITY(U,$J,358.3,12639,0)
 ;;=C11.9^^77^735^22
 ;;^UTILITY(U,$J,358.3,12639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12639,1,3,0)
 ;;=3^Malignant neoplasm of nasopharynx, unspecified
 ;;^UTILITY(U,$J,358.3,12639,1,4,0)
 ;;=4^C11.9
 ;;^UTILITY(U,$J,358.3,12639,2)
 ;;=^5000911
 ;;^UTILITY(U,$J,358.3,12640,0)
 ;;=C12.^^77^735^25
 ;;^UTILITY(U,$J,358.3,12640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12640,1,3,0)
 ;;=3^Malignant neoplasm of pyriform sinus
 ;;^UTILITY(U,$J,358.3,12640,1,4,0)
 ;;=4^C12.
 ;;^UTILITY(U,$J,358.3,12640,2)
 ;;=^267046
 ;;^UTILITY(U,$J,358.3,12641,0)
 ;;=C13.9^^77^735^18
 ;;^UTILITY(U,$J,358.3,12641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12641,1,3,0)
 ;;=3^Malignant neoplasm of hypopharynx, unspecified
 ;;^UTILITY(U,$J,358.3,12641,1,4,0)
 ;;=4^C13.9
 ;;^UTILITY(U,$J,358.3,12641,2)
 ;;=^5000915
 ;;^UTILITY(U,$J,358.3,12642,0)
 ;;=C30.0^^77^735^21
 ;;^UTILITY(U,$J,358.3,12642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12642,1,3,0)
 ;;=3^Malignant neoplasm of nasal cavity
 ;;^UTILITY(U,$J,358.3,12642,1,4,0)
 ;;=4^C30.0
 ;;^UTILITY(U,$J,358.3,12642,2)
 ;;=^5000949
 ;;^UTILITY(U,$J,358.3,12643,0)
 ;;=C31.9^^77^735^12
 ;;^UTILITY(U,$J,358.3,12643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12643,1,3,0)
 ;;=3^Malignant neoplasm of accessory sinus, unspecified
 ;;^UTILITY(U,$J,358.3,12643,1,4,0)
 ;;=4^C31.9
 ;;^UTILITY(U,$J,358.3,12643,2)
 ;;=^5000953
 ;;^UTILITY(U,$J,358.3,12644,0)
 ;;=C32.0^^77^735^15
 ;;^UTILITY(U,$J,358.3,12644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12644,1,3,0)
 ;;=3^Malignant neoplasm of glottis
 ;;^UTILITY(U,$J,358.3,12644,1,4,0)
 ;;=4^C32.0
 ;;^UTILITY(U,$J,358.3,12644,2)
 ;;=^267129
 ;;^UTILITY(U,$J,358.3,12645,0)
 ;;=C32.1^^77^735^28
 ;;^UTILITY(U,$J,358.3,12645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12645,1,3,0)
 ;;=3^Malignant neoplasm of supraglottis
 ;;^UTILITY(U,$J,358.3,12645,1,4,0)
 ;;=4^C32.1
 ;;^UTILITY(U,$J,358.3,12645,2)
 ;;=^267130
 ;;^UTILITY(U,$J,358.3,12646,0)
 ;;=C32.2^^77^735^26
 ;;^UTILITY(U,$J,358.3,12646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12646,1,3,0)
 ;;=3^Malignant neoplasm of subglottis
 ;;^UTILITY(U,$J,358.3,12646,1,4,0)
 ;;=4^C32.2
 ;;^UTILITY(U,$J,358.3,12646,2)
 ;;=^267131
 ;;^UTILITY(U,$J,358.3,12647,0)
 ;;=C44.212^^77^735^3
 ;;^UTILITY(U,$J,358.3,12647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12647,1,3,0)
 ;;=3^BC CA Skin RIGHT Ear and EAC
