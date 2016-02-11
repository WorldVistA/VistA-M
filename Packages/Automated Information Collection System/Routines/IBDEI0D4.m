IBDEI0D4 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5701,0)
 ;;=S01.00XA^^40^375^62
 ;;^UTILITY(U,$J,358.3,5701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5701,1,3,0)
 ;;=3^Open Wound of Scalp,Init Encntr
 ;;^UTILITY(U,$J,358.3,5701,1,4,0)
 ;;=4^S01.00XA
 ;;^UTILITY(U,$J,358.3,5701,2)
 ;;=^5020033
 ;;^UTILITY(U,$J,358.3,5702,0)
 ;;=S01.402A^^40^375^7
 ;;^UTILITY(U,$J,358.3,5702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5702,1,3,0)
 ;;=3^Open Wound of Left Cheek/TMJ Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,5702,1,4,0)
 ;;=4^S01.402A
 ;;^UTILITY(U,$J,358.3,5702,2)
 ;;=^5020150
 ;;^UTILITY(U,$J,358.3,5703,0)
 ;;=S01.401A^^40^375^38
 ;;^UTILITY(U,$J,358.3,5703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5703,1,3,0)
 ;;=3^Open Wound of Right Cheek/TMJ Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,5703,1,4,0)
 ;;=4^S01.401A
 ;;^UTILITY(U,$J,358.3,5703,2)
 ;;=^5020147
 ;;^UTILITY(U,$J,358.3,5704,0)
 ;;=S01.80XA^^40^375^1
 ;;^UTILITY(U,$J,358.3,5704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5704,1,3,0)
 ;;=3^Open Wound of Head NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,5704,1,4,0)
 ;;=4^S01.80XA
 ;;^UTILITY(U,$J,358.3,5704,2)
 ;;=^5020222
 ;;^UTILITY(U,$J,358.3,5705,0)
 ;;=S01.90XA^^40^375^2
 ;;^UTILITY(U,$J,358.3,5705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5705,1,3,0)
 ;;=3^Open Wound of Head,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,5705,1,4,0)
 ;;=4^S01.90XA
 ;;^UTILITY(U,$J,358.3,5705,2)
 ;;=^5020240
 ;;^UTILITY(U,$J,358.3,5706,0)
 ;;=S11.80XA^^40^375^31
 ;;^UTILITY(U,$J,358.3,5706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5706,1,3,0)
 ;;=3^Open Wound of Neck NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,5706,1,4,0)
 ;;=4^S11.80XA
 ;;^UTILITY(U,$J,358.3,5706,2)
 ;;=^5021506
 ;;^UTILITY(U,$J,358.3,5707,0)
 ;;=S11.90XA^^40^375^32
 ;;^UTILITY(U,$J,358.3,5707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5707,1,3,0)
 ;;=3^Open Wound of Neck,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,5707,1,4,0)
 ;;=4^S11.90XA
 ;;^UTILITY(U,$J,358.3,5707,2)
 ;;=^5021527
 ;;^UTILITY(U,$J,358.3,5708,0)
 ;;=S31.819A^^40^375^37
 ;;^UTILITY(U,$J,358.3,5708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5708,1,3,0)
 ;;=3^Open Wound of Right Buttock,Init Encntr
 ;;^UTILITY(U,$J,358.3,5708,1,4,0)
 ;;=4^S31.819A
 ;;^UTILITY(U,$J,358.3,5708,2)
 ;;=^5024308
 ;;^UTILITY(U,$J,358.3,5709,0)
 ;;=S31.829A^^40^375^6
 ;;^UTILITY(U,$J,358.3,5709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5709,1,3,0)
 ;;=3^Open Wound of Left Buttock,Init Encntr
 ;;^UTILITY(U,$J,358.3,5709,1,4,0)
 ;;=4^S31.829A
 ;;^UTILITY(U,$J,358.3,5709,2)
 ;;=^5024320
 ;;^UTILITY(U,$J,358.3,5710,0)
 ;;=S31.100A^^40^375^35
 ;;^UTILITY(U,$J,358.3,5710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5710,1,3,0)
 ;;=3^Open Wound of RUQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,5710,1,4,0)
 ;;=4^S31.100A
 ;;^UTILITY(U,$J,358.3,5710,2)
 ;;=^5024023
 ;;^UTILITY(U,$J,358.3,5711,0)
 ;;=S31.101A^^40^375^4
 ;;^UTILITY(U,$J,358.3,5711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5711,1,3,0)
 ;;=3^Open Wound of LUQ Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,5711,1,4,0)
 ;;=4^S31.101A
 ;;^UTILITY(U,$J,358.3,5711,2)
 ;;=^5024026
 ;;^UTILITY(U,$J,358.3,5712,0)
 ;;=S31.103A^^40^375^34
 ;;^UTILITY(U,$J,358.3,5712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5712,1,3,0)
 ;;=3^Open Wound of RLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,5712,1,4,0)
 ;;=4^S31.103A
 ;;^UTILITY(U,$J,358.3,5712,2)
 ;;=^5024032
 ;;^UTILITY(U,$J,358.3,5713,0)
 ;;=S31.104A^^40^375^3
 ;;^UTILITY(U,$J,358.3,5713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5713,1,3,0)
 ;;=3^Open Wound of LLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
