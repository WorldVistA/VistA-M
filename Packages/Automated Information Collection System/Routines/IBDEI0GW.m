IBDEI0GW ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21401,1,3,0)
 ;;=3^Melena/Hematochezia
 ;;^UTILITY(U,$J,358.3,21401,1,4,0)
 ;;=4^K92.1
 ;;^UTILITY(U,$J,358.3,21401,2)
 ;;=^5008914
 ;;^UTILITY(U,$J,358.3,21402,0)
 ;;=R19.5^^58^835^48
 ;;^UTILITY(U,$J,358.3,21402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21402,1,3,0)
 ;;=3^Fecal Abnormalities NEC
 ;;^UTILITY(U,$J,358.3,21402,1,4,0)
 ;;=4^R19.5
 ;;^UTILITY(U,$J,358.3,21402,2)
 ;;=^5019274
 ;;^UTILITY(U,$J,358.3,21403,0)
 ;;=E53.8^^58^835^81
 ;;^UTILITY(U,$J,358.3,21403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21403,1,3,0)
 ;;=3^Vitamin B12 Deficiency
 ;;^UTILITY(U,$J,358.3,21403,1,4,0)
 ;;=4^E53.8
 ;;^UTILITY(U,$J,358.3,21403,2)
 ;;=^5002797
 ;;^UTILITY(U,$J,358.3,21404,0)
 ;;=A54.00^^58^836^47
 ;;^UTILITY(U,$J,358.3,21404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21404,1,3,0)
 ;;=3^Gonococcal Infection Lower Genitourinary Tract,Unspec
 ;;^UTILITY(U,$J,358.3,21404,1,4,0)
 ;;=4^A54.00
 ;;^UTILITY(U,$J,358.3,21404,2)
 ;;=^5000311
 ;;^UTILITY(U,$J,358.3,21405,0)
 ;;=A54.09^^58^836^48
 ;;^UTILITY(U,$J,358.3,21405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21405,1,3,0)
 ;;=3^Gonococcal Infection Lower Genitourinary Tract,Other
 ;;^UTILITY(U,$J,358.3,21405,1,4,0)
 ;;=4^A54.09
 ;;^UTILITY(U,$J,358.3,21405,2)
 ;;=^5000315
 ;;^UTILITY(U,$J,358.3,21406,0)
 ;;=A54.02^^58^836^49
 ;;^UTILITY(U,$J,358.3,21406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21406,1,3,0)
 ;;=3^Gonococcal Vulvovaginitis,Unspec
 ;;^UTILITY(U,$J,358.3,21406,1,4,0)
 ;;=4^A54.02
 ;;^UTILITY(U,$J,358.3,21406,2)
 ;;=^5000313
 ;;^UTILITY(U,$J,358.3,21407,0)
 ;;=A54.1^^58^836^46
 ;;^UTILITY(U,$J,358.3,21407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21407,1,3,0)
 ;;=3^Gonococcal Infection Lower GU Tract w/ Periureth & Acc Gland Abscess
 ;;^UTILITY(U,$J,358.3,21407,1,4,0)
 ;;=4^A54.1
 ;;^UTILITY(U,$J,358.3,21407,2)
 ;;=^5000316
 ;;^UTILITY(U,$J,358.3,21408,0)
 ;;=A54.01^^58^836^45
 ;;^UTILITY(U,$J,358.3,21408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21408,1,3,0)
 ;;=3^Gonococcal Cystitis & Urethritis,Unspec
 ;;^UTILITY(U,$J,358.3,21408,1,4,0)
 ;;=4^A54.01
 ;;^UTILITY(U,$J,358.3,21408,2)
 ;;=^5000312
 ;;^UTILITY(U,$J,358.3,21409,0)
 ;;=B37.49^^58^836^12
 ;;^UTILITY(U,$J,358.3,21409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21409,1,3,0)
 ;;=3^Candidiasis Urogenital,Other
 ;;^UTILITY(U,$J,358.3,21409,1,4,0)
 ;;=4^B37.49
 ;;^UTILITY(U,$J,358.3,21409,2)
 ;;=^5000618
 ;;^UTILITY(U,$J,358.3,21410,0)
 ;;=B37.41^^58^836^11
 ;;^UTILITY(U,$J,358.3,21410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21410,1,3,0)
 ;;=3^Candidal Cystitis & Urethritis
 ;;^UTILITY(U,$J,358.3,21410,1,4,0)
 ;;=4^B37.41
 ;;^UTILITY(U,$J,358.3,21410,2)
 ;;=^5000616
 ;;^UTILITY(U,$J,358.3,21411,0)
 ;;=B37.42^^58^836^10
 ;;^UTILITY(U,$J,358.3,21411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21411,1,3,0)
 ;;=3^Candidal Balanitis
 ;;^UTILITY(U,$J,358.3,21411,1,4,0)
 ;;=4^B37.42
 ;;^UTILITY(U,$J,358.3,21411,2)
 ;;=^5000617
 ;;^UTILITY(U,$J,358.3,21412,0)
 ;;=A59.03^^58^836^96
 ;;^UTILITY(U,$J,358.3,21412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21412,1,3,0)
 ;;=3^Trichomonal Cystitis & Urethritis
 ;;^UTILITY(U,$J,358.3,21412,1,4,0)
 ;;=4^A59.03
 ;;^UTILITY(U,$J,358.3,21412,2)
 ;;=^5000349
 ;;^UTILITY(U,$J,358.3,21413,0)
 ;;=E87.6^^58^836^57
 ;;^UTILITY(U,$J,358.3,21413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21413,1,3,0)
 ;;=3^Hypokalemia
 ;;^UTILITY(U,$J,358.3,21413,1,4,0)
 ;;=4^E87.6
 ;;^UTILITY(U,$J,358.3,21413,2)
 ;;=^60610
 ;;^UTILITY(U,$J,358.3,21414,0)
 ;;=F52.0^^58^836^56
 ;;^UTILITY(U,$J,358.3,21414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21414,1,3,0)
 ;;=3^Hypoactive Sexual Desire Disorder
 ;;^UTILITY(U,$J,358.3,21414,1,4,0)
 ;;=4^F52.0
 ;;^UTILITY(U,$J,358.3,21414,2)
 ;;=^5003618
 ;;^UTILITY(U,$J,358.3,21415,0)
 ;;=F52.22^^58^836^93
 ;;^UTILITY(U,$J,358.3,21415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21415,1,3,0)
 ;;=3^Sexual Arousal Disorder,Female
 ;;^UTILITY(U,$J,358.3,21415,1,4,0)
 ;;=4^F52.22
 ;;^UTILITY(U,$J,358.3,21415,2)
 ;;=^5003621
 ;;^UTILITY(U,$J,358.3,21416,0)
 ;;=F52.8^^58^836^94
 ;;^UTILITY(U,$J,358.3,21416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21416,1,3,0)
 ;;=3^Sexual Dysfnct Not d/t Substance/Known Physiological Cond
 ;;^UTILITY(U,$J,358.3,21416,1,4,0)
 ;;=4^F52.8
 ;;^UTILITY(U,$J,358.3,21416,2)
 ;;=^5003624
 ;;^UTILITY(U,$J,358.3,21417,0)
 ;;=F52.21^^58^836^33
 ;;^UTILITY(U,$J,358.3,21417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21417,1,3,0)
 ;;=3^Erectile Disorder,Male (Psychogenic)
 ;;^UTILITY(U,$J,358.3,21417,1,4,0)
 ;;=4^F52.21
 ;;^UTILITY(U,$J,358.3,21417,2)
 ;;=^5003620
 ;;^UTILITY(U,$J,358.3,21418,0)
 ;;=I12.9^^58^836^55
 ;;^UTILITY(U,$J,358.3,21418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21418,1,3,0)
 ;;=3^Hypertensive Kidney Disease Chronic w/ Stg 1-4
 ;;^UTILITY(U,$J,358.3,21418,1,4,0)
 ;;=4^I12.9
 ;;^UTILITY(U,$J,358.3,21418,2)
 ;;=^5007066
 ;;^UTILITY(U,$J,358.3,21419,0)
 ;;=N04.9^^58^836^69
 ;;^UTILITY(U,$J,358.3,21419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21419,1,3,0)
 ;;=3^Nephrotic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,21419,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,21419,2)
 ;;=^5015540
 ;;^UTILITY(U,$J,358.3,21420,0)
 ;;=N02.9^^58^836^50
 ;;^UTILITY(U,$J,358.3,21420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21420,1,3,0)
 ;;=3^Hematuria w/ Unspec Morphologic Changes,Recurrent & Persistent
 ;;^UTILITY(U,$J,358.3,21420,1,4,0)
 ;;=4^N02.9
 ;;^UTILITY(U,$J,358.3,21420,2)
 ;;=^5015520
 ;;^UTILITY(U,$J,358.3,21421,0)
 ;;=N06.9^^58^836^86
 ;;^UTILITY(U,$J,358.3,21421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21421,1,3,0)
 ;;=3^Proteinuria Isolated w/ Unspec Morphologic Lesion
 ;;^UTILITY(U,$J,358.3,21421,1,4,0)
 ;;=4^N06.9
 ;;^UTILITY(U,$J,358.3,21421,2)
 ;;=^5015558
 ;;^UTILITY(U,$J,358.3,21422,0)
 ;;=N05.9^^58^836^66
 ;;^UTILITY(U,$J,358.3,21422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21422,1,3,0)
 ;;=3^Nephritic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,21422,1,4,0)
 ;;=4^N05.9
 ;;^UTILITY(U,$J,358.3,21422,2)
 ;;=^5134086
 ;;^UTILITY(U,$J,358.3,21423,0)
 ;;=N07.9^^58^836^68
 ;;^UTILITY(U,$J,358.3,21423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21423,1,3,0)
 ;;=3^Nephropathy Hereditary w/ Unspec Morphologic Lesions
 ;;^UTILITY(U,$J,358.3,21423,1,4,0)
 ;;=4^N07.9
 ;;^UTILITY(U,$J,358.3,21423,2)
 ;;=^5015568
 ;;^UTILITY(U,$J,358.3,21424,0)
 ;;=N15.9^^58^836^92
 ;;^UTILITY(U,$J,358.3,21424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21424,1,3,0)
 ;;=3^Renal Tubulo-Interstitial Disease,Unspec
 ;;^UTILITY(U,$J,358.3,21424,1,4,0)
 ;;=4^N15.9
 ;;^UTILITY(U,$J,358.3,21424,2)
 ;;=^5015596
 ;;^UTILITY(U,$J,358.3,21425,0)
 ;;=N17.9^^58^836^61
 ;;^UTILITY(U,$J,358.3,21425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21425,1,3,0)
 ;;=3^Kidney Failure,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,21425,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,21425,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,21426,0)
 ;;=N19.^^58^836^62
 ;;^UTILITY(U,$J,358.3,21426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21426,1,3,0)
 ;;=3^Kidney Failure,Unspec
 ;;^UTILITY(U,$J,358.3,21426,1,4,0)
 ;;=4^N19.
 ;;^UTILITY(U,$J,358.3,21426,2)
 ;;=^5015607
 ;;^UTILITY(U,$J,358.3,21427,0)
 ;;=N11.0^^58^836^90
 ;;^UTILITY(U,$J,358.3,21427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21427,1,3,0)
 ;;=3^Pyelonephritis,Chronic Nonobstructive Reflux-Associated
 ;;^UTILITY(U,$J,358.3,21427,1,4,0)
 ;;=4^N11.0
 ;;^UTILITY(U,$J,358.3,21427,2)
 ;;=^5015571
 ;;^UTILITY(U,$J,358.3,21428,0)
 ;;=N10.^^58^836^67
 ;;^UTILITY(U,$J,358.3,21428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21428,1,3,0)
 ;;=3^Nephritis Acute Tubulo-Interstitial
 ;;^UTILITY(U,$J,358.3,21428,1,4,0)
 ;;=4^N10.
 ;;^UTILITY(U,$J,358.3,21428,2)
 ;;=^5015570
 ;;^UTILITY(U,$J,358.3,21429,0)
 ;;=N20.2^^58^836^8
 ;;^UTILITY(U,$J,358.3,21429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21429,1,3,0)
 ;;=3^Calculus Kidney w/ Calculus Ureter
 ;;^UTILITY(U,$J,358.3,21429,1,4,0)
 ;;=4^N20.2
 ;;^UTILITY(U,$J,358.3,21429,2)
 ;;=^5015609
 ;;^UTILITY(U,$J,358.3,21430,0)
 ;;=N20.0^^58^836^7
 ;;^UTILITY(U,$J,358.3,21430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21430,1,3,0)
 ;;=3^Calculus Kidney
 ;;^UTILITY(U,$J,358.3,21430,1,4,0)
 ;;=4^N20.0
 ;;^UTILITY(U,$J,358.3,21430,2)
 ;;=^67056
 ;;^UTILITY(U,$J,358.3,21431,0)
 ;;=N29.^^58^836^60
 ;;^UTILITY(U,$J,358.3,21431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21431,1,3,0)
 ;;=3^Kidney & Ureter Disorders in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,21431,1,4,0)
 ;;=4^N29.
 ;;^UTILITY(U,$J,358.3,21431,2)
 ;;=^5015631
 ;;^UTILITY(U,$J,358.3,21432,0)
 ;;=N28.9^^58^836^59
 ;;^UTILITY(U,$J,358.3,21432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21432,1,3,0)
 ;;=3^Kidney & Ureter Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,21432,1,4,0)
 ;;=4^N28.9
 ;;^UTILITY(U,$J,358.3,21432,2)
 ;;=^5015630
 ;;^UTILITY(U,$J,358.3,21433,0)
 ;;=N30.01^^58^836^20
 ;;^UTILITY(U,$J,358.3,21433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21433,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Acute
 ;;^UTILITY(U,$J,358.3,21433,1,4,0)
 ;;=4^N30.01
 ;;^UTILITY(U,$J,358.3,21433,2)
 ;;=^5015633
 ;;^UTILITY(U,$J,358.3,21434,0)
 ;;=N30.00^^58^836^22
 ;;^UTILITY(U,$J,358.3,21434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21434,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Acute
 ;;^UTILITY(U,$J,358.3,21434,1,4,0)
 ;;=4^N30.00
 ;;^UTILITY(U,$J,358.3,21434,2)
 ;;=^5015632
 ;;^UTILITY(U,$J,358.3,21435,0)
 ;;=N30.41^^58^836^21
 ;;^UTILITY(U,$J,358.3,21435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21435,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Irradiation
 ;;^UTILITY(U,$J,358.3,21435,1,4,0)
 ;;=4^N30.41
 ;;^UTILITY(U,$J,358.3,21435,2)
 ;;=^5015640
 ;;^UTILITY(U,$J,358.3,21436,0)
 ;;=N30.40^^58^836^23
 ;;^UTILITY(U,$J,358.3,21436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21436,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Irradiation
