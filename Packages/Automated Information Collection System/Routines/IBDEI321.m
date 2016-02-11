IBDEI321 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,51212,1,3,0)
 ;;=3^Osteomyelitis, acute, lft hand, oth
 ;;^UTILITY(U,$J,358.3,51212,1,4,0)
 ;;=4^M86.142
 ;;^UTILITY(U,$J,358.3,51212,2)
 ;;=^5134064
 ;;^UTILITY(U,$J,358.3,51213,0)
 ;;=M86.151^^222^2472^12
 ;;^UTILITY(U,$J,358.3,51213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51213,1,3,0)
 ;;=3^Osteomyelitis, acute, rt femur, oth
 ;;^UTILITY(U,$J,358.3,51213,1,4,0)
 ;;=4^M86.151
 ;;^UTILITY(U,$J,358.3,51213,2)
 ;;=^5014528
 ;;^UTILITY(U,$J,358.3,51214,0)
 ;;=M86.152^^222^2472^2
 ;;^UTILITY(U,$J,358.3,51214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51214,1,3,0)
 ;;=3^Osteomyelitis, acute, lft femur, oth
 ;;^UTILITY(U,$J,358.3,51214,1,4,0)
 ;;=4^M86.152
 ;;^UTILITY(U,$J,358.3,51214,2)
 ;;=^5134066
 ;;^UTILITY(U,$J,358.3,51215,0)
 ;;=M86.251^^222^2472^44
 ;;^UTILITY(U,$J,358.3,51215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51215,1,3,0)
 ;;=3^Osteomyelitis, subacute, rt femur
 ;;^UTILITY(U,$J,358.3,51215,1,4,0)
 ;;=4^M86.251
 ;;^UTILITY(U,$J,358.3,51215,2)
 ;;=^5014548
 ;;^UTILITY(U,$J,358.3,51216,0)
 ;;=M86.252^^222^2472^37
 ;;^UTILITY(U,$J,358.3,51216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51216,1,3,0)
 ;;=3^Osteomyelitis, subacute, lft femur
 ;;^UTILITY(U,$J,358.3,51216,1,4,0)
 ;;=4^M86.252
 ;;^UTILITY(U,$J,358.3,51216,2)
 ;;=^5014549
 ;;^UTILITY(U,$J,358.3,51217,0)
 ;;=M86.161^^222^2472^17
 ;;^UTILITY(U,$J,358.3,51217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51217,1,3,0)
 ;;=3^Osteomyelitis, acute, rt tibia/fib, oth
 ;;^UTILITY(U,$J,358.3,51217,1,4,0)
 ;;=4^M86.161
 ;;^UTILITY(U,$J,358.3,51217,2)
 ;;=^5014529
 ;;^UTILITY(U,$J,358.3,51218,0)
 ;;=M86.162^^222^2472^8
 ;;^UTILITY(U,$J,358.3,51218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51218,1,3,0)
 ;;=3^Osteomyelitis, acute, lft tibia/fib, oth
 ;;^UTILITY(U,$J,358.3,51218,1,4,0)
 ;;=4^M86.162
 ;;^UTILITY(U,$J,358.3,51218,2)
 ;;=^5134068
 ;;^UTILITY(U,$J,358.3,51219,0)
 ;;=M86.261^^222^2472^47
 ;;^UTILITY(U,$J,358.3,51219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51219,1,3,0)
 ;;=3^Osteomyelitis, subacute, rt tib/fib
 ;;^UTILITY(U,$J,358.3,51219,1,4,0)
 ;;=4^M86.261
 ;;^UTILITY(U,$J,358.3,51219,2)
 ;;=^5014551
 ;;^UTILITY(U,$J,358.3,51220,0)
 ;;=M86.262^^222^2472^40
 ;;^UTILITY(U,$J,358.3,51220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51220,1,3,0)
 ;;=3^Osteomyelitis, subacute, lft tib/fib
 ;;^UTILITY(U,$J,358.3,51220,1,4,0)
 ;;=4^M86.262
 ;;^UTILITY(U,$J,358.3,51220,2)
 ;;=^5014552
 ;;^UTILITY(U,$J,358.3,51221,0)
 ;;=M86.171^^222^2472^11
 ;;^UTILITY(U,$J,358.3,51221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51221,1,3,0)
 ;;=3^Osteomyelitis, acute, rt ankle & foot, oth
 ;;^UTILITY(U,$J,358.3,51221,1,4,0)
 ;;=4^M86.171
 ;;^UTILITY(U,$J,358.3,51221,2)
 ;;=^5014530
 ;;^UTILITY(U,$J,358.3,51222,0)
 ;;=M86.172^^222^2472^1
 ;;^UTILITY(U,$J,358.3,51222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51222,1,3,0)
 ;;=3^Osteomyelitis, acute, lft ankle & foot, oth
 ;;^UTILITY(U,$J,358.3,51222,1,4,0)
 ;;=4^M86.172
 ;;^UTILITY(U,$J,358.3,51222,2)
 ;;=^5014531
 ;;^UTILITY(U,$J,358.3,51223,0)
 ;;=M86.271^^222^2472^43
 ;;^UTILITY(U,$J,358.3,51223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51223,1,3,0)
 ;;=3^Osteomyelitis, subacute, rt ankle & foot
 ;;^UTILITY(U,$J,358.3,51223,1,4,0)
 ;;=4^M86.271
 ;;^UTILITY(U,$J,358.3,51223,2)
 ;;=^5014554
 ;;^UTILITY(U,$J,358.3,51224,0)
 ;;=M86.272^^222^2472^36
 ;;^UTILITY(U,$J,358.3,51224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51224,1,3,0)
 ;;=3^Osteomyelitis, subacute, lft ankle & foot
 ;;^UTILITY(U,$J,358.3,51224,1,4,0)
 ;;=4^M86.272
 ;;^UTILITY(U,$J,358.3,51224,2)
 ;;=^5014555
