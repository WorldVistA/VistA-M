IBDEI320 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,51199,1,4,0)
 ;;=4^M86.111
 ;;^UTILITY(U,$J,358.3,51199,2)
 ;;=^5014522
 ;;^UTILITY(U,$J,358.3,51200,0)
 ;;=M86.112^^222^2472^7
 ;;^UTILITY(U,$J,358.3,51200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51200,1,3,0)
 ;;=3^Osteomyelitis, acute, lft shldr, oth
 ;;^UTILITY(U,$J,358.3,51200,1,4,0)
 ;;=4^M86.112
 ;;^UTILITY(U,$J,358.3,51200,2)
 ;;=^5014523
 ;;^UTILITY(U,$J,358.3,51201,0)
 ;;=M86.121^^222^2472^14
 ;;^UTILITY(U,$J,358.3,51201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51201,1,3,0)
 ;;=3^Osteomyelitis, acute, rt humerus, oth
 ;;^UTILITY(U,$J,358.3,51201,1,4,0)
 ;;=4^M86.121
 ;;^UTILITY(U,$J,358.3,51201,2)
 ;;=^5014525
 ;;^UTILITY(U,$J,358.3,51202,0)
 ;;=M86.122^^222^2472^5
 ;;^UTILITY(U,$J,358.3,51202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51202,1,3,0)
 ;;=3^Osteomyelitis, acute, lft humerus, otho
 ;;^UTILITY(U,$J,358.3,51202,1,4,0)
 ;;=4^M86.122
 ;;^UTILITY(U,$J,358.3,51202,2)
 ;;=^5134060
 ;;^UTILITY(U,$J,358.3,51203,0)
 ;;=M86.211^^222^2472^46
 ;;^UTILITY(U,$J,358.3,51203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51203,1,3,0)
 ;;=3^Osteomyelitis, subacute, rt shldr
 ;;^UTILITY(U,$J,358.3,51203,1,4,0)
 ;;=4^M86.211
 ;;^UTILITY(U,$J,358.3,51203,2)
 ;;=^5014536
 ;;^UTILITY(U,$J,358.3,51204,0)
 ;;=M86.212^^222^2472^39
 ;;^UTILITY(U,$J,358.3,51204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51204,1,3,0)
 ;;=3^Osteomyelitis, subacute, lft shldr
 ;;^UTILITY(U,$J,358.3,51204,1,4,0)
 ;;=4^M86.212
 ;;^UTILITY(U,$J,358.3,51204,2)
 ;;=^5014537
 ;;^UTILITY(U,$J,358.3,51205,0)
 ;;=M86.121^^222^2472^15
 ;;^UTILITY(U,$J,358.3,51205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51205,1,3,0)
 ;;=3^Osteomyelitis, acute, rt humerus, oth
 ;;^UTILITY(U,$J,358.3,51205,1,4,0)
 ;;=4^M86.121
 ;;^UTILITY(U,$J,358.3,51205,2)
 ;;=^5014525
 ;;^UTILITY(U,$J,358.3,51206,0)
 ;;=M86.122^^222^2472^4
 ;;^UTILITY(U,$J,358.3,51206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51206,1,3,0)
 ;;=3^Osteomyelitis, acute, lft humerus, oth
 ;;^UTILITY(U,$J,358.3,51206,1,4,0)
 ;;=4^M86.122
 ;;^UTILITY(U,$J,358.3,51206,2)
 ;;=^5134060
 ;;^UTILITY(U,$J,358.3,51207,0)
 ;;=M86.221^^222^2472^45
 ;;^UTILITY(U,$J,358.3,51207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51207,1,3,0)
 ;;=3^Osteomyelitis, subacute, rt humerus
 ;;^UTILITY(U,$J,358.3,51207,1,4,0)
 ;;=4^M86.221
 ;;^UTILITY(U,$J,358.3,51207,2)
 ;;=^5014539
 ;;^UTILITY(U,$J,358.3,51208,0)
 ;;=M86.222^^222^2472^38
 ;;^UTILITY(U,$J,358.3,51208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51208,1,3,0)
 ;;=3^Osteomyelitis, subacute, lft humerus
 ;;^UTILITY(U,$J,358.3,51208,1,4,0)
 ;;=4^M86.222
 ;;^UTILITY(U,$J,358.3,51208,2)
 ;;=^5014540
 ;;^UTILITY(U,$J,358.3,51209,0)
 ;;=M86.131^^222^2472^67
 ;;^UTILITY(U,$J,358.3,51209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51209,1,3,0)
 ;;=3^Ostoemyelitis, acute, rt radius & ulna, oth
 ;;^UTILITY(U,$J,358.3,51209,1,4,0)
 ;;=4^M86.131
 ;;^UTILITY(U,$J,358.3,51209,2)
 ;;=^5014526
 ;;^UTILITY(U,$J,358.3,51210,0)
 ;;=M86.132^^222^2472^6
 ;;^UTILITY(U,$J,358.3,51210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51210,1,3,0)
 ;;=3^Osteomyelitis, acute, lft radius & ulna, oth
 ;;^UTILITY(U,$J,358.3,51210,1,4,0)
 ;;=4^M86.132
 ;;^UTILITY(U,$J,358.3,51210,2)
 ;;=^5134062
 ;;^UTILITY(U,$J,358.3,51211,0)
 ;;=M86.141^^222^2472^13
 ;;^UTILITY(U,$J,358.3,51211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51211,1,3,0)
 ;;=3^Osteomyelitis, acute, rt hand, oth
 ;;^UTILITY(U,$J,358.3,51211,1,4,0)
 ;;=4^M86.141
 ;;^UTILITY(U,$J,358.3,51211,2)
 ;;=^5014527
 ;;^UTILITY(U,$J,358.3,51212,0)
 ;;=M86.142^^222^2472^3
 ;;^UTILITY(U,$J,358.3,51212,1,0)
 ;;=^358.31IA^4^2
