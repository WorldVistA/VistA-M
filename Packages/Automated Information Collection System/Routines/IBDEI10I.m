IBDEI10I ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16838,1,4,0)
 ;;=4^N26.1
 ;;^UTILITY(U,$J,358.3,16838,2)
 ;;=^5015620
 ;;^UTILITY(U,$J,358.3,16839,0)
 ;;=N26.2^^88^855^17
 ;;^UTILITY(U,$J,358.3,16839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16839,1,3,0)
 ;;=3^Kidney,Page
 ;;^UTILITY(U,$J,358.3,16839,1,4,0)
 ;;=4^N26.2
 ;;^UTILITY(U,$J,358.3,16839,2)
 ;;=^5015621
 ;;^UTILITY(U,$J,358.3,16840,0)
 ;;=N27.9^^88^855^18
 ;;^UTILITY(U,$J,358.3,16840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16840,1,3,0)
 ;;=3^Kidney,Small,Unspec
 ;;^UTILITY(U,$J,358.3,16840,1,4,0)
 ;;=4^N27.9
 ;;^UTILITY(U,$J,358.3,16840,2)
 ;;=^5015625
 ;;^UTILITY(U,$J,358.3,16841,0)
 ;;=N00.9^^88^855^19
 ;;^UTILITY(U,$J,358.3,16841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16841,1,3,0)
 ;;=3^Nephritic Syndrome,Acute w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,16841,1,4,0)
 ;;=4^N00.9
 ;;^UTILITY(U,$J,358.3,16841,2)
 ;;=^5015500
 ;;^UTILITY(U,$J,358.3,16842,0)
 ;;=N11.9^^88^855^21
 ;;^UTILITY(U,$J,358.3,16842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16842,1,3,0)
 ;;=3^Nephritis,Chronic Tubulo-Interstitial,Unspec
 ;;^UTILITY(U,$J,358.3,16842,1,4,0)
 ;;=4^N11.9
 ;;^UTILITY(U,$J,358.3,16842,2)
 ;;=^5015574
 ;;^UTILITY(U,$J,358.3,16843,0)
 ;;=N10.^^88^855^20
 ;;^UTILITY(U,$J,358.3,16843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16843,1,3,0)
 ;;=3^Nephritis,Acute Tubulo-Interstitial
 ;;^UTILITY(U,$J,358.3,16843,1,4,0)
 ;;=4^N10.
 ;;^UTILITY(U,$J,358.3,16843,2)
 ;;=^5015570
 ;;^UTILITY(U,$J,358.3,16844,0)
 ;;=N12.^^88^855^22
 ;;^UTILITY(U,$J,358.3,16844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16844,1,3,0)
 ;;=3^Nephritis,Tubulo-Interstitial,Not Specified
 ;;^UTILITY(U,$J,358.3,16844,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,16844,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,16845,0)
 ;;=N11.0^^88^855^23
 ;;^UTILITY(U,$J,358.3,16845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16845,1,3,0)
 ;;=3^Pyelonephritis,Chronic Non-obstructive Reflux-Associated
 ;;^UTILITY(U,$J,358.3,16845,1,4,0)
 ;;=4^N11.0
 ;;^UTILITY(U,$J,358.3,16845,2)
 ;;=^5015571
 ;;^UTILITY(U,$J,358.3,16846,0)
 ;;=N11.1^^88^855^24
 ;;^UTILITY(U,$J,358.3,16846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16846,1,3,0)
 ;;=3^Pyelonephritis,Chronic Obstructive
 ;;^UTILITY(U,$J,358.3,16846,1,4,0)
 ;;=4^N11.1
 ;;^UTILITY(U,$J,358.3,16846,2)
 ;;=^5015572
 ;;^UTILITY(U,$J,358.3,16847,0)
 ;;=N23.^^88^855^25
 ;;^UTILITY(U,$J,358.3,16847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16847,1,3,0)
 ;;=3^Renal Colic,Unspec
 ;;^UTILITY(U,$J,358.3,16847,1,4,0)
 ;;=4^N23.
 ;;^UTILITY(U,$J,358.3,16847,2)
 ;;=^5015615
 ;;^UTILITY(U,$J,358.3,16848,0)
 ;;=Z99.2^^88^855^26
 ;;^UTILITY(U,$J,358.3,16848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16848,1,3,0)
 ;;=3^Renal Dialysis Dependence
 ;;^UTILITY(U,$J,358.3,16848,1,4,0)
 ;;=4^Z99.2
 ;;^UTILITY(U,$J,358.3,16848,2)
 ;;=^5063758
 ;;^UTILITY(U,$J,358.3,16849,0)
 ;;=N26.9^^88^855^27
 ;;^UTILITY(U,$J,358.3,16849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16849,1,3,0)
 ;;=3^Renal Sclerosis,Unspec
 ;;^UTILITY(U,$J,358.3,16849,1,4,0)
 ;;=4^N26.9
 ;;^UTILITY(U,$J,358.3,16849,2)
 ;;=^5015622
 ;;^UTILITY(U,$J,358.3,16850,0)
 ;;=N25.9^^88^855^28
 ;;^UTILITY(U,$J,358.3,16850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16850,1,3,0)
 ;;=3^Renal Tubular Function Impaired,Disorder from,Unspec
 ;;^UTILITY(U,$J,358.3,16850,1,4,0)
 ;;=4^N25.9
 ;;^UTILITY(U,$J,358.3,16850,2)
 ;;=^5015619
 ;;^UTILITY(U,$J,358.3,16851,0)
 ;;=M89.00^^88^856^1
 ;;^UTILITY(U,$J,358.3,16851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16851,1,3,0)
 ;;=3^Algoneurodystrophy (RSD),Unspec Site
