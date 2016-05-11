IBDEI27P ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37519,1,4,0)
 ;;=4^M86.111
 ;;^UTILITY(U,$J,358.3,37519,2)
 ;;=^5014522
 ;;^UTILITY(U,$J,358.3,37520,0)
 ;;=M86.112^^140^1793^7
 ;;^UTILITY(U,$J,358.3,37520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37520,1,3,0)
 ;;=3^Osteomyelitis, acute, lft shldr, oth
 ;;^UTILITY(U,$J,358.3,37520,1,4,0)
 ;;=4^M86.112
 ;;^UTILITY(U,$J,358.3,37520,2)
 ;;=^5014523
 ;;^UTILITY(U,$J,358.3,37521,0)
 ;;=M86.121^^140^1793^14
 ;;^UTILITY(U,$J,358.3,37521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37521,1,3,0)
 ;;=3^Osteomyelitis, acute, rt humerus, oth
 ;;^UTILITY(U,$J,358.3,37521,1,4,0)
 ;;=4^M86.121
 ;;^UTILITY(U,$J,358.3,37521,2)
 ;;=^5014525
 ;;^UTILITY(U,$J,358.3,37522,0)
 ;;=M86.122^^140^1793^5
 ;;^UTILITY(U,$J,358.3,37522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37522,1,3,0)
 ;;=3^Osteomyelitis, acute, lft humerus, otho
 ;;^UTILITY(U,$J,358.3,37522,1,4,0)
 ;;=4^M86.122
 ;;^UTILITY(U,$J,358.3,37522,2)
 ;;=^5134060
 ;;^UTILITY(U,$J,358.3,37523,0)
 ;;=M86.211^^140^1793^46
 ;;^UTILITY(U,$J,358.3,37523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37523,1,3,0)
 ;;=3^Osteomyelitis, subacute, rt shldr
 ;;^UTILITY(U,$J,358.3,37523,1,4,0)
 ;;=4^M86.211
 ;;^UTILITY(U,$J,358.3,37523,2)
 ;;=^5014536
 ;;^UTILITY(U,$J,358.3,37524,0)
 ;;=M86.212^^140^1793^39
 ;;^UTILITY(U,$J,358.3,37524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37524,1,3,0)
 ;;=3^Osteomyelitis, subacute, lft shldr
 ;;^UTILITY(U,$J,358.3,37524,1,4,0)
 ;;=4^M86.212
 ;;^UTILITY(U,$J,358.3,37524,2)
 ;;=^5014537
 ;;^UTILITY(U,$J,358.3,37525,0)
 ;;=M86.121^^140^1793^15
 ;;^UTILITY(U,$J,358.3,37525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37525,1,3,0)
 ;;=3^Osteomyelitis, acute, rt humerus, oth
 ;;^UTILITY(U,$J,358.3,37525,1,4,0)
 ;;=4^M86.121
 ;;^UTILITY(U,$J,358.3,37525,2)
 ;;=^5014525
 ;;^UTILITY(U,$J,358.3,37526,0)
 ;;=M86.122^^140^1793^4
 ;;^UTILITY(U,$J,358.3,37526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37526,1,3,0)
 ;;=3^Osteomyelitis, acute, lft humerus, oth
 ;;^UTILITY(U,$J,358.3,37526,1,4,0)
 ;;=4^M86.122
 ;;^UTILITY(U,$J,358.3,37526,2)
 ;;=^5134060
 ;;^UTILITY(U,$J,358.3,37527,0)
 ;;=M86.221^^140^1793^45
 ;;^UTILITY(U,$J,358.3,37527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37527,1,3,0)
 ;;=3^Osteomyelitis, subacute, rt humerus
 ;;^UTILITY(U,$J,358.3,37527,1,4,0)
 ;;=4^M86.221
 ;;^UTILITY(U,$J,358.3,37527,2)
 ;;=^5014539
 ;;^UTILITY(U,$J,358.3,37528,0)
 ;;=M86.222^^140^1793^38
 ;;^UTILITY(U,$J,358.3,37528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37528,1,3,0)
 ;;=3^Osteomyelitis, subacute, lft humerus
 ;;^UTILITY(U,$J,358.3,37528,1,4,0)
 ;;=4^M86.222
 ;;^UTILITY(U,$J,358.3,37528,2)
 ;;=^5014540
 ;;^UTILITY(U,$J,358.3,37529,0)
 ;;=M86.131^^140^1793^67
 ;;^UTILITY(U,$J,358.3,37529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37529,1,3,0)
 ;;=3^Ostoemyelitis, acute, rt radius & ulna, oth
 ;;^UTILITY(U,$J,358.3,37529,1,4,0)
 ;;=4^M86.131
 ;;^UTILITY(U,$J,358.3,37529,2)
 ;;=^5014526
 ;;^UTILITY(U,$J,358.3,37530,0)
 ;;=M86.132^^140^1793^6
 ;;^UTILITY(U,$J,358.3,37530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37530,1,3,0)
 ;;=3^Osteomyelitis, acute, lft radius & ulna, oth
 ;;^UTILITY(U,$J,358.3,37530,1,4,0)
 ;;=4^M86.132
 ;;^UTILITY(U,$J,358.3,37530,2)
 ;;=^5134062
 ;;^UTILITY(U,$J,358.3,37531,0)
 ;;=M86.141^^140^1793^13
 ;;^UTILITY(U,$J,358.3,37531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37531,1,3,0)
 ;;=3^Osteomyelitis, acute, rt hand, oth
 ;;^UTILITY(U,$J,358.3,37531,1,4,0)
 ;;=4^M86.141
 ;;^UTILITY(U,$J,358.3,37531,2)
 ;;=^5014527
 ;;^UTILITY(U,$J,358.3,37532,0)
 ;;=M86.142^^140^1793^3
 ;;^UTILITY(U,$J,358.3,37532,1,0)
 ;;=^358.31IA^4^2
