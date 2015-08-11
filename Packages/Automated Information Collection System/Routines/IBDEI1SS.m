IBDEI1SS ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32106,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,32107,0)
 ;;=F31.9^^190^1947^6
 ;;^UTILITY(U,$J,358.3,32107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32107,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,32107,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,32107,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,32108,0)
 ;;=F31.72^^190^1947^7
 ;;^UTILITY(U,$J,358.3,32108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32108,1,3,0)
 ;;=3^Bipolr Disorder,Full Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,32108,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,32108,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,32109,0)
 ;;=F31.71^^190^1947^5
 ;;^UTILITY(U,$J,358.3,32109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32109,1,3,0)
 ;;=3^Bipolar Disorder,Part Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,32109,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,32109,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,32110,0)
 ;;=F31.70^^190^1947^4
 ;;^UTILITY(U,$J,358.3,32110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32110,1,3,0)
 ;;=3^Bipolar Disorder,In Remis,Most Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,32110,1,4,0)
 ;;=4^F31.70
 ;;^UTILITY(U,$J,358.3,32110,2)
 ;;=^5003510
 ;;^UTILITY(U,$J,358.3,32111,0)
 ;;=F29.^^190^1947^21
 ;;^UTILITY(U,$J,358.3,32111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32111,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,32111,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,32111,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,32112,0)
 ;;=F28.^^190^1947^22
 ;;^UTILITY(U,$J,358.3,32112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32112,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond,Oth
 ;;^UTILITY(U,$J,358.3,32112,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,32112,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,32113,0)
 ;;=F41.9^^190^1947^3
 ;;^UTILITY(U,$J,358.3,32113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32113,1,3,0)
 ;;=3^Anxiety Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,32113,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,32113,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,32114,0)
 ;;=F42.^^190^1947^15
 ;;^UTILITY(U,$J,358.3,32114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32114,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder
 ;;^UTILITY(U,$J,358.3,32114,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,32114,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,32115,0)
 ;;=F45.0^^190^1947^24
 ;;^UTILITY(U,$J,358.3,32115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32115,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,32115,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,32115,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,32116,0)
 ;;=F69.^^190^1947^2
 ;;^UTILITY(U,$J,358.3,32116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32116,1,3,0)
 ;;=3^Adult Personality and Behavior Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,32116,1,4,0)
 ;;=4^F69.
 ;;^UTILITY(U,$J,358.3,32116,2)
 ;;=^5003667
 ;;^UTILITY(U,$J,358.3,32117,0)
 ;;=F60.9^^190^1947^19
 ;;^UTILITY(U,$J,358.3,32117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32117,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,32117,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,32117,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,32118,0)
 ;;=F32.9^^190^1947^14
 ;;^UTILITY(U,$J,358.3,32118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32118,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,32118,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,32118,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,32119,0)
 ;;=F40.231^^190^1947^11
 ;;^UTILITY(U,$J,358.3,32119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32119,1,3,0)
 ;;=3^Fear of Injections/Transfusions
