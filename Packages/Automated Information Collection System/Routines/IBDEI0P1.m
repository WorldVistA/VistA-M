IBDEI0P1 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11172,1,3,0)
 ;;=3^Penetrating Orbital Wound,Right Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,11172,1,4,0)
 ;;=4^S05.41XA
 ;;^UTILITY(U,$J,358.3,11172,2)
 ;;=^5020615
 ;;^UTILITY(U,$J,358.3,11173,0)
 ;;=S05.42XA^^77^725^12
 ;;^UTILITY(U,$J,358.3,11173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11173,1,3,0)
 ;;=3^Penetrating Orbital Wound,Left Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,11173,1,4,0)
 ;;=4^S05.42XA
 ;;^UTILITY(U,$J,358.3,11173,2)
 ;;=^5020618
 ;;^UTILITY(U,$J,358.3,11174,0)
 ;;=S02.42XA^^77^725^17
 ;;^UTILITY(U,$J,358.3,11174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11174,1,3,0)
 ;;=3^Fx of Alveoulus of Maxilla,Init Encntr for Closed Fx
 ;;^UTILITY(U,$J,358.3,11174,1,4,0)
 ;;=4^S02.42XA
 ;;^UTILITY(U,$J,358.3,11174,2)
 ;;=^5020354
 ;;^UTILITY(U,$J,358.3,11175,0)
 ;;=S00.11XA^^77^725^18
 ;;^UTILITY(U,$J,358.3,11175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11175,1,3,0)
 ;;=3^Contusion,Right Eyelid,Init Encntr
 ;;^UTILITY(U,$J,358.3,11175,1,4,0)
 ;;=4^S00.11XA
 ;;^UTILITY(U,$J,358.3,11175,2)
 ;;=^5019778
 ;;^UTILITY(U,$J,358.3,11176,0)
 ;;=S00.12XA^^77^725^19
 ;;^UTILITY(U,$J,358.3,11176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11176,1,3,0)
 ;;=3^Contusion,Left Eyelid,Init Encntr
 ;;^UTILITY(U,$J,358.3,11176,1,4,0)
 ;;=4^S00.12XA
 ;;^UTILITY(U,$J,358.3,11176,2)
 ;;=^5019781
 ;;^UTILITY(U,$J,358.3,11177,0)
 ;;=S01.151A^^77^725^20
 ;;^UTILITY(U,$J,358.3,11177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11177,1,3,0)
 ;;=3^Open Bite,Right Eyelid,Init Encntr
 ;;^UTILITY(U,$J,358.3,11177,1,4,0)
 ;;=4^S01.151A
 ;;^UTILITY(U,$J,358.3,11177,2)
 ;;=^5020081
 ;;^UTILITY(U,$J,358.3,11178,0)
 ;;=S01.152A^^77^725^21
 ;;^UTILITY(U,$J,358.3,11178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11178,1,3,0)
 ;;=3^Open Bite,Left Eyelid,Init Encntr
 ;;^UTILITY(U,$J,358.3,11178,1,4,0)
 ;;=4^S01.152A
 ;;^UTILITY(U,$J,358.3,11178,2)
 ;;=^5020084
 ;;^UTILITY(U,$J,358.3,11179,0)
 ;;=S02.81XA^^77^725^13
 ;;^UTILITY(U,$J,358.3,11179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11179,1,3,0)
 ;;=3^Fx of Skull/Facial Bones,Right Side,Init Encntr for Closed Fx
 ;;^UTILITY(U,$J,358.3,11179,1,4,0)
 ;;=4^S02.81XA
 ;;^UTILITY(U,$J,358.3,11179,2)
 ;;=^5139523
 ;;^UTILITY(U,$J,358.3,11180,0)
 ;;=S02.82XA^^77^725^14
 ;;^UTILITY(U,$J,358.3,11180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11180,1,3,0)
 ;;=3^Fx of Skull/Facial Bones,Left Side,Init Encntr for Closed Fx
 ;;^UTILITY(U,$J,358.3,11180,1,4,0)
 ;;=4^S02.82XA
 ;;^UTILITY(U,$J,358.3,11180,2)
 ;;=^5139529
 ;;^UTILITY(U,$J,358.3,11181,0)
 ;;=S02.31XA^^77^725^15
 ;;^UTILITY(U,$J,358.3,11181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11181,1,3,0)
 ;;=3^Fx of Orbital Floor,Right Side,Init Encntr for Closed Fx
 ;;^UTILITY(U,$J,358.3,11181,1,4,0)
 ;;=4^S02.31XA
 ;;^UTILITY(U,$J,358.3,11181,2)
 ;;=^5139325
 ;;^UTILITY(U,$J,358.3,11182,0)
 ;;=S02.32XA^^77^725^16
 ;;^UTILITY(U,$J,358.3,11182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11182,1,3,0)
 ;;=3^Fx of Orbital Floor,Left Side,Init Encntr for Closed Fx
 ;;^UTILITY(U,$J,358.3,11182,1,4,0)
 ;;=4^S02.32XA
 ;;^UTILITY(U,$J,358.3,11182,2)
 ;;=^5139331
 ;;^UTILITY(U,$J,358.3,11183,0)
 ;;=H04.123^^77^726^1
 ;;^UTILITY(U,$J,358.3,11183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11183,1,3,0)
 ;;=3^Dry Eye Syndrome,Bilateral Lacrimal Glands
 ;;^UTILITY(U,$J,358.3,11183,1,4,0)
 ;;=4^H04.123
 ;;^UTILITY(U,$J,358.3,11183,2)
 ;;=^5004465
