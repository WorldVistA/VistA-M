IBDEI0RB ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12195,0)
 ;;=K61.1^^80^773^5
 ;;^UTILITY(U,$J,358.3,12195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12195,1,3,0)
 ;;=3^Rectal Abscess
 ;;^UTILITY(U,$J,358.3,12195,1,4,0)
 ;;=4^K61.1
 ;;^UTILITY(U,$J,358.3,12195,2)
 ;;=^259588
 ;;^UTILITY(U,$J,358.3,12196,0)
 ;;=K61.4^^80^773^3
 ;;^UTILITY(U,$J,358.3,12196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12196,1,3,0)
 ;;=3^Intrasphincteric Abscess
 ;;^UTILITY(U,$J,358.3,12196,1,4,0)
 ;;=4^K61.4
 ;;^UTILITY(U,$J,358.3,12196,2)
 ;;=^5008752
 ;;^UTILITY(U,$J,358.3,12197,0)
 ;;=K61.2^^80^773^2
 ;;^UTILITY(U,$J,358.3,12197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12197,1,3,0)
 ;;=3^Anorectal Abscess
 ;;^UTILITY(U,$J,358.3,12197,1,4,0)
 ;;=4^K61.2
 ;;^UTILITY(U,$J,358.3,12197,2)
 ;;=^5008750
 ;;^UTILITY(U,$J,358.3,12198,0)
 ;;=K61.39^^80^773^4
 ;;^UTILITY(U,$J,358.3,12198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12198,1,3,0)
 ;;=3^Ischiorectal Abscess,Other
 ;;^UTILITY(U,$J,358.3,12198,1,4,0)
 ;;=4^K61.39
 ;;^UTILITY(U,$J,358.3,12198,2)
 ;;=^5157385
 ;;^UTILITY(U,$J,358.3,12199,0)
 ;;=S09.12XA^^80^774^2
 ;;^UTILITY(U,$J,358.3,12199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12199,1,3,0)
 ;;=3^Laceration of Muscle/Tendon of Head,Init Encntr
 ;;^UTILITY(U,$J,358.3,12199,1,4,0)
 ;;=4^S09.12XA
 ;;^UTILITY(U,$J,358.3,12199,2)
 ;;=^5021287
 ;;^UTILITY(U,$J,358.3,12200,0)
 ;;=S16.2XXA^^80^774^1
 ;;^UTILITY(U,$J,358.3,12200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12200,1,3,0)
 ;;=3^Laceration of Muscle/Fascia/Tendon at Neck Level,Init Encntr
 ;;^UTILITY(U,$J,358.3,12200,1,4,0)
 ;;=4^S16.2XXA
 ;;^UTILITY(U,$J,358.3,12200,2)
 ;;=^5022361
 ;;^UTILITY(U,$J,358.3,12201,0)
 ;;=S31.114A^^80^774^5
 ;;^UTILITY(U,$J,358.3,12201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12201,1,3,0)
 ;;=3^Laceration w/o FB of LLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,12201,1,4,0)
 ;;=4^S31.114A
 ;;^UTILITY(U,$J,358.3,12201,2)
 ;;=^5134427
 ;;^UTILITY(U,$J,358.3,12202,0)
 ;;=S31.111A^^80^774^6
 ;;^UTILITY(U,$J,358.3,12202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12202,1,3,0)
 ;;=3^Laceration w/o FB of LUQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,12202,1,4,0)
 ;;=4^S31.111A
 ;;^UTILITY(U,$J,358.3,12202,2)
 ;;=^5024044
 ;;^UTILITY(U,$J,358.3,12203,0)
 ;;=S31.113A^^80^774^37
 ;;^UTILITY(U,$J,358.3,12203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12203,1,3,0)
 ;;=3^Laceration w/o FB of RLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,12203,1,4,0)
 ;;=4^S31.113A
 ;;^UTILITY(U,$J,358.3,12203,2)
 ;;=^5024050
 ;;^UTILITY(U,$J,358.3,12204,0)
 ;;=S31.110A^^80^774^38
 ;;^UTILITY(U,$J,358.3,12204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12204,1,3,0)
 ;;=3^Laceration w/o FB of RUQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,12204,1,4,0)
 ;;=4^S31.110A
 ;;^UTILITY(U,$J,358.3,12204,2)
 ;;=^5024041
 ;;^UTILITY(U,$J,358.3,12205,0)
 ;;=S31.821A^^80^774^8
 ;;^UTILITY(U,$J,358.3,12205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12205,1,3,0)
 ;;=3^Laceration w/o FB of Left Buttock,Init Encntr
 ;;^UTILITY(U,$J,358.3,12205,1,4,0)
 ;;=4^S31.821A
 ;;^UTILITY(U,$J,358.3,12205,2)
 ;;=^5024311
 ;;^UTILITY(U,$J,358.3,12206,0)
 ;;=S01.412A^^80^774^9
 ;;^UTILITY(U,$J,358.3,12206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12206,1,3,0)
 ;;=3^Laceration w/o FB of Left Cheek/TMJ Area,Init Encntr
