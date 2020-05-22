IBDEI2S4 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,44319,2)
 ;;=^5003204
 ;;^UTILITY(U,$J,358.3,44320,0)
 ;;=F13.10^^164^2193^27
 ;;^UTILITY(U,$J,358.3,44320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44320,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use DO,Mild,Uncomp
 ;;^UTILITY(U,$J,358.3,44320,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,44320,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,44321,0)
 ;;=F13.20^^164^2193^29
 ;;^UTILITY(U,$J,358.3,44321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44321,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use DO,Mod/Sev,Uncomp
 ;;^UTILITY(U,$J,358.3,44321,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,44321,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,44322,0)
 ;;=F13.232^^164^2193^33
 ;;^UTILITY(U,$J,358.3,44322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44322,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic WD w/ Percep Disturb Use DO (Mod/Sev)
 ;;^UTILITY(U,$J,358.3,44322,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,44322,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,44323,0)
 ;;=F13.239^^164^2193^35
 ;;^UTILITY(U,$J,358.3,44323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44323,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic WD w/o Percep Disturb Use DO (Mod/Sev)
 ;;^UTILITY(U,$J,358.3,44323,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,44323,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,44324,0)
 ;;=F13.231^^164^2193^31
 ;;^UTILITY(U,$J,358.3,44324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44324,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic WD Delirium w/Mod/Sev Use D/O
 ;;^UTILITY(U,$J,358.3,44324,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,44324,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,44325,0)
 ;;=F13.99^^164^2193^26
 ;;^UTILITY(U,$J,358.3,44325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44325,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,44325,1,4,0)
 ;;=4^F13.99
 ;;^UTILITY(U,$J,358.3,44325,2)
 ;;=^5133353
 ;;^UTILITY(U,$J,358.3,44326,0)
 ;;=F13.21^^164^2193^30
 ;;^UTILITY(U,$J,358.3,44326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44326,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use DO,Mod/Sev,In Remiss
 ;;^UTILITY(U,$J,358.3,44326,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,44326,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,44327,0)
 ;;=F13.11^^164^2193^28
 ;;^UTILITY(U,$J,358.3,44327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44327,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use DO,Mild,In Remiss
 ;;^UTILITY(U,$J,358.3,44327,1,4,0)
 ;;=4^F13.11
 ;;^UTILITY(U,$J,358.3,44327,2)
 ;;=^331938
 ;;^UTILITY(U,$J,358.3,44328,0)
 ;;=F13.930^^164^2193^37
 ;;^UTILITY(U,$J,358.3,44328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44328,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic WD w/o Use D/O
 ;;^UTILITY(U,$J,358.3,44328,1,4,0)
 ;;=4^F13.930
 ;;^UTILITY(U,$J,358.3,44328,2)
 ;;=^5003225
 ;;^UTILITY(U,$J,358.3,44329,0)
 ;;=F13.931^^164^2193^32
 ;;^UTILITY(U,$J,358.3,44329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44329,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic WD w/ Delirium w/o Use D/O
 ;;^UTILITY(U,$J,358.3,44329,1,4,0)
 ;;=4^F13.931
 ;;^UTILITY(U,$J,358.3,44329,2)
 ;;=^5003226
 ;;^UTILITY(U,$J,358.3,44330,0)
 ;;=F13.932^^164^2193^34
 ;;^UTILITY(U,$J,358.3,44330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44330,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic WD w/ Percep Disturb w/o Use D/O
 ;;^UTILITY(U,$J,358.3,44330,1,4,0)
 ;;=4^F13.932
 ;;^UTILITY(U,$J,358.3,44330,2)
 ;;=^5003227
 ;;^UTILITY(U,$J,358.3,44331,0)
 ;;=F13.939^^164^2193^36
