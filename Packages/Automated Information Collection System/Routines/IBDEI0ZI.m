IBDEI0ZI ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16693,1,4,0)
 ;;=4^D51.9
 ;;^UTILITY(U,$J,358.3,16693,2)
 ;;=^5002289
 ;;^UTILITY(U,$J,358.3,16694,0)
 ;;=F43.20^^70^781^4
 ;;^UTILITY(U,$J,358.3,16694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16694,1,3,0)
 ;;=3^Adjustment disorder, unspec
 ;;^UTILITY(U,$J,358.3,16694,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,16694,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,16695,0)
 ;;=F43.21^^70^781^3
 ;;^UTILITY(U,$J,358.3,16695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16695,1,3,0)
 ;;=3^Adjustment disorder w/ depressed mood
 ;;^UTILITY(U,$J,358.3,16695,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,16695,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,16696,0)
 ;;=F43.22^^70^781^1
 ;;^UTILITY(U,$J,358.3,16696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16696,1,3,0)
 ;;=3^Adjustment Disorder w/ Anxiety
 ;;^UTILITY(U,$J,358.3,16696,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,16696,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,16697,0)
 ;;=F43.23^^70^781^2
 ;;^UTILITY(U,$J,358.3,16697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16697,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety and Depressed Mood
 ;;^UTILITY(U,$J,358.3,16697,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,16697,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,16698,0)
 ;;=F41.9^^70^782^4
 ;;^UTILITY(U,$J,358.3,16698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16698,1,3,0)
 ;;=3^Anxiety disorder, unspec
 ;;^UTILITY(U,$J,358.3,16698,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,16698,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,16699,0)
 ;;=F41.0^^70^782^6
 ;;^UTILITY(U,$J,358.3,16699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16699,1,3,0)
 ;;=3^Panic disorder w/o agoraphobia [episodic paroxysmal anxiety]
 ;;^UTILITY(U,$J,358.3,16699,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,16699,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,16700,0)
 ;;=F41.1^^70^782^3
 ;;^UTILITY(U,$J,358.3,16700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16700,1,3,0)
 ;;=3^Anxiety disorder, generalized
 ;;^UTILITY(U,$J,358.3,16700,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,16700,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,16701,0)
 ;;=F40.01^^70^782^1
 ;;^UTILITY(U,$J,358.3,16701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16701,1,3,0)
 ;;=3^Agoraphobia w/ panic disorder
 ;;^UTILITY(U,$J,358.3,16701,1,4,0)
 ;;=4^F40.01
 ;;^UTILITY(U,$J,358.3,16701,2)
 ;;=^331911
 ;;^UTILITY(U,$J,358.3,16702,0)
 ;;=F40.02^^70^782^2
 ;;^UTILITY(U,$J,358.3,16702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16702,1,3,0)
 ;;=3^Agoraphobia w/o panic disorder
 ;;^UTILITY(U,$J,358.3,16702,1,4,0)
 ;;=4^F40.02
 ;;^UTILITY(U,$J,358.3,16702,2)
 ;;=^5003543
 ;;^UTILITY(U,$J,358.3,16703,0)
 ;;=F42.^^70^782^5
 ;;^UTILITY(U,$J,358.3,16703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16703,1,3,0)
 ;;=3^Obsessive-compulsive disorder
 ;;^UTILITY(U,$J,358.3,16703,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,16703,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,16704,0)
 ;;=F43.10^^70^782^8
 ;;^UTILITY(U,$J,358.3,16704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16704,1,3,0)
 ;;=3^Post-traumatic stress disorder, unspec
 ;;^UTILITY(U,$J,358.3,16704,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,16704,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,16705,0)
 ;;=F43.12^^70^782^7
 ;;^UTILITY(U,$J,358.3,16705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16705,1,3,0)
 ;;=3^Post-traumatic stress disorder, chronic
 ;;^UTILITY(U,$J,358.3,16705,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,16705,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,16706,0)
 ;;=E53.8^^70^783^1
 ;;^UTILITY(U,$J,358.3,16706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16706,1,3,0)
 ;;=3^B Vitamin Deficiency
