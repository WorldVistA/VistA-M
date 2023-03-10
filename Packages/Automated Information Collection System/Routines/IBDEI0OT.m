IBDEI0OT ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11144,0)
 ;;=F15.24^^42^509^62
 ;;^UTILITY(U,$J,358.3,11144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11144,1,3,0)
 ;;=3^Stimulant Dependence,Oth w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,11144,1,4,0)
 ;;=4^F15.24
 ;;^UTILITY(U,$J,358.3,11144,2)
 ;;=^5003302
 ;;^UTILITY(U,$J,358.3,11145,0)
 ;;=F15.94^^42^509^63
 ;;^UTILITY(U,$J,358.3,11145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11145,1,3,0)
 ;;=3^Stimulant Use,Unspec w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,11145,1,4,0)
 ;;=4^F15.94
 ;;^UTILITY(U,$J,358.3,11145,2)
 ;;=^5003316
 ;;^UTILITY(U,$J,358.3,11146,0)
 ;;=F15.921^^42^509^64
 ;;^UTILITY(U,$J,358.3,11146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11146,1,3,0)
 ;;=3^Stimulant Use,Unspec w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,11146,1,4,0)
 ;;=4^F15.921
 ;;^UTILITY(U,$J,358.3,11146,2)
 ;;=^5003312
 ;;^UTILITY(U,$J,358.3,11147,0)
 ;;=F15.188^^42^509^6
 ;;^UTILITY(U,$J,358.3,11147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11147,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,11147,1,4,0)
 ;;=4^F15.188
 ;;^UTILITY(U,$J,358.3,11147,2)
 ;;=^5133355
 ;;^UTILITY(U,$J,358.3,11148,0)
 ;;=F15.288^^42^509^7
 ;;^UTILITY(U,$J,358.3,11148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11148,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,11148,1,4,0)
 ;;=4^F15.288
 ;;^UTILITY(U,$J,358.3,11148,2)
 ;;=^5133356
 ;;^UTILITY(U,$J,358.3,11149,0)
 ;;=F15.988^^42^509^8
 ;;^UTILITY(U,$J,358.3,11149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11149,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,11149,1,4,0)
 ;;=4^F15.988
 ;;^UTILITY(U,$J,358.3,11149,2)
 ;;=^5133357
 ;;^UTILITY(U,$J,358.3,11150,0)
 ;;=F15.159^^42^509^9
 ;;^UTILITY(U,$J,358.3,11150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11150,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,11150,1,4,0)
 ;;=4^F15.159
 ;;^UTILITY(U,$J,358.3,11150,2)
 ;;=^5003290
 ;;^UTILITY(U,$J,358.3,11151,0)
 ;;=F15.259^^42^509^10
 ;;^UTILITY(U,$J,358.3,11151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11151,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,11151,1,4,0)
 ;;=4^F15.259
 ;;^UTILITY(U,$J,358.3,11151,2)
 ;;=^5003305
 ;;^UTILITY(U,$J,358.3,11152,0)
 ;;=F15.959^^42^509^11
 ;;^UTILITY(U,$J,358.3,11152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11152,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,11152,1,4,0)
 ;;=4^F15.959
 ;;^UTILITY(U,$J,358.3,11152,2)
 ;;=^5003319
 ;;^UTILITY(U,$J,358.3,11153,0)
 ;;=F15.181^^42^509^12
 ;;^UTILITY(U,$J,358.3,11153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11153,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,11153,1,4,0)
 ;;=4^F15.181
 ;;^UTILITY(U,$J,358.3,11153,2)
 ;;=^5003292
 ;;^UTILITY(U,$J,358.3,11154,0)
 ;;=F15.281^^42^509^13
 ;;^UTILITY(U,$J,358.3,11154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11154,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,11154,1,4,0)
 ;;=4^F15.281
 ;;^UTILITY(U,$J,358.3,11154,2)
 ;;=^5003307
