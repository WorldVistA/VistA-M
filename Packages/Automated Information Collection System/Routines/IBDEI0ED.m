IBDEI0ED ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14364,1,4,0)
 ;;=4^K92.1
 ;;^UTILITY(U,$J,358.3,14364,2)
 ;;=^5008914
 ;;^UTILITY(U,$J,358.3,14365,0)
 ;;=R19.5^^61^735^48
 ;;^UTILITY(U,$J,358.3,14365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14365,1,3,0)
 ;;=3^Fecal Abnormalities NEC
 ;;^UTILITY(U,$J,358.3,14365,1,4,0)
 ;;=4^R19.5
 ;;^UTILITY(U,$J,358.3,14365,2)
 ;;=^5019274
 ;;^UTILITY(U,$J,358.3,14366,0)
 ;;=E53.8^^61^735^81
 ;;^UTILITY(U,$J,358.3,14366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14366,1,3,0)
 ;;=3^Vitamin B12 Deficiency
 ;;^UTILITY(U,$J,358.3,14366,1,4,0)
 ;;=4^E53.8
 ;;^UTILITY(U,$J,358.3,14366,2)
 ;;=^5002797
 ;;^UTILITY(U,$J,358.3,14367,0)
 ;;=A54.00^^61^736^47
 ;;^UTILITY(U,$J,358.3,14367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14367,1,3,0)
 ;;=3^Gonococcal Infection Lower Genitourinary Tract,Unspec
 ;;^UTILITY(U,$J,358.3,14367,1,4,0)
 ;;=4^A54.00
 ;;^UTILITY(U,$J,358.3,14367,2)
 ;;=^5000311
 ;;^UTILITY(U,$J,358.3,14368,0)
 ;;=A54.09^^61^736^48
 ;;^UTILITY(U,$J,358.3,14368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14368,1,3,0)
 ;;=3^Gonococcal Infection Lower Genitourinary Tract,Other
 ;;^UTILITY(U,$J,358.3,14368,1,4,0)
 ;;=4^A54.09
 ;;^UTILITY(U,$J,358.3,14368,2)
 ;;=^5000315
 ;;^UTILITY(U,$J,358.3,14369,0)
 ;;=A54.02^^61^736^49
 ;;^UTILITY(U,$J,358.3,14369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14369,1,3,0)
 ;;=3^Gonococcal Vulvovaginitis,Unspec
 ;;^UTILITY(U,$J,358.3,14369,1,4,0)
 ;;=4^A54.02
 ;;^UTILITY(U,$J,358.3,14369,2)
 ;;=^5000313
 ;;^UTILITY(U,$J,358.3,14370,0)
 ;;=A54.1^^61^736^46
 ;;^UTILITY(U,$J,358.3,14370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14370,1,3,0)
 ;;=3^Gonococcal Infection Lower GU Tract w/ Periureth & Acc Gland Abscess
 ;;^UTILITY(U,$J,358.3,14370,1,4,0)
 ;;=4^A54.1
 ;;^UTILITY(U,$J,358.3,14370,2)
 ;;=^5000316
 ;;^UTILITY(U,$J,358.3,14371,0)
 ;;=A54.01^^61^736^45
 ;;^UTILITY(U,$J,358.3,14371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14371,1,3,0)
 ;;=3^Gonococcal Cystitis & Urethritis,Unspec
 ;;^UTILITY(U,$J,358.3,14371,1,4,0)
 ;;=4^A54.01
 ;;^UTILITY(U,$J,358.3,14371,2)
 ;;=^5000312
 ;;^UTILITY(U,$J,358.3,14372,0)
 ;;=B37.49^^61^736^12
 ;;^UTILITY(U,$J,358.3,14372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14372,1,3,0)
 ;;=3^Candidiasis Urogenital,Other
 ;;^UTILITY(U,$J,358.3,14372,1,4,0)
 ;;=4^B37.49
 ;;^UTILITY(U,$J,358.3,14372,2)
 ;;=^5000618
 ;;^UTILITY(U,$J,358.3,14373,0)
 ;;=B37.41^^61^736^11
 ;;^UTILITY(U,$J,358.3,14373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14373,1,3,0)
 ;;=3^Candidal Cystitis & Urethritis
 ;;^UTILITY(U,$J,358.3,14373,1,4,0)
 ;;=4^B37.41
 ;;^UTILITY(U,$J,358.3,14373,2)
 ;;=^5000616
 ;;^UTILITY(U,$J,358.3,14374,0)
 ;;=B37.42^^61^736^10
 ;;^UTILITY(U,$J,358.3,14374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14374,1,3,0)
 ;;=3^Candidal Balanitis
 ;;^UTILITY(U,$J,358.3,14374,1,4,0)
 ;;=4^B37.42
 ;;^UTILITY(U,$J,358.3,14374,2)
 ;;=^5000617
 ;;^UTILITY(U,$J,358.3,14375,0)
 ;;=A59.03^^61^736^96
 ;;^UTILITY(U,$J,358.3,14375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14375,1,3,0)
 ;;=3^Trichomonal Cystitis & Urethritis
 ;;^UTILITY(U,$J,358.3,14375,1,4,0)
 ;;=4^A59.03
 ;;^UTILITY(U,$J,358.3,14375,2)
 ;;=^5000349
 ;;^UTILITY(U,$J,358.3,14376,0)
 ;;=E87.6^^61^736^57
 ;;^UTILITY(U,$J,358.3,14376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14376,1,3,0)
 ;;=3^Hypokalemia
 ;;^UTILITY(U,$J,358.3,14376,1,4,0)
 ;;=4^E87.6
 ;;^UTILITY(U,$J,358.3,14376,2)
 ;;=^60610
 ;;^UTILITY(U,$J,358.3,14377,0)
 ;;=F52.0^^61^736^56
 ;;^UTILITY(U,$J,358.3,14377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14377,1,3,0)
 ;;=3^Hypoactive Sexual Desire Disorder
 ;;^UTILITY(U,$J,358.3,14377,1,4,0)
 ;;=4^F52.0
 ;;^UTILITY(U,$J,358.3,14377,2)
 ;;=^5003618
 ;;^UTILITY(U,$J,358.3,14378,0)
 ;;=F52.22^^61^736^93
 ;;^UTILITY(U,$J,358.3,14378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14378,1,3,0)
 ;;=3^Sexual Arousal Disorder,Female
 ;;^UTILITY(U,$J,358.3,14378,1,4,0)
 ;;=4^F52.22
 ;;^UTILITY(U,$J,358.3,14378,2)
 ;;=^5003621
 ;;^UTILITY(U,$J,358.3,14379,0)
 ;;=F52.8^^61^736^94
 ;;^UTILITY(U,$J,358.3,14379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14379,1,3,0)
 ;;=3^Sexual Dysfnct Not d/t Substance/Known Physiological Cond
 ;;^UTILITY(U,$J,358.3,14379,1,4,0)
 ;;=4^F52.8
 ;;^UTILITY(U,$J,358.3,14379,2)
 ;;=^5003624
 ;;^UTILITY(U,$J,358.3,14380,0)
 ;;=F52.21^^61^736^33
 ;;^UTILITY(U,$J,358.3,14380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14380,1,3,0)
 ;;=3^Erectile Disorder,Male (Psychogenic)
 ;;^UTILITY(U,$J,358.3,14380,1,4,0)
 ;;=4^F52.21
 ;;^UTILITY(U,$J,358.3,14380,2)
 ;;=^5003620
 ;;^UTILITY(U,$J,358.3,14381,0)
 ;;=I12.9^^61^736^55
 ;;^UTILITY(U,$J,358.3,14381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14381,1,3,0)
 ;;=3^Hypertensive Kidney Disease Chronic w/ Stg 1-4
 ;;^UTILITY(U,$J,358.3,14381,1,4,0)
 ;;=4^I12.9
 ;;^UTILITY(U,$J,358.3,14381,2)
 ;;=^5007066
 ;;^UTILITY(U,$J,358.3,14382,0)
 ;;=N04.9^^61^736^69
 ;;^UTILITY(U,$J,358.3,14382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14382,1,3,0)
 ;;=3^Nephrotic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,14382,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,14382,2)
 ;;=^5015540
 ;;^UTILITY(U,$J,358.3,14383,0)
 ;;=N02.9^^61^736^50
 ;;^UTILITY(U,$J,358.3,14383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14383,1,3,0)
 ;;=3^Hematuria w/ Unspec Morphologic Changes,Recurrent & Persistent
 ;;^UTILITY(U,$J,358.3,14383,1,4,0)
 ;;=4^N02.9
 ;;^UTILITY(U,$J,358.3,14383,2)
 ;;=^5015520
 ;;^UTILITY(U,$J,358.3,14384,0)
 ;;=N06.9^^61^736^86
 ;;^UTILITY(U,$J,358.3,14384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14384,1,3,0)
 ;;=3^Proteinuria Isolated w/ Unspec Morphologic Lesion
 ;;^UTILITY(U,$J,358.3,14384,1,4,0)
 ;;=4^N06.9
 ;;^UTILITY(U,$J,358.3,14384,2)
 ;;=^5015558
 ;;^UTILITY(U,$J,358.3,14385,0)
 ;;=N05.9^^61^736^66
 ;;^UTILITY(U,$J,358.3,14385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14385,1,3,0)
 ;;=3^Nephritic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,14385,1,4,0)
 ;;=4^N05.9
 ;;^UTILITY(U,$J,358.3,14385,2)
 ;;=^5134086
 ;;^UTILITY(U,$J,358.3,14386,0)
 ;;=N07.9^^61^736^68
 ;;^UTILITY(U,$J,358.3,14386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14386,1,3,0)
 ;;=3^Nephropathy Hereditary w/ Unspec Morphologic Lesions
 ;;^UTILITY(U,$J,358.3,14386,1,4,0)
 ;;=4^N07.9
 ;;^UTILITY(U,$J,358.3,14386,2)
 ;;=^5015568
 ;;^UTILITY(U,$J,358.3,14387,0)
 ;;=N15.9^^61^736^92
 ;;^UTILITY(U,$J,358.3,14387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14387,1,3,0)
 ;;=3^Renal Tubulo-Interstitial Disease,Unspec
 ;;^UTILITY(U,$J,358.3,14387,1,4,0)
 ;;=4^N15.9
 ;;^UTILITY(U,$J,358.3,14387,2)
 ;;=^5015596
 ;;^UTILITY(U,$J,358.3,14388,0)
 ;;=N17.9^^61^736^61
 ;;^UTILITY(U,$J,358.3,14388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14388,1,3,0)
 ;;=3^Kidney Failure,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,14388,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,14388,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,14389,0)
 ;;=N19.^^61^736^62
 ;;^UTILITY(U,$J,358.3,14389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14389,1,3,0)
 ;;=3^Kidney Failure,Unspec
 ;;^UTILITY(U,$J,358.3,14389,1,4,0)
 ;;=4^N19.
 ;;^UTILITY(U,$J,358.3,14389,2)
 ;;=^5015607
 ;;^UTILITY(U,$J,358.3,14390,0)
 ;;=N11.0^^61^736^90
 ;;^UTILITY(U,$J,358.3,14390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14390,1,3,0)
 ;;=3^Pyelonephritis,Chronic Nonobstructive Reflux-Associated
 ;;^UTILITY(U,$J,358.3,14390,1,4,0)
 ;;=4^N11.0
 ;;^UTILITY(U,$J,358.3,14390,2)
 ;;=^5015571
 ;;^UTILITY(U,$J,358.3,14391,0)
 ;;=N10.^^61^736^67
 ;;^UTILITY(U,$J,358.3,14391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14391,1,3,0)
 ;;=3^Nephritis Acute Tubulo-Interstitial
 ;;^UTILITY(U,$J,358.3,14391,1,4,0)
 ;;=4^N10.
 ;;^UTILITY(U,$J,358.3,14391,2)
 ;;=^5015570
 ;;^UTILITY(U,$J,358.3,14392,0)
 ;;=N20.2^^61^736^8
