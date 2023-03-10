IBDEI0OS ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11132,1,3,0)
 ;;=3^Other/Unknown Substance Use D/O w/ Moderate Use D/O
 ;;^UTILITY(U,$J,358.3,11132,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,11132,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,11133,0)
 ;;=F19.20^^42^508^25
 ;;^UTILITY(U,$J,358.3,11133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11133,1,3,0)
 ;;=3^Other/Unknown Substance Use D/O w/ Severe Use D/O
 ;;^UTILITY(U,$J,358.3,11133,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,11133,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,11134,0)
 ;;=F19.239^^42^508^26
 ;;^UTILITY(U,$J,358.3,11134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11134,1,3,0)
 ;;=3^Other/Unknown Substance Withdrawal
 ;;^UTILITY(U,$J,358.3,11134,1,4,0)
 ;;=4^F19.239
 ;;^UTILITY(U,$J,358.3,11134,2)
 ;;=^5003440
 ;;^UTILITY(U,$J,358.3,11135,0)
 ;;=F19.231^^42^508^27
 ;;^UTILITY(U,$J,358.3,11135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11135,1,3,0)
 ;;=3^Other/Unknown Substance Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,11135,1,4,0)
 ;;=4^F19.231
 ;;^UTILITY(U,$J,358.3,11135,2)
 ;;=^5003438
 ;;^UTILITY(U,$J,358.3,11136,0)
 ;;=F19.99^^42^508^22
 ;;^UTILITY(U,$J,358.3,11136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11136,1,3,0)
 ;;=3^Other/Unknown Substance Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,11136,1,4,0)
 ;;=4^F19.99
 ;;^UTILITY(U,$J,358.3,11136,2)
 ;;=^5133364
 ;;^UTILITY(U,$J,358.3,11137,0)
 ;;=F15.10^^42^509^61
 ;;^UTILITY(U,$J,358.3,11137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11137,1,3,0)
 ;;=3^Stimulant Abuse,Other
 ;;^UTILITY(U,$J,358.3,11137,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,11137,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,11138,0)
 ;;=F15.99^^42^509^26
 ;;^UTILITY(U,$J,358.3,11138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11138,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,11138,1,4,0)
 ;;=4^F15.99
 ;;^UTILITY(U,$J,358.3,11138,2)
 ;;=^5133358
 ;;^UTILITY(U,$J,358.3,11139,0)
 ;;=F14.99^^42^509^55
 ;;^UTILITY(U,$J,358.3,11139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11139,1,3,0)
 ;;=3^Cocaine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,11139,1,4,0)
 ;;=4^F14.99
 ;;^UTILITY(U,$J,358.3,11139,2)
 ;;=^5133354
 ;;^UTILITY(U,$J,358.3,11140,0)
 ;;=F15.180^^42^509^3
 ;;^UTILITY(U,$J,358.3,11140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11140,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,11140,1,4,0)
 ;;=4^F15.180
 ;;^UTILITY(U,$J,358.3,11140,2)
 ;;=^5003291
 ;;^UTILITY(U,$J,358.3,11141,0)
 ;;=F15.280^^42^509^4
 ;;^UTILITY(U,$J,358.3,11141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11141,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,11141,1,4,0)
 ;;=4^F15.280
 ;;^UTILITY(U,$J,358.3,11141,2)
 ;;=^5003306
 ;;^UTILITY(U,$J,358.3,11142,0)
 ;;=F15.980^^42^509^5
 ;;^UTILITY(U,$J,358.3,11142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11142,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,11142,1,4,0)
 ;;=4^F15.980
 ;;^UTILITY(U,$J,358.3,11142,2)
 ;;=^5003320
 ;;^UTILITY(U,$J,358.3,11143,0)
 ;;=F15.14^^42^509^59
 ;;^UTILITY(U,$J,358.3,11143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11143,1,3,0)
 ;;=3^Stimulant Abuse w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,11143,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,11143,2)
 ;;=^5003287
