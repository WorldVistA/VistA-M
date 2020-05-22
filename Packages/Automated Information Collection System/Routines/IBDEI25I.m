IBDEI25I ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34356,1,3,0)
 ;;=3^Alcohol Use DO (Mild),Uncomplicated
 ;;^UTILITY(U,$J,358.3,34356,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,34356,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,34357,0)
 ;;=F10.20^^134^1744^34
 ;;^UTILITY(U,$J,358.3,34357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34357,1,3,0)
 ;;=3^Alcohol Use DO (Mod/Sev),Uncomplicated
 ;;^UTILITY(U,$J,358.3,34357,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,34357,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,34358,0)
 ;;=F10.239^^134^1744^31
 ;;^UTILITY(U,$J,358.3,34358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34358,1,3,0)
 ;;=3^Alcohol Use DO (Mod/Sev) WD,Unspec
 ;;^UTILITY(U,$J,358.3,34358,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,34358,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,34359,0)
 ;;=F10.180^^134^1744^1
 ;;^UTILITY(U,$J,358.3,34359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34359,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,34359,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,34359,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,34360,0)
 ;;=F10.280^^134^1744^2
 ;;^UTILITY(U,$J,358.3,34360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34360,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Mod/Sev Use D/O
 ;;^UTILITY(U,$J,358.3,34360,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,34360,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,34361,0)
 ;;=F10.980^^134^1744^3
 ;;^UTILITY(U,$J,358.3,34361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34361,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,34361,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,34361,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,34362,0)
 ;;=F10.26^^134^1744^4
 ;;^UTILITY(U,$J,358.3,34362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34362,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/ Mod/Sev Use D/O
 ;;^UTILITY(U,$J,358.3,34362,1,4,0)
 ;;=4^F10.26
 ;;^UTILITY(U,$J,358.3,34362,2)
 ;;=^5003094
 ;;^UTILITY(U,$J,358.3,34363,0)
 ;;=F10.96^^134^1744^5
 ;;^UTILITY(U,$J,358.3,34363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34363,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/o Use D/O
 ;;^UTILITY(U,$J,358.3,34363,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,34363,2)
 ;;=^5003108
 ;;^UTILITY(U,$J,358.3,34364,0)
 ;;=F10.27^^134^1744^6
 ;;^UTILITY(U,$J,358.3,34364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34364,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type w/ Mod/Sev Use D/O
 ;;^UTILITY(U,$J,358.3,34364,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,34364,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,34365,0)
 ;;=F10.97^^134^1744^7
 ;;^UTILITY(U,$J,358.3,34365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34365,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type w/o Use D/O
 ;;^UTILITY(U,$J,358.3,34365,1,4,0)
 ;;=4^F10.97
 ;;^UTILITY(U,$J,358.3,34365,2)
 ;;=^5003109
 ;;^UTILITY(U,$J,358.3,34366,0)
 ;;=F10.288^^134^1744^8
 ;;^UTILITY(U,$J,358.3,34366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34366,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/ Mod/Sev Use D/O
 ;;^UTILITY(U,$J,358.3,34366,1,4,0)
 ;;=4^F10.288
 ;;^UTILITY(U,$J,358.3,34366,2)
 ;;=^5003099
 ;;^UTILITY(U,$J,358.3,34367,0)
 ;;=F10.988^^134^1744^9
 ;;^UTILITY(U,$J,358.3,34367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34367,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,34367,1,4,0)
 ;;=4^F10.988
