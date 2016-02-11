IBDEI22L ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34710,1,3,0)
 ;;=3^Lesion of ulnar nerve, left upper limb
 ;;^UTILITY(U,$J,358.3,34710,1,4,0)
 ;;=4^G56.22
 ;;^UTILITY(U,$J,358.3,34710,2)
 ;;=^5004025
 ;;^UTILITY(U,$J,358.3,34711,0)
 ;;=G56.31^^160^1766^16
 ;;^UTILITY(U,$J,358.3,34711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34711,1,3,0)
 ;;=3^Lesion of radial nerve, right upper limb
 ;;^UTILITY(U,$J,358.3,34711,1,4,0)
 ;;=4^G56.31
 ;;^UTILITY(U,$J,358.3,34711,2)
 ;;=^5004027
 ;;^UTILITY(U,$J,358.3,34712,0)
 ;;=G56.32^^160^1766^15
 ;;^UTILITY(U,$J,358.3,34712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34712,1,3,0)
 ;;=3^Lesion of radial nerve, left upper limb
 ;;^UTILITY(U,$J,358.3,34712,1,4,0)
 ;;=4^G56.32
 ;;^UTILITY(U,$J,358.3,34712,2)
 ;;=^5004028
 ;;^UTILITY(U,$J,358.3,34713,0)
 ;;=G56.81^^160^1766^27
 ;;^UTILITY(U,$J,358.3,34713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34713,1,3,0)
 ;;=3^Mononeuropathies of right upper limb NEC
 ;;^UTILITY(U,$J,358.3,34713,1,4,0)
 ;;=4^G56.81
 ;;^UTILITY(U,$J,358.3,34713,2)
 ;;=^5004033
 ;;^UTILITY(U,$J,358.3,34714,0)
 ;;=G56.82^^160^1766^25
 ;;^UTILITY(U,$J,358.3,34714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34714,1,3,0)
 ;;=3^Mononeuropathies of left upper limb NEC
 ;;^UTILITY(U,$J,358.3,34714,1,4,0)
 ;;=4^G56.82
 ;;^UTILITY(U,$J,358.3,34714,2)
 ;;=^5004034
 ;;^UTILITY(U,$J,358.3,34715,0)
 ;;=G57.01^^160^1766^18
 ;;^UTILITY(U,$J,358.3,34715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34715,1,3,0)
 ;;=3^Lesion of sciatic nerve, right lower limb
 ;;^UTILITY(U,$J,358.3,34715,1,4,0)
 ;;=4^G57.01
 ;;^UTILITY(U,$J,358.3,34715,2)
 ;;=^5004039
 ;;^UTILITY(U,$J,358.3,34716,0)
 ;;=G57.02^^160^1766^17
 ;;^UTILITY(U,$J,358.3,34716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34716,1,3,0)
 ;;=3^Lesion of sciatic nerve, left lower limb
 ;;^UTILITY(U,$J,358.3,34716,1,4,0)
 ;;=4^G57.02
 ;;^UTILITY(U,$J,358.3,34716,2)
 ;;=^5004040
 ;;^UTILITY(U,$J,358.3,34717,0)
 ;;=G57.11^^160^1766^23
 ;;^UTILITY(U,$J,358.3,34717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34717,1,3,0)
 ;;=3^Meralgia paresthetica, right lower limb
 ;;^UTILITY(U,$J,358.3,34717,1,4,0)
 ;;=4^G57.11
 ;;^UTILITY(U,$J,358.3,34717,2)
 ;;=^5004042
 ;;^UTILITY(U,$J,358.3,34718,0)
 ;;=G57.12^^160^1766^22
 ;;^UTILITY(U,$J,358.3,34718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34718,1,3,0)
 ;;=3^Meralgia paresthetica, left lower limb
 ;;^UTILITY(U,$J,358.3,34718,1,4,0)
 ;;=4^G57.12
 ;;^UTILITY(U,$J,358.3,34718,2)
 ;;=^5004043
 ;;^UTILITY(U,$J,358.3,34719,0)
 ;;=G57.21^^160^1766^8
 ;;^UTILITY(U,$J,358.3,34719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34719,1,3,0)
 ;;=3^Lesion of femoral nerve, right lower limb
 ;;^UTILITY(U,$J,358.3,34719,1,4,0)
 ;;=4^G57.21
 ;;^UTILITY(U,$J,358.3,34719,2)
 ;;=^5004045
 ;;^UTILITY(U,$J,358.3,34720,0)
 ;;=G57.22^^160^1766^7
 ;;^UTILITY(U,$J,358.3,34720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34720,1,3,0)
 ;;=3^Lesion of femoral nerve, left lower limb
 ;;^UTILITY(U,$J,358.3,34720,1,4,0)
 ;;=4^G57.22
 ;;^UTILITY(U,$J,358.3,34720,2)
 ;;=^5004046
 ;;^UTILITY(U,$J,358.3,34721,0)
 ;;=G57.31^^160^1766^10
 ;;^UTILITY(U,$J,358.3,34721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34721,1,3,0)
 ;;=3^Lesion of lateral popliteal nerve, right lower limb
 ;;^UTILITY(U,$J,358.3,34721,1,4,0)
 ;;=4^G57.31
 ;;^UTILITY(U,$J,358.3,34721,2)
 ;;=^5004048
 ;;^UTILITY(U,$J,358.3,34722,0)
 ;;=G57.32^^160^1766^9
 ;;^UTILITY(U,$J,358.3,34722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34722,1,3,0)
 ;;=3^Lesion of lateral popliteal nerve, left lower limb
