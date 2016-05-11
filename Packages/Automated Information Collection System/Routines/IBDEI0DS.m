IBDEI0DS ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6331,1,3,0)
 ;;=3^Hypoactive Sexual Desire Disorder
 ;;^UTILITY(U,$J,358.3,6331,1,4,0)
 ;;=4^F52.0
 ;;^UTILITY(U,$J,358.3,6331,2)
 ;;=^5003618
 ;;^UTILITY(U,$J,358.3,6332,0)
 ;;=F52.22^^30^392^99
 ;;^UTILITY(U,$J,358.3,6332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6332,1,3,0)
 ;;=3^Sexual Arousal Disorder,Female
 ;;^UTILITY(U,$J,358.3,6332,1,4,0)
 ;;=4^F52.22
 ;;^UTILITY(U,$J,358.3,6332,2)
 ;;=^5003621
 ;;^UTILITY(U,$J,358.3,6333,0)
 ;;=F52.8^^30^392^100
 ;;^UTILITY(U,$J,358.3,6333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6333,1,3,0)
 ;;=3^Sexual Dysfnct Not d/t Substance/Known Physiological Cond
 ;;^UTILITY(U,$J,358.3,6333,1,4,0)
 ;;=4^F52.8
 ;;^UTILITY(U,$J,358.3,6333,2)
 ;;=^5003624
 ;;^UTILITY(U,$J,358.3,6334,0)
 ;;=F52.21^^30^392^37
 ;;^UTILITY(U,$J,358.3,6334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6334,1,3,0)
 ;;=3^Erectile Disorder,Male (Psychogenic)
 ;;^UTILITY(U,$J,358.3,6334,1,4,0)
 ;;=4^F52.21
 ;;^UTILITY(U,$J,358.3,6334,2)
 ;;=^5003620
 ;;^UTILITY(U,$J,358.3,6335,0)
 ;;=I12.9^^30^392^59
 ;;^UTILITY(U,$J,358.3,6335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6335,1,3,0)
 ;;=3^Hypertensive Kidney Disease Chronic w/ Stg 1-4
 ;;^UTILITY(U,$J,358.3,6335,1,4,0)
 ;;=4^I12.9
 ;;^UTILITY(U,$J,358.3,6335,2)
 ;;=^5007066
 ;;^UTILITY(U,$J,358.3,6336,0)
 ;;=N04.9^^30^392^75
 ;;^UTILITY(U,$J,358.3,6336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6336,1,3,0)
 ;;=3^Nephrotic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,6336,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,6336,2)
 ;;=^5015540
 ;;^UTILITY(U,$J,358.3,6337,0)
 ;;=N02.9^^30^392^54
 ;;^UTILITY(U,$J,358.3,6337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6337,1,3,0)
 ;;=3^Hematuria w/ Unspec Morphologic Changes,Recurrent & Persistent
 ;;^UTILITY(U,$J,358.3,6337,1,4,0)
 ;;=4^N02.9
 ;;^UTILITY(U,$J,358.3,6337,2)
 ;;=^5015520
 ;;^UTILITY(U,$J,358.3,6338,0)
 ;;=N06.9^^30^392^92
 ;;^UTILITY(U,$J,358.3,6338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6338,1,3,0)
 ;;=3^Proteinuria Isolated w/ Unspec Morphologic Lesion
 ;;^UTILITY(U,$J,358.3,6338,1,4,0)
 ;;=4^N06.9
 ;;^UTILITY(U,$J,358.3,6338,2)
 ;;=^5015558
 ;;^UTILITY(U,$J,358.3,6339,0)
 ;;=N05.9^^30^392^72
 ;;^UTILITY(U,$J,358.3,6339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6339,1,3,0)
 ;;=3^Nephritic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,6339,1,4,0)
 ;;=4^N05.9
 ;;^UTILITY(U,$J,358.3,6339,2)
 ;;=^5134086
 ;;^UTILITY(U,$J,358.3,6340,0)
 ;;=N07.9^^30^392^74
 ;;^UTILITY(U,$J,358.3,6340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6340,1,3,0)
 ;;=3^Nephropathy Hereditary w/ Unspec Morphologic Lesions
 ;;^UTILITY(U,$J,358.3,6340,1,4,0)
 ;;=4^N07.9
 ;;^UTILITY(U,$J,358.3,6340,2)
 ;;=^5015568
 ;;^UTILITY(U,$J,358.3,6341,0)
 ;;=N15.9^^30^392^98
 ;;^UTILITY(U,$J,358.3,6341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6341,1,3,0)
 ;;=3^Renal Tubulo-Interstitial Disease,Unspec
 ;;^UTILITY(U,$J,358.3,6341,1,4,0)
 ;;=4^N15.9
 ;;^UTILITY(U,$J,358.3,6341,2)
 ;;=^5015596
 ;;^UTILITY(U,$J,358.3,6342,0)
 ;;=N17.9^^30^392^67
 ;;^UTILITY(U,$J,358.3,6342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6342,1,3,0)
 ;;=3^Kidney Failure,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,6342,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,6342,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,6343,0)
 ;;=N19.^^30^392^68
 ;;^UTILITY(U,$J,358.3,6343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6343,1,3,0)
 ;;=3^Kidney Failure,Unspec
 ;;^UTILITY(U,$J,358.3,6343,1,4,0)
 ;;=4^N19.
 ;;^UTILITY(U,$J,358.3,6343,2)
 ;;=^5015607
