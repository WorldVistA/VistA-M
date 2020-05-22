IBDEI15X ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18693,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,18693,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,18693,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,18694,0)
 ;;=F10.26^^91^958^4
 ;;^UTILITY(U,$J,358.3,18694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18694,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/ Mod/Sev Use D/O
 ;;^UTILITY(U,$J,358.3,18694,1,4,0)
 ;;=4^F10.26
 ;;^UTILITY(U,$J,358.3,18694,2)
 ;;=^5003094
 ;;^UTILITY(U,$J,358.3,18695,0)
 ;;=F10.96^^91^958^5
 ;;^UTILITY(U,$J,358.3,18695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18695,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/o Use D/O
 ;;^UTILITY(U,$J,358.3,18695,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,18695,2)
 ;;=^5003108
 ;;^UTILITY(U,$J,358.3,18696,0)
 ;;=F10.27^^91^958^6
 ;;^UTILITY(U,$J,358.3,18696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18696,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type w/ Mod/Sev Use D/O
 ;;^UTILITY(U,$J,358.3,18696,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,18696,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,18697,0)
 ;;=F10.97^^91^958^7
 ;;^UTILITY(U,$J,358.3,18697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18697,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type w/o Use D/O
 ;;^UTILITY(U,$J,358.3,18697,1,4,0)
 ;;=4^F10.97
 ;;^UTILITY(U,$J,358.3,18697,2)
 ;;=^5003109
 ;;^UTILITY(U,$J,358.3,18698,0)
 ;;=F10.288^^91^958^8
 ;;^UTILITY(U,$J,358.3,18698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18698,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/ Mod/Sev Use D/O
 ;;^UTILITY(U,$J,358.3,18698,1,4,0)
 ;;=4^F10.288
 ;;^UTILITY(U,$J,358.3,18698,2)
 ;;=^5003099
 ;;^UTILITY(U,$J,358.3,18699,0)
 ;;=F10.988^^91^958^9
 ;;^UTILITY(U,$J,358.3,18699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18699,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,18699,1,4,0)
 ;;=4^F10.988
 ;;^UTILITY(U,$J,358.3,18699,2)
 ;;=^5003113
 ;;^UTILITY(U,$J,358.3,18700,0)
 ;;=F10.159^^91^958^13
 ;;^UTILITY(U,$J,358.3,18700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18700,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,18700,1,4,0)
 ;;=4^F10.159
 ;;^UTILITY(U,$J,358.3,18700,2)
 ;;=^5003075
 ;;^UTILITY(U,$J,358.3,18701,0)
 ;;=F10.259^^91^958^14
 ;;^UTILITY(U,$J,358.3,18701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18701,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mod/Sev Use D/O
 ;;^UTILITY(U,$J,358.3,18701,1,4,0)
 ;;=4^F10.259
 ;;^UTILITY(U,$J,358.3,18701,2)
 ;;=^5003093
 ;;^UTILITY(U,$J,358.3,18702,0)
 ;;=F10.959^^91^958^15
 ;;^UTILITY(U,$J,358.3,18702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18702,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,18702,1,4,0)
 ;;=4^F10.959
 ;;^UTILITY(U,$J,358.3,18702,2)
 ;;=^5003107
 ;;^UTILITY(U,$J,358.3,18703,0)
 ;;=F10.181^^91^958^16
 ;;^UTILITY(U,$J,358.3,18703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18703,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysf w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,18703,1,4,0)
 ;;=4^F10.181
 ;;^UTILITY(U,$J,358.3,18703,2)
 ;;=^5003077
 ;;^UTILITY(U,$J,358.3,18704,0)
 ;;=F10.282^^91^958^20
 ;;^UTILITY(U,$J,358.3,18704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18704,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/ Mod/Sev Use D/O
