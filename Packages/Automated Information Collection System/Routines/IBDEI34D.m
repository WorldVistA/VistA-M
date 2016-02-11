IBDEI34D ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,52357,0)
 ;;=F06.30^^237^2593^2
 ;;^UTILITY(U,$J,358.3,52357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52357,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition,Unspec
 ;;^UTILITY(U,$J,358.3,52357,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,52357,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,52358,0)
 ;;=F06.31^^237^2593^3
 ;;^UTILITY(U,$J,358.3,52358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52358,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Depressive Features
 ;;^UTILITY(U,$J,358.3,52358,1,4,0)
 ;;=4^F06.31
 ;;^UTILITY(U,$J,358.3,52358,2)
 ;;=^5003057
 ;;^UTILITY(U,$J,358.3,52359,0)
 ;;=F06.32^^237^2593^4
 ;;^UTILITY(U,$J,358.3,52359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52359,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Major Depressive-Like Episode
 ;;^UTILITY(U,$J,358.3,52359,1,4,0)
 ;;=4^F06.32
 ;;^UTILITY(U,$J,358.3,52359,2)
 ;;=^5003058
 ;;^UTILITY(U,$J,358.3,52360,0)
 ;;=F32.9^^237^2593^14
 ;;^UTILITY(U,$J,358.3,52360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52360,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,52360,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,52360,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,52361,0)
 ;;=F32.0^^237^2593^15
 ;;^UTILITY(U,$J,358.3,52361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52361,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Mild
 ;;^UTILITY(U,$J,358.3,52361,1,4,0)
 ;;=4^F32.0
 ;;^UTILITY(U,$J,358.3,52361,2)
 ;;=^5003521
 ;;^UTILITY(U,$J,358.3,52362,0)
 ;;=F32.1^^237^2593^16
 ;;^UTILITY(U,$J,358.3,52362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52362,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Moderate
 ;;^UTILITY(U,$J,358.3,52362,1,4,0)
 ;;=4^F32.1
 ;;^UTILITY(U,$J,358.3,52362,2)
 ;;=^5003522
 ;;^UTILITY(U,$J,358.3,52363,0)
 ;;=F32.2^^237^2593^17
 ;;^UTILITY(U,$J,358.3,52363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52363,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Severe
 ;;^UTILITY(U,$J,358.3,52363,1,4,0)
 ;;=4^F32.2
 ;;^UTILITY(U,$J,358.3,52363,2)
 ;;=^5003523
 ;;^UTILITY(U,$J,358.3,52364,0)
 ;;=F32.3^^237^2593^18
 ;;^UTILITY(U,$J,358.3,52364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52364,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode w Psychotic Features
 ;;^UTILITY(U,$J,358.3,52364,1,4,0)
 ;;=4^F32.3
 ;;^UTILITY(U,$J,358.3,52364,2)
 ;;=^5003524
 ;;^UTILITY(U,$J,358.3,52365,0)
 ;;=F32.4^^237^2593^19
 ;;^UTILITY(U,$J,358.3,52365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52365,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,In Partial Remission
 ;;^UTILITY(U,$J,358.3,52365,1,4,0)
 ;;=4^F32.4
 ;;^UTILITY(U,$J,358.3,52365,2)
 ;;=^5003525
 ;;^UTILITY(U,$J,358.3,52366,0)
 ;;=F32.5^^237^2593^20
 ;;^UTILITY(U,$J,358.3,52366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52366,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,In Full Remission
 ;;^UTILITY(U,$J,358.3,52366,1,4,0)
 ;;=4^F32.5
 ;;^UTILITY(U,$J,358.3,52366,2)
 ;;=^5003526
 ;;^UTILITY(U,$J,358.3,52367,0)
 ;;=F33.9^^237^2593^13
 ;;^UTILITY(U,$J,358.3,52367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52367,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Unspec
 ;;^UTILITY(U,$J,358.3,52367,1,4,0)
 ;;=4^F33.9
 ;;^UTILITY(U,$J,358.3,52367,2)
 ;;=^5003537
 ;;^UTILITY(U,$J,358.3,52368,0)
 ;;=F33.0^^237^2593^10
 ;;^UTILITY(U,$J,358.3,52368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52368,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Mild
 ;;^UTILITY(U,$J,358.3,52368,1,4,0)
 ;;=4^F33.0
 ;;^UTILITY(U,$J,358.3,52368,2)
 ;;=^5003529
