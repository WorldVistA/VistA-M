IBDEI0OX ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11189,1,3,0)
 ;;=3^Cocaine Intoxication w/ Percept Disturb w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,11189,1,4,0)
 ;;=4^F14.222
 ;;^UTILITY(U,$J,358.3,11189,2)
 ;;=^5003257
 ;;^UTILITY(U,$J,358.3,11190,0)
 ;;=F14.922^^42^509^51
 ;;^UTILITY(U,$J,358.3,11190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11190,1,3,0)
 ;;=3^Cocaine Intoxication w/ Percept Disturb w/o Use D/O
 ;;^UTILITY(U,$J,358.3,11190,1,4,0)
 ;;=4^F14.922
 ;;^UTILITY(U,$J,358.3,11190,2)
 ;;=^5003272
 ;;^UTILITY(U,$J,358.3,11191,0)
 ;;=F14.129^^42^509^52
 ;;^UTILITY(U,$J,358.3,11191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11191,1,3,0)
 ;;=3^Cocaine Intoxication w/o  Percept Disturb w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,11191,1,4,0)
 ;;=4^F14.129
 ;;^UTILITY(U,$J,358.3,11191,2)
 ;;=^5003243
 ;;^UTILITY(U,$J,358.3,11192,0)
 ;;=F14.229^^42^509^53
 ;;^UTILITY(U,$J,358.3,11192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11192,1,3,0)
 ;;=3^Cocaine Intoxication w/o  Percept Disturb w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,11192,1,4,0)
 ;;=4^F14.229
 ;;^UTILITY(U,$J,358.3,11192,2)
 ;;=^5003258
 ;;^UTILITY(U,$J,358.3,11193,0)
 ;;=F14.929^^42^509^54
 ;;^UTILITY(U,$J,358.3,11193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11193,1,3,0)
 ;;=3^Cocaine Intoxication w/o Percept Disturb w/o Use D/O
 ;;^UTILITY(U,$J,358.3,11193,1,4,0)
 ;;=4^F14.929
 ;;^UTILITY(U,$J,358.3,11193,2)
 ;;=^5003273
 ;;^UTILITY(U,$J,358.3,11194,0)
 ;;=F14.121^^42^509^46
 ;;^UTILITY(U,$J,358.3,11194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11194,1,3,0)
 ;;=3^Cocaine Intoxication Delirium w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,11194,1,4,0)
 ;;=4^F14.121
 ;;^UTILITY(U,$J,358.3,11194,2)
 ;;=^5003241
 ;;^UTILITY(U,$J,358.3,11195,0)
 ;;=F14.221^^42^509^47
 ;;^UTILITY(U,$J,358.3,11195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11195,1,3,0)
 ;;=3^Cocaine Intoxication Delirium w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,11195,1,4,0)
 ;;=4^F14.221
 ;;^UTILITY(U,$J,358.3,11195,2)
 ;;=^5003256
 ;;^UTILITY(U,$J,358.3,11196,0)
 ;;=F14.921^^42^509^48
 ;;^UTILITY(U,$J,358.3,11196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11196,1,3,0)
 ;;=3^Cocaine Intoxication Delirium w/o Use D/O
 ;;^UTILITY(U,$J,358.3,11196,1,4,0)
 ;;=4^F14.921
 ;;^UTILITY(U,$J,358.3,11196,2)
 ;;=^5003271
 ;;^UTILITY(U,$J,358.3,11197,0)
 ;;=F14.10^^42^509^56
 ;;^UTILITY(U,$J,358.3,11197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11197,1,3,0)
 ;;=3^Cocaine Use D/O, Mild
 ;;^UTILITY(U,$J,358.3,11197,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,11197,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,11198,0)
 ;;=F14.20^^42^509^29
 ;;^UTILITY(U,$J,358.3,11198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11198,1,3,0)
 ;;=3^Cocaine Dependence
 ;;^UTILITY(U,$J,358.3,11198,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,11198,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,11199,0)
 ;;=F14.23^^42^509^58
 ;;^UTILITY(U,$J,358.3,11199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11199,1,3,0)
 ;;=3^Cocaine Withdrawal
 ;;^UTILITY(U,$J,358.3,11199,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,11199,2)
 ;;=^5003259
 ;;^UTILITY(U,$J,358.3,11200,0)
 ;;=F15.11^^42^509^60
 ;;^UTILITY(U,$J,358.3,11200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11200,1,3,0)
 ;;=3^Stimulant Abuse,Oth,In Remission
 ;;^UTILITY(U,$J,358.3,11200,1,4,0)
 ;;=4^F15.11
 ;;^UTILITY(U,$J,358.3,11200,2)
 ;;=^5151304
 ;;^UTILITY(U,$J,358.3,11201,0)
 ;;=Z02.71^^42^510^2
