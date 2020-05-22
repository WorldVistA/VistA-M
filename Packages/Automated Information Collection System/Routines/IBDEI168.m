IBDEI168 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18821,2)
 ;;=^5003204
 ;;^UTILITY(U,$J,358.3,18822,0)
 ;;=F13.10^^91^962^27
 ;;^UTILITY(U,$J,358.3,18822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18822,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use DO,Mild,Uncomp
 ;;^UTILITY(U,$J,358.3,18822,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,18822,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,18823,0)
 ;;=F13.20^^91^962^29
 ;;^UTILITY(U,$J,358.3,18823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18823,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use DO,Mod/Sev,Uncomp
 ;;^UTILITY(U,$J,358.3,18823,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,18823,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,18824,0)
 ;;=F13.232^^91^962^33
 ;;^UTILITY(U,$J,358.3,18824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18824,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic WD w/ Percep Disturb Use DO (Mod/Sev)
 ;;^UTILITY(U,$J,358.3,18824,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,18824,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,18825,0)
 ;;=F13.239^^91^962^35
 ;;^UTILITY(U,$J,358.3,18825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18825,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic WD w/o Percep Disturb Use DO (Mod/Sev)
 ;;^UTILITY(U,$J,358.3,18825,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,18825,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,18826,0)
 ;;=F13.231^^91^962^31
 ;;^UTILITY(U,$J,358.3,18826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18826,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic WD Delirium w/Mod/Sev Use D/O
 ;;^UTILITY(U,$J,358.3,18826,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,18826,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,18827,0)
 ;;=F13.99^^91^962^26
 ;;^UTILITY(U,$J,358.3,18827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18827,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,18827,1,4,0)
 ;;=4^F13.99
 ;;^UTILITY(U,$J,358.3,18827,2)
 ;;=^5133353
 ;;^UTILITY(U,$J,358.3,18828,0)
 ;;=F13.21^^91^962^30
 ;;^UTILITY(U,$J,358.3,18828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18828,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use DO,Mod/Sev,In Remiss
 ;;^UTILITY(U,$J,358.3,18828,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,18828,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,18829,0)
 ;;=F13.11^^91^962^28
 ;;^UTILITY(U,$J,358.3,18829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18829,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use DO,Mild,In Remiss
 ;;^UTILITY(U,$J,358.3,18829,1,4,0)
 ;;=4^F13.11
 ;;^UTILITY(U,$J,358.3,18829,2)
 ;;=^331938
 ;;^UTILITY(U,$J,358.3,18830,0)
 ;;=F13.930^^91^962^37
 ;;^UTILITY(U,$J,358.3,18830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18830,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic WD w/o Use D/O
 ;;^UTILITY(U,$J,358.3,18830,1,4,0)
 ;;=4^F13.930
 ;;^UTILITY(U,$J,358.3,18830,2)
 ;;=^5003225
 ;;^UTILITY(U,$J,358.3,18831,0)
 ;;=F13.931^^91^962^32
 ;;^UTILITY(U,$J,358.3,18831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18831,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic WD w/ Delirium w/o Use D/O
 ;;^UTILITY(U,$J,358.3,18831,1,4,0)
 ;;=4^F13.931
 ;;^UTILITY(U,$J,358.3,18831,2)
 ;;=^5003226
 ;;^UTILITY(U,$J,358.3,18832,0)
 ;;=F13.932^^91^962^34
 ;;^UTILITY(U,$J,358.3,18832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18832,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic WD w/ Percep Disturb w/o Use D/O
 ;;^UTILITY(U,$J,358.3,18832,1,4,0)
 ;;=4^F13.932
 ;;^UTILITY(U,$J,358.3,18832,2)
 ;;=^5003227
 ;;^UTILITY(U,$J,358.3,18833,0)
 ;;=F13.939^^91^962^36
