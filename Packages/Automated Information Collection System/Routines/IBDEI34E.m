IBDEI34E ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,52369,0)
 ;;=F33.1^^237^2593^11
 ;;^UTILITY(U,$J,358.3,52369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52369,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Moderate
 ;;^UTILITY(U,$J,358.3,52369,1,4,0)
 ;;=4^F33.1
 ;;^UTILITY(U,$J,358.3,52369,2)
 ;;=^5003530
 ;;^UTILITY(U,$J,358.3,52370,0)
 ;;=F33.2^^237^2593^12
 ;;^UTILITY(U,$J,358.3,52370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52370,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Severe
 ;;^UTILITY(U,$J,358.3,52370,1,4,0)
 ;;=4^F33.2
 ;;^UTILITY(U,$J,358.3,52370,2)
 ;;=^5003531
 ;;^UTILITY(U,$J,358.3,52371,0)
 ;;=F33.3^^237^2593^7
 ;;^UTILITY(U,$J,358.3,52371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52371,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,52371,1,4,0)
 ;;=4^F33.3
 ;;^UTILITY(U,$J,358.3,52371,2)
 ;;=^5003532
 ;;^UTILITY(U,$J,358.3,52372,0)
 ;;=F33.41^^237^2593^8
 ;;^UTILITY(U,$J,358.3,52372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52372,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,In Partial Remission
 ;;^UTILITY(U,$J,358.3,52372,1,4,0)
 ;;=4^F33.41
 ;;^UTILITY(U,$J,358.3,52372,2)
 ;;=^5003534
 ;;^UTILITY(U,$J,358.3,52373,0)
 ;;=F33.42^^237^2593^9
 ;;^UTILITY(U,$J,358.3,52373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52373,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,In Full Remission
 ;;^UTILITY(U,$J,358.3,52373,1,4,0)
 ;;=4^F33.42
 ;;^UTILITY(U,$J,358.3,52373,2)
 ;;=^5003535
 ;;^UTILITY(U,$J,358.3,52374,0)
 ;;=F34.8^^237^2593^6
 ;;^UTILITY(U,$J,358.3,52374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52374,1,3,0)
 ;;=3^Disruptive Mood Dysregulation Disorder
 ;;^UTILITY(U,$J,358.3,52374,1,4,0)
 ;;=4^F34.8
 ;;^UTILITY(U,$J,358.3,52374,2)
 ;;=^5003539
 ;;^UTILITY(U,$J,358.3,52375,0)
 ;;=F32.8^^237^2593^1
 ;;^UTILITY(U,$J,358.3,52375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52375,1,3,0)
 ;;=3^Depressive Disorder NEC
 ;;^UTILITY(U,$J,358.3,52375,1,4,0)
 ;;=4^F32.8
 ;;^UTILITY(U,$J,358.3,52375,2)
 ;;=^5003527
 ;;^UTILITY(U,$J,358.3,52376,0)
 ;;=F34.1^^237^2593^22
 ;;^UTILITY(U,$J,358.3,52376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52376,1,3,0)
 ;;=3^Persistent Depressive Disorder (Dysthymic)
 ;;^UTILITY(U,$J,358.3,52376,1,4,0)
 ;;=4^F34.1
 ;;^UTILITY(U,$J,358.3,52376,2)
 ;;=^331913
 ;;^UTILITY(U,$J,358.3,52377,0)
 ;;=F32.9^^237^2593^5
 ;;^UTILITY(U,$J,358.3,52377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52377,1,3,0)
 ;;=3^Depressive Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,52377,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,52377,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,52378,0)
 ;;=N94.3^^237^2593^23
 ;;^UTILITY(U,$J,358.3,52378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52378,1,3,0)
 ;;=3^Premenstrual Dysphoric Disorder
 ;;^UTILITY(U,$J,358.3,52378,1,4,0)
 ;;=4^N94.3
 ;;^UTILITY(U,$J,358.3,52378,2)
 ;;=^5015919
 ;;^UTILITY(U,$J,358.3,52379,0)
 ;;=G31.84^^237^2593^21
 ;;^UTILITY(U,$J,358.3,52379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52379,1,3,0)
 ;;=3^Mild Cognitive Impairment,So Stated
 ;;^UTILITY(U,$J,358.3,52379,1,4,0)
 ;;=4^G31.84
 ;;^UTILITY(U,$J,358.3,52379,2)
 ;;=^5003813
 ;;^UTILITY(U,$J,358.3,52380,0)
 ;;=F44.81^^237^2594^5
 ;;^UTILITY(U,$J,358.3,52380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52380,1,3,0)
 ;;=3^Dissociative Identity Disorder
 ;;^UTILITY(U,$J,358.3,52380,1,4,0)
 ;;=4^F44.81
 ;;^UTILITY(U,$J,358.3,52380,2)
 ;;=^331909
 ;;^UTILITY(U,$J,358.3,52381,0)
 ;;=F44.9^^237^2594^4
 ;;^UTILITY(U,$J,358.3,52381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52381,1,3,0)
 ;;=3^Dissociative Disorder,Unspec
