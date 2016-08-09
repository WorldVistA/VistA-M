IBDEI01A ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,760,0)
 ;;=F15.180^^3^61^1
 ;;^UTILITY(U,$J,358.3,760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,760,1,3,0)
 ;;=3^Caffeine Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,760,1,4,0)
 ;;=4^F15.180
 ;;^UTILITY(U,$J,358.3,760,2)
 ;;=^5003291
 ;;^UTILITY(U,$J,358.3,761,0)
 ;;=F15.280^^3^61^2
 ;;^UTILITY(U,$J,358.3,761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,761,1,3,0)
 ;;=3^Caffeine Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,761,1,4,0)
 ;;=4^F15.280
 ;;^UTILITY(U,$J,358.3,761,2)
 ;;=^5003306
 ;;^UTILITY(U,$J,358.3,762,0)
 ;;=F15.980^^3^61^3
 ;;^UTILITY(U,$J,358.3,762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,762,1,3,0)
 ;;=3^Caffeine Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,762,1,4,0)
 ;;=4^F15.980
 ;;^UTILITY(U,$J,358.3,762,2)
 ;;=^5003320
 ;;^UTILITY(U,$J,358.3,763,0)
 ;;=F15.182^^3^61^4
 ;;^UTILITY(U,$J,358.3,763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,763,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,763,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,763,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,764,0)
 ;;=F15.282^^3^61^5
 ;;^UTILITY(U,$J,358.3,764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,764,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,764,1,4,0)
 ;;=4^F15.282
 ;;^UTILITY(U,$J,358.3,764,2)
 ;;=^5003308
 ;;^UTILITY(U,$J,358.3,765,0)
 ;;=F15.982^^3^61^6
 ;;^UTILITY(U,$J,358.3,765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,765,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,765,1,4,0)
 ;;=4^F15.982
 ;;^UTILITY(U,$J,358.3,765,2)
 ;;=^5003322
 ;;^UTILITY(U,$J,358.3,766,0)
 ;;=F15.99^^3^61^9
 ;;^UTILITY(U,$J,358.3,766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,766,1,3,0)
 ;;=3^Caffeinie Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,766,1,4,0)
 ;;=4^F15.99
 ;;^UTILITY(U,$J,358.3,766,2)
 ;;=^5133358
 ;;^UTILITY(U,$J,358.3,767,0)
 ;;=R45.851^^3^62^1
 ;;^UTILITY(U,$J,358.3,767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,767,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,767,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,767,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,768,0)
 ;;=F19.14^^3^63^1
 ;;^UTILITY(U,$J,358.3,768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,768,1,3,0)
 ;;=3^Other/Unknown Substance Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,768,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,768,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,769,0)
 ;;=F19.24^^3^63^2
 ;;^UTILITY(U,$J,358.3,769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,769,1,3,0)
 ;;=3^Other/Unknown Substance Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,769,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,769,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,770,0)
 ;;=F19.94^^3^63^3
 ;;^UTILITY(U,$J,358.3,770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,770,1,3,0)
 ;;=3^Other/Unknown Substance Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,770,1,4,0)
 ;;=4^F19.94
 ;;^UTILITY(U,$J,358.3,770,2)
 ;;=^5003460
 ;;^UTILITY(U,$J,358.3,771,0)
 ;;=F19.17^^3^63^4
 ;;^UTILITY(U,$J,358.3,771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,771,1,3,0)
 ;;=3^Other/Unknown Substance Induced Maj Neurocog D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,771,1,4,0)
 ;;=4^F19.17
 ;;^UTILITY(U,$J,358.3,771,2)
 ;;=^5003426
 ;;^UTILITY(U,$J,358.3,772,0)
 ;;=F19.27^^3^63^5
 ;;^UTILITY(U,$J,358.3,772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,772,1,3,0)
 ;;=3^Other/Unknown Substance Induced Maj Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,772,1,4,0)
 ;;=4^F19.27
 ;;^UTILITY(U,$J,358.3,772,2)
 ;;=^5003446
 ;;^UTILITY(U,$J,358.3,773,0)
 ;;=F19.97^^3^63^6
 ;;^UTILITY(U,$J,358.3,773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,773,1,3,0)
 ;;=3^Other/Unknown Substance Induced Maj Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,773,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,773,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,774,0)
 ;;=F19.188^^3^63^7
 ;;^UTILITY(U,$J,358.3,774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,774,1,3,0)
 ;;=3^Other/Unknown Substance Induced Mild Neurocog D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,774,1,4,0)
 ;;=4^F19.188
 ;;^UTILITY(U,$J,358.3,774,2)
 ;;=^5133361
 ;;^UTILITY(U,$J,358.3,775,0)
 ;;=F19.288^^3^63^8
 ;;^UTILITY(U,$J,358.3,775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,775,1,3,0)
 ;;=3^Other/Unknown Substance Induced Mild Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,775,1,4,0)
 ;;=4^F19.288
 ;;^UTILITY(U,$J,358.3,775,2)
 ;;=^5133362
 ;;^UTILITY(U,$J,358.3,776,0)
 ;;=F19.988^^3^63^9
 ;;^UTILITY(U,$J,358.3,776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,776,1,3,0)
 ;;=3^Other/Unknown Substance Induced Mild Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,776,1,4,0)
 ;;=4^F19.988
 ;;^UTILITY(U,$J,358.3,776,2)
 ;;=^5133363
 ;;^UTILITY(U,$J,358.3,777,0)
 ;;=F19.188^^3^63^10
 ;;^UTILITY(U,$J,358.3,777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,777,1,3,0)
 ;;=3^Other/Unknown Substance Induced Obsess-Compul & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,777,1,4,0)
 ;;=4^F19.188
 ;;^UTILITY(U,$J,358.3,777,2)
 ;;=^5133361
 ;;^UTILITY(U,$J,358.3,778,0)
 ;;=F19.288^^3^63^11
 ;;^UTILITY(U,$J,358.3,778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,778,1,3,0)
 ;;=3^Other/Unknown Substance Induced Obsess-Compul & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,778,1,4,0)
 ;;=4^F19.288
 ;;^UTILITY(U,$J,358.3,778,2)
 ;;=^5133362
 ;;^UTILITY(U,$J,358.3,779,0)
 ;;=F19.988^^3^63^12
 ;;^UTILITY(U,$J,358.3,779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,779,1,3,0)
 ;;=3^Other/Unknown Substance Induced Obsess-Compul & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,779,1,4,0)
 ;;=4^F19.988
 ;;^UTILITY(U,$J,358.3,779,2)
 ;;=^5133363
 ;;^UTILITY(U,$J,358.3,780,0)
 ;;=F19.159^^3^63^13
 ;;^UTILITY(U,$J,358.3,780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,780,1,3,0)
 ;;=3^Other/Unknown Substance Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,780,1,4,0)
 ;;=4^F19.159
 ;;^UTILITY(U,$J,358.3,780,2)
 ;;=^5003424
 ;;^UTILITY(U,$J,358.3,781,0)
 ;;=F19.259^^3^63^14
 ;;^UTILITY(U,$J,358.3,781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,781,1,3,0)
 ;;=3^Other/Unknown Substance Induced Psychotic D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,781,1,4,0)
 ;;=4^F19.259
 ;;^UTILITY(U,$J,358.3,781,2)
 ;;=^5003444
 ;;^UTILITY(U,$J,358.3,782,0)
 ;;=F19.959^^3^63^15
 ;;^UTILITY(U,$J,358.3,782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,782,1,3,0)
 ;;=3^Other/Unknown Substance Induced Psychotic D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,782,1,4,0)
 ;;=4^F19.959
 ;;^UTILITY(U,$J,358.3,782,2)
 ;;=^5003463
 ;;^UTILITY(U,$J,358.3,783,0)
 ;;=F19.181^^3^63^16
 ;;^UTILITY(U,$J,358.3,783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,783,1,3,0)
 ;;=3^Other/Unknown Substance Induced Sexual Dysfunction w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,783,1,4,0)
 ;;=4^F19.181
 ;;^UTILITY(U,$J,358.3,783,2)
 ;;=^5003428
 ;;^UTILITY(U,$J,358.3,784,0)
 ;;=F19.281^^3^63^17
 ;;^UTILITY(U,$J,358.3,784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,784,1,3,0)
 ;;=3^Other/Unknown Substance Induced Sexual Dysfunction w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,784,1,4,0)
 ;;=4^F19.281
 ;;^UTILITY(U,$J,358.3,784,2)
 ;;=^5003448
 ;;^UTILITY(U,$J,358.3,785,0)
 ;;=F19.981^^3^63^18
 ;;^UTILITY(U,$J,358.3,785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,785,1,3,0)
 ;;=3^Other/Unknown Substance Induced Sexual Dysfunction w/ o Use D/O
 ;;^UTILITY(U,$J,358.3,785,1,4,0)
 ;;=4^F19.981
 ;;^UTILITY(U,$J,358.3,785,2)
 ;;=^5003467
 ;;^UTILITY(U,$J,358.3,786,0)
 ;;=F19.182^^3^63^19
 ;;^UTILITY(U,$J,358.3,786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,786,1,3,0)
 ;;=3^Other/Unknown Substance Induced Sleep D/O w/ Mild Use D/O
