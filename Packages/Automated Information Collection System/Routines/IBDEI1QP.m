IBDEI1QP ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27807,1,3,0)
 ;;=3^Alcohol Use DO (Mild),Uncomplicated
 ;;^UTILITY(U,$J,358.3,27807,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,27807,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,27808,0)
 ;;=F10.20^^113^1360^34
 ;;^UTILITY(U,$J,358.3,27808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27808,1,3,0)
 ;;=3^Alcohol Use DO (Mod/Sev),Uncomplicated
 ;;^UTILITY(U,$J,358.3,27808,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,27808,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,27809,0)
 ;;=F10.239^^113^1360^31
 ;;^UTILITY(U,$J,358.3,27809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27809,1,3,0)
 ;;=3^Alcohol Use DO (Mod/Sev) WD,Unspec
 ;;^UTILITY(U,$J,358.3,27809,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,27809,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,27810,0)
 ;;=F10.180^^113^1360^1
 ;;^UTILITY(U,$J,358.3,27810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27810,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27810,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,27810,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,27811,0)
 ;;=F10.280^^113^1360^2
 ;;^UTILITY(U,$J,358.3,27811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27811,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Mod/Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27811,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,27811,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,27812,0)
 ;;=F10.980^^113^1360^3
 ;;^UTILITY(U,$J,358.3,27812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27812,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27812,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,27812,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,27813,0)
 ;;=F10.26^^113^1360^4
 ;;^UTILITY(U,$J,358.3,27813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27813,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/ Mod/Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27813,1,4,0)
 ;;=4^F10.26
 ;;^UTILITY(U,$J,358.3,27813,2)
 ;;=^5003094
 ;;^UTILITY(U,$J,358.3,27814,0)
 ;;=F10.96^^113^1360^5
 ;;^UTILITY(U,$J,358.3,27814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27814,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27814,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,27814,2)
 ;;=^5003108
 ;;^UTILITY(U,$J,358.3,27815,0)
 ;;=F10.27^^113^1360^6
 ;;^UTILITY(U,$J,358.3,27815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27815,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type w/ Mod/Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27815,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,27815,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,27816,0)
 ;;=F10.97^^113^1360^7
 ;;^UTILITY(U,$J,358.3,27816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27816,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27816,1,4,0)
 ;;=4^F10.97
 ;;^UTILITY(U,$J,358.3,27816,2)
 ;;=^5003109
 ;;^UTILITY(U,$J,358.3,27817,0)
 ;;=F10.288^^113^1360^8
 ;;^UTILITY(U,$J,358.3,27817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27817,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/ Mod/Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27817,1,4,0)
 ;;=4^F10.288
 ;;^UTILITY(U,$J,358.3,27817,2)
 ;;=^5003099
 ;;^UTILITY(U,$J,358.3,27818,0)
 ;;=F10.988^^113^1360^9
 ;;^UTILITY(U,$J,358.3,27818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27818,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/o Use D/O
