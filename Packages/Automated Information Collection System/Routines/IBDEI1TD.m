IBDEI1TD ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30366,2)
 ;;=^5008834
 ;;^UTILITY(U,$J,358.3,30367,0)
 ;;=F20.3^^135^1376^25
 ;;^UTILITY(U,$J,358.3,30367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30367,1,3,0)
 ;;=3^Undifferentiated/Atypical Schizophrenia
 ;;^UTILITY(U,$J,358.3,30367,1,4,0)
 ;;=4^F20.3
 ;;^UTILITY(U,$J,358.3,30367,2)
 ;;=^5003472
 ;;^UTILITY(U,$J,358.3,30368,0)
 ;;=F20.9^^135^1376^21
 ;;^UTILITY(U,$J,358.3,30368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30368,1,3,0)
 ;;=3^Schizophrenia,Unspec
 ;;^UTILITY(U,$J,358.3,30368,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,30368,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,30369,0)
 ;;=F31.9^^135^1376^6
 ;;^UTILITY(U,$J,358.3,30369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30369,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,30369,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,30369,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,30370,0)
 ;;=F31.72^^135^1376^7
 ;;^UTILITY(U,$J,358.3,30370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30370,1,3,0)
 ;;=3^Bipolr Disorder,Full Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,30370,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,30370,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,30371,0)
 ;;=F31.71^^135^1376^5
 ;;^UTILITY(U,$J,358.3,30371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30371,1,3,0)
 ;;=3^Bipolar Disorder,Part Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,30371,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,30371,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,30372,0)
 ;;=F31.70^^135^1376^4
 ;;^UTILITY(U,$J,358.3,30372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30372,1,3,0)
 ;;=3^Bipolar Disorder,In Remis,Most Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,30372,1,4,0)
 ;;=4^F31.70
 ;;^UTILITY(U,$J,358.3,30372,2)
 ;;=^5003510
 ;;^UTILITY(U,$J,358.3,30373,0)
 ;;=F29.^^135^1376^19
 ;;^UTILITY(U,$J,358.3,30373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30373,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,30373,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,30373,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,30374,0)
 ;;=F28.^^135^1376^20
 ;;^UTILITY(U,$J,358.3,30374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30374,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond NEC
 ;;^UTILITY(U,$J,358.3,30374,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,30374,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,30375,0)
 ;;=F41.9^^135^1376^3
 ;;^UTILITY(U,$J,358.3,30375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30375,1,3,0)
 ;;=3^Anxiety Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,30375,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,30375,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,30376,0)
 ;;=F42.^^135^1376^13
 ;;^UTILITY(U,$J,358.3,30376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30376,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder
 ;;^UTILITY(U,$J,358.3,30376,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,30376,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,30377,0)
 ;;=F45.0^^135^1376^23
 ;;^UTILITY(U,$J,358.3,30377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30377,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,30377,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,30377,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,30378,0)
 ;;=F69.^^135^1376^2
 ;;^UTILITY(U,$J,358.3,30378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30378,1,3,0)
 ;;=3^Adult Personality and Behavior Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,30378,1,4,0)
 ;;=4^F69.
 ;;^UTILITY(U,$J,358.3,30378,2)
 ;;=^5003667
 ;;^UTILITY(U,$J,358.3,30379,0)
 ;;=F60.9^^135^1376^17
 ;;^UTILITY(U,$J,358.3,30379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30379,1,3,0)
 ;;=3^Personality Disorder,Unspec
