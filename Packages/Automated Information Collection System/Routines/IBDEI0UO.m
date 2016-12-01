IBDEI0UO ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40305,1,3,0)
 ;;=3^Stereotypic Movement D/O w/o Self-Injurious Behavior
 ;;^UTILITY(U,$J,358.3,40305,1,4,0)
 ;;=4^F98.4
 ;;^UTILITY(U,$J,358.3,40305,2)
 ;;=^5003716
 ;;^UTILITY(U,$J,358.3,40306,0)
 ;;=F90.9^^114^1705^6
 ;;^UTILITY(U,$J,358.3,40306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40306,1,3,0)
 ;;=3^Attention Deficit/Hyperativity Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,40306,1,4,0)
 ;;=4^F90.9
 ;;^UTILITY(U,$J,358.3,40306,2)
 ;;=^5003696
 ;;^UTILITY(U,$J,358.3,40307,0)
 ;;=F79.^^114^1705^17
 ;;^UTILITY(U,$J,358.3,40307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40307,1,3,0)
 ;;=3^Intellectual Disability,Unspec
 ;;^UTILITY(U,$J,358.3,40307,1,4,0)
 ;;=4^F79.
 ;;^UTILITY(U,$J,358.3,40307,2)
 ;;=^5003673
 ;;^UTILITY(U,$J,358.3,40308,0)
 ;;=F15.929^^114^1706^7
 ;;^UTILITY(U,$J,358.3,40308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40308,1,3,0)
 ;;=3^Caffeine Intoxication
 ;;^UTILITY(U,$J,358.3,40308,1,4,0)
 ;;=4^F15.929
 ;;^UTILITY(U,$J,358.3,40308,2)
 ;;=^5003314
 ;;^UTILITY(U,$J,358.3,40309,0)
 ;;=F15.93^^114^1706^8
 ;;^UTILITY(U,$J,358.3,40309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40309,1,3,0)
 ;;=3^Caffeine Withdrawal
 ;;^UTILITY(U,$J,358.3,40309,1,4,0)
 ;;=4^F15.93
 ;;^UTILITY(U,$J,358.3,40309,2)
 ;;=^5003315
 ;;^UTILITY(U,$J,358.3,40310,0)
 ;;=F15.180^^114^1706^1
 ;;^UTILITY(U,$J,358.3,40310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40310,1,3,0)
 ;;=3^Caffeine Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40310,1,4,0)
 ;;=4^F15.180
 ;;^UTILITY(U,$J,358.3,40310,2)
 ;;=^5003291
 ;;^UTILITY(U,$J,358.3,40311,0)
 ;;=F15.280^^114^1706^2
 ;;^UTILITY(U,$J,358.3,40311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40311,1,3,0)
 ;;=3^Caffeine Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40311,1,4,0)
 ;;=4^F15.280
 ;;^UTILITY(U,$J,358.3,40311,2)
 ;;=^5003306
 ;;^UTILITY(U,$J,358.3,40312,0)
 ;;=F15.980^^114^1706^3
 ;;^UTILITY(U,$J,358.3,40312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40312,1,3,0)
 ;;=3^Caffeine Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40312,1,4,0)
 ;;=4^F15.980
 ;;^UTILITY(U,$J,358.3,40312,2)
 ;;=^5003320
 ;;^UTILITY(U,$J,358.3,40313,0)
 ;;=F15.182^^114^1706^4
 ;;^UTILITY(U,$J,358.3,40313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40313,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40313,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,40313,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,40314,0)
 ;;=F15.282^^114^1706^5
 ;;^UTILITY(U,$J,358.3,40314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40314,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40314,1,4,0)
 ;;=4^F15.282
 ;;^UTILITY(U,$J,358.3,40314,2)
 ;;=^5003308
 ;;^UTILITY(U,$J,358.3,40315,0)
 ;;=F15.982^^114^1706^6
 ;;^UTILITY(U,$J,358.3,40315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40315,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40315,1,4,0)
 ;;=4^F15.982
 ;;^UTILITY(U,$J,358.3,40315,2)
 ;;=^5003322
 ;;^UTILITY(U,$J,358.3,40316,0)
 ;;=F15.99^^114^1706^9
 ;;^UTILITY(U,$J,358.3,40316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40316,1,3,0)
 ;;=3^Caffeinie Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,40316,1,4,0)
 ;;=4^F15.99
 ;;^UTILITY(U,$J,358.3,40316,2)
 ;;=^5133358
 ;;^UTILITY(U,$J,358.3,40317,0)
 ;;=R45.851^^114^1707^1
 ;;^UTILITY(U,$J,358.3,40317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40317,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,40317,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,40317,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,40318,0)
 ;;=F19.14^^114^1708^1
 ;;^UTILITY(U,$J,358.3,40318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40318,1,3,0)
 ;;=3^Other/Unknown Substance Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,40318,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,40318,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,40319,0)
 ;;=F19.24^^114^1708^2
 ;;^UTILITY(U,$J,358.3,40319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40319,1,3,0)
 ;;=3^Other/Unknown Substance Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,40319,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,40319,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,40320,0)
 ;;=F19.94^^114^1708^3
 ;;^UTILITY(U,$J,358.3,40320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40320,1,3,0)
 ;;=3^Other/Unknown Substance Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,40320,1,4,0)
 ;;=4^F19.94
 ;;^UTILITY(U,$J,358.3,40320,2)
 ;;=^5003460
 ;;^UTILITY(U,$J,358.3,40321,0)
 ;;=F19.17^^114^1708^4
 ;;^UTILITY(U,$J,358.3,40321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40321,1,3,0)
 ;;=3^Other/Unknown Substance Induced Maj Neurocog D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,40321,1,4,0)
 ;;=4^F19.17
 ;;^UTILITY(U,$J,358.3,40321,2)
 ;;=^5003426
 ;;^UTILITY(U,$J,358.3,40322,0)
 ;;=F19.27^^114^1708^5
 ;;^UTILITY(U,$J,358.3,40322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40322,1,3,0)
 ;;=3^Other/Unknown Substance Induced Maj Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,40322,1,4,0)
 ;;=4^F19.27
 ;;^UTILITY(U,$J,358.3,40322,2)
 ;;=^5003446
 ;;^UTILITY(U,$J,358.3,40323,0)
 ;;=F19.97^^114^1708^6
 ;;^UTILITY(U,$J,358.3,40323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40323,1,3,0)
 ;;=3^Other/Unknown Substance Induced Maj Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,40323,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,40323,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,40324,0)
 ;;=F19.188^^114^1708^7
 ;;^UTILITY(U,$J,358.3,40324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40324,1,3,0)
 ;;=3^Other/Unknown Substance Induced Mild Neurocog D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,40324,1,4,0)
 ;;=4^F19.188
 ;;^UTILITY(U,$J,358.3,40324,2)
 ;;=^5133361
 ;;^UTILITY(U,$J,358.3,40325,0)
 ;;=F19.288^^114^1708^8
 ;;^UTILITY(U,$J,358.3,40325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40325,1,3,0)
 ;;=3^Other/Unknown Substance Induced Mild Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,40325,1,4,0)
 ;;=4^F19.288
 ;;^UTILITY(U,$J,358.3,40325,2)
 ;;=^5133362
 ;;^UTILITY(U,$J,358.3,40326,0)
 ;;=F19.988^^114^1708^9
 ;;^UTILITY(U,$J,358.3,40326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40326,1,3,0)
 ;;=3^Other/Unknown Substance Induced Mild Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,40326,1,4,0)
 ;;=4^F19.988
 ;;^UTILITY(U,$J,358.3,40326,2)
 ;;=^5133363
 ;;^UTILITY(U,$J,358.3,40327,0)
 ;;=F19.188^^114^1708^10
 ;;^UTILITY(U,$J,358.3,40327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40327,1,3,0)
 ;;=3^Other/Unknown Substance Induced Obsess-Compul & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,40327,1,4,0)
 ;;=4^F19.188
 ;;^UTILITY(U,$J,358.3,40327,2)
 ;;=^5133361
 ;;^UTILITY(U,$J,358.3,40328,0)
 ;;=F19.288^^114^1708^11
 ;;^UTILITY(U,$J,358.3,40328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40328,1,3,0)
 ;;=3^Other/Unknown Substance Induced Obsess-Compul & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,40328,1,4,0)
 ;;=4^F19.288
 ;;^UTILITY(U,$J,358.3,40328,2)
 ;;=^5133362
 ;;^UTILITY(U,$J,358.3,40329,0)
 ;;=F19.988^^114^1708^12
 ;;^UTILITY(U,$J,358.3,40329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40329,1,3,0)
 ;;=3^Other/Unknown Substance Induced Obsess-Compul & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,40329,1,4,0)
 ;;=4^F19.988
 ;;^UTILITY(U,$J,358.3,40329,2)
 ;;=^5133363
 ;;^UTILITY(U,$J,358.3,40330,0)
 ;;=F19.159^^114^1708^13
 ;;^UTILITY(U,$J,358.3,40330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40330,1,3,0)
 ;;=3^Other/Unknown Substance Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,40330,1,4,0)
 ;;=4^F19.159
 ;;^UTILITY(U,$J,358.3,40330,2)
 ;;=^5003424
 ;;^UTILITY(U,$J,358.3,40331,0)
 ;;=F19.259^^114^1708^14
 ;;^UTILITY(U,$J,358.3,40331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40331,1,3,0)
 ;;=3^Other/Unknown Substance Induced Psychotic D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,40331,1,4,0)
 ;;=4^F19.259
 ;;^UTILITY(U,$J,358.3,40331,2)
 ;;=^5003444
 ;;^UTILITY(U,$J,358.3,40332,0)
 ;;=F19.959^^114^1708^15
 ;;^UTILITY(U,$J,358.3,40332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40332,1,3,0)
 ;;=3^Other/Unknown Substance Induced Psychotic D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,40332,1,4,0)
 ;;=4^F19.959
 ;;^UTILITY(U,$J,358.3,40332,2)
 ;;=^5003463
 ;;^UTILITY(U,$J,358.3,40333,0)
 ;;=F19.181^^114^1708^16
 ;;^UTILITY(U,$J,358.3,40333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40333,1,3,0)
 ;;=3^Other/Unknown Substance Induced Sexual Dysfunction w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,40333,1,4,0)
 ;;=4^F19.181
 ;;^UTILITY(U,$J,358.3,40333,2)
 ;;=^5003428
 ;;^UTILITY(U,$J,358.3,40334,0)
 ;;=F19.281^^114^1708^17
 ;;^UTILITY(U,$J,358.3,40334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40334,1,3,0)
 ;;=3^Other/Unknown Substance Induced Sexual Dysfunction w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,40334,1,4,0)
 ;;=4^F19.281
 ;;^UTILITY(U,$J,358.3,40334,2)
 ;;=^5003448
 ;;^UTILITY(U,$J,358.3,40335,0)
 ;;=F19.981^^114^1708^18
 ;;^UTILITY(U,$J,358.3,40335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40335,1,3,0)
 ;;=3^Other/Unknown Substance Induced Sexual Dysfunction w/ o Use D/O
 ;;^UTILITY(U,$J,358.3,40335,1,4,0)
 ;;=4^F19.981
 ;;^UTILITY(U,$J,358.3,40335,2)
 ;;=^5003467
 ;;^UTILITY(U,$J,358.3,40336,0)
 ;;=F19.182^^114^1708^19
 ;;^UTILITY(U,$J,358.3,40336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40336,1,3,0)
 ;;=3^Other/Unknown Substance Induced Sleep D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,40336,1,4,0)
 ;;=4^F19.182
 ;;^UTILITY(U,$J,358.3,40336,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,40337,0)
 ;;=F19.282^^114^1708^20
 ;;^UTILITY(U,$J,358.3,40337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40337,1,3,0)
 ;;=3^Other/Unknown Substance Induced Sleep D/O w/ Mod-Sev Use D/O
