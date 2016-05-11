IBDEI27Q ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37532,1,3,0)
 ;;=3^Osteomyelitis, acute, lft hand, oth
 ;;^UTILITY(U,$J,358.3,37532,1,4,0)
 ;;=4^M86.142
 ;;^UTILITY(U,$J,358.3,37532,2)
 ;;=^5134064
 ;;^UTILITY(U,$J,358.3,37533,0)
 ;;=M86.151^^140^1793^12
 ;;^UTILITY(U,$J,358.3,37533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37533,1,3,0)
 ;;=3^Osteomyelitis, acute, rt femur, oth
 ;;^UTILITY(U,$J,358.3,37533,1,4,0)
 ;;=4^M86.151
 ;;^UTILITY(U,$J,358.3,37533,2)
 ;;=^5014528
 ;;^UTILITY(U,$J,358.3,37534,0)
 ;;=M86.152^^140^1793^2
 ;;^UTILITY(U,$J,358.3,37534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37534,1,3,0)
 ;;=3^Osteomyelitis, acute, lft femur, oth
 ;;^UTILITY(U,$J,358.3,37534,1,4,0)
 ;;=4^M86.152
 ;;^UTILITY(U,$J,358.3,37534,2)
 ;;=^5134066
 ;;^UTILITY(U,$J,358.3,37535,0)
 ;;=M86.251^^140^1793^44
 ;;^UTILITY(U,$J,358.3,37535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37535,1,3,0)
 ;;=3^Osteomyelitis, subacute, rt femur
 ;;^UTILITY(U,$J,358.3,37535,1,4,0)
 ;;=4^M86.251
 ;;^UTILITY(U,$J,358.3,37535,2)
 ;;=^5014548
 ;;^UTILITY(U,$J,358.3,37536,0)
 ;;=M86.252^^140^1793^37
 ;;^UTILITY(U,$J,358.3,37536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37536,1,3,0)
 ;;=3^Osteomyelitis, subacute, lft femur
 ;;^UTILITY(U,$J,358.3,37536,1,4,0)
 ;;=4^M86.252
 ;;^UTILITY(U,$J,358.3,37536,2)
 ;;=^5014549
 ;;^UTILITY(U,$J,358.3,37537,0)
 ;;=M86.161^^140^1793^17
 ;;^UTILITY(U,$J,358.3,37537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37537,1,3,0)
 ;;=3^Osteomyelitis, acute, rt tibia/fib, oth
 ;;^UTILITY(U,$J,358.3,37537,1,4,0)
 ;;=4^M86.161
 ;;^UTILITY(U,$J,358.3,37537,2)
 ;;=^5014529
 ;;^UTILITY(U,$J,358.3,37538,0)
 ;;=M86.162^^140^1793^8
 ;;^UTILITY(U,$J,358.3,37538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37538,1,3,0)
 ;;=3^Osteomyelitis, acute, lft tibia/fib, oth
 ;;^UTILITY(U,$J,358.3,37538,1,4,0)
 ;;=4^M86.162
 ;;^UTILITY(U,$J,358.3,37538,2)
 ;;=^5134068
 ;;^UTILITY(U,$J,358.3,37539,0)
 ;;=M86.261^^140^1793^47
 ;;^UTILITY(U,$J,358.3,37539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37539,1,3,0)
 ;;=3^Osteomyelitis, subacute, rt tib/fib
 ;;^UTILITY(U,$J,358.3,37539,1,4,0)
 ;;=4^M86.261
 ;;^UTILITY(U,$J,358.3,37539,2)
 ;;=^5014551
 ;;^UTILITY(U,$J,358.3,37540,0)
 ;;=M86.262^^140^1793^40
 ;;^UTILITY(U,$J,358.3,37540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37540,1,3,0)
 ;;=3^Osteomyelitis, subacute, lft tib/fib
 ;;^UTILITY(U,$J,358.3,37540,1,4,0)
 ;;=4^M86.262
 ;;^UTILITY(U,$J,358.3,37540,2)
 ;;=^5014552
 ;;^UTILITY(U,$J,358.3,37541,0)
 ;;=M86.171^^140^1793^11
 ;;^UTILITY(U,$J,358.3,37541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37541,1,3,0)
 ;;=3^Osteomyelitis, acute, rt ankle & foot, oth
 ;;^UTILITY(U,$J,358.3,37541,1,4,0)
 ;;=4^M86.171
 ;;^UTILITY(U,$J,358.3,37541,2)
 ;;=^5014530
 ;;^UTILITY(U,$J,358.3,37542,0)
 ;;=M86.172^^140^1793^1
 ;;^UTILITY(U,$J,358.3,37542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37542,1,3,0)
 ;;=3^Osteomyelitis, acute, lft ankle & foot, oth
 ;;^UTILITY(U,$J,358.3,37542,1,4,0)
 ;;=4^M86.172
 ;;^UTILITY(U,$J,358.3,37542,2)
 ;;=^5014531
 ;;^UTILITY(U,$J,358.3,37543,0)
 ;;=M86.271^^140^1793^43
 ;;^UTILITY(U,$J,358.3,37543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37543,1,3,0)
 ;;=3^Osteomyelitis, subacute, rt ankle & foot
 ;;^UTILITY(U,$J,358.3,37543,1,4,0)
 ;;=4^M86.271
 ;;^UTILITY(U,$J,358.3,37543,2)
 ;;=^5014554
 ;;^UTILITY(U,$J,358.3,37544,0)
 ;;=M86.272^^140^1793^36
 ;;^UTILITY(U,$J,358.3,37544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37544,1,3,0)
 ;;=3^Osteomyelitis, subacute, lft ankle & foot
 ;;^UTILITY(U,$J,358.3,37544,1,4,0)
 ;;=4^M86.272
 ;;^UTILITY(U,$J,358.3,37544,2)
 ;;=^5014555
