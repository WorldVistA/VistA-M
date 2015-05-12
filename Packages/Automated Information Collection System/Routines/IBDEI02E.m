IBDEI02E ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2792,1,3,0)
 ;;=3^Osteomyelitis, subacute, rt femur
 ;;^UTILITY(U,$J,358.3,2792,1,4,0)
 ;;=4^M86.251
 ;;^UTILITY(U,$J,358.3,2792,2)
 ;;=^5014548
 ;;^UTILITY(U,$J,358.3,2793,0)
 ;;=M86.252^^12^110^37
 ;;^UTILITY(U,$J,358.3,2793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2793,1,3,0)
 ;;=3^Osteomyelitis, subacute, lft femur
 ;;^UTILITY(U,$J,358.3,2793,1,4,0)
 ;;=4^M86.252
 ;;^UTILITY(U,$J,358.3,2793,2)
 ;;=^5014549
 ;;^UTILITY(U,$J,358.3,2794,0)
 ;;=M86.161^^12^110^17
 ;;^UTILITY(U,$J,358.3,2794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2794,1,3,0)
 ;;=3^Osteomyelitis, acute, rt tibia/fib, oth
 ;;^UTILITY(U,$J,358.3,2794,1,4,0)
 ;;=4^M86.161
 ;;^UTILITY(U,$J,358.3,2794,2)
 ;;=^5014529
 ;;^UTILITY(U,$J,358.3,2795,0)
 ;;=M86.162^^12^110^8
 ;;^UTILITY(U,$J,358.3,2795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2795,1,3,0)
 ;;=3^Osteomyelitis, acute, lft tibia/fib, oth
 ;;^UTILITY(U,$J,358.3,2795,1,4,0)
 ;;=4^M86.162
 ;;^UTILITY(U,$J,358.3,2795,2)
 ;;=^5134068
 ;;^UTILITY(U,$J,358.3,2796,0)
 ;;=M86.261^^12^110^47
 ;;^UTILITY(U,$J,358.3,2796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2796,1,3,0)
 ;;=3^Osteomyelitis, subacute, rt tib/fib
 ;;^UTILITY(U,$J,358.3,2796,1,4,0)
 ;;=4^M86.261
 ;;^UTILITY(U,$J,358.3,2796,2)
 ;;=^5014551
 ;;^UTILITY(U,$J,358.3,2797,0)
 ;;=M86.262^^12^110^40
 ;;^UTILITY(U,$J,358.3,2797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2797,1,3,0)
 ;;=3^Osteomyelitis, subacute, lft tib/fib
 ;;^UTILITY(U,$J,358.3,2797,1,4,0)
 ;;=4^M86.262
 ;;^UTILITY(U,$J,358.3,2797,2)
 ;;=^5014552
 ;;^UTILITY(U,$J,358.3,2798,0)
 ;;=M86.171^^12^110^11
 ;;^UTILITY(U,$J,358.3,2798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2798,1,3,0)
 ;;=3^Osteomyelitis, acute, rt ankle & foot, oth
 ;;^UTILITY(U,$J,358.3,2798,1,4,0)
 ;;=4^M86.171
 ;;^UTILITY(U,$J,358.3,2798,2)
 ;;=^5014530
 ;;^UTILITY(U,$J,358.3,2799,0)
 ;;=M86.172^^12^110^1
 ;;^UTILITY(U,$J,358.3,2799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2799,1,3,0)
 ;;=3^Osteomyelitis, acute, lft ankle & foot, oth
 ;;^UTILITY(U,$J,358.3,2799,1,4,0)
 ;;=4^M86.172
 ;;^UTILITY(U,$J,358.3,2799,2)
 ;;=^5014531
 ;;^UTILITY(U,$J,358.3,2800,0)
 ;;=M86.271^^12^110^43
 ;;^UTILITY(U,$J,358.3,2800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2800,1,3,0)
 ;;=3^Osteomyelitis, subacute, rt ankle & foot
 ;;^UTILITY(U,$J,358.3,2800,1,4,0)
 ;;=4^M86.271
 ;;^UTILITY(U,$J,358.3,2800,2)
 ;;=^5014554
 ;;^UTILITY(U,$J,358.3,2801,0)
 ;;=M86.272^^12^110^36
 ;;^UTILITY(U,$J,358.3,2801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2801,1,3,0)
 ;;=3^Osteomyelitis, subacute, lft ankle & foot
 ;;^UTILITY(U,$J,358.3,2801,1,4,0)
 ;;=4^M86.272
 ;;^UTILITY(U,$J,358.3,2801,2)
 ;;=^5014555
 ;;^UTILITY(U,$J,358.3,2802,0)
 ;;=M86.18^^12^110^10
 ;;^UTILITY(U,$J,358.3,2802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2802,1,3,0)
 ;;=3^Osteomyelitis, acute, oth site, oth
 ;;^UTILITY(U,$J,358.3,2802,1,4,0)
 ;;=4^M86.18
 ;;^UTILITY(U,$J,358.3,2802,2)
 ;;=^5014533
 ;;^UTILITY(U,$J,358.3,2803,0)
 ;;=M86.28^^12^110^42
 ;;^UTILITY(U,$J,358.3,2803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2803,1,3,0)
 ;;=3^Osteomyelitis, subacute, oth site
 ;;^UTILITY(U,$J,358.3,2803,1,4,0)
 ;;=4^M86.28
 ;;^UTILITY(U,$J,358.3,2803,2)
 ;;=^5014557
 ;;^UTILITY(U,$J,358.3,2804,0)
 ;;=M86.19^^12^110^9
 ;;^UTILITY(U,$J,358.3,2804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2804,1,3,0)
 ;;=3^Osteomyelitis, acute, mult sites, oth
 ;;^UTILITY(U,$J,358.3,2804,1,4,0)
 ;;=4^M86.19
 ;;^UTILITY(U,$J,358.3,2804,2)
 ;;=^5014534
 ;;^UTILITY(U,$J,358.3,2805,0)
 ;;=M86.29^^12^110^41
 ;;^UTILITY(U,$J,358.3,2805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2805,1,3,0)
 ;;=3^Osteomyelitis, subacute, mult sites
 ;;^UTILITY(U,$J,358.3,2805,1,4,0)
 ;;=4^M86.29
 ;;^UTILITY(U,$J,358.3,2805,2)
 ;;=^5014558
 ;;^UTILITY(U,$J,358.3,2806,0)
 ;;=M86.60^^12^110^35
 ;;^UTILITY(U,$J,358.3,2806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2806,1,3,0)
 ;;=3^Osteomyelitis, chron, unspec site, oth
 ;;^UTILITY(U,$J,358.3,2806,1,4,0)
 ;;=4^M86.60
 ;;^UTILITY(U,$J,358.3,2806,2)
 ;;=^5014630
 ;;^UTILITY(U,$J,358.3,2807,0)
 ;;=M86.611^^12^110^32
 ;;^UTILITY(U,$J,358.3,2807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2807,1,3,0)
 ;;=3^Osteomyelitis, chron, rt shldr, oth
 ;;^UTILITY(U,$J,358.3,2807,1,4,0)
 ;;=4^M86.611
 ;;^UTILITY(U,$J,358.3,2807,2)
 ;;=^5014631
 ;;^UTILITY(U,$J,358.3,2808,0)
 ;;=M86.612^^12^110^23
 ;;^UTILITY(U,$J,358.3,2808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2808,1,3,0)
 ;;=3^Osteomyelitis, chron, lft shldr, oth
 ;;^UTILITY(U,$J,358.3,2808,1,4,0)
 ;;=4^M86.612
 ;;^UTILITY(U,$J,358.3,2808,2)
 ;;=^5014632
 ;;^UTILITY(U,$J,358.3,2809,0)
 ;;=M86.621^^12^110^30
 ;;^UTILITY(U,$J,358.3,2809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2809,1,3,0)
 ;;=3^Osteomyelitis, chron, rt humerus, oth
 ;;^UTILITY(U,$J,358.3,2809,1,4,0)
 ;;=4^M86.621
 ;;^UTILITY(U,$J,358.3,2809,2)
 ;;=^5014634
 ;;^UTILITY(U,$J,358.3,2810,0)
 ;;=M86.622^^12^110^21
 ;;^UTILITY(U,$J,358.3,2810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2810,1,3,0)
 ;;=3^Osteomyelitis, chron, lft numerus, oth
 ;;^UTILITY(U,$J,358.3,2810,1,4,0)
 ;;=4^M86.622
 ;;^UTILITY(U,$J,358.3,2810,2)
 ;;=^5134070
 ;;^UTILITY(U,$J,358.3,2811,0)
 ;;=M86.631^^12^110^31
 ;;^UTILITY(U,$J,358.3,2811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2811,1,3,0)
 ;;=3^Osteomyelitis, chron, rt radius & ulna, oth
 ;;^UTILITY(U,$J,358.3,2811,1,4,0)
 ;;=4^M86.631
 ;;^UTILITY(U,$J,358.3,2811,2)
 ;;=^5014635
 ;;^UTILITY(U,$J,358.3,2812,0)
 ;;=M86.632^^12^110^22
 ;;^UTILITY(U,$J,358.3,2812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2812,1,3,0)
 ;;=3^Osteomyelitis, chron, lft radius & ulna, oth
 ;;^UTILITY(U,$J,358.3,2812,1,4,0)
 ;;=4^M86.632
 ;;^UTILITY(U,$J,358.3,2812,2)
 ;;=^5134072
 ;;^UTILITY(U,$J,358.3,2813,0)
 ;;=M86.641^^12^110^29
 ;;^UTILITY(U,$J,358.3,2813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2813,1,3,0)
 ;;=3^Osteomyelitis, chron, rt hand, oth
 ;;^UTILITY(U,$J,358.3,2813,1,4,0)
 ;;=4^M86.641
 ;;^UTILITY(U,$J,358.3,2813,2)
 ;;=^5014636
 ;;^UTILITY(U,$J,358.3,2814,0)
 ;;=M86.642^^12^110^20
 ;;^UTILITY(U,$J,358.3,2814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2814,1,3,0)
 ;;=3^Osteomyelitis, chron, lft hand, oth
 ;;^UTILITY(U,$J,358.3,2814,1,4,0)
 ;;=4^M86.642
 ;;^UTILITY(U,$J,358.3,2814,2)
 ;;=^5134074
 ;;^UTILITY(U,$J,358.3,2815,0)
 ;;=M86.651^^12^110^33
 ;;^UTILITY(U,$J,358.3,2815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2815,1,3,0)
 ;;=3^Osteomyelitis, chron, rt thigh, oth
 ;;^UTILITY(U,$J,358.3,2815,1,4,0)
 ;;=4^M86.651
 ;;^UTILITY(U,$J,358.3,2815,2)
 ;;=^5014637
 ;;^UTILITY(U,$J,358.3,2816,0)
 ;;=M86.652^^12^110^24
 ;;^UTILITY(U,$J,358.3,2816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2816,1,3,0)
 ;;=3^Osteomyelitis, chron, lft thigh, oth
 ;;^UTILITY(U,$J,358.3,2816,1,4,0)
 ;;=4^M86.652
 ;;^UTILITY(U,$J,358.3,2816,2)
 ;;=^5014638
 ;;^UTILITY(U,$J,358.3,2817,0)
 ;;=M86.661^^12^110^34
 ;;^UTILITY(U,$J,358.3,2817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2817,1,3,0)
 ;;=3^Osteomyelitis, chron, rt tib/fib, oth
 ;;^UTILITY(U,$J,358.3,2817,1,4,0)
 ;;=4^M86.661
 ;;^UTILITY(U,$J,358.3,2817,2)
 ;;=^5014640
 ;;^UTILITY(U,$J,358.3,2818,0)
 ;;=M86.662^^12^110^25
 ;;^UTILITY(U,$J,358.3,2818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2818,1,3,0)
 ;;=3^Osteomyelitis, chron, lft tib/fib, oth
 ;;^UTILITY(U,$J,358.3,2818,1,4,0)
 ;;=4^M86.662
 ;;^UTILITY(U,$J,358.3,2818,2)
 ;;=^5134076
 ;;^UTILITY(U,$J,358.3,2819,0)
 ;;=M86.671^^12^110^28
 ;;^UTILITY(U,$J,358.3,2819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2819,1,3,0)
 ;;=3^Osteomyelitis, chron, rt ankle & foot, oth
 ;;^UTILITY(U,$J,358.3,2819,1,4,0)
 ;;=4^M86.671
 ;;^UTILITY(U,$J,358.3,2819,2)
 ;;=^5014641
 ;;^UTILITY(U,$J,358.3,2820,0)
 ;;=M86.672^^12^110^19
 ;;^UTILITY(U,$J,358.3,2820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2820,1,3,0)
 ;;=3^Osteomyelitis, chron, lft ankle & foot, oth
 ;;^UTILITY(U,$J,358.3,2820,1,4,0)
 ;;=4^M86.672
 ;;^UTILITY(U,$J,358.3,2820,2)
 ;;=^5014642
 ;;^UTILITY(U,$J,358.3,2821,0)
 ;;=M86.68^^12^110^27
 ;;^UTILITY(U,$J,358.3,2821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2821,1,3,0)
 ;;=3^Osteomyelitis, chron, oth, oth site
 ;;^UTILITY(U,$J,358.3,2821,1,4,0)
 ;;=4^M86.68
 ;;^UTILITY(U,$J,358.3,2821,2)
 ;;=^5014644
 ;;^UTILITY(U,$J,358.3,2822,0)
 ;;=M86.69^^12^110^26
 ;;^UTILITY(U,$J,358.3,2822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2822,1,3,0)
 ;;=3^Osteomyelitis, chron, mult sites, oth
 ;;^UTILITY(U,$J,358.3,2822,1,4,0)
 ;;=4^M86.69
 ;;^UTILITY(U,$J,358.3,2822,2)
 ;;=^5014645
 ;;^UTILITY(U,$J,358.3,2823,0)
 ;;=M86.9^^12^110^49
 ;;^UTILITY(U,$J,358.3,2823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2823,1,3,0)
 ;;=3^Osteomyelitis, unspec
 ;;^UTILITY(U,$J,358.3,2823,1,4,0)
 ;;=4^M86.9
 ;;^UTILITY(U,$J,358.3,2823,2)
 ;;=^5014656
 ;;^UTILITY(U,$J,358.3,2824,0)
 ;;=M90.80^^12^110^66
 ;;^UTILITY(U,$J,358.3,2824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2824,1,3,0)
 ;;=3^Osteopathy in dis clsfd elswhr, unsp site
 ;;^UTILITY(U,$J,358.3,2824,1,4,0)
 ;;=4^M90.80
 ;;^UTILITY(U,$J,358.3,2824,2)
 ;;=^5015168
 ;;^UTILITY(U,$J,358.3,2825,0)
 ;;=M90.811^^12^110^63
 ;;^UTILITY(U,$J,358.3,2825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2825,1,3,0)
 ;;=3^Osteopathy in dis clsfd elswhr, rt shldr
 ;;^UTILITY(U,$J,358.3,2825,1,4,0)
 ;;=4^M90.811
 ;;^UTILITY(U,$J,358.3,2825,2)
 ;;=^5015169
 ;;^UTILITY(U,$J,358.3,2826,0)
 ;;=M90.812^^12^110^54
 ;;^UTILITY(U,$J,358.3,2826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2826,1,3,0)
 ;;=3^Osteopathy in dis clsfd elswhr, lft shldr
 ;;^UTILITY(U,$J,358.3,2826,1,4,0)
 ;;=4^M90.812
 ;;^UTILITY(U,$J,358.3,2826,2)
 ;;=^5015170
 ;;^UTILITY(U,$J,358.3,2827,0)
 ;;=M90.821^^12^110^65
 ;;^UTILITY(U,$J,358.3,2827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2827,1,3,0)
 ;;=3^Osteopathy in dis clsfd elswhr, rt upper arm
