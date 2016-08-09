IBDEI0P5 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25311,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intoxication w/o  Percept Disturb w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,25311,1,4,0)
 ;;=4^F15.129
 ;;^UTILITY(U,$J,358.3,25311,2)
 ;;=^5003286
 ;;^UTILITY(U,$J,358.3,25312,0)
 ;;=F15.229^^95^1193^33
 ;;^UTILITY(U,$J,358.3,25312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25312,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intoxication w/o  Percept Disturb w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,25312,1,4,0)
 ;;=4^F15.229
 ;;^UTILITY(U,$J,358.3,25312,2)
 ;;=^5003300
 ;;^UTILITY(U,$J,358.3,25313,0)
 ;;=F15.929^^95^1193^34
 ;;^UTILITY(U,$J,358.3,25313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25313,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intoxication w/o Percept Disturb w/o Use D/O
 ;;^UTILITY(U,$J,358.3,25313,1,4,0)
 ;;=4^F15.929
 ;;^UTILITY(U,$J,358.3,25313,2)
 ;;=^5003314
 ;;^UTILITY(U,$J,358.3,25314,0)
 ;;=F15.121^^95^1193^26
 ;;^UTILITY(U,$J,358.3,25314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25314,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intox Delirium  w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,25314,1,4,0)
 ;;=4^F15.121
 ;;^UTILITY(U,$J,358.3,25314,2)
 ;;=^5003284
 ;;^UTILITY(U,$J,358.3,25315,0)
 ;;=F15.221^^95^1193^27
 ;;^UTILITY(U,$J,358.3,25315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25315,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intox Delirium  w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,25315,1,4,0)
 ;;=4^F15.221
 ;;^UTILITY(U,$J,358.3,25315,2)
 ;;=^5003298
 ;;^UTILITY(U,$J,358.3,25316,0)
 ;;=F15.921^^95^1193^28
 ;;^UTILITY(U,$J,358.3,25316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25316,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intox Delirium w/o Use D/O
 ;;^UTILITY(U,$J,358.3,25316,1,4,0)
 ;;=4^F15.921
 ;;^UTILITY(U,$J,358.3,25316,2)
 ;;=^5003312
 ;;^UTILITY(U,$J,358.3,25317,0)
 ;;=F15.23^^95^1193^36
 ;;^UTILITY(U,$J,358.3,25317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25317,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,25317,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,25317,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,25318,0)
 ;;=F15.10^^95^1193^1
 ;;^UTILITY(U,$J,358.3,25318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25318,1,3,0)
 ;;=3^Amphetamine Type Substance Use D/O, Mild
 ;;^UTILITY(U,$J,358.3,25318,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,25318,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,25319,0)
 ;;=F15.20^^95^1193^2
 ;;^UTILITY(U,$J,358.3,25319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25319,1,3,0)
 ;;=3^Amphetamine Type Substance Use D/O, Moderate
 ;;^UTILITY(U,$J,358.3,25319,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,25319,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,25320,0)
 ;;=F15.20^^95^1193^3
 ;;^UTILITY(U,$J,358.3,25320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25320,1,3,0)
 ;;=3^Amphetamine Type Substance Use D/O, Severe
 ;;^UTILITY(U,$J,358.3,25320,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,25320,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,25321,0)
 ;;=F14.180^^95^1193^37
 ;;^UTILITY(U,$J,358.3,25321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25321,1,3,0)
 ;;=3^Cocaine Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,25321,1,4,0)
 ;;=4^F14.180
 ;;^UTILITY(U,$J,358.3,25321,2)
 ;;=^5003248
 ;;^UTILITY(U,$J,358.3,25322,0)
 ;;=F14.280^^95^1193^38
 ;;^UTILITY(U,$J,358.3,25322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25322,1,3,0)
 ;;=3^Cocaine Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,25322,1,4,0)
 ;;=4^F14.280
 ;;^UTILITY(U,$J,358.3,25322,2)
 ;;=^5003264
 ;;^UTILITY(U,$J,358.3,25323,0)
 ;;=F14.980^^95^1193^39
 ;;^UTILITY(U,$J,358.3,25323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25323,1,3,0)
 ;;=3^Cocaine Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,25323,1,4,0)
 ;;=4^F14.980
 ;;^UTILITY(U,$J,358.3,25323,2)
 ;;=^5003278
 ;;^UTILITY(U,$J,358.3,25324,0)
 ;;=F14.14^^95^1193^40
 ;;^UTILITY(U,$J,358.3,25324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25324,1,3,0)
 ;;=3^Cocaine Induced Bipolar & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,25324,1,4,0)
 ;;=4^F14.14
 ;;^UTILITY(U,$J,358.3,25324,2)
 ;;=^5003244
 ;;^UTILITY(U,$J,358.3,25325,0)
 ;;=F14.24^^95^1193^41
 ;;^UTILITY(U,$J,358.3,25325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25325,1,3,0)
 ;;=3^Cocaine Induced Bipolar & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,25325,1,4,0)
 ;;=4^F14.24
 ;;^UTILITY(U,$J,358.3,25325,2)
 ;;=^5003260
 ;;^UTILITY(U,$J,358.3,25326,0)
 ;;=F14.94^^95^1193^42
 ;;^UTILITY(U,$J,358.3,25326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25326,1,3,0)
 ;;=3^Cocaine Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,25326,1,4,0)
 ;;=4^F14.94
 ;;^UTILITY(U,$J,358.3,25326,2)
 ;;=^5003274
 ;;^UTILITY(U,$J,358.3,25327,0)
 ;;=F14.14^^95^1193^43
 ;;^UTILITY(U,$J,358.3,25327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25327,1,3,0)
 ;;=3^Cocaine Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,25327,1,4,0)
 ;;=4^F14.14
 ;;^UTILITY(U,$J,358.3,25327,2)
 ;;=^5003244
 ;;^UTILITY(U,$J,358.3,25328,0)
 ;;=F14.24^^95^1193^44
 ;;^UTILITY(U,$J,358.3,25328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25328,1,3,0)
 ;;=3^Cocaine Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,25328,1,4,0)
 ;;=4^F14.24
 ;;^UTILITY(U,$J,358.3,25328,2)
 ;;=^5003260
 ;;^UTILITY(U,$J,358.3,25329,0)
 ;;=F14.94^^95^1193^45
 ;;^UTILITY(U,$J,358.3,25329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25329,1,3,0)
 ;;=3^Cocaine Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,25329,1,4,0)
 ;;=4^F14.94
 ;;^UTILITY(U,$J,358.3,25329,2)
 ;;=^5003274
 ;;^UTILITY(U,$J,358.3,25330,0)
 ;;=F14.188^^95^1193^46
 ;;^UTILITY(U,$J,358.3,25330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25330,1,3,0)
 ;;=3^Cocaine Induced Obess-Compul & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,25330,1,4,0)
 ;;=4^F14.188
 ;;^UTILITY(U,$J,358.3,25330,2)
 ;;=^5003251
 ;;^UTILITY(U,$J,358.3,25331,0)
 ;;=F14.288^^95^1193^47
 ;;^UTILITY(U,$J,358.3,25331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25331,1,3,0)
 ;;=3^Cocaine Induced Obess-Compul & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,25331,1,4,0)
 ;;=4^F14.288
 ;;^UTILITY(U,$J,358.3,25331,2)
 ;;=^5003267
 ;;^UTILITY(U,$J,358.3,25332,0)
 ;;=F14.988^^95^1193^48
 ;;^UTILITY(U,$J,358.3,25332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25332,1,3,0)
 ;;=3^Cocaine Induced Obess-Compul & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,25332,1,4,0)
 ;;=4^F14.988
 ;;^UTILITY(U,$J,358.3,25332,2)
 ;;=^5003281
 ;;^UTILITY(U,$J,358.3,25333,0)
 ;;=F14.159^^95^1193^49
 ;;^UTILITY(U,$J,358.3,25333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25333,1,3,0)
 ;;=3^Cocaine Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,25333,1,4,0)
 ;;=4^F14.159
 ;;^UTILITY(U,$J,358.3,25333,2)
 ;;=^5003247
 ;;^UTILITY(U,$J,358.3,25334,0)
 ;;=F14.259^^95^1193^50
 ;;^UTILITY(U,$J,358.3,25334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25334,1,3,0)
 ;;=3^Cocaine Induced Psychotic D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,25334,1,4,0)
 ;;=4^F14.259
 ;;^UTILITY(U,$J,358.3,25334,2)
 ;;=^5003263
 ;;^UTILITY(U,$J,358.3,25335,0)
 ;;=F14.959^^95^1193^51
 ;;^UTILITY(U,$J,358.3,25335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25335,1,3,0)
 ;;=3^Cocaine Induced Psychotic D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,25335,1,4,0)
 ;;=4^F14.959
 ;;^UTILITY(U,$J,358.3,25335,2)
 ;;=^5003277
 ;;^UTILITY(U,$J,358.3,25336,0)
 ;;=F14.181^^95^1193^52
 ;;^UTILITY(U,$J,358.3,25336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25336,1,3,0)
 ;;=3^Cocaine Induced Sexual Dysfunction w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,25336,1,4,0)
 ;;=4^F14.181
 ;;^UTILITY(U,$J,358.3,25336,2)
 ;;=^5003249
 ;;^UTILITY(U,$J,358.3,25337,0)
 ;;=F14.281^^95^1193^53
 ;;^UTILITY(U,$J,358.3,25337,1,0)
 ;;=^358.31IA^4^2
