IBDEI1HS ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24955,1,4,0)
 ;;=4^T82.590A
 ;;^UTILITY(U,$J,358.3,24955,2)
 ;;=^5054884
 ;;^UTILITY(U,$J,358.3,24956,0)
 ;;=T82.591A^^124^1239^154
 ;;^UTILITY(U,$J,358.3,24956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24956,1,3,0)
 ;;=3^Mechanical Compl of Surgically Created AV Shunt,Init Encntr
 ;;^UTILITY(U,$J,358.3,24956,1,4,0)
 ;;=4^T82.591A
 ;;^UTILITY(U,$J,358.3,24956,2)
 ;;=^5054887
 ;;^UTILITY(U,$J,358.3,24957,0)
 ;;=T82.593A^^124^1239^138
 ;;^UTILITY(U,$J,358.3,24957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24957,1,3,0)
 ;;=3^Mechanical Compl of Balloon Device,Init Encntr
 ;;^UTILITY(U,$J,358.3,24957,1,4,0)
 ;;=4^T82.593A
 ;;^UTILITY(U,$J,358.3,24957,2)
 ;;=^5054893
 ;;^UTILITY(U,$J,358.3,24958,0)
 ;;=T82.595A^^124^1239^155
 ;;^UTILITY(U,$J,358.3,24958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24958,1,3,0)
 ;;=3^Mechanical Compl of Umbrella Device,Init Encntr
 ;;^UTILITY(U,$J,358.3,24958,1,4,0)
 ;;=4^T82.595A
 ;;^UTILITY(U,$J,358.3,24958,2)
 ;;=^5054899
 ;;^UTILITY(U,$J,358.3,24959,0)
 ;;=T82.599A^^124^1239^140
 ;;^UTILITY(U,$J,358.3,24959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24959,1,3,0)
 ;;=3^Mechanical Compl of Cardiac/Vascular Device/Implant Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,24959,1,4,0)
 ;;=4^T82.599A
 ;;^UTILITY(U,$J,358.3,24959,2)
 ;;=^5054905
 ;;^UTILITY(U,$J,358.3,24960,0)
 ;;=T85.01XA^^124^1239^19
 ;;^UTILITY(U,$J,358.3,24960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24960,1,3,0)
 ;;=3^Breakdown of Ventricular Intracranial Shunt,Init Encntr
 ;;^UTILITY(U,$J,358.3,24960,1,4,0)
 ;;=4^T85.01XA
 ;;^UTILITY(U,$J,358.3,24960,2)
 ;;=^5055478
 ;;^UTILITY(U,$J,358.3,24961,0)
 ;;=T85.02XA^^124^1239^48
 ;;^UTILITY(U,$J,358.3,24961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24961,1,3,0)
 ;;=3^Displacement of Ventricular Intracranial Shunt,Init Encntr
 ;;^UTILITY(U,$J,358.3,24961,1,4,0)
 ;;=4^T85.02XA
 ;;^UTILITY(U,$J,358.3,24961,2)
 ;;=^5055481
 ;;^UTILITY(U,$J,358.3,24962,0)
 ;;=T85.03XA^^124^1239^136
 ;;^UTILITY(U,$J,358.3,24962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24962,1,3,0)
 ;;=3^Leakage of Ventricular Intracranial Shunt,Init Encntr
 ;;^UTILITY(U,$J,358.3,24962,1,4,0)
 ;;=4^T85.03XA
 ;;^UTILITY(U,$J,358.3,24962,2)
 ;;=^5055484
 ;;^UTILITY(U,$J,358.3,24963,0)
 ;;=T85.09XA^^124^1239^157
 ;;^UTILITY(U,$J,358.3,24963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24963,1,3,0)
 ;;=3^Mechanical Compl of Ventricular Intracranial Shunt,Init Encntr
 ;;^UTILITY(U,$J,358.3,24963,1,4,0)
 ;;=4^T85.09XA
 ;;^UTILITY(U,$J,358.3,24963,2)
 ;;=^5055487
 ;;^UTILITY(U,$J,358.3,24964,0)
 ;;=T85.110A^^124^1239^9
 ;;^UTILITY(U,$J,358.3,24964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24964,1,3,0)
 ;;=3^Breakdown of Implanted Electronic Neurostim of Brain,Init Encntr
 ;;^UTILITY(U,$J,358.3,24964,1,4,0)
 ;;=4^T85.110A
 ;;^UTILITY(U,$J,358.3,24964,2)
 ;;=^5055490
 ;;^UTILITY(U,$J,358.3,24965,0)
 ;;=T85.111A^^124^1239^10
 ;;^UTILITY(U,$J,358.3,24965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24965,1,3,0)
 ;;=3^Breakdown of Implanted Electronic Neurostim of Periph Nrv,Init Encntr
 ;;^UTILITY(U,$J,358.3,24965,1,4,0)
 ;;=4^T85.111A
 ;;^UTILITY(U,$J,358.3,24965,2)
 ;;=^5055493
 ;;^UTILITY(U,$J,358.3,24966,0)
 ;;=T85.112A^^124^1239^11
 ;;^UTILITY(U,$J,358.3,24966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24966,1,3,0)
 ;;=3^Breakdown of Implanted Electronic Neurostim of Spinal Cord,Init Encntr
 ;;^UTILITY(U,$J,358.3,24966,1,4,0)
 ;;=4^T85.112A
 ;;^UTILITY(U,$J,358.3,24966,2)
 ;;=^5055496
 ;;^UTILITY(U,$J,358.3,24967,0)
 ;;=T85.118A^^124^1239^12
 ;;^UTILITY(U,$J,358.3,24967,1,0)
 ;;=^358.31IA^4^2
