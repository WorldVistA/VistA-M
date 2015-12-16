IBDEI07O ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3089,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Severe
 ;;^UTILITY(U,$J,358.3,3089,1,4,0)
 ;;=4^F33.2
 ;;^UTILITY(U,$J,358.3,3089,2)
 ;;=^5003531
 ;;^UTILITY(U,$J,358.3,3090,0)
 ;;=F33.3^^8^90^7
 ;;^UTILITY(U,$J,358.3,3090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3090,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,3090,1,4,0)
 ;;=4^F33.3
 ;;^UTILITY(U,$J,358.3,3090,2)
 ;;=^5003532
 ;;^UTILITY(U,$J,358.3,3091,0)
 ;;=F33.41^^8^90^8
 ;;^UTILITY(U,$J,358.3,3091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3091,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,In Partial Remission
 ;;^UTILITY(U,$J,358.3,3091,1,4,0)
 ;;=4^F33.41
 ;;^UTILITY(U,$J,358.3,3091,2)
 ;;=^5003534
 ;;^UTILITY(U,$J,358.3,3092,0)
 ;;=F33.42^^8^90^9
 ;;^UTILITY(U,$J,358.3,3092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3092,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,In Full Remission
 ;;^UTILITY(U,$J,358.3,3092,1,4,0)
 ;;=4^F33.42
 ;;^UTILITY(U,$J,358.3,3092,2)
 ;;=^5003535
 ;;^UTILITY(U,$J,358.3,3093,0)
 ;;=F34.8^^8^90^6
 ;;^UTILITY(U,$J,358.3,3093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3093,1,3,0)
 ;;=3^Disruptive Mood Dysregulation Disorder
 ;;^UTILITY(U,$J,358.3,3093,1,4,0)
 ;;=4^F34.8
 ;;^UTILITY(U,$J,358.3,3093,2)
 ;;=^5003539
 ;;^UTILITY(U,$J,358.3,3094,0)
 ;;=F32.8^^8^90^1
 ;;^UTILITY(U,$J,358.3,3094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3094,1,3,0)
 ;;=3^Depressive Disorder NEC
 ;;^UTILITY(U,$J,358.3,3094,1,4,0)
 ;;=4^F32.8
 ;;^UTILITY(U,$J,358.3,3094,2)
 ;;=^5003527
 ;;^UTILITY(U,$J,358.3,3095,0)
 ;;=F34.1^^8^90^21
 ;;^UTILITY(U,$J,358.3,3095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3095,1,3,0)
 ;;=3^Persistent Depressive Disorder (Dysthymic)
 ;;^UTILITY(U,$J,358.3,3095,1,4,0)
 ;;=4^F34.1
 ;;^UTILITY(U,$J,358.3,3095,2)
 ;;=^331913
 ;;^UTILITY(U,$J,358.3,3096,0)
 ;;=F32.9^^8^90^5
 ;;^UTILITY(U,$J,358.3,3096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3096,1,3,0)
 ;;=3^Depressive Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3096,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,3096,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,3097,0)
 ;;=N94.3^^8^90^22
 ;;^UTILITY(U,$J,358.3,3097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3097,1,3,0)
 ;;=3^Premenstrual Dysphoric Disorder
 ;;^UTILITY(U,$J,358.3,3097,1,4,0)
 ;;=4^N94.3
 ;;^UTILITY(U,$J,358.3,3097,2)
 ;;=^5015919
 ;;^UTILITY(U,$J,358.3,3098,0)
 ;;=F44.81^^8^91^5
 ;;^UTILITY(U,$J,358.3,3098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3098,1,3,0)
 ;;=3^Dissociative Identity Disorder
 ;;^UTILITY(U,$J,358.3,3098,1,4,0)
 ;;=4^F44.81
 ;;^UTILITY(U,$J,358.3,3098,2)
 ;;=^331909
 ;;^UTILITY(U,$J,358.3,3099,0)
 ;;=F44.9^^8^91^4
 ;;^UTILITY(U,$J,358.3,3099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3099,1,3,0)
 ;;=3^Dissociative Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3099,1,4,0)
 ;;=4^F44.9
 ;;^UTILITY(U,$J,358.3,3099,2)
 ;;=^5003584
 ;;^UTILITY(U,$J,358.3,3100,0)
 ;;=F44.0^^8^91^2
 ;;^UTILITY(U,$J,358.3,3100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3100,1,3,0)
 ;;=3^Dissociative Amnesia
 ;;^UTILITY(U,$J,358.3,3100,1,4,0)
 ;;=4^F44.0
 ;;^UTILITY(U,$J,358.3,3100,2)
 ;;=^5003577
 ;;^UTILITY(U,$J,358.3,3101,0)
 ;;=F48.1^^8^91^1
 ;;^UTILITY(U,$J,358.3,3101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3101,1,3,0)
 ;;=3^Depersonalization/Derealization Disorder
 ;;^UTILITY(U,$J,358.3,3101,1,4,0)
 ;;=4^F48.1
 ;;^UTILITY(U,$J,358.3,3101,2)
 ;;=^5003593
 ;;^UTILITY(U,$J,358.3,3102,0)
 ;;=F44.89^^8^91^3
 ;;^UTILITY(U,$J,358.3,3102,1,0)
 ;;=^358.31IA^4^2
