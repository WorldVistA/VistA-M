IBDEI0OE ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11159,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,11159,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,11160,0)
 ;;=F31.9^^68^679^6
 ;;^UTILITY(U,$J,358.3,11160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11160,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,11160,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,11160,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,11161,0)
 ;;=F31.72^^68^679^7
 ;;^UTILITY(U,$J,358.3,11161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11161,1,3,0)
 ;;=3^Bipolr Disorder,Full Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,11161,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,11161,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,11162,0)
 ;;=F31.71^^68^679^5
 ;;^UTILITY(U,$J,358.3,11162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11162,1,3,0)
 ;;=3^Bipolar Disorder,Part Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,11162,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,11162,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,11163,0)
 ;;=F31.70^^68^679^4
 ;;^UTILITY(U,$J,358.3,11163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11163,1,3,0)
 ;;=3^Bipolar Disorder,In Remis,Most Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,11163,1,4,0)
 ;;=4^F31.70
 ;;^UTILITY(U,$J,358.3,11163,2)
 ;;=^5003510
 ;;^UTILITY(U,$J,358.3,11164,0)
 ;;=F29.^^68^679^19
 ;;^UTILITY(U,$J,358.3,11164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11164,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,11164,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,11164,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,11165,0)
 ;;=F28.^^68^679^20
 ;;^UTILITY(U,$J,358.3,11165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11165,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond NEC
 ;;^UTILITY(U,$J,358.3,11165,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,11165,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,11166,0)
 ;;=F41.9^^68^679^3
 ;;^UTILITY(U,$J,358.3,11166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11166,1,3,0)
 ;;=3^Anxiety Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,11166,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,11166,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,11167,0)
 ;;=F42.^^68^679^13
 ;;^UTILITY(U,$J,358.3,11167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11167,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder
 ;;^UTILITY(U,$J,358.3,11167,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,11167,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,11168,0)
 ;;=F45.0^^68^679^23
 ;;^UTILITY(U,$J,358.3,11168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11168,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,11168,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,11168,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,11169,0)
 ;;=F69.^^68^679^2
 ;;^UTILITY(U,$J,358.3,11169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11169,1,3,0)
 ;;=3^Adult Personality and Behavior Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,11169,1,4,0)
 ;;=4^F69.
 ;;^UTILITY(U,$J,358.3,11169,2)
 ;;=^5003667
 ;;^UTILITY(U,$J,358.3,11170,0)
 ;;=F60.9^^68^679^17
 ;;^UTILITY(U,$J,358.3,11170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11170,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,11170,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,11170,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,11171,0)
 ;;=F32.9^^68^679^12
 ;;^UTILITY(U,$J,358.3,11171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11171,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,11171,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,11171,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,11172,0)
 ;;=F40.231^^68^679^9
 ;;^UTILITY(U,$J,358.3,11172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11172,1,3,0)
 ;;=3^Fear of Injections/Transfusions
