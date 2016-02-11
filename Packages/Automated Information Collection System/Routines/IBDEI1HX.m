IBDEI1HX ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25013,0)
 ;;=T82.818A^^124^1239^55
 ;;^UTILITY(U,$J,358.3,25013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25013,1,3,0)
 ;;=3^Embolism of Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,25013,1,4,0)
 ;;=4^T82.818A
 ;;^UTILITY(U,$J,358.3,25013,2)
 ;;=^5054917
 ;;^UTILITY(U,$J,358.3,25014,0)
 ;;=T82.828A^^124^1239^60
 ;;^UTILITY(U,$J,358.3,25014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25014,1,3,0)
 ;;=3^Fibrosis of Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,25014,1,4,0)
 ;;=4^T82.828A
 ;;^UTILITY(U,$J,358.3,25014,2)
 ;;=^5054923
 ;;^UTILITY(U,$J,358.3,25015,0)
 ;;=T82.838A^^124^1239^65
 ;;^UTILITY(U,$J,358.3,25015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25015,1,3,0)
 ;;=3^Hemorrhage of Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,25015,1,4,0)
 ;;=4^T82.838A
 ;;^UTILITY(U,$J,358.3,25015,2)
 ;;=^5054929
 ;;^UTILITY(U,$J,358.3,25016,0)
 ;;=T82.848A^^124^1239^162
 ;;^UTILITY(U,$J,358.3,25016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25016,1,3,0)
 ;;=3^Pain from Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,25016,1,4,0)
 ;;=4^T82.848A
 ;;^UTILITY(U,$J,358.3,25016,2)
 ;;=^5054935
 ;;^UTILITY(U,$J,358.3,25017,0)
 ;;=T82.858A^^124^1239^208
 ;;^UTILITY(U,$J,358.3,25017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25017,1,3,0)
 ;;=3^Stenosis of Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,25017,1,4,0)
 ;;=4^T82.858A
 ;;^UTILITY(U,$J,358.3,25017,2)
 ;;=^5054941
 ;;^UTILITY(U,$J,358.3,25018,0)
 ;;=T82.868A^^124^1239^214
 ;;^UTILITY(U,$J,358.3,25018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25018,1,3,0)
 ;;=3^Thrombosis of Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,25018,1,4,0)
 ;;=4^T82.868A
 ;;^UTILITY(U,$J,358.3,25018,2)
 ;;=^5054947
 ;;^UTILITY(U,$J,358.3,25019,0)
 ;;=T82.898A^^124^1239^23
 ;;^UTILITY(U,$J,358.3,25019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25019,1,3,0)
 ;;=3^Complication of Vascular Prosthetic Device/Implant/Graft Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,25019,1,4,0)
 ;;=4^T82.898A
 ;;^UTILITY(U,$J,358.3,25019,2)
 ;;=^5054953
 ;;^UTILITY(U,$J,358.3,25020,0)
 ;;=T85.81XA^^124^1239^50
 ;;^UTILITY(U,$J,358.3,25020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25020,1,3,0)
 ;;=3^Embolism d/t Internal Prosth Device/Implant/Graft NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,25020,1,4,0)
 ;;=4^T85.81XA
 ;;^UTILITY(U,$J,358.3,25020,2)
 ;;=^5055679
 ;;^UTILITY(U,$J,358.3,25021,0)
 ;;=T85.82XA^^124^1239^57
 ;;^UTILITY(U,$J,358.3,25021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25021,1,3,0)
 ;;=3^Fibrosis d/t Internal Prosth Device/Implant/Graft NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,25021,1,4,0)
 ;;=4^T85.82XA
 ;;^UTILITY(U,$J,358.3,25021,2)
 ;;=^5055682
 ;;^UTILITY(U,$J,358.3,25022,0)
 ;;=T85.83XA^^124^1239^62
 ;;^UTILITY(U,$J,358.3,25022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25022,1,3,0)
 ;;=3^Hemorrhage d/t Internal Prosth Device/Implant/Graft NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,25022,1,4,0)
 ;;=4^T85.83XA
 ;;^UTILITY(U,$J,358.3,25022,2)
 ;;=^5055685
 ;;^UTILITY(U,$J,358.3,25023,0)
 ;;=T85.84XA^^124^1239^159
 ;;^UTILITY(U,$J,358.3,25023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25023,1,3,0)
 ;;=3^Pain d/t Internal Prosth Device/Implant/Graft NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,25023,1,4,0)
 ;;=4^T85.84XA
 ;;^UTILITY(U,$J,358.3,25023,2)
 ;;=^5055688
 ;;^UTILITY(U,$J,358.3,25024,0)
 ;;=T85.85XA^^124^1239^206
 ;;^UTILITY(U,$J,358.3,25024,1,0)
 ;;=^358.31IA^4^2
