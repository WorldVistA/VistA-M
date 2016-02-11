IBDEI1XO ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32368,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,32369,0)
 ;;=F03.91^^143^1521^15
 ;;^UTILITY(U,$J,358.3,32369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32369,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,32369,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,32369,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,32370,0)
 ;;=F03.90^^143^1521^17
 ;;^UTILITY(U,$J,358.3,32370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32370,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,32370,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,32370,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,32371,0)
 ;;=F06.30^^143^1522^2
 ;;^UTILITY(U,$J,358.3,32371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32371,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition,Unspec
 ;;^UTILITY(U,$J,358.3,32371,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,32371,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,32372,0)
 ;;=F06.31^^143^1522^3
 ;;^UTILITY(U,$J,358.3,32372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32372,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Depressive Features
 ;;^UTILITY(U,$J,358.3,32372,1,4,0)
 ;;=4^F06.31
 ;;^UTILITY(U,$J,358.3,32372,2)
 ;;=^5003057
 ;;^UTILITY(U,$J,358.3,32373,0)
 ;;=F06.32^^143^1522^4
 ;;^UTILITY(U,$J,358.3,32373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32373,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Major Depressive-Like Episode
 ;;^UTILITY(U,$J,358.3,32373,1,4,0)
 ;;=4^F06.32
 ;;^UTILITY(U,$J,358.3,32373,2)
 ;;=^5003058
 ;;^UTILITY(U,$J,358.3,32374,0)
 ;;=F32.9^^143^1522^14
 ;;^UTILITY(U,$J,358.3,32374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32374,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,32374,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,32374,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,32375,0)
 ;;=F32.0^^143^1522^15
 ;;^UTILITY(U,$J,358.3,32375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32375,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Mild
 ;;^UTILITY(U,$J,358.3,32375,1,4,0)
 ;;=4^F32.0
 ;;^UTILITY(U,$J,358.3,32375,2)
 ;;=^5003521
 ;;^UTILITY(U,$J,358.3,32376,0)
 ;;=F32.1^^143^1522^16
 ;;^UTILITY(U,$J,358.3,32376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32376,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Moderate
 ;;^UTILITY(U,$J,358.3,32376,1,4,0)
 ;;=4^F32.1
 ;;^UTILITY(U,$J,358.3,32376,2)
 ;;=^5003522
 ;;^UTILITY(U,$J,358.3,32377,0)
 ;;=F32.2^^143^1522^17
 ;;^UTILITY(U,$J,358.3,32377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32377,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Severe
 ;;^UTILITY(U,$J,358.3,32377,1,4,0)
 ;;=4^F32.2
 ;;^UTILITY(U,$J,358.3,32377,2)
 ;;=^5003523
 ;;^UTILITY(U,$J,358.3,32378,0)
 ;;=F32.3^^143^1522^18
 ;;^UTILITY(U,$J,358.3,32378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32378,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode w Psychotic Features
 ;;^UTILITY(U,$J,358.3,32378,1,4,0)
 ;;=4^F32.3
 ;;^UTILITY(U,$J,358.3,32378,2)
 ;;=^5003524
 ;;^UTILITY(U,$J,358.3,32379,0)
 ;;=F32.4^^143^1522^19
 ;;^UTILITY(U,$J,358.3,32379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32379,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,In Partial Remission
 ;;^UTILITY(U,$J,358.3,32379,1,4,0)
 ;;=4^F32.4
 ;;^UTILITY(U,$J,358.3,32379,2)
 ;;=^5003525
 ;;^UTILITY(U,$J,358.3,32380,0)
 ;;=F32.5^^143^1522^20
 ;;^UTILITY(U,$J,358.3,32380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32380,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,In Full Remission
 ;;^UTILITY(U,$J,358.3,32380,1,4,0)
 ;;=4^F32.5
