IBDEI1ED ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23317,0)
 ;;=Z89.512^^113^1118^3
 ;;^UTILITY(U,$J,358.3,23317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23317,1,3,0)
 ;;=3^Acquired Absence Left Leg Below Knee
 ;;^UTILITY(U,$J,358.3,23317,1,4,0)
 ;;=4^Z89.512
 ;;^UTILITY(U,$J,358.3,23317,2)
 ;;=^5063567
 ;;^UTILITY(U,$J,358.3,23318,0)
 ;;=Z89.511^^113^1118^4
 ;;^UTILITY(U,$J,358.3,23318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23318,1,3,0)
 ;;=3^Acquired Absence Right Leg Below Knee
 ;;^UTILITY(U,$J,358.3,23318,1,4,0)
 ;;=4^Z89.511
 ;;^UTILITY(U,$J,358.3,23318,2)
 ;;=^5063566
 ;;^UTILITY(U,$J,358.3,23319,0)
 ;;=F43.20^^113^1119^4
 ;;^UTILITY(U,$J,358.3,23319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23319,1,3,0)
 ;;=3^Adjustment disorder, unspec
 ;;^UTILITY(U,$J,358.3,23319,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,23319,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,23320,0)
 ;;=F43.21^^113^1119^3
 ;;^UTILITY(U,$J,358.3,23320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23320,1,3,0)
 ;;=3^Adjustment disorder w/ depressed mood
 ;;^UTILITY(U,$J,358.3,23320,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,23320,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,23321,0)
 ;;=F43.22^^113^1119^1
 ;;^UTILITY(U,$J,358.3,23321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23321,1,3,0)
 ;;=3^Adjustment Disorder w/ Anxiety
 ;;^UTILITY(U,$J,358.3,23321,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,23321,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,23322,0)
 ;;=F43.23^^113^1119^2
 ;;^UTILITY(U,$J,358.3,23322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23322,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety and Depressed Mood
 ;;^UTILITY(U,$J,358.3,23322,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,23322,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,23323,0)
 ;;=F41.9^^113^1120^4
 ;;^UTILITY(U,$J,358.3,23323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23323,1,3,0)
 ;;=3^Anxiety disorder, unspec
 ;;^UTILITY(U,$J,358.3,23323,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,23323,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,23324,0)
 ;;=F41.0^^113^1120^6
 ;;^UTILITY(U,$J,358.3,23324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23324,1,3,0)
 ;;=3^Panic disorder w/o agoraphobia [episodic paroxysmal anxiety]
 ;;^UTILITY(U,$J,358.3,23324,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,23324,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,23325,0)
 ;;=F41.1^^113^1120^3
 ;;^UTILITY(U,$J,358.3,23325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23325,1,3,0)
 ;;=3^Anxiety disorder, generalized
 ;;^UTILITY(U,$J,358.3,23325,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,23325,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,23326,0)
 ;;=F40.01^^113^1120^1
 ;;^UTILITY(U,$J,358.3,23326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23326,1,3,0)
 ;;=3^Agoraphobia w/ panic disorder
 ;;^UTILITY(U,$J,358.3,23326,1,4,0)
 ;;=4^F40.01
 ;;^UTILITY(U,$J,358.3,23326,2)
 ;;=^331911
 ;;^UTILITY(U,$J,358.3,23327,0)
 ;;=F40.02^^113^1120^2
 ;;^UTILITY(U,$J,358.3,23327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23327,1,3,0)
 ;;=3^Agoraphobia w/o panic disorder
 ;;^UTILITY(U,$J,358.3,23327,1,4,0)
 ;;=4^F40.02
 ;;^UTILITY(U,$J,358.3,23327,2)
 ;;=^5003543
 ;;^UTILITY(U,$J,358.3,23328,0)
 ;;=F42.^^113^1120^5
 ;;^UTILITY(U,$J,358.3,23328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23328,1,3,0)
 ;;=3^Obsessive-compulsive disorder
 ;;^UTILITY(U,$J,358.3,23328,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,23328,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,23329,0)
 ;;=F43.10^^113^1120^8
 ;;^UTILITY(U,$J,358.3,23329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23329,1,3,0)
 ;;=3^Post-traumatic stress disorder, unspec
 ;;^UTILITY(U,$J,358.3,23329,1,4,0)
 ;;=4^F43.10
