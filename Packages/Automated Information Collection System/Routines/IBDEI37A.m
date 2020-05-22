IBDEI37A ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,51099,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,51100,0)
 ;;=F31.9^^193^2501^6
 ;;^UTILITY(U,$J,358.3,51100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51100,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,51100,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,51100,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,51101,0)
 ;;=F31.72^^193^2501^7
 ;;^UTILITY(U,$J,358.3,51101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51101,1,3,0)
 ;;=3^Bipolr Disorder,Full Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,51101,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,51101,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,51102,0)
 ;;=F31.71^^193^2501^5
 ;;^UTILITY(U,$J,358.3,51102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51102,1,3,0)
 ;;=3^Bipolar Disorder,Part Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,51102,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,51102,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,51103,0)
 ;;=F31.70^^193^2501^4
 ;;^UTILITY(U,$J,358.3,51103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51103,1,3,0)
 ;;=3^Bipolar Disorder,In Remis,Most Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,51103,1,4,0)
 ;;=4^F31.70
 ;;^UTILITY(U,$J,358.3,51103,2)
 ;;=^5003510
 ;;^UTILITY(U,$J,358.3,51104,0)
 ;;=F29.^^193^2501^25
 ;;^UTILITY(U,$J,358.3,51104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51104,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,51104,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,51104,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,51105,0)
 ;;=F28.^^193^2501^26
 ;;^UTILITY(U,$J,358.3,51105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51105,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond NEC
 ;;^UTILITY(U,$J,358.3,51105,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,51105,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,51106,0)
 ;;=F41.9^^193^2501^3
 ;;^UTILITY(U,$J,358.3,51106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51106,1,3,0)
 ;;=3^Anxiety Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,51106,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,51106,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,51107,0)
 ;;=F45.0^^193^2501^29
 ;;^UTILITY(U,$J,358.3,51107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51107,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,51107,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,51107,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,51108,0)
 ;;=F69.^^193^2501^2
 ;;^UTILITY(U,$J,358.3,51108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51108,1,3,0)
 ;;=3^Adult Personality and Behavior Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,51108,1,4,0)
 ;;=4^F69.
 ;;^UTILITY(U,$J,358.3,51108,2)
 ;;=^5003667
 ;;^UTILITY(U,$J,358.3,51109,0)
 ;;=F60.9^^193^2501^23
 ;;^UTILITY(U,$J,358.3,51109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51109,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,51109,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,51109,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,51110,0)
 ;;=F32.9^^193^2501^16
 ;;^UTILITY(U,$J,358.3,51110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51110,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,51110,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,51110,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,51111,0)
 ;;=F40.231^^193^2501^12
 ;;^UTILITY(U,$J,358.3,51111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51111,1,3,0)
 ;;=3^Fear of Injections/Transfusions
 ;;^UTILITY(U,$J,358.3,51111,1,4,0)
 ;;=4^F40.231
