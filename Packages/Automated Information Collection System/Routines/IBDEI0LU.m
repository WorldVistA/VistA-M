IBDEI0LU ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22024,0)
 ;;=A59.03^^89^1042^96
 ;;^UTILITY(U,$J,358.3,22024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22024,1,3,0)
 ;;=3^Trichomonal Cystitis & Urethritis
 ;;^UTILITY(U,$J,358.3,22024,1,4,0)
 ;;=4^A59.03
 ;;^UTILITY(U,$J,358.3,22024,2)
 ;;=^5000349
 ;;^UTILITY(U,$J,358.3,22025,0)
 ;;=E87.6^^89^1042^57
 ;;^UTILITY(U,$J,358.3,22025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22025,1,3,0)
 ;;=3^Hypokalemia
 ;;^UTILITY(U,$J,358.3,22025,1,4,0)
 ;;=4^E87.6
 ;;^UTILITY(U,$J,358.3,22025,2)
 ;;=^60610
 ;;^UTILITY(U,$J,358.3,22026,0)
 ;;=F52.0^^89^1042^56
 ;;^UTILITY(U,$J,358.3,22026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22026,1,3,0)
 ;;=3^Hypoactive Sexual Desire Disorder
 ;;^UTILITY(U,$J,358.3,22026,1,4,0)
 ;;=4^F52.0
 ;;^UTILITY(U,$J,358.3,22026,2)
 ;;=^5003618
 ;;^UTILITY(U,$J,358.3,22027,0)
 ;;=F52.22^^89^1042^93
 ;;^UTILITY(U,$J,358.3,22027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22027,1,3,0)
 ;;=3^Sexual Arousal Disorder,Female
 ;;^UTILITY(U,$J,358.3,22027,1,4,0)
 ;;=4^F52.22
 ;;^UTILITY(U,$J,358.3,22027,2)
 ;;=^5003621
 ;;^UTILITY(U,$J,358.3,22028,0)
 ;;=F52.8^^89^1042^94
 ;;^UTILITY(U,$J,358.3,22028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22028,1,3,0)
 ;;=3^Sexual Dysfnct Not d/t Substance/Known Physiological Cond
 ;;^UTILITY(U,$J,358.3,22028,1,4,0)
 ;;=4^F52.8
 ;;^UTILITY(U,$J,358.3,22028,2)
 ;;=^5003624
 ;;^UTILITY(U,$J,358.3,22029,0)
 ;;=F52.21^^89^1042^33
 ;;^UTILITY(U,$J,358.3,22029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22029,1,3,0)
 ;;=3^Erectile Disorder,Male (Psychogenic)
 ;;^UTILITY(U,$J,358.3,22029,1,4,0)
 ;;=4^F52.21
 ;;^UTILITY(U,$J,358.3,22029,2)
 ;;=^5003620
 ;;^UTILITY(U,$J,358.3,22030,0)
 ;;=I12.9^^89^1042^55
 ;;^UTILITY(U,$J,358.3,22030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22030,1,3,0)
 ;;=3^Hypertensive Kidney Disease Chronic w/ Stg 1-4
 ;;^UTILITY(U,$J,358.3,22030,1,4,0)
 ;;=4^I12.9
 ;;^UTILITY(U,$J,358.3,22030,2)
 ;;=^5007066
 ;;^UTILITY(U,$J,358.3,22031,0)
 ;;=N04.9^^89^1042^69
 ;;^UTILITY(U,$J,358.3,22031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22031,1,3,0)
 ;;=3^Nephrotic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,22031,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,22031,2)
 ;;=^5015540
 ;;^UTILITY(U,$J,358.3,22032,0)
 ;;=N02.9^^89^1042^50
 ;;^UTILITY(U,$J,358.3,22032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22032,1,3,0)
 ;;=3^Hematuria w/ Unspec Morphologic Changes,Recurrent & Persistent
 ;;^UTILITY(U,$J,358.3,22032,1,4,0)
 ;;=4^N02.9
 ;;^UTILITY(U,$J,358.3,22032,2)
 ;;=^5015520
 ;;^UTILITY(U,$J,358.3,22033,0)
 ;;=N06.9^^89^1042^86
 ;;^UTILITY(U,$J,358.3,22033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22033,1,3,0)
 ;;=3^Proteinuria Isolated w/ Unspec Morphologic Lesion
 ;;^UTILITY(U,$J,358.3,22033,1,4,0)
 ;;=4^N06.9
 ;;^UTILITY(U,$J,358.3,22033,2)
 ;;=^5015558
 ;;^UTILITY(U,$J,358.3,22034,0)
 ;;=N05.9^^89^1042^66
 ;;^UTILITY(U,$J,358.3,22034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22034,1,3,0)
 ;;=3^Nephritic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,22034,1,4,0)
 ;;=4^N05.9
 ;;^UTILITY(U,$J,358.3,22034,2)
 ;;=^5134086
 ;;^UTILITY(U,$J,358.3,22035,0)
 ;;=N07.9^^89^1042^68
 ;;^UTILITY(U,$J,358.3,22035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22035,1,3,0)
 ;;=3^Nephropathy Hereditary w/ Unspec Morphologic Lesions
 ;;^UTILITY(U,$J,358.3,22035,1,4,0)
 ;;=4^N07.9
 ;;^UTILITY(U,$J,358.3,22035,2)
 ;;=^5015568
 ;;^UTILITY(U,$J,358.3,22036,0)
 ;;=N15.9^^89^1042^92
 ;;^UTILITY(U,$J,358.3,22036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22036,1,3,0)
 ;;=3^Renal Tubulo-Interstitial Disease,Unspec
 ;;^UTILITY(U,$J,358.3,22036,1,4,0)
 ;;=4^N15.9
 ;;^UTILITY(U,$J,358.3,22036,2)
 ;;=^5015596
 ;;^UTILITY(U,$J,358.3,22037,0)
 ;;=N17.9^^89^1042^61
 ;;^UTILITY(U,$J,358.3,22037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22037,1,3,0)
 ;;=3^Kidney Failure,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,22037,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,22037,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,22038,0)
 ;;=N19.^^89^1042^62
 ;;^UTILITY(U,$J,358.3,22038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22038,1,3,0)
 ;;=3^Kidney Failure,Unspec
 ;;^UTILITY(U,$J,358.3,22038,1,4,0)
 ;;=4^N19.
 ;;^UTILITY(U,$J,358.3,22038,2)
 ;;=^5015607
 ;;^UTILITY(U,$J,358.3,22039,0)
 ;;=N11.0^^89^1042^90
 ;;^UTILITY(U,$J,358.3,22039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22039,1,3,0)
 ;;=3^Pyelonephritis,Chronic Nonobstructive Reflux-Associated
 ;;^UTILITY(U,$J,358.3,22039,1,4,0)
 ;;=4^N11.0
 ;;^UTILITY(U,$J,358.3,22039,2)
 ;;=^5015571
 ;;^UTILITY(U,$J,358.3,22040,0)
 ;;=N10.^^89^1042^67
 ;;^UTILITY(U,$J,358.3,22040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22040,1,3,0)
 ;;=3^Nephritis Acute Tubulo-Interstitial
 ;;^UTILITY(U,$J,358.3,22040,1,4,0)
 ;;=4^N10.
 ;;^UTILITY(U,$J,358.3,22040,2)
 ;;=^5015570
 ;;^UTILITY(U,$J,358.3,22041,0)
 ;;=N20.2^^89^1042^8
 ;;^UTILITY(U,$J,358.3,22041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22041,1,3,0)
 ;;=3^Calculus Kidney w/ Calculus Ureter
 ;;^UTILITY(U,$J,358.3,22041,1,4,0)
 ;;=4^N20.2
 ;;^UTILITY(U,$J,358.3,22041,2)
 ;;=^5015609
 ;;^UTILITY(U,$J,358.3,22042,0)
 ;;=N20.0^^89^1042^7
 ;;^UTILITY(U,$J,358.3,22042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22042,1,3,0)
 ;;=3^Calculus Kidney
 ;;^UTILITY(U,$J,358.3,22042,1,4,0)
 ;;=4^N20.0
 ;;^UTILITY(U,$J,358.3,22042,2)
 ;;=^67056
 ;;^UTILITY(U,$J,358.3,22043,0)
 ;;=N29.^^89^1042^60
 ;;^UTILITY(U,$J,358.3,22043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22043,1,3,0)
 ;;=3^Kidney & Ureter Disorders in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,22043,1,4,0)
 ;;=4^N29.
 ;;^UTILITY(U,$J,358.3,22043,2)
 ;;=^5015631
 ;;^UTILITY(U,$J,358.3,22044,0)
 ;;=N28.9^^89^1042^59
 ;;^UTILITY(U,$J,358.3,22044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22044,1,3,0)
 ;;=3^Kidney & Ureter Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,22044,1,4,0)
 ;;=4^N28.9
 ;;^UTILITY(U,$J,358.3,22044,2)
 ;;=^5015630
 ;;^UTILITY(U,$J,358.3,22045,0)
 ;;=N30.01^^89^1042^20
 ;;^UTILITY(U,$J,358.3,22045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22045,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Acute
 ;;^UTILITY(U,$J,358.3,22045,1,4,0)
 ;;=4^N30.01
 ;;^UTILITY(U,$J,358.3,22045,2)
 ;;=^5015633
 ;;^UTILITY(U,$J,358.3,22046,0)
 ;;=N30.00^^89^1042^22
 ;;^UTILITY(U,$J,358.3,22046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22046,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Acute
 ;;^UTILITY(U,$J,358.3,22046,1,4,0)
 ;;=4^N30.00
 ;;^UTILITY(U,$J,358.3,22046,2)
 ;;=^5015632
 ;;^UTILITY(U,$J,358.3,22047,0)
 ;;=N30.41^^89^1042^21
 ;;^UTILITY(U,$J,358.3,22047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22047,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Irradiation
 ;;^UTILITY(U,$J,358.3,22047,1,4,0)
 ;;=4^N30.41
 ;;^UTILITY(U,$J,358.3,22047,2)
 ;;=^5015640
 ;;^UTILITY(U,$J,358.3,22048,0)
 ;;=N30.40^^89^1042^23
 ;;^UTILITY(U,$J,358.3,22048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22048,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Irradiation
 ;;^UTILITY(U,$J,358.3,22048,1,4,0)
 ;;=4^N30.40
 ;;^UTILITY(U,$J,358.3,22048,2)
 ;;=^5015639
 ;;^UTILITY(U,$J,358.3,22049,0)
 ;;=N32.0^^89^1042^6
 ;;^UTILITY(U,$J,358.3,22049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22049,1,3,0)
 ;;=3^Bladder-Neck Obstruction
 ;;^UTILITY(U,$J,358.3,22049,1,4,0)
 ;;=4^N32.0
 ;;^UTILITY(U,$J,358.3,22049,2)
 ;;=^5015649
 ;;^UTILITY(U,$J,358.3,22050,0)
 ;;=N31.9^^89^1042^70
 ;;^UTILITY(U,$J,358.3,22050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22050,1,3,0)
 ;;=3^Neurogenic Bladder Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,22050,1,4,0)
 ;;=4^N31.9
 ;;^UTILITY(U,$J,358.3,22050,2)
 ;;=^5015648
 ;;^UTILITY(U,$J,358.3,22051,0)
 ;;=N31.1^^89^1042^71
 ;;^UTILITY(U,$J,358.3,22051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22051,1,3,0)
 ;;=3^Neuropathic Bladder,Reflex NEC
