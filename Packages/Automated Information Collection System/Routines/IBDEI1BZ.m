IBDEI1BZ ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21263,1,4,0)
 ;;=4^F15.980
 ;;^UTILITY(U,$J,358.3,21263,2)
 ;;=^5003320
 ;;^UTILITY(U,$J,358.3,21264,0)
 ;;=F15.182^^95^1058^4
 ;;^UTILITY(U,$J,358.3,21264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21264,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21264,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,21264,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,21265,0)
 ;;=F15.282^^95^1058^5
 ;;^UTILITY(U,$J,358.3,21265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21265,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21265,1,4,0)
 ;;=4^F15.282
 ;;^UTILITY(U,$J,358.3,21265,2)
 ;;=^5003308
 ;;^UTILITY(U,$J,358.3,21266,0)
 ;;=F15.982^^95^1058^6
 ;;^UTILITY(U,$J,358.3,21266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21266,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21266,1,4,0)
 ;;=4^F15.982
 ;;^UTILITY(U,$J,358.3,21266,2)
 ;;=^5003322
 ;;^UTILITY(U,$J,358.3,21267,0)
 ;;=F15.99^^95^1058^9
 ;;^UTILITY(U,$J,358.3,21267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21267,1,3,0)
 ;;=3^Caffeinie Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,21267,1,4,0)
 ;;=4^F15.99
 ;;^UTILITY(U,$J,358.3,21267,2)
 ;;=^5133358
 ;;^UTILITY(U,$J,358.3,21268,0)
 ;;=R45.851^^95^1059^2
 ;;^UTILITY(U,$J,358.3,21268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21268,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,21268,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,21268,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,21269,0)
 ;;=Z91.5^^95^1059^1
 ;;^UTILITY(U,$J,358.3,21269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21269,1,3,0)
 ;;=3^Personal Hx of One or More Suicide Attempts
 ;;^UTILITY(U,$J,358.3,21269,1,4,0)
 ;;=4^Z91.5
 ;;^UTILITY(U,$J,358.3,21269,2)
 ;;=^5063624
 ;;^UTILITY(U,$J,358.3,21270,0)
 ;;=T14.91XA^^95^1059^3
 ;;^UTILITY(U,$J,358.3,21270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21270,1,3,0)
 ;;=3^Suicide Attempt,Initial Encntr
 ;;^UTILITY(U,$J,358.3,21270,1,4,0)
 ;;=4^T14.91XA
 ;;^UTILITY(U,$J,358.3,21270,2)
 ;;=^5151779
 ;;^UTILITY(U,$J,358.3,21271,0)
 ;;=T14.91XD^^95^1059^4
 ;;^UTILITY(U,$J,358.3,21271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21271,1,3,0)
 ;;=3^Suicide Attempt,Subsequent Encntr
 ;;^UTILITY(U,$J,358.3,21271,1,4,0)
 ;;=4^T14.91XD
 ;;^UTILITY(U,$J,358.3,21271,2)
 ;;=^5151780
 ;;^UTILITY(U,$J,358.3,21272,0)
 ;;=T14.91XS^^95^1059^5
 ;;^UTILITY(U,$J,358.3,21272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21272,1,3,0)
 ;;=3^Suicide Attempt,Sequela
 ;;^UTILITY(U,$J,358.3,21272,1,4,0)
 ;;=4^T14.91XS
 ;;^UTILITY(U,$J,358.3,21272,2)
 ;;=^5151781
 ;;^UTILITY(U,$J,358.3,21273,0)
 ;;=F19.14^^95^1060^1
 ;;^UTILITY(U,$J,358.3,21273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21273,1,3,0)
 ;;=3^Other/Unknown Substance Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,21273,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,21273,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,21274,0)
 ;;=F19.24^^95^1060^2
 ;;^UTILITY(U,$J,358.3,21274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21274,1,3,0)
 ;;=3^Other/Unknown Substance Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,21274,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,21274,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,21275,0)
 ;;=F19.94^^95^1060^3
 ;;^UTILITY(U,$J,358.3,21275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21275,1,3,0)
 ;;=3^Other/Unknown Substance Induced Depressive D/O w/o Use D/O
