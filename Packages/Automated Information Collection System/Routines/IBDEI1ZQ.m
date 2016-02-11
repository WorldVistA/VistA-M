IBDEI1ZQ ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33330,2)
 ;;=^5003537
 ;;^UTILITY(U,$J,358.3,33331,0)
 ;;=F33.0^^148^1636^10
 ;;^UTILITY(U,$J,358.3,33331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33331,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Mild
 ;;^UTILITY(U,$J,358.3,33331,1,4,0)
 ;;=4^F33.0
 ;;^UTILITY(U,$J,358.3,33331,2)
 ;;=^5003529
 ;;^UTILITY(U,$J,358.3,33332,0)
 ;;=F33.1^^148^1636^11
 ;;^UTILITY(U,$J,358.3,33332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33332,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Moderate
 ;;^UTILITY(U,$J,358.3,33332,1,4,0)
 ;;=4^F33.1
 ;;^UTILITY(U,$J,358.3,33332,2)
 ;;=^5003530
 ;;^UTILITY(U,$J,358.3,33333,0)
 ;;=F33.2^^148^1636^12
 ;;^UTILITY(U,$J,358.3,33333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33333,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Severe
 ;;^UTILITY(U,$J,358.3,33333,1,4,0)
 ;;=4^F33.2
 ;;^UTILITY(U,$J,358.3,33333,2)
 ;;=^5003531
 ;;^UTILITY(U,$J,358.3,33334,0)
 ;;=F33.3^^148^1636^7
 ;;^UTILITY(U,$J,358.3,33334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33334,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,33334,1,4,0)
 ;;=4^F33.3
 ;;^UTILITY(U,$J,358.3,33334,2)
 ;;=^5003532
 ;;^UTILITY(U,$J,358.3,33335,0)
 ;;=F33.41^^148^1636^8
 ;;^UTILITY(U,$J,358.3,33335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33335,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,In Partial Remission
 ;;^UTILITY(U,$J,358.3,33335,1,4,0)
 ;;=4^F33.41
 ;;^UTILITY(U,$J,358.3,33335,2)
 ;;=^5003534
 ;;^UTILITY(U,$J,358.3,33336,0)
 ;;=F33.42^^148^1636^9
 ;;^UTILITY(U,$J,358.3,33336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33336,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,In Full Remission
 ;;^UTILITY(U,$J,358.3,33336,1,4,0)
 ;;=4^F33.42
 ;;^UTILITY(U,$J,358.3,33336,2)
 ;;=^5003535
 ;;^UTILITY(U,$J,358.3,33337,0)
 ;;=F34.8^^148^1636^6
 ;;^UTILITY(U,$J,358.3,33337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33337,1,3,0)
 ;;=3^Disruptive Mood Dysregulation Disorder
 ;;^UTILITY(U,$J,358.3,33337,1,4,0)
 ;;=4^F34.8
 ;;^UTILITY(U,$J,358.3,33337,2)
 ;;=^5003539
 ;;^UTILITY(U,$J,358.3,33338,0)
 ;;=F32.8^^148^1636^1
 ;;^UTILITY(U,$J,358.3,33338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33338,1,3,0)
 ;;=3^Depressive Disorder NEC
 ;;^UTILITY(U,$J,358.3,33338,1,4,0)
 ;;=4^F32.8
 ;;^UTILITY(U,$J,358.3,33338,2)
 ;;=^5003527
 ;;^UTILITY(U,$J,358.3,33339,0)
 ;;=F34.1^^148^1636^22
 ;;^UTILITY(U,$J,358.3,33339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33339,1,3,0)
 ;;=3^Persistent Depressive Disorder (Dysthymic)
 ;;^UTILITY(U,$J,358.3,33339,1,4,0)
 ;;=4^F34.1
 ;;^UTILITY(U,$J,358.3,33339,2)
 ;;=^331913
 ;;^UTILITY(U,$J,358.3,33340,0)
 ;;=F32.9^^148^1636^5
 ;;^UTILITY(U,$J,358.3,33340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33340,1,3,0)
 ;;=3^Depressive Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,33340,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,33340,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,33341,0)
 ;;=N94.3^^148^1636^23
 ;;^UTILITY(U,$J,358.3,33341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33341,1,3,0)
 ;;=3^Premenstrual Dysphoric Disorder
 ;;^UTILITY(U,$J,358.3,33341,1,4,0)
 ;;=4^N94.3
 ;;^UTILITY(U,$J,358.3,33341,2)
 ;;=^5015919
 ;;^UTILITY(U,$J,358.3,33342,0)
 ;;=G31.84^^148^1636^21
 ;;^UTILITY(U,$J,358.3,33342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33342,1,3,0)
 ;;=3^Mild Cognitive Impairment,So Stated
 ;;^UTILITY(U,$J,358.3,33342,1,4,0)
 ;;=4^G31.84
 ;;^UTILITY(U,$J,358.3,33342,2)
 ;;=^5003813
 ;;^UTILITY(U,$J,358.3,33343,0)
 ;;=F44.81^^148^1637^5
 ;;^UTILITY(U,$J,358.3,33343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33343,1,3,0)
 ;;=3^Dissociative Identity Disorder
