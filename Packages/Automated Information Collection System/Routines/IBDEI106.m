IBDEI106 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16314,0)
 ;;=F52.0^^61^772^62
 ;;^UTILITY(U,$J,358.3,16314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16314,1,3,0)
 ;;=3^Hypoactive Sexual Desire Disorder
 ;;^UTILITY(U,$J,358.3,16314,1,4,0)
 ;;=4^F52.0
 ;;^UTILITY(U,$J,358.3,16314,2)
 ;;=^5003618
 ;;^UTILITY(U,$J,358.3,16315,0)
 ;;=F52.22^^61^772^105
 ;;^UTILITY(U,$J,358.3,16315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16315,1,3,0)
 ;;=3^Sexual Arousal Disorder,Female
 ;;^UTILITY(U,$J,358.3,16315,1,4,0)
 ;;=4^F52.22
 ;;^UTILITY(U,$J,358.3,16315,2)
 ;;=^5003621
 ;;^UTILITY(U,$J,358.3,16316,0)
 ;;=F52.8^^61^772^106
 ;;^UTILITY(U,$J,358.3,16316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16316,1,3,0)
 ;;=3^Sexual Dysfnct Not d/t Substance/Known Physiological Cond
 ;;^UTILITY(U,$J,358.3,16316,1,4,0)
 ;;=4^F52.8
 ;;^UTILITY(U,$J,358.3,16316,2)
 ;;=^5003624
 ;;^UTILITY(U,$J,358.3,16317,0)
 ;;=F52.21^^61^772^35
 ;;^UTILITY(U,$J,358.3,16317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16317,1,3,0)
 ;;=3^Erectile Disorder,Male (Psychogenic)
 ;;^UTILITY(U,$J,358.3,16317,1,4,0)
 ;;=4^F52.21
 ;;^UTILITY(U,$J,358.3,16317,2)
 ;;=^5003620
 ;;^UTILITY(U,$J,358.3,16318,0)
 ;;=I12.9^^61^772^61
 ;;^UTILITY(U,$J,358.3,16318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16318,1,3,0)
 ;;=3^Hypertensive Kidney Disease Chronic w/ Stg 1-4
 ;;^UTILITY(U,$J,358.3,16318,1,4,0)
 ;;=4^I12.9
 ;;^UTILITY(U,$J,358.3,16318,2)
 ;;=^5007066
 ;;^UTILITY(U,$J,358.3,16319,0)
 ;;=N04.9^^61^772^78
 ;;^UTILITY(U,$J,358.3,16319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16319,1,3,0)
 ;;=3^Nephrotic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,16319,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,16319,2)
 ;;=^5015540
 ;;^UTILITY(U,$J,358.3,16320,0)
 ;;=N02.9^^61^772^55
 ;;^UTILITY(U,$J,358.3,16320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16320,1,3,0)
 ;;=3^Hematuria w/ Unspec Morphologic Changes,Recurrent & Persistent
 ;;^UTILITY(U,$J,358.3,16320,1,4,0)
 ;;=4^N02.9
 ;;^UTILITY(U,$J,358.3,16320,2)
 ;;=^5015520
 ;;^UTILITY(U,$J,358.3,16321,0)
 ;;=N06.9^^61^772^95
 ;;^UTILITY(U,$J,358.3,16321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16321,1,3,0)
 ;;=3^Proteinuria Isolated w/ Unspec Morphologic Lesion
 ;;^UTILITY(U,$J,358.3,16321,1,4,0)
 ;;=4^N06.9
 ;;^UTILITY(U,$J,358.3,16321,2)
 ;;=^5015558
 ;;^UTILITY(U,$J,358.3,16322,0)
 ;;=N05.9^^61^772^75
 ;;^UTILITY(U,$J,358.3,16322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16322,1,3,0)
 ;;=3^Nephritic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,16322,1,4,0)
 ;;=4^N05.9
 ;;^UTILITY(U,$J,358.3,16322,2)
 ;;=^5134086
 ;;^UTILITY(U,$J,358.3,16323,0)
 ;;=N07.9^^61^772^77
 ;;^UTILITY(U,$J,358.3,16323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16323,1,3,0)
 ;;=3^Nephropathy Hereditary w/ Unspec Morphologic Lesions
 ;;^UTILITY(U,$J,358.3,16323,1,4,0)
 ;;=4^N07.9
 ;;^UTILITY(U,$J,358.3,16323,2)
 ;;=^5015568
 ;;^UTILITY(U,$J,358.3,16324,0)
 ;;=N15.9^^61^772^102
 ;;^UTILITY(U,$J,358.3,16324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16324,1,3,0)
 ;;=3^Renal Tubulo-Interstitial Disease,Unspec
 ;;^UTILITY(U,$J,358.3,16324,1,4,0)
 ;;=4^N15.9
 ;;^UTILITY(U,$J,358.3,16324,2)
 ;;=^5015596
 ;;^UTILITY(U,$J,358.3,16325,0)
 ;;=N17.9^^61^772^67
 ;;^UTILITY(U,$J,358.3,16325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16325,1,3,0)
 ;;=3^Kidney Failure,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,16325,1,4,0)
 ;;=4^N17.9
