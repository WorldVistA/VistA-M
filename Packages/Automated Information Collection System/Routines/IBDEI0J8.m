IBDEI0J8 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9339,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9339,1,4,0)
 ;;=4^Oth Specified Pre-Op Exam
 ;;^UTILITY(U,$J,358.3,9339,1,5,0)
 ;;=5^V72.83
 ;;^UTILITY(U,$J,358.3,9339,2)
 ;;=^321505
 ;;^UTILITY(U,$J,358.3,9340,0)
 ;;=196.0^^55^619^2
 ;;^UTILITY(U,$J,358.3,9340,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9340,1,4,0)
 ;;=4^Malig Neop Lymph,Head/Neck
 ;;^UTILITY(U,$J,358.3,9340,1,5,0)
 ;;=5^196.0
 ;;^UTILITY(U,$J,358.3,9340,2)
 ;;=^267314
 ;;^UTILITY(U,$J,358.3,9341,0)
 ;;=196.1^^55^619^6
 ;;^UTILITY(U,$J,358.3,9341,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9341,1,4,0)
 ;;=4^Malig Neop Lymph,Intrathoracic
 ;;^UTILITY(U,$J,358.3,9341,1,5,0)
 ;;=5^196.1
 ;;^UTILITY(U,$J,358.3,9341,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,9342,0)
 ;;=196.2^^55^619^4
 ;;^UTILITY(U,$J,358.3,9342,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9342,1,4,0)
 ;;=4^Malig Neop Lymph,Intra-abdominal
 ;;^UTILITY(U,$J,358.3,9342,1,5,0)
 ;;=5^196.2
 ;;^UTILITY(U,$J,358.3,9342,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,9343,0)
 ;;=196.3^^55^619^1
 ;;^UTILITY(U,$J,358.3,9343,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9343,1,4,0)
 ;;=4^Malig Neop Lymph,Axilla/Arm
 ;;^UTILITY(U,$J,358.3,9343,1,5,0)
 ;;=5^196.3
 ;;^UTILITY(U,$J,358.3,9343,2)
 ;;=^267317
 ;;^UTILITY(U,$J,358.3,9344,0)
 ;;=196.5^^55^619^3
 ;;^UTILITY(U,$J,358.3,9344,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9344,1,4,0)
 ;;=4^Malig Neop Lymph,Inguin/Leg
 ;;^UTILITY(U,$J,358.3,9344,1,5,0)
 ;;=5^196.5
 ;;^UTILITY(U,$J,358.3,9344,2)
 ;;=^267318
 ;;^UTILITY(U,$J,358.3,9345,0)
 ;;=196.6^^55^619^5
 ;;^UTILITY(U,$J,358.3,9345,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9345,1,4,0)
 ;;=4^Malig Neop Lymph,Intrapelvic
 ;;^UTILITY(U,$J,358.3,9345,1,5,0)
 ;;=5^196.6
 ;;^UTILITY(U,$J,358.3,9345,2)
 ;;=^267319
 ;;^UTILITY(U,$J,358.3,9346,0)
 ;;=196.8^^55^619^7
 ;;^UTILITY(U,$J,358.3,9346,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9346,1,4,0)
 ;;=4^Malig Neop Lymph,Multiple Sites
 ;;^UTILITY(U,$J,358.3,9346,1,5,0)
 ;;=5^196.8
 ;;^UTILITY(U,$J,358.3,9346,2)
 ;;=^267320
 ;;^UTILITY(U,$J,358.3,9347,0)
 ;;=197.0^^55^619^17
 ;;^UTILITY(U,$J,358.3,9347,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9347,1,4,0)
 ;;=4^Secondary Malig Neop,Lung
 ;;^UTILITY(U,$J,358.3,9347,1,5,0)
 ;;=5^197.0
 ;;^UTILITY(U,$J,358.3,9347,2)
 ;;=^267322
 ;;^UTILITY(U,$J,358.3,9348,0)
 ;;=197.1^^55^619^18
 ;;^UTILITY(U,$J,358.3,9348,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9348,1,4,0)
 ;;=4^Secondary Malig Neop,Mediastinum
 ;;^UTILITY(U,$J,358.3,9348,1,5,0)
 ;;=5^197.1
 ;;^UTILITY(U,$J,358.3,9348,2)
 ;;=^267323
 ;;^UTILITY(U,$J,358.3,9349,0)
 ;;=197.2^^55^619^22
 ;;^UTILITY(U,$J,358.3,9349,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9349,1,4,0)
 ;;=4^Secondary Malig Neop,Pleura
 ;;^UTILITY(U,$J,358.3,9349,1,5,0)
 ;;=5^197.2
 ;;^UTILITY(U,$J,358.3,9349,2)
 ;;=^267324
 ;;^UTILITY(U,$J,358.3,9350,0)
 ;;=197.3^^55^619^23
 ;;^UTILITY(U,$J,358.3,9350,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9350,1,4,0)
 ;;=4^Secondary Malig Neop,Resp NEC
 ;;^UTILITY(U,$J,358.3,9350,1,5,0)
 ;;=5^197.3
 ;;^UTILITY(U,$J,358.3,9350,2)
 ;;=^267325
 ;;^UTILITY(U,$J,358.3,9351,0)
 ;;=197.4^^55^619^25
 ;;^UTILITY(U,$J,358.3,9351,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9351,1,4,0)
 ;;=4^Secondary Malig Neop,Sm Bowel
 ;;^UTILITY(U,$J,358.3,9351,1,5,0)
 ;;=5^197.4
 ;;^UTILITY(U,$J,358.3,9351,2)
 ;;=^267326
 ;;^UTILITY(U,$J,358.3,9352,0)
 ;;=197.5^^55^619^15
 ;;^UTILITY(U,$J,358.3,9352,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9352,1,4,0)
 ;;=4^Secondary Malig Neop,Lg Bowel
 ;;^UTILITY(U,$J,358.3,9352,1,5,0)
 ;;=5^197.5
