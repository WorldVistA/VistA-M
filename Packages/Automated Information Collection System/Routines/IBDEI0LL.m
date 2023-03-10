IBDEI0LL ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9714,2)
 ;;=^5015906
 ;;^UTILITY(U,$J,358.3,9715,0)
 ;;=N91.5^^39^417^75
 ;;^UTILITY(U,$J,358.3,9715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9715,1,3,0)
 ;;=3^Oligomenorrhea,Unspec
 ;;^UTILITY(U,$J,358.3,9715,1,4,0)
 ;;=4^N91.5
 ;;^UTILITY(U,$J,358.3,9715,2)
 ;;=^5015907
 ;;^UTILITY(U,$J,358.3,9716,0)
 ;;=N92.0^^39^417^40
 ;;^UTILITY(U,$J,358.3,9716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9716,1,3,0)
 ;;=3^Excessive/Frequent Menstruation w/ Regular Cycle
 ;;^UTILITY(U,$J,358.3,9716,1,4,0)
 ;;=4^N92.0
 ;;^UTILITY(U,$J,358.3,9716,2)
 ;;=^5015908
 ;;^UTILITY(U,$J,358.3,9717,0)
 ;;=N92.6^^39^417^62
 ;;^UTILITY(U,$J,358.3,9717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9717,1,3,0)
 ;;=3^Irregular Menstruation,Unspec
 ;;^UTILITY(U,$J,358.3,9717,1,4,0)
 ;;=4^N92.6
 ;;^UTILITY(U,$J,358.3,9717,2)
 ;;=^5015913
 ;;^UTILITY(U,$J,358.3,9718,0)
 ;;=N92.5^^39^417^61
 ;;^UTILITY(U,$J,358.3,9718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9718,1,3,0)
 ;;=3^Irregular Menstruation,Other Spec
 ;;^UTILITY(U,$J,358.3,9718,1,4,0)
 ;;=4^N92.5
 ;;^UTILITY(U,$J,358.3,9718,2)
 ;;=^5015912
 ;;^UTILITY(U,$J,358.3,9719,0)
 ;;=N92.3^^39^417^80
 ;;^UTILITY(U,$J,358.3,9719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9719,1,3,0)
 ;;=3^Ovulation Bleeding
 ;;^UTILITY(U,$J,358.3,9719,1,4,0)
 ;;=4^N92.3
 ;;^UTILITY(U,$J,358.3,9719,2)
 ;;=^270570
 ;;^UTILITY(U,$J,358.3,9720,0)
 ;;=N89.7^^39^417^54
 ;;^UTILITY(U,$J,358.3,9720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9720,1,3,0)
 ;;=3^Hematocolpos
 ;;^UTILITY(U,$J,358.3,9720,1,4,0)
 ;;=4^N89.7
 ;;^UTILITY(U,$J,358.3,9720,2)
 ;;=^5015889
 ;;^UTILITY(U,$J,358.3,9721,0)
 ;;=N93.8^^39^417^5
 ;;^UTILITY(U,$J,358.3,9721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9721,1,3,0)
 ;;=3^Abnormal Uterine/Vaginal Bleeding,Other Spec
 ;;^UTILITY(U,$J,358.3,9721,1,4,0)
 ;;=4^N93.8
 ;;^UTILITY(U,$J,358.3,9721,2)
 ;;=^5015915
 ;;^UTILITY(U,$J,358.3,9722,0)
 ;;=N93.9^^39^417^6
 ;;^UTILITY(U,$J,358.3,9722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9722,1,3,0)
 ;;=3^Abnormal Uterine/Vaginal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,9722,1,4,0)
 ;;=4^N93.9
 ;;^UTILITY(U,$J,358.3,9722,2)
 ;;=^5015916
 ;;^UTILITY(U,$J,358.3,9723,0)
 ;;=N92.4^^39^417^38
 ;;^UTILITY(U,$J,358.3,9723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9723,1,3,0)
 ;;=3^Excessive Bleeding in Premenopausal Period
 ;;^UTILITY(U,$J,358.3,9723,1,4,0)
 ;;=4^N92.4
 ;;^UTILITY(U,$J,358.3,9723,2)
 ;;=^5015911
 ;;^UTILITY(U,$J,358.3,9724,0)
 ;;=N95.0^^39^417^89
 ;;^UTILITY(U,$J,358.3,9724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9724,1,3,0)
 ;;=3^Postmenopausal Bleeding
 ;;^UTILITY(U,$J,358.3,9724,1,4,0)
 ;;=4^N95.0
 ;;^UTILITY(U,$J,358.3,9724,2)
 ;;=^97040
 ;;^UTILITY(U,$J,358.3,9725,0)
 ;;=N95.1^^39^417^69
 ;;^UTILITY(U,$J,358.3,9725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9725,1,3,0)
 ;;=3^Menopausal/Female Climacteric States
 ;;^UTILITY(U,$J,358.3,9725,1,4,0)
 ;;=4^N95.1
 ;;^UTILITY(U,$J,358.3,9725,2)
 ;;=^5015927
 ;;^UTILITY(U,$J,358.3,9726,0)
 ;;=N97.0^^39^417^45
 ;;^UTILITY(U,$J,358.3,9726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9726,1,3,0)
 ;;=3^Female Infertility Associated w/ Anovulation
 ;;^UTILITY(U,$J,358.3,9726,1,4,0)
 ;;=4^N97.0
 ;;^UTILITY(U,$J,358.3,9726,2)
 ;;=^5015931
 ;;^UTILITY(U,$J,358.3,9727,0)
 ;;=N97.9^^39^417^46
 ;;^UTILITY(U,$J,358.3,9727,1,0)
 ;;=^358.31IA^4^2
