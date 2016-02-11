IBDEI0X0 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15220,1,3,0)
 ;;=3^Laceration w/o FB of LUQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,15220,1,4,0)
 ;;=4^S31.111A
 ;;^UTILITY(U,$J,358.3,15220,2)
 ;;=^5024044
 ;;^UTILITY(U,$J,358.3,15221,0)
 ;;=S31.113A^^85^813^37
 ;;^UTILITY(U,$J,358.3,15221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15221,1,3,0)
 ;;=3^Laceration w/o FB of RLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,15221,1,4,0)
 ;;=4^S31.113A
 ;;^UTILITY(U,$J,358.3,15221,2)
 ;;=^5024050
 ;;^UTILITY(U,$J,358.3,15222,0)
 ;;=S31.110A^^85^813^38
 ;;^UTILITY(U,$J,358.3,15222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15222,1,3,0)
 ;;=3^Laceration w/o FB of RUQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,15222,1,4,0)
 ;;=4^S31.110A
 ;;^UTILITY(U,$J,358.3,15222,2)
 ;;=^5024041
 ;;^UTILITY(U,$J,358.3,15223,0)
 ;;=S31.821A^^85^813^8
 ;;^UTILITY(U,$J,358.3,15223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15223,1,3,0)
 ;;=3^Laceration w/o FB of Left Buttock,Init Encntr
 ;;^UTILITY(U,$J,358.3,15223,1,4,0)
 ;;=4^S31.821A
 ;;^UTILITY(U,$J,358.3,15223,2)
 ;;=^5024311
 ;;^UTILITY(U,$J,358.3,15224,0)
 ;;=S01.412A^^85^813^9
 ;;^UTILITY(U,$J,358.3,15224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15224,1,3,0)
 ;;=3^Laceration w/o FB of Left Cheek/TMJ Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,15224,1,4,0)
 ;;=4^S01.412A
 ;;^UTILITY(U,$J,358.3,15224,2)
 ;;=^5020156
 ;;^UTILITY(U,$J,358.3,15225,0)
 ;;=S01.312A^^85^813^10
 ;;^UTILITY(U,$J,358.3,15225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15225,1,3,0)
 ;;=3^Laceration w/o FB of Left Ear,Init Encntr
 ;;^UTILITY(U,$J,358.3,15225,1,4,0)
 ;;=4^S01.312A
 ;;^UTILITY(U,$J,358.3,15225,2)
 ;;=^5020117
 ;;^UTILITY(U,$J,358.3,15226,0)
 ;;=S51.012A^^85^813^11
 ;;^UTILITY(U,$J,358.3,15226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15226,1,3,0)
 ;;=3^Laceration w/o FB of Left Elbow,Init Encntr
 ;;^UTILITY(U,$J,358.3,15226,1,4,0)
 ;;=4^S51.012A
 ;;^UTILITY(U,$J,358.3,15226,2)
 ;;=^5028629
 ;;^UTILITY(U,$J,358.3,15227,0)
 ;;=S91.212A^^85^813^13
 ;;^UTILITY(U,$J,358.3,15227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15227,1,3,0)
 ;;=3^Laceration w/o FB of Left Great Toe w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15227,1,4,0)
 ;;=4^S91.212A
 ;;^UTILITY(U,$J,358.3,15227,2)
 ;;=^5044276
 ;;^UTILITY(U,$J,358.3,15228,0)
 ;;=S91.112A^^85^813^14
 ;;^UTILITY(U,$J,358.3,15228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15228,1,3,0)
 ;;=3^Laceration w/o FB of Left Great Toe w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15228,1,4,0)
 ;;=4^S91.112A
 ;;^UTILITY(U,$J,358.3,15228,2)
 ;;=^5044186
 ;;^UTILITY(U,$J,358.3,15229,0)
 ;;=S61.412A^^85^813^15
 ;;^UTILITY(U,$J,358.3,15229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15229,1,3,0)
 ;;=3^Laceration w/o FB of Left Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,15229,1,4,0)
 ;;=4^S61.412A
 ;;^UTILITY(U,$J,358.3,15229,2)
 ;;=^5032990
 ;;^UTILITY(U,$J,358.3,15230,0)
 ;;=S61.311A^^85^813^17
 ;;^UTILITY(U,$J,358.3,15230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15230,1,3,0)
 ;;=3^Laceration w/o FB of Left Index Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15230,1,4,0)
 ;;=4^S61.311A
 ;;^UTILITY(U,$J,358.3,15230,2)
 ;;=^5032909
 ;;^UTILITY(U,$J,358.3,15231,0)
 ;;=S61.211A^^85^813^18
 ;;^UTILITY(U,$J,358.3,15231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15231,1,3,0)
 ;;=3^Laceration w/o FB of Left Index Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15231,1,4,0)
 ;;=4^S61.211A
 ;;^UTILITY(U,$J,358.3,15231,2)
 ;;=^5032774
