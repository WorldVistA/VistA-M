IBDEI1UI ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29481,2)
 ;;=^5133352
 ;;^UTILITY(U,$J,358.3,29482,0)
 ;;=F11.21^^118^1487^27
 ;;^UTILITY(U,$J,358.3,29482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29482,1,3,0)
 ;;=3^Opioid Use DO,Mod/Sev,In Remiss
 ;;^UTILITY(U,$J,358.3,29482,1,4,0)
 ;;=4^F11.21
 ;;^UTILITY(U,$J,358.3,29482,2)
 ;;=^5003128
 ;;^UTILITY(U,$J,358.3,29483,0)
 ;;=Z79.891^^118^1487^1
 ;;^UTILITY(U,$J,358.3,29483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29483,1,3,0)
 ;;=3^Long Term Opiate/Opioid Analgesic Use
 ;;^UTILITY(U,$J,358.3,29483,1,4,0)
 ;;=4^Z79.891
 ;;^UTILITY(U,$J,358.3,29483,2)
 ;;=^5063342
 ;;^UTILITY(U,$J,358.3,29484,0)
 ;;=F11.11^^118^1487^24
 ;;^UTILITY(U,$J,358.3,29484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29484,1,3,0)
 ;;=3^Opioid Use DO,Mild,In Remiss
 ;;^UTILITY(U,$J,358.3,29484,1,4,0)
 ;;=4^F11.11
 ;;^UTILITY(U,$J,358.3,29484,2)
 ;;=^268246
 ;;^UTILITY(U,$J,358.3,29485,0)
 ;;=F13.180^^118^1488^1
 ;;^UTILITY(U,$J,358.3,29485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29485,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,29485,1,4,0)
 ;;=4^F13.180
 ;;^UTILITY(U,$J,358.3,29485,2)
 ;;=^5003197
 ;;^UTILITY(U,$J,358.3,29486,0)
 ;;=F13.280^^118^1488^2
 ;;^UTILITY(U,$J,358.3,29486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29486,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,29486,1,4,0)
 ;;=4^F13.280
 ;;^UTILITY(U,$J,358.3,29486,2)
 ;;=^5003216
 ;;^UTILITY(U,$J,358.3,29487,0)
 ;;=F13.980^^118^1488^3
 ;;^UTILITY(U,$J,358.3,29487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29487,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,29487,1,4,0)
 ;;=4^F13.980
 ;;^UTILITY(U,$J,358.3,29487,2)
 ;;=^5003235
 ;;^UTILITY(U,$J,358.3,29488,0)
 ;;=F13.14^^118^1488^4
 ;;^UTILITY(U,$J,358.3,29488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29488,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,29488,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,29488,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,29489,0)
 ;;=F13.24^^118^1488^5
 ;;^UTILITY(U,$J,358.3,29489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29489,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/ Mod-Sev Use D/O 
 ;;^UTILITY(U,$J,358.3,29489,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,29489,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,29490,0)
 ;;=F13.94^^118^1488^6
 ;;^UTILITY(U,$J,358.3,29490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29490,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,29490,1,4,0)
 ;;=4^F13.94
 ;;^UTILITY(U,$J,358.3,29490,2)
 ;;=^5003229
 ;;^UTILITY(U,$J,358.3,29491,0)
 ;;=F13.921^^118^1488^7
 ;;^UTILITY(U,$J,358.3,29491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29491,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Delirium
 ;;^UTILITY(U,$J,358.3,29491,1,4,0)
 ;;=4^F13.921
 ;;^UTILITY(U,$J,358.3,29491,2)
 ;;=^5003223
 ;;^UTILITY(U,$J,358.3,29492,0)
 ;;=F13.27^^118^1488^8
 ;;^UTILITY(U,$J,358.3,29492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29492,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Maj Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,29492,1,4,0)
 ;;=4^F13.27
 ;;^UTILITY(U,$J,358.3,29492,2)
 ;;=^5003215
 ;;^UTILITY(U,$J,358.3,29493,0)
 ;;=F13.97^^118^1488^9
