IBDEI07N ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3076,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,3076,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,3077,0)
 ;;=F06.31^^8^90^3
 ;;^UTILITY(U,$J,358.3,3077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3077,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Depressive Features
 ;;^UTILITY(U,$J,358.3,3077,1,4,0)
 ;;=4^F06.31
 ;;^UTILITY(U,$J,358.3,3077,2)
 ;;=^5003057
 ;;^UTILITY(U,$J,358.3,3078,0)
 ;;=F06.32^^8^90^4
 ;;^UTILITY(U,$J,358.3,3078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3078,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Major Depressive-Like Episode
 ;;^UTILITY(U,$J,358.3,3078,1,4,0)
 ;;=4^F06.32
 ;;^UTILITY(U,$J,358.3,3078,2)
 ;;=^5003058
 ;;^UTILITY(U,$J,358.3,3079,0)
 ;;=F32.9^^8^90^14
 ;;^UTILITY(U,$J,358.3,3079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3079,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,3079,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,3079,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,3080,0)
 ;;=F32.0^^8^90^15
 ;;^UTILITY(U,$J,358.3,3080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3080,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Mild
 ;;^UTILITY(U,$J,358.3,3080,1,4,0)
 ;;=4^F32.0
 ;;^UTILITY(U,$J,358.3,3080,2)
 ;;=^5003521
 ;;^UTILITY(U,$J,358.3,3081,0)
 ;;=F32.1^^8^90^16
 ;;^UTILITY(U,$J,358.3,3081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3081,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Moderate
 ;;^UTILITY(U,$J,358.3,3081,1,4,0)
 ;;=4^F32.1
 ;;^UTILITY(U,$J,358.3,3081,2)
 ;;=^5003522
 ;;^UTILITY(U,$J,358.3,3082,0)
 ;;=F32.2^^8^90^17
 ;;^UTILITY(U,$J,358.3,3082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3082,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Severe
 ;;^UTILITY(U,$J,358.3,3082,1,4,0)
 ;;=4^F32.2
 ;;^UTILITY(U,$J,358.3,3082,2)
 ;;=^5003523
 ;;^UTILITY(U,$J,358.3,3083,0)
 ;;=F32.3^^8^90^18
 ;;^UTILITY(U,$J,358.3,3083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3083,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode w Psychotic Features
 ;;^UTILITY(U,$J,358.3,3083,1,4,0)
 ;;=4^F32.3
 ;;^UTILITY(U,$J,358.3,3083,2)
 ;;=^5003524
 ;;^UTILITY(U,$J,358.3,3084,0)
 ;;=F32.4^^8^90^19
 ;;^UTILITY(U,$J,358.3,3084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3084,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,In Partial Remission
 ;;^UTILITY(U,$J,358.3,3084,1,4,0)
 ;;=4^F32.4
 ;;^UTILITY(U,$J,358.3,3084,2)
 ;;=^5003525
 ;;^UTILITY(U,$J,358.3,3085,0)
 ;;=F32.5^^8^90^20
 ;;^UTILITY(U,$J,358.3,3085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3085,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,In Full Remission
 ;;^UTILITY(U,$J,358.3,3085,1,4,0)
 ;;=4^F32.5
 ;;^UTILITY(U,$J,358.3,3085,2)
 ;;=^5003526
 ;;^UTILITY(U,$J,358.3,3086,0)
 ;;=F33.9^^8^90^13
 ;;^UTILITY(U,$J,358.3,3086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3086,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Unspec
 ;;^UTILITY(U,$J,358.3,3086,1,4,0)
 ;;=4^F33.9
 ;;^UTILITY(U,$J,358.3,3086,2)
 ;;=^5003537
 ;;^UTILITY(U,$J,358.3,3087,0)
 ;;=F33.0^^8^90^10
 ;;^UTILITY(U,$J,358.3,3087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3087,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Mild
 ;;^UTILITY(U,$J,358.3,3087,1,4,0)
 ;;=4^F33.0
 ;;^UTILITY(U,$J,358.3,3087,2)
 ;;=^5003529
 ;;^UTILITY(U,$J,358.3,3088,0)
 ;;=F33.1^^8^90^11
 ;;^UTILITY(U,$J,358.3,3088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3088,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Moderate
 ;;^UTILITY(U,$J,358.3,3088,1,4,0)
 ;;=4^F33.1
 ;;^UTILITY(U,$J,358.3,3088,2)
 ;;=^5003530
 ;;^UTILITY(U,$J,358.3,3089,0)
 ;;=F33.2^^8^90^12
