IBDEI25X ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36265,1,3,0)
 ;;=3^Cnsl and instruction in natrl family planning to avoid preg
 ;;^UTILITY(U,$J,358.3,36265,1,4,0)
 ;;=4^Z30.02
 ;;^UTILITY(U,$J,358.3,36265,2)
 ;;=^5062816
 ;;^UTILITY(U,$J,358.3,36266,0)
 ;;=Z30.430^^166^1835^62
 ;;^UTILITY(U,$J,358.3,36266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36266,1,3,0)
 ;;=3^Insert Intrauterine Contraceptive Device
 ;;^UTILITY(U,$J,358.3,36266,1,4,0)
 ;;=4^Z30.430
 ;;^UTILITY(U,$J,358.3,36266,2)
 ;;=^5062822
 ;;^UTILITY(U,$J,358.3,36267,0)
 ;;=Z30.432^^166^1835^88
 ;;^UTILITY(U,$J,358.3,36267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36267,1,3,0)
 ;;=3^Remove Intrauterine Contraceptive Device
 ;;^UTILITY(U,$J,358.3,36267,1,4,0)
 ;;=4^Z30.432
 ;;^UTILITY(U,$J,358.3,36267,2)
 ;;=^5062824
 ;;^UTILITY(U,$J,358.3,36268,0)
 ;;=Z30.433^^166^1835^87
 ;;^UTILITY(U,$J,358.3,36268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36268,1,3,0)
 ;;=3^Removal/Reinsertion of Uterine Contraceptive Device
 ;;^UTILITY(U,$J,358.3,36268,1,4,0)
 ;;=4^Z30.433
 ;;^UTILITY(U,$J,358.3,36268,2)
 ;;=^5062825
 ;;^UTILITY(U,$J,358.3,36269,0)
 ;;=Z30.2^^166^1835^92
 ;;^UTILITY(U,$J,358.3,36269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36269,1,3,0)
 ;;=3^Sterilization Encounter
 ;;^UTILITY(U,$J,358.3,36269,1,4,0)
 ;;=4^Z30.2
 ;;^UTILITY(U,$J,358.3,36269,2)
 ;;=^5062818
 ;;^UTILITY(U,$J,358.3,36270,0)
 ;;=Z30.40^^166^1835^98
 ;;^UTILITY(U,$J,358.3,36270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36270,1,3,0)
 ;;=3^Surveillance of Contraceptives,Unspec
 ;;^UTILITY(U,$J,358.3,36270,1,4,0)
 ;;=4^Z30.40
 ;;^UTILITY(U,$J,358.3,36270,2)
 ;;=^5062819
 ;;^UTILITY(U,$J,358.3,36271,0)
 ;;=Z30.41^^166^1835^96
 ;;^UTILITY(U,$J,358.3,36271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36271,1,3,0)
 ;;=3^Surveillance of Contraceptive Pills
 ;;^UTILITY(U,$J,358.3,36271,1,4,0)
 ;;=4^Z30.41
 ;;^UTILITY(U,$J,358.3,36271,2)
 ;;=^5062820
 ;;^UTILITY(U,$J,358.3,36272,0)
 ;;=Z30.431^^166^1835^89
 ;;^UTILITY(U,$J,358.3,36272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36272,1,3,0)
 ;;=3^Routine Check of Intrauterine Contraceptive Device
 ;;^UTILITY(U,$J,358.3,36272,1,4,0)
 ;;=4^Z30.431
 ;;^UTILITY(U,$J,358.3,36272,2)
 ;;=^5062823
 ;;^UTILITY(U,$J,358.3,36273,0)
 ;;=Z30.49^^166^1835^97
 ;;^UTILITY(U,$J,358.3,36273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36273,1,3,0)
 ;;=3^Surveillance of Contraceptives NEC
 ;;^UTILITY(U,$J,358.3,36273,1,4,0)
 ;;=4^Z30.49
 ;;^UTILITY(U,$J,358.3,36273,2)
 ;;=^5062826
 ;;^UTILITY(U,$J,358.3,36274,0)
 ;;=Z98.51^^166^1835^100
 ;;^UTILITY(U,$J,358.3,36274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36274,1,3,0)
 ;;=3^Tubal ligation status
 ;;^UTILITY(U,$J,358.3,36274,1,4,0)
 ;;=4^Z98.51
 ;;^UTILITY(U,$J,358.3,36274,2)
 ;;=^5063740
 ;;^UTILITY(U,$J,358.3,36275,0)
 ;;=Z97.5^^166^1835^85
 ;;^UTILITY(U,$J,358.3,36275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36275,1,3,0)
 ;;=3^Presence of (intrauterine) contraceptive device
 ;;^UTILITY(U,$J,358.3,36275,1,4,0)
 ;;=4^Z97.5
 ;;^UTILITY(U,$J,358.3,36275,2)
 ;;=^5063731
 ;;^UTILITY(U,$J,358.3,36276,0)
 ;;=Z90.79^^166^1835^9
 ;;^UTILITY(U,$J,358.3,36276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36276,1,3,0)
 ;;=3^Acquired absence of other genital organ(s)
 ;;^UTILITY(U,$J,358.3,36276,1,4,0)
 ;;=4^Z90.79
 ;;^UTILITY(U,$J,358.3,36276,2)
 ;;=^5063596
 ;;^UTILITY(U,$J,358.3,36277,0)
 ;;=Z90.710^^166^1835^7
 ;;^UTILITY(U,$J,358.3,36277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36277,1,3,0)
 ;;=3^Acquired absence of both cervix and uterus
 ;;^UTILITY(U,$J,358.3,36277,1,4,0)
 ;;=4^Z90.710
