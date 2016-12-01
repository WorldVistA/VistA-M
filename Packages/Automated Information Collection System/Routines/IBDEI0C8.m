IBDEI0C8 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15495,1,3,0)
 ;;=3^Amphetamine Type Substance Use D/O, Moderate
 ;;^UTILITY(U,$J,358.3,15495,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,15495,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,15496,0)
 ;;=F15.20^^45^695^3
 ;;^UTILITY(U,$J,358.3,15496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15496,1,3,0)
 ;;=3^Amphetamine Type Substance Use D/O, Severe
 ;;^UTILITY(U,$J,358.3,15496,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,15496,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,15497,0)
 ;;=F14.180^^45^695^37
 ;;^UTILITY(U,$J,358.3,15497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15497,1,3,0)
 ;;=3^Cocaine Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,15497,1,4,0)
 ;;=4^F14.180
 ;;^UTILITY(U,$J,358.3,15497,2)
 ;;=^5003248
 ;;^UTILITY(U,$J,358.3,15498,0)
 ;;=F14.280^^45^695^38
 ;;^UTILITY(U,$J,358.3,15498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15498,1,3,0)
 ;;=3^Cocaine Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,15498,1,4,0)
 ;;=4^F14.280
 ;;^UTILITY(U,$J,358.3,15498,2)
 ;;=^5003264
 ;;^UTILITY(U,$J,358.3,15499,0)
 ;;=F14.980^^45^695^39
 ;;^UTILITY(U,$J,358.3,15499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15499,1,3,0)
 ;;=3^Cocaine Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,15499,1,4,0)
 ;;=4^F14.980
 ;;^UTILITY(U,$J,358.3,15499,2)
 ;;=^5003278
 ;;^UTILITY(U,$J,358.3,15500,0)
 ;;=F14.14^^45^695^40
 ;;^UTILITY(U,$J,358.3,15500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15500,1,3,0)
 ;;=3^Cocaine Induced Bipolar & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,15500,1,4,0)
 ;;=4^F14.14
 ;;^UTILITY(U,$J,358.3,15500,2)
 ;;=^5003244
 ;;^UTILITY(U,$J,358.3,15501,0)
 ;;=F14.24^^45^695^41
 ;;^UTILITY(U,$J,358.3,15501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15501,1,3,0)
 ;;=3^Cocaine Induced Bipolar & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,15501,1,4,0)
 ;;=4^F14.24
 ;;^UTILITY(U,$J,358.3,15501,2)
 ;;=^5003260
 ;;^UTILITY(U,$J,358.3,15502,0)
 ;;=F14.94^^45^695^42
 ;;^UTILITY(U,$J,358.3,15502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15502,1,3,0)
 ;;=3^Cocaine Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,15502,1,4,0)
 ;;=4^F14.94
 ;;^UTILITY(U,$J,358.3,15502,2)
 ;;=^5003274
 ;;^UTILITY(U,$J,358.3,15503,0)
 ;;=F14.14^^45^695^43
 ;;^UTILITY(U,$J,358.3,15503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15503,1,3,0)
 ;;=3^Cocaine Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,15503,1,4,0)
 ;;=4^F14.14
 ;;^UTILITY(U,$J,358.3,15503,2)
 ;;=^5003244
 ;;^UTILITY(U,$J,358.3,15504,0)
 ;;=F14.24^^45^695^44
 ;;^UTILITY(U,$J,358.3,15504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15504,1,3,0)
 ;;=3^Cocaine Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,15504,1,4,0)
 ;;=4^F14.24
 ;;^UTILITY(U,$J,358.3,15504,2)
 ;;=^5003260
 ;;^UTILITY(U,$J,358.3,15505,0)
 ;;=F14.94^^45^695^45
 ;;^UTILITY(U,$J,358.3,15505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15505,1,3,0)
 ;;=3^Cocaine Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,15505,1,4,0)
 ;;=4^F14.94
 ;;^UTILITY(U,$J,358.3,15505,2)
 ;;=^5003274
 ;;^UTILITY(U,$J,358.3,15506,0)
 ;;=F14.188^^45^695^46
 ;;^UTILITY(U,$J,358.3,15506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15506,1,3,0)
 ;;=3^Cocaine Induced Obess-Compul & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,15506,1,4,0)
 ;;=4^F14.188
 ;;^UTILITY(U,$J,358.3,15506,2)
 ;;=^5003251
 ;;^UTILITY(U,$J,358.3,15507,0)
 ;;=F14.288^^45^695^47
 ;;^UTILITY(U,$J,358.3,15507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15507,1,3,0)
 ;;=3^Cocaine Induced Obess-Compul & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,15507,1,4,0)
 ;;=4^F14.288
 ;;^UTILITY(U,$J,358.3,15507,2)
 ;;=^5003267
 ;;^UTILITY(U,$J,358.3,15508,0)
 ;;=F14.988^^45^695^48
 ;;^UTILITY(U,$J,358.3,15508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15508,1,3,0)
 ;;=3^Cocaine Induced Obess-Compul & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,15508,1,4,0)
 ;;=4^F14.988
 ;;^UTILITY(U,$J,358.3,15508,2)
 ;;=^5003281
 ;;^UTILITY(U,$J,358.3,15509,0)
 ;;=F14.159^^45^695^49
 ;;^UTILITY(U,$J,358.3,15509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15509,1,3,0)
 ;;=3^Cocaine Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,15509,1,4,0)
 ;;=4^F14.159
 ;;^UTILITY(U,$J,358.3,15509,2)
 ;;=^5003247
 ;;^UTILITY(U,$J,358.3,15510,0)
 ;;=F14.259^^45^695^50
 ;;^UTILITY(U,$J,358.3,15510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15510,1,3,0)
 ;;=3^Cocaine Induced Psychotic D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,15510,1,4,0)
 ;;=4^F14.259
 ;;^UTILITY(U,$J,358.3,15510,2)
 ;;=^5003263
 ;;^UTILITY(U,$J,358.3,15511,0)
 ;;=F14.959^^45^695^51
 ;;^UTILITY(U,$J,358.3,15511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15511,1,3,0)
 ;;=3^Cocaine Induced Psychotic D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,15511,1,4,0)
 ;;=4^F14.959
 ;;^UTILITY(U,$J,358.3,15511,2)
 ;;=^5003277
 ;;^UTILITY(U,$J,358.3,15512,0)
 ;;=F14.181^^45^695^52
 ;;^UTILITY(U,$J,358.3,15512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15512,1,3,0)
 ;;=3^Cocaine Induced Sexual Dysfunction w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,15512,1,4,0)
 ;;=4^F14.181
 ;;^UTILITY(U,$J,358.3,15512,2)
 ;;=^5003249
 ;;^UTILITY(U,$J,358.3,15513,0)
 ;;=F14.281^^45^695^53
 ;;^UTILITY(U,$J,358.3,15513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15513,1,3,0)
 ;;=3^Cocaine Induced Sexual Dysfunction w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,15513,1,4,0)
 ;;=4^F14.281
 ;;^UTILITY(U,$J,358.3,15513,2)
 ;;=^5003265
 ;;^UTILITY(U,$J,358.3,15514,0)
 ;;=F14.981^^45^695^54
 ;;^UTILITY(U,$J,358.3,15514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15514,1,3,0)
 ;;=3^Cocaine Induced Sexual Dysfunction w/o Use D/O
 ;;^UTILITY(U,$J,358.3,15514,1,4,0)
 ;;=4^F14.981
 ;;^UTILITY(U,$J,358.3,15514,2)
 ;;=^5003279
 ;;^UTILITY(U,$J,358.3,15515,0)
 ;;=F14.182^^45^695^55
 ;;^UTILITY(U,$J,358.3,15515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15515,1,3,0)
 ;;=3^Cocaine Induced Sleep D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,15515,1,4,0)
 ;;=4^F14.182
 ;;^UTILITY(U,$J,358.3,15515,2)
 ;;=^5003250
 ;;^UTILITY(U,$J,358.3,15516,0)
 ;;=F14.282^^45^695^56
 ;;^UTILITY(U,$J,358.3,15516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15516,1,3,0)
 ;;=3^Cocaine Induced Sleep D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,15516,1,4,0)
 ;;=4^F14.282
 ;;^UTILITY(U,$J,358.3,15516,2)
 ;;=^5003266
 ;;^UTILITY(U,$J,358.3,15517,0)
 ;;=F14.982^^45^695^57
 ;;^UTILITY(U,$J,358.3,15517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15517,1,3,0)
 ;;=3^Cocaine Induced Sleep D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,15517,1,4,0)
 ;;=4^F14.982
 ;;^UTILITY(U,$J,358.3,15517,2)
 ;;=^5003280
 ;;^UTILITY(U,$J,358.3,15518,0)
 ;;=F14.122^^45^695^61
 ;;^UTILITY(U,$J,358.3,15518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15518,1,3,0)
 ;;=3^Cocaine Intoxication w/ Percept Disturb w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,15518,1,4,0)
 ;;=4^F14.122
 ;;^UTILITY(U,$J,358.3,15518,2)
 ;;=^5003242
 ;;^UTILITY(U,$J,358.3,15519,0)
 ;;=F14.222^^45^695^62
 ;;^UTILITY(U,$J,358.3,15519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15519,1,3,0)
 ;;=3^Cocaine Intoxication w/ Percept Disturb w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,15519,1,4,0)
 ;;=4^F14.222
 ;;^UTILITY(U,$J,358.3,15519,2)
 ;;=^5003257
 ;;^UTILITY(U,$J,358.3,15520,0)
 ;;=F14.922^^45^695^63
 ;;^UTILITY(U,$J,358.3,15520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15520,1,3,0)
 ;;=3^Cocaine Intoxication w/ Percept Disturb w/o Use D/O
 ;;^UTILITY(U,$J,358.3,15520,1,4,0)
 ;;=4^F14.922
 ;;^UTILITY(U,$J,358.3,15520,2)
 ;;=^5003272
 ;;^UTILITY(U,$J,358.3,15521,0)
 ;;=F14.129^^45^695^64
 ;;^UTILITY(U,$J,358.3,15521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15521,1,3,0)
 ;;=3^Cocaine Intoxication w/o  Percept Disturb w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,15521,1,4,0)
 ;;=4^F14.129
 ;;^UTILITY(U,$J,358.3,15521,2)
 ;;=^5003243
 ;;^UTILITY(U,$J,358.3,15522,0)
 ;;=F14.229^^45^695^65
 ;;^UTILITY(U,$J,358.3,15522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15522,1,3,0)
 ;;=3^Cocaine Intoxication w/o  Percept Disturb w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,15522,1,4,0)
 ;;=4^F14.229
 ;;^UTILITY(U,$J,358.3,15522,2)
 ;;=^5003258
 ;;^UTILITY(U,$J,358.3,15523,0)
 ;;=F14.929^^45^695^66
 ;;^UTILITY(U,$J,358.3,15523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15523,1,3,0)
 ;;=3^Cocaine Intoxication w/o Percept Disturb w/o Use D/O
 ;;^UTILITY(U,$J,358.3,15523,1,4,0)
 ;;=4^F14.929
 ;;^UTILITY(U,$J,358.3,15523,2)
 ;;=^5003273
 ;;^UTILITY(U,$J,358.3,15524,0)
 ;;=F14.121^^45^695^58
 ;;^UTILITY(U,$J,358.3,15524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15524,1,3,0)
 ;;=3^Cocaine Intoxication Delirium  w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,15524,1,4,0)
 ;;=4^F14.121
 ;;^UTILITY(U,$J,358.3,15524,2)
 ;;=^5003241
 ;;^UTILITY(U,$J,358.3,15525,0)
 ;;=F14.221^^45^695^59
 ;;^UTILITY(U,$J,358.3,15525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15525,1,3,0)
 ;;=3^Cocaine Intoxication Delirium  w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,15525,1,4,0)
 ;;=4^F14.221
 ;;^UTILITY(U,$J,358.3,15525,2)
 ;;=^5003256
 ;;^UTILITY(U,$J,358.3,15526,0)
 ;;=F14.921^^45^695^60
 ;;^UTILITY(U,$J,358.3,15526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15526,1,3,0)
 ;;=3^Cocaine Intoxication Delirium w/o Use D/O
 ;;^UTILITY(U,$J,358.3,15526,1,4,0)
 ;;=4^F14.921
 ;;^UTILITY(U,$J,358.3,15526,2)
 ;;=^5003271
 ;;^UTILITY(U,$J,358.3,15527,0)
 ;;=F14.10^^45^695^68
 ;;^UTILITY(U,$J,358.3,15527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15527,1,3,0)
 ;;=3^Cocaine Use D/O, Mild
 ;;^UTILITY(U,$J,358.3,15527,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,15527,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,15528,0)
 ;;=F14.20^^45^695^69
 ;;^UTILITY(U,$J,358.3,15528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15528,1,3,0)
 ;;=3^Cocaine Use D/O, Moderate
 ;;^UTILITY(U,$J,358.3,15528,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,15528,2)
 ;;=^5003253
