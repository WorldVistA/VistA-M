IBDEI13G ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18594,0)
 ;;=M00.9^^79^880^88
 ;;^UTILITY(U,$J,358.3,18594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18594,1,3,0)
 ;;=3^Pyogenic Arthritis,Unspec
 ;;^UTILITY(U,$J,358.3,18594,1,4,0)
 ;;=4^M00.9
 ;;^UTILITY(U,$J,358.3,18594,2)
 ;;=^5009693
 ;;^UTILITY(U,$J,358.3,18595,0)
 ;;=M86.10^^79^880^7
 ;;^UTILITY(U,$J,358.3,18595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18595,1,3,0)
 ;;=3^Acute Osteomyelitis,Unspec Site,NEC
 ;;^UTILITY(U,$J,358.3,18595,1,4,0)
 ;;=4^M86.10
 ;;^UTILITY(U,$J,358.3,18595,2)
 ;;=^5014521
 ;;^UTILITY(U,$J,358.3,18596,0)
 ;;=M86.20^^79^880^97
 ;;^UTILITY(U,$J,358.3,18596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18596,1,3,0)
 ;;=3^Subacute Osteomyelitis,Unspec Site
 ;;^UTILITY(U,$J,358.3,18596,1,4,0)
 ;;=4^M86.20
 ;;^UTILITY(U,$J,358.3,18596,2)
 ;;=^5014535
 ;;^UTILITY(U,$J,358.3,18597,0)
 ;;=M86.60^^79^880^33
 ;;^UTILITY(U,$J,358.3,18597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18597,1,3,0)
 ;;=3^Chronic Osteomyelitis,Unspec Site,NEC
 ;;^UTILITY(U,$J,358.3,18597,1,4,0)
 ;;=4^M86.60
 ;;^UTILITY(U,$J,358.3,18597,2)
 ;;=^5014630
 ;;^UTILITY(U,$J,358.3,18598,0)
 ;;=R50.9^^79^880^52
 ;;^UTILITY(U,$J,358.3,18598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18598,1,3,0)
 ;;=3^Fever,Unspec
 ;;^UTILITY(U,$J,358.3,18598,1,4,0)
 ;;=4^R50.9
 ;;^UTILITY(U,$J,358.3,18598,2)
 ;;=^5019512
 ;;^UTILITY(U,$J,358.3,18599,0)
 ;;=N70.91^^79^880^90
 ;;^UTILITY(U,$J,358.3,18599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18599,1,3,0)
 ;;=3^Salpingitis,Unspec
 ;;^UTILITY(U,$J,358.3,18599,1,4,0)
 ;;=4^N70.91
 ;;^UTILITY(U,$J,358.3,18599,2)
 ;;=^5015806
 ;;^UTILITY(U,$J,358.3,18600,0)
 ;;=N70.93^^79^880^89
 ;;^UTILITY(U,$J,358.3,18600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18600,1,3,0)
 ;;=3^Salpingitis & Oophoritis,Unspec
 ;;^UTILITY(U,$J,358.3,18600,1,4,0)
 ;;=4^N70.93
 ;;^UTILITY(U,$J,358.3,18600,2)
 ;;=^5015808
 ;;^UTILITY(U,$J,358.3,18601,0)
 ;;=C77.0^^79^881^8
 ;;^UTILITY(U,$J,358.3,18601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18601,1,3,0)
 ;;=3^Secondary Malig Neop of Head/Face/Neck Lymph Nodes
 ;;^UTILITY(U,$J,358.3,18601,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,18601,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,18602,0)
 ;;=C77.1^^79^881^12
 ;;^UTILITY(U,$J,358.3,18602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18602,1,3,0)
 ;;=3^Secondary Malig Neop of Intrathoracic Lymph Nodes
 ;;^UTILITY(U,$J,358.3,18602,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,18602,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,18603,0)
 ;;=C77.2^^79^881^10
 ;;^UTILITY(U,$J,358.3,18603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18603,1,3,0)
 ;;=3^Secondary Malig Neop of Intra-Abdominal Lymph Nodes
 ;;^UTILITY(U,$J,358.3,18603,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,18603,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,18604,0)
 ;;=C77.3^^79^881^1
 ;;^UTILITY(U,$J,358.3,18604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18604,1,3,0)
 ;;=3^Secondary Malig Neop of Axilla/Upper Limb Lymph Nodes
 ;;^UTILITY(U,$J,358.3,18604,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,18604,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,18605,0)
 ;;=C77.4^^79^881^9
 ;;^UTILITY(U,$J,358.3,18605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18605,1,3,0)
 ;;=3^Secondary Malig Neop of Inguinal/Lower Limb Lymph Nodes
 ;;^UTILITY(U,$J,358.3,18605,1,4,0)
 ;;=4^C77.4
 ;;^UTILITY(U,$J,358.3,18605,2)
 ;;=^5001331
 ;;^UTILITY(U,$J,358.3,18606,0)
 ;;=C77.5^^79^881^11
 ;;^UTILITY(U,$J,358.3,18606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18606,1,3,0)
 ;;=3^Secondary Malig Neop of Intrapelvic Lymph Nodes
 ;;^UTILITY(U,$J,358.3,18606,1,4,0)
 ;;=4^C77.5
