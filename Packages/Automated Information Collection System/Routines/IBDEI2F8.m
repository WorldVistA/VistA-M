IBDEI2F8 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41069,0)
 ;;=A59.03^^159^2000^96
 ;;^UTILITY(U,$J,358.3,41069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41069,1,3,0)
 ;;=3^Trichomonal Cystitis & Urethritis
 ;;^UTILITY(U,$J,358.3,41069,1,4,0)
 ;;=4^A59.03
 ;;^UTILITY(U,$J,358.3,41069,2)
 ;;=^5000349
 ;;^UTILITY(U,$J,358.3,41070,0)
 ;;=E87.6^^159^2000^57
 ;;^UTILITY(U,$J,358.3,41070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41070,1,3,0)
 ;;=3^Hypokalemia
 ;;^UTILITY(U,$J,358.3,41070,1,4,0)
 ;;=4^E87.6
 ;;^UTILITY(U,$J,358.3,41070,2)
 ;;=^60610
 ;;^UTILITY(U,$J,358.3,41071,0)
 ;;=F52.0^^159^2000^56
 ;;^UTILITY(U,$J,358.3,41071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41071,1,3,0)
 ;;=3^Hypoactive Sexual Desire Disorder
 ;;^UTILITY(U,$J,358.3,41071,1,4,0)
 ;;=4^F52.0
 ;;^UTILITY(U,$J,358.3,41071,2)
 ;;=^5003618
 ;;^UTILITY(U,$J,358.3,41072,0)
 ;;=F52.22^^159^2000^93
 ;;^UTILITY(U,$J,358.3,41072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41072,1,3,0)
 ;;=3^Sexual Arousal Disorder,Female
 ;;^UTILITY(U,$J,358.3,41072,1,4,0)
 ;;=4^F52.22
 ;;^UTILITY(U,$J,358.3,41072,2)
 ;;=^5003621
 ;;^UTILITY(U,$J,358.3,41073,0)
 ;;=F52.8^^159^2000^94
 ;;^UTILITY(U,$J,358.3,41073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41073,1,3,0)
 ;;=3^Sexual Dysfnct Not d/t Substance/Known Physiological Cond
 ;;^UTILITY(U,$J,358.3,41073,1,4,0)
 ;;=4^F52.8
 ;;^UTILITY(U,$J,358.3,41073,2)
 ;;=^5003624
 ;;^UTILITY(U,$J,358.3,41074,0)
 ;;=F52.21^^159^2000^33
 ;;^UTILITY(U,$J,358.3,41074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41074,1,3,0)
 ;;=3^Erectile Disorder,Male (Psychogenic)
 ;;^UTILITY(U,$J,358.3,41074,1,4,0)
 ;;=4^F52.21
 ;;^UTILITY(U,$J,358.3,41074,2)
 ;;=^5003620
 ;;^UTILITY(U,$J,358.3,41075,0)
 ;;=I12.9^^159^2000^55
 ;;^UTILITY(U,$J,358.3,41075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41075,1,3,0)
 ;;=3^Hypertensive Kidney Disease Chronic w/ Stg 1-4
 ;;^UTILITY(U,$J,358.3,41075,1,4,0)
 ;;=4^I12.9
 ;;^UTILITY(U,$J,358.3,41075,2)
 ;;=^5007066
 ;;^UTILITY(U,$J,358.3,41076,0)
 ;;=N04.9^^159^2000^69
 ;;^UTILITY(U,$J,358.3,41076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41076,1,3,0)
 ;;=3^Nephrotic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,41076,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,41076,2)
 ;;=^5015540
 ;;^UTILITY(U,$J,358.3,41077,0)
 ;;=N02.9^^159^2000^50
 ;;^UTILITY(U,$J,358.3,41077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41077,1,3,0)
 ;;=3^Hematuria w/ Unspec Morphologic Changes,Recurrent & Persistent
 ;;^UTILITY(U,$J,358.3,41077,1,4,0)
 ;;=4^N02.9
 ;;^UTILITY(U,$J,358.3,41077,2)
 ;;=^5015520
 ;;^UTILITY(U,$J,358.3,41078,0)
 ;;=N06.9^^159^2000^86
 ;;^UTILITY(U,$J,358.3,41078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41078,1,3,0)
 ;;=3^Proteinuria Isolated w/ Unspec Morphologic Lesion
 ;;^UTILITY(U,$J,358.3,41078,1,4,0)
 ;;=4^N06.9
 ;;^UTILITY(U,$J,358.3,41078,2)
 ;;=^5015558
 ;;^UTILITY(U,$J,358.3,41079,0)
 ;;=N05.9^^159^2000^66
 ;;^UTILITY(U,$J,358.3,41079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41079,1,3,0)
 ;;=3^Nephritic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,41079,1,4,0)
 ;;=4^N05.9
 ;;^UTILITY(U,$J,358.3,41079,2)
 ;;=^5134086
 ;;^UTILITY(U,$J,358.3,41080,0)
 ;;=N07.9^^159^2000^68
 ;;^UTILITY(U,$J,358.3,41080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41080,1,3,0)
 ;;=3^Nephropathy Hereditary w/ Unspec Morphologic Lesions
 ;;^UTILITY(U,$J,358.3,41080,1,4,0)
 ;;=4^N07.9
 ;;^UTILITY(U,$J,358.3,41080,2)
 ;;=^5015568
 ;;^UTILITY(U,$J,358.3,41081,0)
 ;;=N15.9^^159^2000^92
 ;;^UTILITY(U,$J,358.3,41081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41081,1,3,0)
 ;;=3^Renal Tubulo-Interstitial Disease,Unspec
