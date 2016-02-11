IBDEI1XP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32380,2)
 ;;=^5003526
 ;;^UTILITY(U,$J,358.3,32381,0)
 ;;=F33.9^^143^1522^13
 ;;^UTILITY(U,$J,358.3,32381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32381,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Unspec
 ;;^UTILITY(U,$J,358.3,32381,1,4,0)
 ;;=4^F33.9
 ;;^UTILITY(U,$J,358.3,32381,2)
 ;;=^5003537
 ;;^UTILITY(U,$J,358.3,32382,0)
 ;;=F33.0^^143^1522^10
 ;;^UTILITY(U,$J,358.3,32382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32382,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Mild
 ;;^UTILITY(U,$J,358.3,32382,1,4,0)
 ;;=4^F33.0
 ;;^UTILITY(U,$J,358.3,32382,2)
 ;;=^5003529
 ;;^UTILITY(U,$J,358.3,32383,0)
 ;;=F33.1^^143^1522^11
 ;;^UTILITY(U,$J,358.3,32383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32383,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Moderate
 ;;^UTILITY(U,$J,358.3,32383,1,4,0)
 ;;=4^F33.1
 ;;^UTILITY(U,$J,358.3,32383,2)
 ;;=^5003530
 ;;^UTILITY(U,$J,358.3,32384,0)
 ;;=F33.2^^143^1522^12
 ;;^UTILITY(U,$J,358.3,32384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32384,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Severe
 ;;^UTILITY(U,$J,358.3,32384,1,4,0)
 ;;=4^F33.2
 ;;^UTILITY(U,$J,358.3,32384,2)
 ;;=^5003531
 ;;^UTILITY(U,$J,358.3,32385,0)
 ;;=F33.3^^143^1522^7
 ;;^UTILITY(U,$J,358.3,32385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32385,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,32385,1,4,0)
 ;;=4^F33.3
 ;;^UTILITY(U,$J,358.3,32385,2)
 ;;=^5003532
 ;;^UTILITY(U,$J,358.3,32386,0)
 ;;=F33.41^^143^1522^8
 ;;^UTILITY(U,$J,358.3,32386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32386,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,In Partial Remission
 ;;^UTILITY(U,$J,358.3,32386,1,4,0)
 ;;=4^F33.41
 ;;^UTILITY(U,$J,358.3,32386,2)
 ;;=^5003534
 ;;^UTILITY(U,$J,358.3,32387,0)
 ;;=F33.42^^143^1522^9
 ;;^UTILITY(U,$J,358.3,32387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32387,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,In Full Remission
 ;;^UTILITY(U,$J,358.3,32387,1,4,0)
 ;;=4^F33.42
 ;;^UTILITY(U,$J,358.3,32387,2)
 ;;=^5003535
 ;;^UTILITY(U,$J,358.3,32388,0)
 ;;=F34.8^^143^1522^6
 ;;^UTILITY(U,$J,358.3,32388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32388,1,3,0)
 ;;=3^Disruptive Mood Dysregulation Disorder
 ;;^UTILITY(U,$J,358.3,32388,1,4,0)
 ;;=4^F34.8
 ;;^UTILITY(U,$J,358.3,32388,2)
 ;;=^5003539
 ;;^UTILITY(U,$J,358.3,32389,0)
 ;;=F32.8^^143^1522^1
 ;;^UTILITY(U,$J,358.3,32389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32389,1,3,0)
 ;;=3^Depressive Disorder NEC
 ;;^UTILITY(U,$J,358.3,32389,1,4,0)
 ;;=4^F32.8
 ;;^UTILITY(U,$J,358.3,32389,2)
 ;;=^5003527
 ;;^UTILITY(U,$J,358.3,32390,0)
 ;;=F34.1^^143^1522^22
 ;;^UTILITY(U,$J,358.3,32390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32390,1,3,0)
 ;;=3^Persistent Depressive Disorder (Dysthymic)
 ;;^UTILITY(U,$J,358.3,32390,1,4,0)
 ;;=4^F34.1
 ;;^UTILITY(U,$J,358.3,32390,2)
 ;;=^331913
 ;;^UTILITY(U,$J,358.3,32391,0)
 ;;=F32.9^^143^1522^5
 ;;^UTILITY(U,$J,358.3,32391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32391,1,3,0)
 ;;=3^Depressive Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,32391,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,32391,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,32392,0)
 ;;=N94.3^^143^1522^23
 ;;^UTILITY(U,$J,358.3,32392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32392,1,3,0)
 ;;=3^Premenstrual Dysphoric Disorder
 ;;^UTILITY(U,$J,358.3,32392,1,4,0)
 ;;=4^N94.3
 ;;^UTILITY(U,$J,358.3,32392,2)
 ;;=^5015919
 ;;^UTILITY(U,$J,358.3,32393,0)
 ;;=G31.84^^143^1522^21
 ;;^UTILITY(U,$J,358.3,32393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32393,1,3,0)
 ;;=3^Mild Cognitive Impairment,So Stated
