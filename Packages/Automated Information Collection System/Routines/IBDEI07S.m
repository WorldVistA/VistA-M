IBDEI07S ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3339,2)
 ;;=^5015570
 ;;^UTILITY(U,$J,358.3,3340,0)
 ;;=N12.^^18^218^22
 ;;^UTILITY(U,$J,358.3,3340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3340,1,3,0)
 ;;=3^Nephritis,Tubulo-Interstitial,Not Specified
 ;;^UTILITY(U,$J,358.3,3340,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,3340,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,3341,0)
 ;;=N11.0^^18^218^23
 ;;^UTILITY(U,$J,358.3,3341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3341,1,3,0)
 ;;=3^Pyelonephritis,Chronic Non-obstructive Reflux-Associated
 ;;^UTILITY(U,$J,358.3,3341,1,4,0)
 ;;=4^N11.0
 ;;^UTILITY(U,$J,358.3,3341,2)
 ;;=^5015571
 ;;^UTILITY(U,$J,358.3,3342,0)
 ;;=N11.1^^18^218^24
 ;;^UTILITY(U,$J,358.3,3342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3342,1,3,0)
 ;;=3^Pyelonephritis,Chronic Obstructive
 ;;^UTILITY(U,$J,358.3,3342,1,4,0)
 ;;=4^N11.1
 ;;^UTILITY(U,$J,358.3,3342,2)
 ;;=^5015572
 ;;^UTILITY(U,$J,358.3,3343,0)
 ;;=N23.^^18^218^25
 ;;^UTILITY(U,$J,358.3,3343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3343,1,3,0)
 ;;=3^Renal Colic,Unspec
 ;;^UTILITY(U,$J,358.3,3343,1,4,0)
 ;;=4^N23.
 ;;^UTILITY(U,$J,358.3,3343,2)
 ;;=^5015615
 ;;^UTILITY(U,$J,358.3,3344,0)
 ;;=Z99.2^^18^218^26
 ;;^UTILITY(U,$J,358.3,3344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3344,1,3,0)
 ;;=3^Renal Dialysis Dependence
 ;;^UTILITY(U,$J,358.3,3344,1,4,0)
 ;;=4^Z99.2
 ;;^UTILITY(U,$J,358.3,3344,2)
 ;;=^5063758
 ;;^UTILITY(U,$J,358.3,3345,0)
 ;;=N26.9^^18^218^27
 ;;^UTILITY(U,$J,358.3,3345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3345,1,3,0)
 ;;=3^Renal Sclerosis,Unspec
 ;;^UTILITY(U,$J,358.3,3345,1,4,0)
 ;;=4^N26.9
 ;;^UTILITY(U,$J,358.3,3345,2)
 ;;=^5015622
 ;;^UTILITY(U,$J,358.3,3346,0)
 ;;=N25.9^^18^218^28
 ;;^UTILITY(U,$J,358.3,3346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3346,1,3,0)
 ;;=3^Renal Tubular Function Impaired,Disorder from,Unspec
 ;;^UTILITY(U,$J,358.3,3346,1,4,0)
 ;;=4^N25.9
 ;;^UTILITY(U,$J,358.3,3346,2)
 ;;=^5015619
 ;;^UTILITY(U,$J,358.3,3347,0)
 ;;=M89.00^^18^219^1
 ;;^UTILITY(U,$J,358.3,3347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3347,1,3,0)
 ;;=3^Algoneurodystrophy (RSD),Unspec Site
 ;;^UTILITY(U,$J,358.3,3347,1,4,0)
 ;;=4^M89.00
 ;;^UTILITY(U,$J,358.3,3347,2)
 ;;=^5014900
 ;;^UTILITY(U,$J,358.3,3348,0)
 ;;=Z89.612^^18^219^2
 ;;^UTILITY(U,$J,358.3,3348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3348,1,3,0)
 ;;=3^Amputation,Acquired Absence,Left Leg above Knee
 ;;^UTILITY(U,$J,358.3,3348,1,4,0)
 ;;=4^Z89.612
 ;;^UTILITY(U,$J,358.3,3348,2)
 ;;=^5063573
 ;;^UTILITY(U,$J,358.3,3349,0)
 ;;=Z89.512^^18^219^3
 ;;^UTILITY(U,$J,358.3,3349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3349,1,3,0)
 ;;=3^Amputation,Acquired Absence,Left Leg below Knee
 ;;^UTILITY(U,$J,358.3,3349,1,4,0)
 ;;=4^Z89.512
 ;;^UTILITY(U,$J,358.3,3349,2)
 ;;=^5063567
 ;;^UTILITY(U,$J,358.3,3350,0)
 ;;=Z89.611^^18^219^4
 ;;^UTILITY(U,$J,358.3,3350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3350,1,3,0)
 ;;=3^Amputation,Acquired Absence,Right Leg above Knee
 ;;^UTILITY(U,$J,358.3,3350,1,4,0)
 ;;=4^Z89.611
 ;;^UTILITY(U,$J,358.3,3350,2)
 ;;=^5063572
 ;;^UTILITY(U,$J,358.3,3351,0)
 ;;=Z89.511^^18^219^5
 ;;^UTILITY(U,$J,358.3,3351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3351,1,3,0)
 ;;=3^Amputation,Acquired Absence,Right Leg below Knee
 ;;^UTILITY(U,$J,358.3,3351,1,4,0)
 ;;=4^Z89.511
 ;;^UTILITY(U,$J,358.3,3351,2)
 ;;=^5063566
 ;;^UTILITY(U,$J,358.3,3352,0)
 ;;=M48.10^^18^219^6
 ;;^UTILITY(U,$J,358.3,3352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3352,1,3,0)
 ;;=3^Ankylosing Hyperostosis,Unspec Site
 ;;^UTILITY(U,$J,358.3,3352,1,4,0)
 ;;=4^M48.10
