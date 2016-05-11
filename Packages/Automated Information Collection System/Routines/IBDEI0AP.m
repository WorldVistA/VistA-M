IBDEI0AP ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4790,1,3,0)
 ;;=3^Femoral Nerve Lesion,Left Lower Limb
 ;;^UTILITY(U,$J,358.3,4790,1,4,0)
 ;;=4^G57.22
 ;;^UTILITY(U,$J,358.3,4790,2)
 ;;=^5004046
 ;;^UTILITY(U,$J,358.3,4791,0)
 ;;=G57.31^^24^305^94
 ;;^UTILITY(U,$J,358.3,4791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4791,1,3,0)
 ;;=3^Lateral Popliteal Nerve Lesion,Right Lower Limb
 ;;^UTILITY(U,$J,358.3,4791,1,4,0)
 ;;=4^G57.31
 ;;^UTILITY(U,$J,358.3,4791,2)
 ;;=^5004048
 ;;^UTILITY(U,$J,358.3,4792,0)
 ;;=G57.32^^24^305^93
 ;;^UTILITY(U,$J,358.3,4792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4792,1,3,0)
 ;;=3^Lateral Popliteal Nerve Lesion,Left Lower Limb
 ;;^UTILITY(U,$J,358.3,4792,1,4,0)
 ;;=4^G57.32
 ;;^UTILITY(U,$J,358.3,4792,2)
 ;;=^5004049
 ;;^UTILITY(U,$J,358.3,4793,0)
 ;;=G57.41^^24^305^98
 ;;^UTILITY(U,$J,358.3,4793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4793,1,3,0)
 ;;=3^Medial Popliteal Nerve Lesion,Right Lower Limb
 ;;^UTILITY(U,$J,358.3,4793,1,4,0)
 ;;=4^G57.41
 ;;^UTILITY(U,$J,358.3,4793,2)
 ;;=^5004051
 ;;^UTILITY(U,$J,358.3,4794,0)
 ;;=G57.42^^24^305^97
 ;;^UTILITY(U,$J,358.3,4794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4794,1,3,0)
 ;;=3^Medial Popliteal Nerve Lesion,Left Lower Limb
 ;;^UTILITY(U,$J,358.3,4794,1,4,0)
 ;;=4^G57.42
 ;;^UTILITY(U,$J,358.3,4794,2)
 ;;=^5004052
 ;;^UTILITY(U,$J,358.3,4795,0)
 ;;=G57.51^^24^305^136
 ;;^UTILITY(U,$J,358.3,4795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4795,1,3,0)
 ;;=3^Tarsal Tunnel Syndrome,Right Lower Limb
 ;;^UTILITY(U,$J,358.3,4795,1,4,0)
 ;;=4^G57.51
 ;;^UTILITY(U,$J,358.3,4795,2)
 ;;=^5004054
 ;;^UTILITY(U,$J,358.3,4796,0)
 ;;=G57.52^^24^305^135
 ;;^UTILITY(U,$J,358.3,4796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4796,1,3,0)
 ;;=3^Tarsal Tunnel Syndrome,Left Lower Limb
 ;;^UTILITY(U,$J,358.3,4796,1,4,0)
 ;;=4^G57.52
 ;;^UTILITY(U,$J,358.3,4796,2)
 ;;=^5004055
 ;;^UTILITY(U,$J,358.3,4797,0)
 ;;=G57.61^^24^305^130
 ;;^UTILITY(U,$J,358.3,4797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4797,1,3,0)
 ;;=3^Plantar Nerve Lesion,Right Lower Limb
 ;;^UTILITY(U,$J,358.3,4797,1,4,0)
 ;;=4^G57.61
 ;;^UTILITY(U,$J,358.3,4797,2)
 ;;=^5004057
 ;;^UTILITY(U,$J,358.3,4798,0)
 ;;=G57.62^^24^305^129
 ;;^UTILITY(U,$J,358.3,4798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4798,1,3,0)
 ;;=3^Plantar Nerve Lesion,Left Lower Limb
 ;;^UTILITY(U,$J,358.3,4798,1,4,0)
 ;;=4^G57.62
 ;;^UTILITY(U,$J,358.3,4798,2)
 ;;=^5004058
 ;;^UTILITY(U,$J,358.3,4799,0)
 ;;=G57.71^^24^305^3
 ;;^UTILITY(U,$J,358.3,4799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4799,1,3,0)
 ;;=3^Causalgia,Right Lower Limb
 ;;^UTILITY(U,$J,358.3,4799,1,4,0)
 ;;=4^G57.71
 ;;^UTILITY(U,$J,358.3,4799,2)
 ;;=^5133365
 ;;^UTILITY(U,$J,358.3,4800,0)
 ;;=G57.72^^24^305^1
 ;;^UTILITY(U,$J,358.3,4800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4800,1,3,0)
 ;;=3^Causalgia,Left Lower Limb
 ;;^UTILITY(U,$J,358.3,4800,1,4,0)
 ;;=4^G57.72
 ;;^UTILITY(U,$J,358.3,4800,2)
 ;;=^5133366
 ;;^UTILITY(U,$J,358.3,4801,0)
 ;;=G57.81^^24^305^106
 ;;^UTILITY(U,$J,358.3,4801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4801,1,3,0)
 ;;=3^Mononeuropathies,Right Lower Limb,Spec
 ;;^UTILITY(U,$J,358.3,4801,1,4,0)
 ;;=4^G57.81
 ;;^UTILITY(U,$J,358.3,4801,2)
 ;;=^5133367
 ;;^UTILITY(U,$J,358.3,4802,0)
 ;;=G57.82^^24^305^104
 ;;^UTILITY(U,$J,358.3,4802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4802,1,3,0)
 ;;=3^Mononeuropathies,Left Lower Limb,Spec
 ;;^UTILITY(U,$J,358.3,4802,1,4,0)
 ;;=4^G57.82
 ;;^UTILITY(U,$J,358.3,4802,2)
 ;;=^5133368
 ;;^UTILITY(U,$J,358.3,4803,0)
 ;;=G57.91^^24^305^110
