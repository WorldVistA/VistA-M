IBDEI1HW ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25001,1,4,0)
 ;;=4^T84.623A
 ;;^UTILITY(U,$J,358.3,25001,2)
 ;;=^5055433
 ;;^UTILITY(U,$J,358.3,25002,0)
 ;;=T84.624A^^124^1239^80
 ;;^UTILITY(U,$J,358.3,25002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25002,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Internal Fix Right Fibula,Init Encntr
 ;;^UTILITY(U,$J,358.3,25002,1,4,0)
 ;;=4^T84.624A
 ;;^UTILITY(U,$J,358.3,25002,2)
 ;;=^5055436
 ;;^UTILITY(U,$J,358.3,25003,0)
 ;;=T84.625A^^124^1239^81
 ;;^UTILITY(U,$J,358.3,25003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25003,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Internal Fix Left Fibula,Init Encntr
 ;;^UTILITY(U,$J,358.3,25003,1,4,0)
 ;;=4^T84.625A
 ;;^UTILITY(U,$J,358.3,25003,2)
 ;;=^5055439
 ;;^UTILITY(U,$J,358.3,25004,0)
 ;;=T84.63XA^^124^1239^82
 ;;^UTILITY(U,$J,358.3,25004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25004,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Internal Fix Spine,Init Encntr
 ;;^UTILITY(U,$J,358.3,25004,1,4,0)
 ;;=4^T84.63XA
 ;;^UTILITY(U,$J,358.3,25004,2)
 ;;=^5055445
 ;;^UTILITY(U,$J,358.3,25005,0)
 ;;=T84.7XXA^^124^1239^85
 ;;^UTILITY(U,$J,358.3,25005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25005,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Internal Ortho Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,25005,1,4,0)
 ;;=4^T84.7XXA
 ;;^UTILITY(U,$J,358.3,25005,2)
 ;;=^5055451
 ;;^UTILITY(U,$J,358.3,25006,0)
 ;;=T82.817A^^124^1239^52
 ;;^UTILITY(U,$J,358.3,25006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25006,1,3,0)
 ;;=3^Embolism of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,25006,1,4,0)
 ;;=4^T82.817A
 ;;^UTILITY(U,$J,358.3,25006,2)
 ;;=^5054914
 ;;^UTILITY(U,$J,358.3,25007,0)
 ;;=T82.827A^^124^1239^58
 ;;^UTILITY(U,$J,358.3,25007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25007,1,3,0)
 ;;=3^Fibrosis of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,25007,1,4,0)
 ;;=4^T82.827A
 ;;^UTILITY(U,$J,358.3,25007,2)
 ;;=^5054920
 ;;^UTILITY(U,$J,358.3,25008,0)
 ;;=T82.837A^^124^1239^63
 ;;^UTILITY(U,$J,358.3,25008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25008,1,3,0)
 ;;=3^Hemorrhage of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,25008,1,4,0)
 ;;=4^T82.837A
 ;;^UTILITY(U,$J,358.3,25008,2)
 ;;=^5054926
 ;;^UTILITY(U,$J,358.3,25009,0)
 ;;=T82.847A^^124^1239^160
 ;;^UTILITY(U,$J,358.3,25009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25009,1,3,0)
 ;;=3^Pain from Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,25009,1,4,0)
 ;;=4^T82.847A
 ;;^UTILITY(U,$J,358.3,25009,2)
 ;;=^5054932
 ;;^UTILITY(U,$J,358.3,25010,0)
 ;;=T82.857A^^124^1239^209
 ;;^UTILITY(U,$J,358.3,25010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25010,1,3,0)
 ;;=3^Stenosis of of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,25010,1,4,0)
 ;;=4^T82.857A
 ;;^UTILITY(U,$J,358.3,25010,2)
 ;;=^5054938
 ;;^UTILITY(U,$J,358.3,25011,0)
 ;;=T82.867A^^124^1239^212
 ;;^UTILITY(U,$J,358.3,25011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25011,1,3,0)
 ;;=3^Thrombosis of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,25011,1,4,0)
 ;;=4^T82.867A
 ;;^UTILITY(U,$J,358.3,25011,2)
 ;;=^5054944
 ;;^UTILITY(U,$J,358.3,25012,0)
 ;;=T82.9XXA^^124^1239^28
 ;;^UTILITY(U,$J,358.3,25012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25012,1,3,0)
 ;;=3^Complications of Cardiac/Vascular Prosthetic Device/Implant/Graft Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,25012,1,4,0)
 ;;=4^T82.9XXA
 ;;^UTILITY(U,$J,358.3,25012,2)
 ;;=^5054956
