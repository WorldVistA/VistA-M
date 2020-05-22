IBDEI0VF ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13990,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,13991,0)
 ;;=N11.0^^83^820^23
 ;;^UTILITY(U,$J,358.3,13991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13991,1,3,0)
 ;;=3^Pyelonephritis,Chronic Non-obstructive Reflux-Associated
 ;;^UTILITY(U,$J,358.3,13991,1,4,0)
 ;;=4^N11.0
 ;;^UTILITY(U,$J,358.3,13991,2)
 ;;=^5015571
 ;;^UTILITY(U,$J,358.3,13992,0)
 ;;=N11.1^^83^820^24
 ;;^UTILITY(U,$J,358.3,13992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13992,1,3,0)
 ;;=3^Pyelonephritis,Chronic Obstructive
 ;;^UTILITY(U,$J,358.3,13992,1,4,0)
 ;;=4^N11.1
 ;;^UTILITY(U,$J,358.3,13992,2)
 ;;=^5015572
 ;;^UTILITY(U,$J,358.3,13993,0)
 ;;=N23.^^83^820^25
 ;;^UTILITY(U,$J,358.3,13993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13993,1,3,0)
 ;;=3^Renal Colic,Unspec
 ;;^UTILITY(U,$J,358.3,13993,1,4,0)
 ;;=4^N23.
 ;;^UTILITY(U,$J,358.3,13993,2)
 ;;=^5015615
 ;;^UTILITY(U,$J,358.3,13994,0)
 ;;=Z99.2^^83^820^26
 ;;^UTILITY(U,$J,358.3,13994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13994,1,3,0)
 ;;=3^Renal Dialysis Dependence
 ;;^UTILITY(U,$J,358.3,13994,1,4,0)
 ;;=4^Z99.2
 ;;^UTILITY(U,$J,358.3,13994,2)
 ;;=^5063758
 ;;^UTILITY(U,$J,358.3,13995,0)
 ;;=N26.9^^83^820^27
 ;;^UTILITY(U,$J,358.3,13995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13995,1,3,0)
 ;;=3^Renal Sclerosis,Unspec
 ;;^UTILITY(U,$J,358.3,13995,1,4,0)
 ;;=4^N26.9
 ;;^UTILITY(U,$J,358.3,13995,2)
 ;;=^5015622
 ;;^UTILITY(U,$J,358.3,13996,0)
 ;;=N25.9^^83^820^28
 ;;^UTILITY(U,$J,358.3,13996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13996,1,3,0)
 ;;=3^Renal Tubular Function Impaired,Disorder from,Unspec
 ;;^UTILITY(U,$J,358.3,13996,1,4,0)
 ;;=4^N25.9
 ;;^UTILITY(U,$J,358.3,13996,2)
 ;;=^5015619
 ;;^UTILITY(U,$J,358.3,13997,0)
 ;;=M89.00^^83^821^1
 ;;^UTILITY(U,$J,358.3,13997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13997,1,3,0)
 ;;=3^Algoneurodystrophy (RSD),Unspec Site
 ;;^UTILITY(U,$J,358.3,13997,1,4,0)
 ;;=4^M89.00
 ;;^UTILITY(U,$J,358.3,13997,2)
 ;;=^5014900
 ;;^UTILITY(U,$J,358.3,13998,0)
 ;;=Z89.612^^83^821^2
 ;;^UTILITY(U,$J,358.3,13998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13998,1,3,0)
 ;;=3^Amputation,Acquired Absence,Left Leg above Knee
 ;;^UTILITY(U,$J,358.3,13998,1,4,0)
 ;;=4^Z89.612
 ;;^UTILITY(U,$J,358.3,13998,2)
 ;;=^5063573
 ;;^UTILITY(U,$J,358.3,13999,0)
 ;;=Z89.512^^83^821^3
 ;;^UTILITY(U,$J,358.3,13999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13999,1,3,0)
 ;;=3^Amputation,Acquired Absence,Left Leg below Knee
 ;;^UTILITY(U,$J,358.3,13999,1,4,0)
 ;;=4^Z89.512
 ;;^UTILITY(U,$J,358.3,13999,2)
 ;;=^5063567
 ;;^UTILITY(U,$J,358.3,14000,0)
 ;;=Z89.611^^83^821^4
 ;;^UTILITY(U,$J,358.3,14000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14000,1,3,0)
 ;;=3^Amputation,Acquired Absence,Right Leg above Knee
 ;;^UTILITY(U,$J,358.3,14000,1,4,0)
 ;;=4^Z89.611
 ;;^UTILITY(U,$J,358.3,14000,2)
 ;;=^5063572
 ;;^UTILITY(U,$J,358.3,14001,0)
 ;;=Z89.511^^83^821^5
 ;;^UTILITY(U,$J,358.3,14001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14001,1,3,0)
 ;;=3^Amputation,Acquired Absence,Right Leg below Knee
 ;;^UTILITY(U,$J,358.3,14001,1,4,0)
 ;;=4^Z89.511
 ;;^UTILITY(U,$J,358.3,14001,2)
 ;;=^5063566
 ;;^UTILITY(U,$J,358.3,14002,0)
 ;;=M48.10^^83^821^6
 ;;^UTILITY(U,$J,358.3,14002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14002,1,3,0)
 ;;=3^Ankylosing Hyperostosis,Unspec Site
 ;;^UTILITY(U,$J,358.3,14002,1,4,0)
 ;;=4^M48.10
