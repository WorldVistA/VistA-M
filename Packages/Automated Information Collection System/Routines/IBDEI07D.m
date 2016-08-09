IBDEI07D ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7279,1,3,0)
 ;;=3^Hypoactive Sexual Desire Disorder
 ;;^UTILITY(U,$J,358.3,7279,1,4,0)
 ;;=4^F52.0
 ;;^UTILITY(U,$J,358.3,7279,2)
 ;;=^5003618
 ;;^UTILITY(U,$J,358.3,7280,0)
 ;;=F52.22^^42^494^99
 ;;^UTILITY(U,$J,358.3,7280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7280,1,3,0)
 ;;=3^Sexual Arousal Disorder,Female
 ;;^UTILITY(U,$J,358.3,7280,1,4,0)
 ;;=4^F52.22
 ;;^UTILITY(U,$J,358.3,7280,2)
 ;;=^5003621
 ;;^UTILITY(U,$J,358.3,7281,0)
 ;;=F52.8^^42^494^100
 ;;^UTILITY(U,$J,358.3,7281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7281,1,3,0)
 ;;=3^Sexual Dysfnct Not d/t Substance/Known Physiological Cond
 ;;^UTILITY(U,$J,358.3,7281,1,4,0)
 ;;=4^F52.8
 ;;^UTILITY(U,$J,358.3,7281,2)
 ;;=^5003624
 ;;^UTILITY(U,$J,358.3,7282,0)
 ;;=F52.21^^42^494^37
 ;;^UTILITY(U,$J,358.3,7282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7282,1,3,0)
 ;;=3^Erectile Disorder,Male (Psychogenic)
 ;;^UTILITY(U,$J,358.3,7282,1,4,0)
 ;;=4^F52.21
 ;;^UTILITY(U,$J,358.3,7282,2)
 ;;=^5003620
 ;;^UTILITY(U,$J,358.3,7283,0)
 ;;=I12.9^^42^494^59
 ;;^UTILITY(U,$J,358.3,7283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7283,1,3,0)
 ;;=3^Hypertensive Kidney Disease Chronic w/ Stg 1-4
 ;;^UTILITY(U,$J,358.3,7283,1,4,0)
 ;;=4^I12.9
 ;;^UTILITY(U,$J,358.3,7283,2)
 ;;=^5007066
 ;;^UTILITY(U,$J,358.3,7284,0)
 ;;=N04.9^^42^494^75
 ;;^UTILITY(U,$J,358.3,7284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7284,1,3,0)
 ;;=3^Nephrotic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,7284,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,7284,2)
 ;;=^5015540
 ;;^UTILITY(U,$J,358.3,7285,0)
 ;;=N02.9^^42^494^54
 ;;^UTILITY(U,$J,358.3,7285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7285,1,3,0)
 ;;=3^Hematuria w/ Unspec Morphologic Changes,Recurrent & Persistent
 ;;^UTILITY(U,$J,358.3,7285,1,4,0)
 ;;=4^N02.9
 ;;^UTILITY(U,$J,358.3,7285,2)
 ;;=^5015520
 ;;^UTILITY(U,$J,358.3,7286,0)
 ;;=N06.9^^42^494^92
 ;;^UTILITY(U,$J,358.3,7286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7286,1,3,0)
 ;;=3^Proteinuria Isolated w/ Unspec Morphologic Lesion
 ;;^UTILITY(U,$J,358.3,7286,1,4,0)
 ;;=4^N06.9
 ;;^UTILITY(U,$J,358.3,7286,2)
 ;;=^5015558
 ;;^UTILITY(U,$J,358.3,7287,0)
 ;;=N05.9^^42^494^72
 ;;^UTILITY(U,$J,358.3,7287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7287,1,3,0)
 ;;=3^Nephritic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,7287,1,4,0)
 ;;=4^N05.9
 ;;^UTILITY(U,$J,358.3,7287,2)
 ;;=^5134086
 ;;^UTILITY(U,$J,358.3,7288,0)
 ;;=N07.9^^42^494^74
 ;;^UTILITY(U,$J,358.3,7288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7288,1,3,0)
 ;;=3^Nephropathy Hereditary w/ Unspec Morphologic Lesions
 ;;^UTILITY(U,$J,358.3,7288,1,4,0)
 ;;=4^N07.9
 ;;^UTILITY(U,$J,358.3,7288,2)
 ;;=^5015568
 ;;^UTILITY(U,$J,358.3,7289,0)
 ;;=N15.9^^42^494^98
 ;;^UTILITY(U,$J,358.3,7289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7289,1,3,0)
 ;;=3^Renal Tubulo-Interstitial Disease,Unspec
 ;;^UTILITY(U,$J,358.3,7289,1,4,0)
 ;;=4^N15.9
 ;;^UTILITY(U,$J,358.3,7289,2)
 ;;=^5015596
 ;;^UTILITY(U,$J,358.3,7290,0)
 ;;=N17.9^^42^494^67
 ;;^UTILITY(U,$J,358.3,7290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7290,1,3,0)
 ;;=3^Kidney Failure,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,7290,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,7290,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,7291,0)
 ;;=N19.^^42^494^68
 ;;^UTILITY(U,$J,358.3,7291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7291,1,3,0)
 ;;=3^Kidney Failure,Unspec
 ;;^UTILITY(U,$J,358.3,7291,1,4,0)
 ;;=4^N19.
 ;;^UTILITY(U,$J,358.3,7291,2)
 ;;=^5015607
 ;;^UTILITY(U,$J,358.3,7292,0)
 ;;=N11.0^^42^494^96
 ;;^UTILITY(U,$J,358.3,7292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7292,1,3,0)
 ;;=3^Pyelonephritis,Chronic Nonobstructive Reflux-Associated
 ;;^UTILITY(U,$J,358.3,7292,1,4,0)
 ;;=4^N11.0
 ;;^UTILITY(U,$J,358.3,7292,2)
 ;;=^5015571
 ;;^UTILITY(U,$J,358.3,7293,0)
 ;;=N10.^^42^494^73
 ;;^UTILITY(U,$J,358.3,7293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7293,1,3,0)
 ;;=3^Nephritis Acute Tubulo-Interstitial
 ;;^UTILITY(U,$J,358.3,7293,1,4,0)
 ;;=4^N10.
 ;;^UTILITY(U,$J,358.3,7293,2)
 ;;=^5015570
 ;;^UTILITY(U,$J,358.3,7294,0)
 ;;=N20.2^^42^494^8
 ;;^UTILITY(U,$J,358.3,7294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7294,1,3,0)
 ;;=3^Calculus Kidney w/ Calculus Ureter
 ;;^UTILITY(U,$J,358.3,7294,1,4,0)
 ;;=4^N20.2
 ;;^UTILITY(U,$J,358.3,7294,2)
 ;;=^5015609
 ;;^UTILITY(U,$J,358.3,7295,0)
 ;;=N20.0^^42^494^7
 ;;^UTILITY(U,$J,358.3,7295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7295,1,3,0)
 ;;=3^Calculus Kidney
 ;;^UTILITY(U,$J,358.3,7295,1,4,0)
 ;;=4^N20.0
 ;;^UTILITY(U,$J,358.3,7295,2)
 ;;=^67056
 ;;^UTILITY(U,$J,358.3,7296,0)
 ;;=N29.^^42^494^66
 ;;^UTILITY(U,$J,358.3,7296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7296,1,3,0)
 ;;=3^Kidney & Ureter Disorders in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,7296,1,4,0)
 ;;=4^N29.
 ;;^UTILITY(U,$J,358.3,7296,2)
 ;;=^5015631
 ;;^UTILITY(U,$J,358.3,7297,0)
 ;;=N28.9^^42^494^65
 ;;^UTILITY(U,$J,358.3,7297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7297,1,3,0)
 ;;=3^Kidney & Ureter Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,7297,1,4,0)
 ;;=4^N28.9
 ;;^UTILITY(U,$J,358.3,7297,2)
 ;;=^5015630
 ;;^UTILITY(U,$J,358.3,7298,0)
 ;;=N30.01^^42^494^20
 ;;^UTILITY(U,$J,358.3,7298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7298,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Acute
 ;;^UTILITY(U,$J,358.3,7298,1,4,0)
 ;;=4^N30.01
 ;;^UTILITY(U,$J,358.3,7298,2)
 ;;=^5015633
 ;;^UTILITY(U,$J,358.3,7299,0)
 ;;=N30.00^^42^494^24
 ;;^UTILITY(U,$J,358.3,7299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7299,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Acute
 ;;^UTILITY(U,$J,358.3,7299,1,4,0)
 ;;=4^N30.00
 ;;^UTILITY(U,$J,358.3,7299,2)
 ;;=^5015632
 ;;^UTILITY(U,$J,358.3,7300,0)
 ;;=N30.41^^42^494^21
 ;;^UTILITY(U,$J,358.3,7300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7300,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Irradiation
 ;;^UTILITY(U,$J,358.3,7300,1,4,0)
 ;;=4^N30.41
 ;;^UTILITY(U,$J,358.3,7300,2)
 ;;=^5015640
 ;;^UTILITY(U,$J,358.3,7301,0)
 ;;=N30.40^^42^494^25
 ;;^UTILITY(U,$J,358.3,7301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7301,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Irradiation
 ;;^UTILITY(U,$J,358.3,7301,1,4,0)
 ;;=4^N30.40
 ;;^UTILITY(U,$J,358.3,7301,2)
 ;;=^5015639
 ;;^UTILITY(U,$J,358.3,7302,0)
 ;;=N32.0^^42^494^6
 ;;^UTILITY(U,$J,358.3,7302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7302,1,3,0)
 ;;=3^Bladder-Neck Obstruction
 ;;^UTILITY(U,$J,358.3,7302,1,4,0)
 ;;=4^N32.0
 ;;^UTILITY(U,$J,358.3,7302,2)
 ;;=^5015649
 ;;^UTILITY(U,$J,358.3,7303,0)
 ;;=N31.9^^42^494^76
 ;;^UTILITY(U,$J,358.3,7303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7303,1,3,0)
 ;;=3^Neurogenic Bladder Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,7303,1,4,0)
 ;;=4^N31.9
 ;;^UTILITY(U,$J,358.3,7303,2)
 ;;=^5015648
 ;;^UTILITY(U,$J,358.3,7304,0)
 ;;=N31.1^^42^494^77
 ;;^UTILITY(U,$J,358.3,7304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7304,1,3,0)
 ;;=3^Neuropathic Bladder,Reflex NEC
 ;;^UTILITY(U,$J,358.3,7304,1,4,0)
 ;;=4^N31.1
 ;;^UTILITY(U,$J,358.3,7304,2)
 ;;=^5015645
 ;;^UTILITY(U,$J,358.3,7305,0)
 ;;=N32.89^^42^494^5
 ;;^UTILITY(U,$J,358.3,7305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7305,1,3,0)
 ;;=3^Bladder Disorders,Other Spec
 ;;^UTILITY(U,$J,358.3,7305,1,4,0)
 ;;=4^N32.89
 ;;^UTILITY(U,$J,358.3,7305,2)
 ;;=^87989
 ;;^UTILITY(U,$J,358.3,7306,0)
 ;;=N33.^^42^494^4
 ;;^UTILITY(U,$J,358.3,7306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7306,1,3,0)
 ;;=3^Bladder Disorders,Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,7306,1,4,0)
 ;;=4^N33.
 ;;^UTILITY(U,$J,358.3,7306,2)
 ;;=^5015654
 ;;^UTILITY(U,$J,358.3,7307,0)
 ;;=N34.2^^42^494^105
 ;;^UTILITY(U,$J,358.3,7307,1,0)
 ;;=^358.31IA^4^2
