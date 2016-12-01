IBDEI0KV ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26400,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,26400,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,26401,0)
 ;;=F15.99^^69^1101^35
 ;;^UTILITY(U,$J,358.3,26401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26401,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,26401,1,4,0)
 ;;=4^F15.99
 ;;^UTILITY(U,$J,358.3,26401,2)
 ;;=^5133358
 ;;^UTILITY(U,$J,358.3,26402,0)
 ;;=F14.99^^69^1101^67
 ;;^UTILITY(U,$J,358.3,26402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26402,1,3,0)
 ;;=3^Cocaine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26402,1,4,0)
 ;;=4^F14.99
 ;;^UTILITY(U,$J,358.3,26402,2)
 ;;=^5133354
 ;;^UTILITY(U,$J,358.3,26403,0)
 ;;=F14.99^^69^1101^75
 ;;^UTILITY(U,$J,358.3,26403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26403,1,3,0)
 ;;=3^Stimulant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26403,1,4,0)
 ;;=4^F14.99
 ;;^UTILITY(U,$J,358.3,26403,2)
 ;;=^5133354
 ;;^UTILITY(U,$J,358.3,26404,0)
 ;;=F15.180^^69^1101^4
 ;;^UTILITY(U,$J,358.3,26404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26404,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26404,1,4,0)
 ;;=4^F15.180
 ;;^UTILITY(U,$J,358.3,26404,2)
 ;;=^5003291
 ;;^UTILITY(U,$J,358.3,26405,0)
 ;;=F15.280^^69^1101^5
 ;;^UTILITY(U,$J,358.3,26405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26405,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26405,1,4,0)
 ;;=4^F15.280
 ;;^UTILITY(U,$J,358.3,26405,2)
 ;;=^5003306
 ;;^UTILITY(U,$J,358.3,26406,0)
 ;;=F15.980^^69^1101^6
 ;;^UTILITY(U,$J,358.3,26406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26406,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26406,1,4,0)
 ;;=4^F15.980
 ;;^UTILITY(U,$J,358.3,26406,2)
 ;;=^5003320
 ;;^UTILITY(U,$J,358.3,26407,0)
 ;;=F15.14^^69^1101^7
 ;;^UTILITY(U,$J,358.3,26407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26407,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26407,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,26407,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,26408,0)
 ;;=F15.24^^69^1101^8
 ;;^UTILITY(U,$J,358.3,26408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26408,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26408,1,4,0)
 ;;=4^F15.24
 ;;^UTILITY(U,$J,358.3,26408,2)
 ;;=^5003302
 ;;^UTILITY(U,$J,358.3,26409,0)
 ;;=F15.94^^69^1101^9
 ;;^UTILITY(U,$J,358.3,26409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26409,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26409,1,4,0)
 ;;=4^F15.94
 ;;^UTILITY(U,$J,358.3,26409,2)
 ;;=^5003316
 ;;^UTILITY(U,$J,358.3,26410,0)
 ;;=F15.921^^69^1101^10
 ;;^UTILITY(U,$J,358.3,26410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26410,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Delirium
 ;;^UTILITY(U,$J,358.3,26410,1,4,0)
 ;;=4^F15.921
 ;;^UTILITY(U,$J,358.3,26410,2)
 ;;=^5003312
 ;;^UTILITY(U,$J,358.3,26411,0)
 ;;=F15.14^^69^1101^11
 ;;^UTILITY(U,$J,358.3,26411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26411,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26411,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,26411,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,26412,0)
 ;;=F15.24^^69^1101^12
 ;;^UTILITY(U,$J,358.3,26412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26412,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26412,1,4,0)
 ;;=4^F15.24
 ;;^UTILITY(U,$J,358.3,26412,2)
 ;;=^5003302
 ;;^UTILITY(U,$J,358.3,26413,0)
 ;;=F15.94^^69^1101^13
 ;;^UTILITY(U,$J,358.3,26413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26413,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26413,1,4,0)
 ;;=4^F15.94
 ;;^UTILITY(U,$J,358.3,26413,2)
 ;;=^5003316
 ;;^UTILITY(U,$J,358.3,26414,0)
 ;;=F15.188^^69^1101^14
 ;;^UTILITY(U,$J,358.3,26414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26414,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26414,1,4,0)
 ;;=4^F15.188
 ;;^UTILITY(U,$J,358.3,26414,2)
 ;;=^5133355
 ;;^UTILITY(U,$J,358.3,26415,0)
 ;;=F15.288^^69^1101^15
 ;;^UTILITY(U,$J,358.3,26415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26415,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26415,1,4,0)
 ;;=4^F15.288
 ;;^UTILITY(U,$J,358.3,26415,2)
 ;;=^5133356
 ;;^UTILITY(U,$J,358.3,26416,0)
 ;;=F15.988^^69^1101^16
 ;;^UTILITY(U,$J,358.3,26416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26416,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26416,1,4,0)
 ;;=4^F15.988
 ;;^UTILITY(U,$J,358.3,26416,2)
 ;;=^5133357
 ;;^UTILITY(U,$J,358.3,26417,0)
 ;;=F15.159^^69^1101^17
 ;;^UTILITY(U,$J,358.3,26417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26417,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26417,1,4,0)
 ;;=4^F15.159
 ;;^UTILITY(U,$J,358.3,26417,2)
 ;;=^5003290
 ;;^UTILITY(U,$J,358.3,26418,0)
 ;;=F15.259^^69^1101^18
 ;;^UTILITY(U,$J,358.3,26418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26418,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26418,1,4,0)
 ;;=4^F15.259
 ;;^UTILITY(U,$J,358.3,26418,2)
 ;;=^5003305
 ;;^UTILITY(U,$J,358.3,26419,0)
 ;;=F15.959^^69^1101^19
 ;;^UTILITY(U,$J,358.3,26419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26419,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26419,1,4,0)
 ;;=4^F15.959
 ;;^UTILITY(U,$J,358.3,26419,2)
 ;;=^5003319
 ;;^UTILITY(U,$J,358.3,26420,0)
 ;;=F15.181^^69^1101^20
 ;;^UTILITY(U,$J,358.3,26420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26420,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26420,1,4,0)
 ;;=4^F15.181
 ;;^UTILITY(U,$J,358.3,26420,2)
 ;;=^5003292
 ;;^UTILITY(U,$J,358.3,26421,0)
 ;;=F15.281^^69^1101^21
 ;;^UTILITY(U,$J,358.3,26421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26421,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26421,1,4,0)
 ;;=4^F15.281
 ;;^UTILITY(U,$J,358.3,26421,2)
 ;;=^5003307
 ;;^UTILITY(U,$J,358.3,26422,0)
 ;;=F15.981^^69^1101^22
 ;;^UTILITY(U,$J,358.3,26422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26422,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26422,1,4,0)
 ;;=4^F15.981
 ;;^UTILITY(U,$J,358.3,26422,2)
 ;;=^5003321
 ;;^UTILITY(U,$J,358.3,26423,0)
 ;;=F15.182^^69^1101^23
 ;;^UTILITY(U,$J,358.3,26423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26423,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sleep D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26423,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,26423,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,26424,0)
 ;;=F15.282^^69^1101^24
 ;;^UTILITY(U,$J,358.3,26424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26424,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sleep D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26424,1,4,0)
 ;;=4^F15.282
 ;;^UTILITY(U,$J,358.3,26424,2)
 ;;=^5003308
 ;;^UTILITY(U,$J,358.3,26425,0)
 ;;=F15.982^^69^1101^25
 ;;^UTILITY(U,$J,358.3,26425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26425,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sleep D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26425,1,4,0)
 ;;=4^F15.982
 ;;^UTILITY(U,$J,358.3,26425,2)
 ;;=^5003322
 ;;^UTILITY(U,$J,358.3,26426,0)
 ;;=F15.122^^69^1101^29
 ;;^UTILITY(U,$J,358.3,26426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26426,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intoxication w/ Percept Disturb w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26426,1,4,0)
 ;;=4^F15.122
 ;;^UTILITY(U,$J,358.3,26426,2)
 ;;=^5003285
 ;;^UTILITY(U,$J,358.3,26427,0)
 ;;=F15.222^^69^1101^30
 ;;^UTILITY(U,$J,358.3,26427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26427,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intoxication w/ Percept Disturb w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26427,1,4,0)
 ;;=4^F15.222
 ;;^UTILITY(U,$J,358.3,26427,2)
 ;;=^5003299
 ;;^UTILITY(U,$J,358.3,26428,0)
 ;;=F15.922^^69^1101^31
 ;;^UTILITY(U,$J,358.3,26428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26428,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intoxication w/ Percept Disturb w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26428,1,4,0)
 ;;=4^F15.922
 ;;^UTILITY(U,$J,358.3,26428,2)
 ;;=^5003313
 ;;^UTILITY(U,$J,358.3,26429,0)
 ;;=F15.129^^69^1101^32
 ;;^UTILITY(U,$J,358.3,26429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26429,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intoxication w/o  Percept Disturb w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26429,1,4,0)
 ;;=4^F15.129
 ;;^UTILITY(U,$J,358.3,26429,2)
 ;;=^5003286
 ;;^UTILITY(U,$J,358.3,26430,0)
 ;;=F15.229^^69^1101^33
 ;;^UTILITY(U,$J,358.3,26430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26430,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intoxication w/o  Percept Disturb w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26430,1,4,0)
 ;;=4^F15.229
 ;;^UTILITY(U,$J,358.3,26430,2)
 ;;=^5003300
 ;;^UTILITY(U,$J,358.3,26431,0)
 ;;=F15.929^^69^1101^34
 ;;^UTILITY(U,$J,358.3,26431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26431,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intoxication w/o Percept Disturb w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26431,1,4,0)
 ;;=4^F15.929
 ;;^UTILITY(U,$J,358.3,26431,2)
 ;;=^5003314
 ;;^UTILITY(U,$J,358.3,26432,0)
 ;;=F15.121^^69^1101^26
