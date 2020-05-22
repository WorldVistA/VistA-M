IBDEI1C2 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21298,1,3,0)
 ;;=3^Other/Unknown Substance Use D/O w/ Moderate Use D/O
 ;;^UTILITY(U,$J,358.3,21298,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,21298,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,21299,0)
 ;;=F19.20^^95^1060^25
 ;;^UTILITY(U,$J,358.3,21299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21299,1,3,0)
 ;;=3^Other/Unknown Substance Use D/O w/ Severe Use D/O
 ;;^UTILITY(U,$J,358.3,21299,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,21299,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,21300,0)
 ;;=F19.239^^95^1060^26
 ;;^UTILITY(U,$J,358.3,21300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21300,1,3,0)
 ;;=3^Other/Unknown Substance Withdrawal
 ;;^UTILITY(U,$J,358.3,21300,1,4,0)
 ;;=4^F19.239
 ;;^UTILITY(U,$J,358.3,21300,2)
 ;;=^5003440
 ;;^UTILITY(U,$J,358.3,21301,0)
 ;;=F19.231^^95^1060^27
 ;;^UTILITY(U,$J,358.3,21301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21301,1,3,0)
 ;;=3^Other/Unknown Substance Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,21301,1,4,0)
 ;;=4^F19.231
 ;;^UTILITY(U,$J,358.3,21301,2)
 ;;=^5003438
 ;;^UTILITY(U,$J,358.3,21302,0)
 ;;=F19.99^^95^1060^22
 ;;^UTILITY(U,$J,358.3,21302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21302,1,3,0)
 ;;=3^Other/Unknown Substance Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,21302,1,4,0)
 ;;=4^F19.99
 ;;^UTILITY(U,$J,358.3,21302,2)
 ;;=^5133364
 ;;^UTILITY(U,$J,358.3,21303,0)
 ;;=F15.10^^95^1061^61
 ;;^UTILITY(U,$J,358.3,21303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21303,1,3,0)
 ;;=3^Stimulant Abuse,Other
 ;;^UTILITY(U,$J,358.3,21303,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,21303,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,21304,0)
 ;;=F15.99^^95^1061^26
 ;;^UTILITY(U,$J,358.3,21304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21304,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,21304,1,4,0)
 ;;=4^F15.99
 ;;^UTILITY(U,$J,358.3,21304,2)
 ;;=^5133358
 ;;^UTILITY(U,$J,358.3,21305,0)
 ;;=F14.99^^95^1061^55
 ;;^UTILITY(U,$J,358.3,21305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21305,1,3,0)
 ;;=3^Cocaine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,21305,1,4,0)
 ;;=4^F14.99
 ;;^UTILITY(U,$J,358.3,21305,2)
 ;;=^5133354
 ;;^UTILITY(U,$J,358.3,21306,0)
 ;;=F15.180^^95^1061^3
 ;;^UTILITY(U,$J,358.3,21306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21306,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,21306,1,4,0)
 ;;=4^F15.180
 ;;^UTILITY(U,$J,358.3,21306,2)
 ;;=^5003291
 ;;^UTILITY(U,$J,358.3,21307,0)
 ;;=F15.280^^95^1061^4
 ;;^UTILITY(U,$J,358.3,21307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21307,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,21307,1,4,0)
 ;;=4^F15.280
 ;;^UTILITY(U,$J,358.3,21307,2)
 ;;=^5003306
 ;;^UTILITY(U,$J,358.3,21308,0)
 ;;=F15.980^^95^1061^5
 ;;^UTILITY(U,$J,358.3,21308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21308,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,21308,1,4,0)
 ;;=4^F15.980
 ;;^UTILITY(U,$J,358.3,21308,2)
 ;;=^5003320
 ;;^UTILITY(U,$J,358.3,21309,0)
 ;;=F15.14^^95^1061^59
 ;;^UTILITY(U,$J,358.3,21309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21309,1,3,0)
 ;;=3^Stimulant Abuse w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,21309,1,4,0)
 ;;=4^F15.14
