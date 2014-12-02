IBDEI0VR ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15707,2)
 ;;=Cluster Headach^294062
 ;;^UTILITY(U,$J,358.3,15708,0)
 ;;=346.90^^98^963^3
 ;;^UTILITY(U,$J,358.3,15708,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15708,1,2,0)
 ;;=2^346.90
 ;;^UTILITY(U,$J,358.3,15708,1,3,0)
 ;;=3^Migraine Headaches
 ;;^UTILITY(U,$J,358.3,15708,2)
 ;;=Migraine Headache^293880
 ;;^UTILITY(U,$J,358.3,15709,0)
 ;;=307.81^^98^963^4
 ;;^UTILITY(U,$J,358.3,15709,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15709,1,2,0)
 ;;=2^307.81
 ;;^UTILITY(U,$J,358.3,15709,1,3,0)
 ;;=3^Tension Headache
 ;;^UTILITY(U,$J,358.3,15709,2)
 ;;=Tension Headache^100405
 ;;^UTILITY(U,$J,358.3,15710,0)
 ;;=784.0^^98^963^2
 ;;^UTILITY(U,$J,358.3,15710,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15710,1,2,0)
 ;;=2^784.0
 ;;^UTILITY(U,$J,358.3,15710,1,3,0)
 ;;=3^Headache, Unspecified
 ;;^UTILITY(U,$J,358.3,15710,2)
 ;;=Headache, Unspecified^54133
 ;;^UTILITY(U,$J,358.3,15711,0)
 ;;=780.4^^98^964^3
 ;;^UTILITY(U,$J,358.3,15711,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15711,1,2,0)
 ;;=2^780.4
 ;;^UTILITY(U,$J,358.3,15711,1,3,0)
 ;;=3^Dizziness/Vertigo
 ;;^UTILITY(U,$J,358.3,15711,2)
 ;;=Dizziness/Vertigo^35946
 ;;^UTILITY(U,$J,358.3,15712,0)
 ;;=386.11^^98^964^1
 ;;^UTILITY(U,$J,358.3,15712,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15712,1,2,0)
 ;;=2^386.11
 ;;^UTILITY(U,$J,358.3,15712,1,3,0)
 ;;=3^Benign Positional Vert
 ;;^UTILITY(U,$J,358.3,15712,2)
 ;;=Benign Paroxysmal Vertigo^269480
 ;;^UTILITY(U,$J,358.3,15713,0)
 ;;=386.2^^98^964^2
 ;;^UTILITY(U,$J,358.3,15713,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15713,1,2,0)
 ;;=2^386.2
 ;;^UTILITY(U,$J,358.3,15713,1,3,0)
 ;;=3^Central Vertigo
 ;;^UTILITY(U,$J,358.3,15713,2)
 ;;=Central Vertigo^269484
 ;;^UTILITY(U,$J,358.3,15714,0)
 ;;=780.2^^98^964^4
 ;;^UTILITY(U,$J,358.3,15714,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15714,1,2,0)
 ;;=2^780.2
 ;;^UTILITY(U,$J,358.3,15714,1,3,0)
 ;;=3^Syncope
 ;;^UTILITY(U,$J,358.3,15714,2)
 ;;=Syncope^116707
 ;;^UTILITY(U,$J,358.3,15715,0)
 ;;=331.0^^98^965^1
 ;;^UTILITY(U,$J,358.3,15715,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15715,1,2,0)
 ;;=2^331.0
 ;;^UTILITY(U,$J,358.3,15715,1,3,0)
 ;;=3^Alzheimer's
 ;;^UTILITY(U,$J,358.3,15715,2)
 ;;=Alzheimers^5679^294.10
 ;;^UTILITY(U,$J,358.3,15716,0)
 ;;=333.4^^98^965^4
 ;;^UTILITY(U,$J,358.3,15716,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15716,1,2,0)
 ;;=2^333.4
 ;;^UTILITY(U,$J,358.3,15716,1,3,0)
 ;;=3^Huntington's Disease
 ;;^UTILITY(U,$J,358.3,15716,2)
 ;;=Huntington's Disease^59370
 ;;^UTILITY(U,$J,358.3,15717,0)
 ;;=340.^^98^965^5
 ;;^UTILITY(U,$J,358.3,15717,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15717,1,2,0)
 ;;=2^340.
 ;;^UTILITY(U,$J,358.3,15717,1,3,0)
 ;;=3^Multiple Sclerosis
 ;;^UTILITY(U,$J,358.3,15717,2)
 ;;=Multiple Sclerosis^79761
 ;;^UTILITY(U,$J,358.3,15718,0)
 ;;=335.24^^98^965^7
 ;;^UTILITY(U,$J,358.3,15718,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15718,1,2,0)
 ;;=2^335.24
 ;;^UTILITY(U,$J,358.3,15718,1,3,0)
 ;;=3^Primary Lateral Sclerosis
 ;;^UTILITY(U,$J,358.3,15718,2)
 ;;=Primary Lateral Sclerosis^268422
 ;;^UTILITY(U,$J,358.3,15719,0)
 ;;=334.8^^98^965^8
 ;;^UTILITY(U,$J,358.3,15719,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15719,1,2,0)
 ;;=2^334.8
 ;;^UTILITY(U,$J,358.3,15719,1,3,0)
 ;;=3^Spinocerebellar Disease
 ;;^UTILITY(U,$J,358.3,15719,2)
 ;;=Spinocerebellar Disease^88188
 ;;^UTILITY(U,$J,358.3,15720,0)
 ;;=336.0^^98^965^9
 ;;^UTILITY(U,$J,358.3,15720,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15720,1,2,0)
 ;;=2^336.0
 ;;^UTILITY(U,$J,358.3,15720,1,3,0)
 ;;=3^Syringomyelia
