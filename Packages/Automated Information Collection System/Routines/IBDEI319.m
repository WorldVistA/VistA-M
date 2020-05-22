IBDEI319 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,48431,1,3,0)
 ;;=3^Kidney,Page
 ;;^UTILITY(U,$J,358.3,48431,1,4,0)
 ;;=4^N26.2
 ;;^UTILITY(U,$J,358.3,48431,2)
 ;;=^5015621
 ;;^UTILITY(U,$J,358.3,48432,0)
 ;;=N27.9^^185^2422^18
 ;;^UTILITY(U,$J,358.3,48432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48432,1,3,0)
 ;;=3^Kidney,Small,Unspec
 ;;^UTILITY(U,$J,358.3,48432,1,4,0)
 ;;=4^N27.9
 ;;^UTILITY(U,$J,358.3,48432,2)
 ;;=^5015625
 ;;^UTILITY(U,$J,358.3,48433,0)
 ;;=N00.9^^185^2422^19
 ;;^UTILITY(U,$J,358.3,48433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48433,1,3,0)
 ;;=3^Nephritic Syndrome,Acute w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,48433,1,4,0)
 ;;=4^N00.9
 ;;^UTILITY(U,$J,358.3,48433,2)
 ;;=^5015500
 ;;^UTILITY(U,$J,358.3,48434,0)
 ;;=N11.9^^185^2422^21
 ;;^UTILITY(U,$J,358.3,48434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48434,1,3,0)
 ;;=3^Nephritis,Chronic Tubulo-Interstitial,Unspec
 ;;^UTILITY(U,$J,358.3,48434,1,4,0)
 ;;=4^N11.9
 ;;^UTILITY(U,$J,358.3,48434,2)
 ;;=^5015574
 ;;^UTILITY(U,$J,358.3,48435,0)
 ;;=N10.^^185^2422^20
 ;;^UTILITY(U,$J,358.3,48435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48435,1,3,0)
 ;;=3^Nephritis,Acute Tubulo-Interstitial
 ;;^UTILITY(U,$J,358.3,48435,1,4,0)
 ;;=4^N10.
 ;;^UTILITY(U,$J,358.3,48435,2)
 ;;=^5015570
 ;;^UTILITY(U,$J,358.3,48436,0)
 ;;=N12.^^185^2422^22
 ;;^UTILITY(U,$J,358.3,48436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48436,1,3,0)
 ;;=3^Nephritis,Tubulo-Interstitial,Not Specified
 ;;^UTILITY(U,$J,358.3,48436,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,48436,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,48437,0)
 ;;=N11.0^^185^2422^23
 ;;^UTILITY(U,$J,358.3,48437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48437,1,3,0)
 ;;=3^Pyelonephritis,Chronic Non-obstructive Reflux-Associated
 ;;^UTILITY(U,$J,358.3,48437,1,4,0)
 ;;=4^N11.0
 ;;^UTILITY(U,$J,358.3,48437,2)
 ;;=^5015571
 ;;^UTILITY(U,$J,358.3,48438,0)
 ;;=N11.1^^185^2422^24
 ;;^UTILITY(U,$J,358.3,48438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48438,1,3,0)
 ;;=3^Pyelonephritis,Chronic Obstructive
 ;;^UTILITY(U,$J,358.3,48438,1,4,0)
 ;;=4^N11.1
 ;;^UTILITY(U,$J,358.3,48438,2)
 ;;=^5015572
 ;;^UTILITY(U,$J,358.3,48439,0)
 ;;=N23.^^185^2422^25
 ;;^UTILITY(U,$J,358.3,48439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48439,1,3,0)
 ;;=3^Renal Colic,Unspec
 ;;^UTILITY(U,$J,358.3,48439,1,4,0)
 ;;=4^N23.
 ;;^UTILITY(U,$J,358.3,48439,2)
 ;;=^5015615
 ;;^UTILITY(U,$J,358.3,48440,0)
 ;;=Z99.2^^185^2422^26
 ;;^UTILITY(U,$J,358.3,48440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48440,1,3,0)
 ;;=3^Renal Dialysis Dependence
 ;;^UTILITY(U,$J,358.3,48440,1,4,0)
 ;;=4^Z99.2
 ;;^UTILITY(U,$J,358.3,48440,2)
 ;;=^5063758
 ;;^UTILITY(U,$J,358.3,48441,0)
 ;;=N26.9^^185^2422^27
 ;;^UTILITY(U,$J,358.3,48441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48441,1,3,0)
 ;;=3^Renal Sclerosis,Unspec
 ;;^UTILITY(U,$J,358.3,48441,1,4,0)
 ;;=4^N26.9
 ;;^UTILITY(U,$J,358.3,48441,2)
 ;;=^5015622
 ;;^UTILITY(U,$J,358.3,48442,0)
 ;;=N25.9^^185^2422^28
 ;;^UTILITY(U,$J,358.3,48442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48442,1,3,0)
 ;;=3^Renal Tubular Function Impaired,Disorder from,Unspec
 ;;^UTILITY(U,$J,358.3,48442,1,4,0)
 ;;=4^N25.9
 ;;^UTILITY(U,$J,358.3,48442,2)
 ;;=^5015619
 ;;^UTILITY(U,$J,358.3,48443,0)
 ;;=M89.00^^185^2423^1
 ;;^UTILITY(U,$J,358.3,48443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48443,1,3,0)
 ;;=3^Algoneurodystrophy (RSD),Unspec Site
