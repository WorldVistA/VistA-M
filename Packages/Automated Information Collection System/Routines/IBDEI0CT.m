IBDEI0CT ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5561,0)
 ;;=K61.1^^40^370^5
 ;;^UTILITY(U,$J,358.3,5561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5561,1,3,0)
 ;;=3^Rectal Abscess
 ;;^UTILITY(U,$J,358.3,5561,1,4,0)
 ;;=4^K61.1
 ;;^UTILITY(U,$J,358.3,5561,2)
 ;;=^259588
 ;;^UTILITY(U,$J,358.3,5562,0)
 ;;=K61.3^^40^370^4
 ;;^UTILITY(U,$J,358.3,5562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5562,1,3,0)
 ;;=3^Ischiorectal Abscess
 ;;^UTILITY(U,$J,358.3,5562,1,4,0)
 ;;=4^K61.3
 ;;^UTILITY(U,$J,358.3,5562,2)
 ;;=^5008751
 ;;^UTILITY(U,$J,358.3,5563,0)
 ;;=K61.4^^40^370^3
 ;;^UTILITY(U,$J,358.3,5563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5563,1,3,0)
 ;;=3^Intrasphincteric Abscess
 ;;^UTILITY(U,$J,358.3,5563,1,4,0)
 ;;=4^K61.4
 ;;^UTILITY(U,$J,358.3,5563,2)
 ;;=^5008752
 ;;^UTILITY(U,$J,358.3,5564,0)
 ;;=K61.2^^40^370^2
 ;;^UTILITY(U,$J,358.3,5564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5564,1,3,0)
 ;;=3^Anorectal Abscess
 ;;^UTILITY(U,$J,358.3,5564,1,4,0)
 ;;=4^K61.2
 ;;^UTILITY(U,$J,358.3,5564,2)
 ;;=^5008750
 ;;^UTILITY(U,$J,358.3,5565,0)
 ;;=S09.12XA^^40^371^2
 ;;^UTILITY(U,$J,358.3,5565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5565,1,3,0)
 ;;=3^Laceration of Muscle/Tendon of Head,Init Encntr
 ;;^UTILITY(U,$J,358.3,5565,1,4,0)
 ;;=4^S09.12XA
 ;;^UTILITY(U,$J,358.3,5565,2)
 ;;=^5021287
 ;;^UTILITY(U,$J,358.3,5566,0)
 ;;=S16.2XXA^^40^371^1
 ;;^UTILITY(U,$J,358.3,5566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5566,1,3,0)
 ;;=3^Laceration of Muscle/Fascia/Tendon at Neck Level,Init Encntr
 ;;^UTILITY(U,$J,358.3,5566,1,4,0)
 ;;=4^S16.2XXA
 ;;^UTILITY(U,$J,358.3,5566,2)
 ;;=^5022361
 ;;^UTILITY(U,$J,358.3,5567,0)
 ;;=S31.114A^^40^371^5
 ;;^UTILITY(U,$J,358.3,5567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5567,1,3,0)
 ;;=3^Laceration w/o FB of LLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,5567,1,4,0)
 ;;=4^S31.114A
 ;;^UTILITY(U,$J,358.3,5567,2)
 ;;=^5134427
 ;;^UTILITY(U,$J,358.3,5568,0)
 ;;=S31.111A^^40^371^6
 ;;^UTILITY(U,$J,358.3,5568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5568,1,3,0)
 ;;=3^Laceration w/o FB of LUQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,5568,1,4,0)
 ;;=4^S31.111A
 ;;^UTILITY(U,$J,358.3,5568,2)
 ;;=^5024044
 ;;^UTILITY(U,$J,358.3,5569,0)
 ;;=S31.113A^^40^371^37
 ;;^UTILITY(U,$J,358.3,5569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5569,1,3,0)
 ;;=3^Laceration w/o FB of RLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,5569,1,4,0)
 ;;=4^S31.113A
 ;;^UTILITY(U,$J,358.3,5569,2)
 ;;=^5024050
 ;;^UTILITY(U,$J,358.3,5570,0)
 ;;=S31.110A^^40^371^38
 ;;^UTILITY(U,$J,358.3,5570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5570,1,3,0)
 ;;=3^Laceration w/o FB of RUQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,5570,1,4,0)
 ;;=4^S31.110A
 ;;^UTILITY(U,$J,358.3,5570,2)
 ;;=^5024041
 ;;^UTILITY(U,$J,358.3,5571,0)
 ;;=S31.821A^^40^371^8
 ;;^UTILITY(U,$J,358.3,5571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5571,1,3,0)
 ;;=3^Laceration w/o FB of Left Buttock,Init Encntr
 ;;^UTILITY(U,$J,358.3,5571,1,4,0)
 ;;=4^S31.821A
 ;;^UTILITY(U,$J,358.3,5571,2)
 ;;=^5024311
 ;;^UTILITY(U,$J,358.3,5572,0)
 ;;=S01.412A^^40^371^9
 ;;^UTILITY(U,$J,358.3,5572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5572,1,3,0)
 ;;=3^Laceration w/o FB of Left Cheek/TMJ Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,5572,1,4,0)
 ;;=4^S01.412A
 ;;^UTILITY(U,$J,358.3,5572,2)
 ;;=^5020156
 ;;^UTILITY(U,$J,358.3,5573,0)
 ;;=S01.312A^^40^371^10
 ;;^UTILITY(U,$J,358.3,5573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5573,1,3,0)
 ;;=3^Laceration w/o FB of Left Ear,Init Encntr
