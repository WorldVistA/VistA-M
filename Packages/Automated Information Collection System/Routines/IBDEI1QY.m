IBDEI1QY ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27913,1,3,0)
 ;;=3^Opioid Use DO,Mod/Sev,In Remiss
 ;;^UTILITY(U,$J,358.3,27913,1,4,0)
 ;;=4^F11.21
 ;;^UTILITY(U,$J,358.3,27913,2)
 ;;=^5003128
 ;;^UTILITY(U,$J,358.3,27914,0)
 ;;=Z79.891^^113^1363^1
 ;;^UTILITY(U,$J,358.3,27914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27914,1,3,0)
 ;;=3^Long Term Opiate/Opioid Analgesic Use
 ;;^UTILITY(U,$J,358.3,27914,1,4,0)
 ;;=4^Z79.891
 ;;^UTILITY(U,$J,358.3,27914,2)
 ;;=^5063342
 ;;^UTILITY(U,$J,358.3,27915,0)
 ;;=F11.11^^113^1363^24
 ;;^UTILITY(U,$J,358.3,27915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27915,1,3,0)
 ;;=3^Opioid Use DO,Mild,In Remiss
 ;;^UTILITY(U,$J,358.3,27915,1,4,0)
 ;;=4^F11.11
 ;;^UTILITY(U,$J,358.3,27915,2)
 ;;=^268246
 ;;^UTILITY(U,$J,358.3,27916,0)
 ;;=F13.180^^113^1364^1
 ;;^UTILITY(U,$J,358.3,27916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27916,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27916,1,4,0)
 ;;=4^F13.180
 ;;^UTILITY(U,$J,358.3,27916,2)
 ;;=^5003197
 ;;^UTILITY(U,$J,358.3,27917,0)
 ;;=F13.280^^113^1364^2
 ;;^UTILITY(U,$J,358.3,27917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27917,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27917,1,4,0)
 ;;=4^F13.280
 ;;^UTILITY(U,$J,358.3,27917,2)
 ;;=^5003216
 ;;^UTILITY(U,$J,358.3,27918,0)
 ;;=F13.980^^113^1364^3
 ;;^UTILITY(U,$J,358.3,27918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27918,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27918,1,4,0)
 ;;=4^F13.980
 ;;^UTILITY(U,$J,358.3,27918,2)
 ;;=^5003235
 ;;^UTILITY(U,$J,358.3,27919,0)
 ;;=F13.14^^113^1364^4
 ;;^UTILITY(U,$J,358.3,27919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27919,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27919,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,27919,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,27920,0)
 ;;=F13.24^^113^1364^5
 ;;^UTILITY(U,$J,358.3,27920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27920,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/ Mod-Sev Use D/O 
 ;;^UTILITY(U,$J,358.3,27920,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,27920,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,27921,0)
 ;;=F13.94^^113^1364^6
 ;;^UTILITY(U,$J,358.3,27921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27921,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27921,1,4,0)
 ;;=4^F13.94
 ;;^UTILITY(U,$J,358.3,27921,2)
 ;;=^5003229
 ;;^UTILITY(U,$J,358.3,27922,0)
 ;;=F13.921^^113^1364^7
 ;;^UTILITY(U,$J,358.3,27922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27922,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Delirium
 ;;^UTILITY(U,$J,358.3,27922,1,4,0)
 ;;=4^F13.921
 ;;^UTILITY(U,$J,358.3,27922,2)
 ;;=^5003223
 ;;^UTILITY(U,$J,358.3,27923,0)
 ;;=F13.27^^113^1364^8
 ;;^UTILITY(U,$J,358.3,27923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27923,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Maj Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27923,1,4,0)
 ;;=4^F13.27
 ;;^UTILITY(U,$J,358.3,27923,2)
 ;;=^5003215
 ;;^UTILITY(U,$J,358.3,27924,0)
 ;;=F13.97^^113^1364^9
 ;;^UTILITY(U,$J,358.3,27924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27924,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Maj Neurocog D/O w/o Use D/O
