IBDEI1P8 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27148,1,4,0)
 ;;=4^F13.221
 ;;^UTILITY(U,$J,358.3,27148,2)
 ;;=^5003204
 ;;^UTILITY(U,$J,358.3,27149,0)
 ;;=F13.10^^110^1310^27
 ;;^UTILITY(U,$J,358.3,27149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27149,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use DO,Mild,Uncomp
 ;;^UTILITY(U,$J,358.3,27149,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,27149,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,27150,0)
 ;;=F13.20^^110^1310^29
 ;;^UTILITY(U,$J,358.3,27150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27150,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use DO,Mod/Sev,Uncomp
 ;;^UTILITY(U,$J,358.3,27150,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,27150,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,27151,0)
 ;;=F13.232^^110^1310^33
 ;;^UTILITY(U,$J,358.3,27151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27151,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic WD w/ Percep Disturb Use DO (Mod/Sev)
 ;;^UTILITY(U,$J,358.3,27151,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,27151,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,27152,0)
 ;;=F13.239^^110^1310^35
 ;;^UTILITY(U,$J,358.3,27152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27152,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic WD w/o Percep Disturb Use DO (Mod/Sev)
 ;;^UTILITY(U,$J,358.3,27152,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,27152,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,27153,0)
 ;;=F13.231^^110^1310^31
 ;;^UTILITY(U,$J,358.3,27153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27153,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic WD Delirium w/Mod/Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27153,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,27153,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,27154,0)
 ;;=F13.99^^110^1310^26
 ;;^UTILITY(U,$J,358.3,27154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27154,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,27154,1,4,0)
 ;;=4^F13.99
 ;;^UTILITY(U,$J,358.3,27154,2)
 ;;=^5133353
 ;;^UTILITY(U,$J,358.3,27155,0)
 ;;=F13.21^^110^1310^30
 ;;^UTILITY(U,$J,358.3,27155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27155,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use DO,Mod/Sev,In Remiss
 ;;^UTILITY(U,$J,358.3,27155,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,27155,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,27156,0)
 ;;=F13.11^^110^1310^28
 ;;^UTILITY(U,$J,358.3,27156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27156,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use DO,Mild,In Remiss
 ;;^UTILITY(U,$J,358.3,27156,1,4,0)
 ;;=4^F13.11
 ;;^UTILITY(U,$J,358.3,27156,2)
 ;;=^331938
 ;;^UTILITY(U,$J,358.3,27157,0)
 ;;=F13.930^^110^1310^37
 ;;^UTILITY(U,$J,358.3,27157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27157,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic WD w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27157,1,4,0)
 ;;=4^F13.930
 ;;^UTILITY(U,$J,358.3,27157,2)
 ;;=^5003225
 ;;^UTILITY(U,$J,358.3,27158,0)
 ;;=F13.931^^110^1310^32
 ;;^UTILITY(U,$J,358.3,27158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27158,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic WD w/ Delirium w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27158,1,4,0)
 ;;=4^F13.931
 ;;^UTILITY(U,$J,358.3,27158,2)
 ;;=^5003226
 ;;^UTILITY(U,$J,358.3,27159,0)
 ;;=F13.932^^110^1310^34
 ;;^UTILITY(U,$J,358.3,27159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27159,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic WD w/ Percep Disturb w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27159,1,4,0)
 ;;=4^F13.932
 ;;^UTILITY(U,$J,358.3,27159,2)
 ;;=^5003227
