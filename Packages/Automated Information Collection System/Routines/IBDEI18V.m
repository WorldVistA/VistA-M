IBDEI18V ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20808,1,4,0)
 ;;=4^F06.31
 ;;^UTILITY(U,$J,358.3,20808,2)
 ;;=^5003057
 ;;^UTILITY(U,$J,358.3,20809,0)
 ;;=F06.32^^99^986^4
 ;;^UTILITY(U,$J,358.3,20809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20809,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Major Depressive-Like Episode
 ;;^UTILITY(U,$J,358.3,20809,1,4,0)
 ;;=4^F06.32
 ;;^UTILITY(U,$J,358.3,20809,2)
 ;;=^5003058
 ;;^UTILITY(U,$J,358.3,20810,0)
 ;;=F32.9^^99^986^14
 ;;^UTILITY(U,$J,358.3,20810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20810,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,20810,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,20810,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,20811,0)
 ;;=F32.0^^99^986^15
 ;;^UTILITY(U,$J,358.3,20811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20811,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Mild
 ;;^UTILITY(U,$J,358.3,20811,1,4,0)
 ;;=4^F32.0
 ;;^UTILITY(U,$J,358.3,20811,2)
 ;;=^5003521
 ;;^UTILITY(U,$J,358.3,20812,0)
 ;;=F32.1^^99^986^16
 ;;^UTILITY(U,$J,358.3,20812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20812,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Moderate
 ;;^UTILITY(U,$J,358.3,20812,1,4,0)
 ;;=4^F32.1
 ;;^UTILITY(U,$J,358.3,20812,2)
 ;;=^5003522
 ;;^UTILITY(U,$J,358.3,20813,0)
 ;;=F32.2^^99^986^17
 ;;^UTILITY(U,$J,358.3,20813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20813,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Severe
 ;;^UTILITY(U,$J,358.3,20813,1,4,0)
 ;;=4^F32.2
 ;;^UTILITY(U,$J,358.3,20813,2)
 ;;=^5003523
 ;;^UTILITY(U,$J,358.3,20814,0)
 ;;=F32.3^^99^986^18
 ;;^UTILITY(U,$J,358.3,20814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20814,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode w Psychotic Features
 ;;^UTILITY(U,$J,358.3,20814,1,4,0)
 ;;=4^F32.3
 ;;^UTILITY(U,$J,358.3,20814,2)
 ;;=^5003524
 ;;^UTILITY(U,$J,358.3,20815,0)
 ;;=F32.4^^99^986^19
 ;;^UTILITY(U,$J,358.3,20815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20815,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,In Partial Remission
 ;;^UTILITY(U,$J,358.3,20815,1,4,0)
 ;;=4^F32.4
 ;;^UTILITY(U,$J,358.3,20815,2)
 ;;=^5003525
 ;;^UTILITY(U,$J,358.3,20816,0)
 ;;=F32.5^^99^986^20
 ;;^UTILITY(U,$J,358.3,20816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20816,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,In Full Remission
 ;;^UTILITY(U,$J,358.3,20816,1,4,0)
 ;;=4^F32.5
 ;;^UTILITY(U,$J,358.3,20816,2)
 ;;=^5003526
 ;;^UTILITY(U,$J,358.3,20817,0)
 ;;=F33.9^^99^986^13
 ;;^UTILITY(U,$J,358.3,20817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20817,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Unspec
 ;;^UTILITY(U,$J,358.3,20817,1,4,0)
 ;;=4^F33.9
 ;;^UTILITY(U,$J,358.3,20817,2)
 ;;=^5003537
 ;;^UTILITY(U,$J,358.3,20818,0)
 ;;=F33.0^^99^986^10
 ;;^UTILITY(U,$J,358.3,20818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20818,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Mild
 ;;^UTILITY(U,$J,358.3,20818,1,4,0)
 ;;=4^F33.0
 ;;^UTILITY(U,$J,358.3,20818,2)
 ;;=^5003529
 ;;^UTILITY(U,$J,358.3,20819,0)
 ;;=F33.1^^99^986^11
 ;;^UTILITY(U,$J,358.3,20819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20819,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Moderate
 ;;^UTILITY(U,$J,358.3,20819,1,4,0)
 ;;=4^F33.1
 ;;^UTILITY(U,$J,358.3,20819,2)
 ;;=^5003530
 ;;^UTILITY(U,$J,358.3,20820,0)
 ;;=F33.2^^99^986^12
 ;;^UTILITY(U,$J,358.3,20820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20820,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Severe
 ;;^UTILITY(U,$J,358.3,20820,1,4,0)
 ;;=4^F33.2
