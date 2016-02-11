IBDEI1VW ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31552,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Mild
 ;;^UTILITY(U,$J,358.3,31552,1,4,0)
 ;;=4^F32.0
 ;;^UTILITY(U,$J,358.3,31552,2)
 ;;=^5003521
 ;;^UTILITY(U,$J,358.3,31553,0)
 ;;=F32.1^^138^1430^16
 ;;^UTILITY(U,$J,358.3,31553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31553,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Moderate
 ;;^UTILITY(U,$J,358.3,31553,1,4,0)
 ;;=4^F32.1
 ;;^UTILITY(U,$J,358.3,31553,2)
 ;;=^5003522
 ;;^UTILITY(U,$J,358.3,31554,0)
 ;;=F32.2^^138^1430^17
 ;;^UTILITY(U,$J,358.3,31554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31554,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Severe
 ;;^UTILITY(U,$J,358.3,31554,1,4,0)
 ;;=4^F32.2
 ;;^UTILITY(U,$J,358.3,31554,2)
 ;;=^5003523
 ;;^UTILITY(U,$J,358.3,31555,0)
 ;;=F32.3^^138^1430^18
 ;;^UTILITY(U,$J,358.3,31555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31555,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode w Psychotic Features
 ;;^UTILITY(U,$J,358.3,31555,1,4,0)
 ;;=4^F32.3
 ;;^UTILITY(U,$J,358.3,31555,2)
 ;;=^5003524
 ;;^UTILITY(U,$J,358.3,31556,0)
 ;;=F32.4^^138^1430^19
 ;;^UTILITY(U,$J,358.3,31556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31556,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,In Partial Remission
 ;;^UTILITY(U,$J,358.3,31556,1,4,0)
 ;;=4^F32.4
 ;;^UTILITY(U,$J,358.3,31556,2)
 ;;=^5003525
 ;;^UTILITY(U,$J,358.3,31557,0)
 ;;=F32.5^^138^1430^20
 ;;^UTILITY(U,$J,358.3,31557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31557,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,In Full Remission
 ;;^UTILITY(U,$J,358.3,31557,1,4,0)
 ;;=4^F32.5
 ;;^UTILITY(U,$J,358.3,31557,2)
 ;;=^5003526
 ;;^UTILITY(U,$J,358.3,31558,0)
 ;;=F33.9^^138^1430^13
 ;;^UTILITY(U,$J,358.3,31558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31558,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Unspec
 ;;^UTILITY(U,$J,358.3,31558,1,4,0)
 ;;=4^F33.9
 ;;^UTILITY(U,$J,358.3,31558,2)
 ;;=^5003537
 ;;^UTILITY(U,$J,358.3,31559,0)
 ;;=F33.0^^138^1430^10
 ;;^UTILITY(U,$J,358.3,31559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31559,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Mild
 ;;^UTILITY(U,$J,358.3,31559,1,4,0)
 ;;=4^F33.0
 ;;^UTILITY(U,$J,358.3,31559,2)
 ;;=^5003529
 ;;^UTILITY(U,$J,358.3,31560,0)
 ;;=F33.1^^138^1430^11
 ;;^UTILITY(U,$J,358.3,31560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31560,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Moderate
 ;;^UTILITY(U,$J,358.3,31560,1,4,0)
 ;;=4^F33.1
 ;;^UTILITY(U,$J,358.3,31560,2)
 ;;=^5003530
 ;;^UTILITY(U,$J,358.3,31561,0)
 ;;=F33.2^^138^1430^12
 ;;^UTILITY(U,$J,358.3,31561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31561,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Severe
 ;;^UTILITY(U,$J,358.3,31561,1,4,0)
 ;;=4^F33.2
 ;;^UTILITY(U,$J,358.3,31561,2)
 ;;=^5003531
 ;;^UTILITY(U,$J,358.3,31562,0)
 ;;=F33.3^^138^1430^7
 ;;^UTILITY(U,$J,358.3,31562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31562,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,31562,1,4,0)
 ;;=4^F33.3
 ;;^UTILITY(U,$J,358.3,31562,2)
 ;;=^5003532
 ;;^UTILITY(U,$J,358.3,31563,0)
 ;;=F33.41^^138^1430^8
 ;;^UTILITY(U,$J,358.3,31563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31563,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,In Partial Remission
 ;;^UTILITY(U,$J,358.3,31563,1,4,0)
 ;;=4^F33.41
 ;;^UTILITY(U,$J,358.3,31563,2)
 ;;=^5003534
 ;;^UTILITY(U,$J,358.3,31564,0)
 ;;=F33.42^^138^1430^9
 ;;^UTILITY(U,$J,358.3,31564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31564,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,In Full Remission
