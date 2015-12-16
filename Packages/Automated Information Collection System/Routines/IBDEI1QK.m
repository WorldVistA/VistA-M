IBDEI1QK ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30706,1,4,0)
 ;;=4^Z30.430
 ;;^UTILITY(U,$J,358.3,30706,2)
 ;;=^5062822
 ;;^UTILITY(U,$J,358.3,30707,0)
 ;;=Z30.432^^178^1924^88
 ;;^UTILITY(U,$J,358.3,30707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30707,1,3,0)
 ;;=3^Remove Intrauterine Contraceptive Device
 ;;^UTILITY(U,$J,358.3,30707,1,4,0)
 ;;=4^Z30.432
 ;;^UTILITY(U,$J,358.3,30707,2)
 ;;=^5062824
 ;;^UTILITY(U,$J,358.3,30708,0)
 ;;=Z30.433^^178^1924^87
 ;;^UTILITY(U,$J,358.3,30708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30708,1,3,0)
 ;;=3^Removal/Reinsertion of Uterine Contraceptive Device
 ;;^UTILITY(U,$J,358.3,30708,1,4,0)
 ;;=4^Z30.433
 ;;^UTILITY(U,$J,358.3,30708,2)
 ;;=^5062825
 ;;^UTILITY(U,$J,358.3,30709,0)
 ;;=Z30.2^^178^1924^92
 ;;^UTILITY(U,$J,358.3,30709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30709,1,3,0)
 ;;=3^Sterilization Encounter
 ;;^UTILITY(U,$J,358.3,30709,1,4,0)
 ;;=4^Z30.2
 ;;^UTILITY(U,$J,358.3,30709,2)
 ;;=^5062818
 ;;^UTILITY(U,$J,358.3,30710,0)
 ;;=Z30.40^^178^1924^98
 ;;^UTILITY(U,$J,358.3,30710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30710,1,3,0)
 ;;=3^Surveillance of Contraceptives,Unspec
 ;;^UTILITY(U,$J,358.3,30710,1,4,0)
 ;;=4^Z30.40
 ;;^UTILITY(U,$J,358.3,30710,2)
 ;;=^5062819
 ;;^UTILITY(U,$J,358.3,30711,0)
 ;;=Z30.41^^178^1924^96
 ;;^UTILITY(U,$J,358.3,30711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30711,1,3,0)
 ;;=3^Surveillance of Contraceptive Pills
 ;;^UTILITY(U,$J,358.3,30711,1,4,0)
 ;;=4^Z30.41
 ;;^UTILITY(U,$J,358.3,30711,2)
 ;;=^5062820
 ;;^UTILITY(U,$J,358.3,30712,0)
 ;;=Z30.431^^178^1924^89
 ;;^UTILITY(U,$J,358.3,30712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30712,1,3,0)
 ;;=3^Routine Check of Intrauterine Contraceptive Device
 ;;^UTILITY(U,$J,358.3,30712,1,4,0)
 ;;=4^Z30.431
 ;;^UTILITY(U,$J,358.3,30712,2)
 ;;=^5062823
 ;;^UTILITY(U,$J,358.3,30713,0)
 ;;=Z30.49^^178^1924^97
 ;;^UTILITY(U,$J,358.3,30713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30713,1,3,0)
 ;;=3^Surveillance of Contraceptives NEC
 ;;^UTILITY(U,$J,358.3,30713,1,4,0)
 ;;=4^Z30.49
 ;;^UTILITY(U,$J,358.3,30713,2)
 ;;=^5062826
 ;;^UTILITY(U,$J,358.3,30714,0)
 ;;=Z98.51^^178^1924^100
 ;;^UTILITY(U,$J,358.3,30714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30714,1,3,0)
 ;;=3^Tubal ligation status
 ;;^UTILITY(U,$J,358.3,30714,1,4,0)
 ;;=4^Z98.51
 ;;^UTILITY(U,$J,358.3,30714,2)
 ;;=^5063740
 ;;^UTILITY(U,$J,358.3,30715,0)
 ;;=Z97.5^^178^1924^85
 ;;^UTILITY(U,$J,358.3,30715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30715,1,3,0)
 ;;=3^Presence of (intrauterine) contraceptive device
 ;;^UTILITY(U,$J,358.3,30715,1,4,0)
 ;;=4^Z97.5
 ;;^UTILITY(U,$J,358.3,30715,2)
 ;;=^5063731
 ;;^UTILITY(U,$J,358.3,30716,0)
 ;;=Z90.79^^178^1924^9
 ;;^UTILITY(U,$J,358.3,30716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30716,1,3,0)
 ;;=3^Acquired absence of other genital organ(s)
 ;;^UTILITY(U,$J,358.3,30716,1,4,0)
 ;;=4^Z90.79
 ;;^UTILITY(U,$J,358.3,30716,2)
 ;;=^5063596
 ;;^UTILITY(U,$J,358.3,30717,0)
 ;;=Z90.710^^178^1924^7
 ;;^UTILITY(U,$J,358.3,30717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30717,1,3,0)
 ;;=3^Acquired absence of both cervix and uterus
 ;;^UTILITY(U,$J,358.3,30717,1,4,0)
 ;;=4^Z90.710
 ;;^UTILITY(U,$J,358.3,30717,2)
 ;;=^5063591
 ;;^UTILITY(U,$J,358.3,30718,0)
 ;;=Z90.711^^178^1924^10
 ;;^UTILITY(U,$J,358.3,30718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30718,1,3,0)
 ;;=3^Acquired absence of uterus with remaining cervical stump
 ;;^UTILITY(U,$J,358.3,30718,1,4,0)
 ;;=4^Z90.711
 ;;^UTILITY(U,$J,358.3,30718,2)
 ;;=^5063592
 ;;^UTILITY(U,$J,358.3,30719,0)
 ;;=Z90.712^^178^1924^8
