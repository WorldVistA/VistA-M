IBDEI02D ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2756,1,3,0)
 ;;=3^Second osteoarthritis, lft shldr
 ;;^UTILITY(U,$J,358.3,2756,1,4,0)
 ;;=4^M19.212
 ;;^UTILITY(U,$J,358.3,2756,2)
 ;;=^5010839
 ;;^UTILITY(U,$J,358.3,2757,0)
 ;;=M19.221^^12^109^28
 ;;^UTILITY(U,$J,358.3,2757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2757,1,3,0)
 ;;=3^Second osteoarthritis, rt elbow
 ;;^UTILITY(U,$J,358.3,2757,1,4,0)
 ;;=4^M19.221
 ;;^UTILITY(U,$J,358.3,2757,2)
 ;;=^5010841
 ;;^UTILITY(U,$J,358.3,2758,0)
 ;;=M19.222^^12^109^23
 ;;^UTILITY(U,$J,358.3,2758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2758,1,3,0)
 ;;=3^Second osteoarthritis, lft elbow
 ;;^UTILITY(U,$J,358.3,2758,1,4,0)
 ;;=4^M19.222
 ;;^UTILITY(U,$J,358.3,2758,2)
 ;;=^5010842
 ;;^UTILITY(U,$J,358.3,2759,0)
 ;;=M19.231^^12^109^31
 ;;^UTILITY(U,$J,358.3,2759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2759,1,3,0)
 ;;=3^Second osteoarthritis, rt wrist
 ;;^UTILITY(U,$J,358.3,2759,1,4,0)
 ;;=4^M19.231
 ;;^UTILITY(U,$J,358.3,2759,2)
 ;;=^5010844
 ;;^UTILITY(U,$J,358.3,2760,0)
 ;;=M19.232^^12^109^26
 ;;^UTILITY(U,$J,358.3,2760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2760,1,3,0)
 ;;=3^Second osteoarthritis, lft wrist
 ;;^UTILITY(U,$J,358.3,2760,1,4,0)
 ;;=4^M19.232
 ;;^UTILITY(U,$J,358.3,2760,2)
 ;;=^5010845
 ;;^UTILITY(U,$J,358.3,2761,0)
 ;;=M19.241^^12^109^29
 ;;^UTILITY(U,$J,358.3,2761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2761,1,3,0)
 ;;=3^Second osteoarthritis, rt hand
 ;;^UTILITY(U,$J,358.3,2761,1,4,0)
 ;;=4^M19.241
 ;;^UTILITY(U,$J,358.3,2761,2)
 ;;=^5010847
 ;;^UTILITY(U,$J,358.3,2762,0)
 ;;=M19.242^^12^109^24
 ;;^UTILITY(U,$J,358.3,2762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2762,1,3,0)
 ;;=3^Second osteoarthritis, lft hand
 ;;^UTILITY(U,$J,358.3,2762,1,4,0)
 ;;=4^M19.242
 ;;^UTILITY(U,$J,358.3,2762,2)
 ;;=^5010848
 ;;^UTILITY(U,$J,358.3,2763,0)
 ;;=M19.271^^12^109^27
 ;;^UTILITY(U,$J,358.3,2763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2763,1,3,0)
 ;;=3^Second osteoarthritis, rt ankle & foot
 ;;^UTILITY(U,$J,358.3,2763,1,4,0)
 ;;=4^M19.271
 ;;^UTILITY(U,$J,358.3,2763,2)
 ;;=^5010850
 ;;^UTILITY(U,$J,358.3,2764,0)
 ;;=M19.272^^12^109^22
 ;;^UTILITY(U,$J,358.3,2764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2764,1,3,0)
 ;;=3^Second osteoarthritis, lft ankle & foot
 ;;^UTILITY(U,$J,358.3,2764,1,4,0)
 ;;=4^M19.272
 ;;^UTILITY(U,$J,358.3,2764,2)
 ;;=^5010851
 ;;^UTILITY(U,$J,358.3,2765,0)
 ;;=M19.90^^12^109^1
 ;;^UTILITY(U,$J,358.3,2765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2765,1,3,0)
 ;;=3^Osteoarthritis, unspec site, unspec
 ;;^UTILITY(U,$J,358.3,2765,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,2765,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,2766,0)
 ;;=M16.11^^12^109^13
 ;;^UTILITY(U,$J,358.3,2766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2766,1,3,0)
 ;;=3^Prim osteoarthritis, rt hip
 ;;^UTILITY(U,$J,358.3,2766,1,4,0)
 ;;=4^M16.11
 ;;^UTILITY(U,$J,358.3,2766,2)
 ;;=^5010771
 ;;^UTILITY(U,$J,358.3,2767,0)
 ;;=M16.12^^12^109^6
 ;;^UTILITY(U,$J,358.3,2767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2767,1,3,0)
 ;;=3^Prim osteoarthritis, lft hip
 ;;^UTILITY(U,$J,358.3,2767,1,4,0)
 ;;=4^M16.12
 ;;^UTILITY(U,$J,358.3,2767,2)
 ;;=^5010772
 ;;^UTILITY(U,$J,358.3,2768,0)
 ;;=M17.11^^12^109^14
 ;;^UTILITY(U,$J,358.3,2768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2768,1,3,0)
 ;;=3^Prim osteoarthritis, rt knee
 ;;^UTILITY(U,$J,358.3,2768,1,4,0)
 ;;=4^M17.11
 ;;^UTILITY(U,$J,358.3,2768,2)
 ;;=^5010786
 ;;^UTILITY(U,$J,358.3,2769,0)
 ;;=M17.12^^12^109^7
 ;;^UTILITY(U,$J,358.3,2769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2769,1,3,0)
 ;;=3^Prim osteoarthritis, lft knee
 ;;^UTILITY(U,$J,358.3,2769,1,4,0)
 ;;=4^M17.12
 ;;^UTILITY(U,$J,358.3,2769,2)
 ;;=^5010787
 ;;^UTILITY(U,$J,358.3,2770,0)
 ;;=M16.7^^12^109^19
 ;;^UTILITY(U,$J,358.3,2770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2770,1,3,0)
 ;;=3^Second osteoarthritis, hip, unlit, oth
 ;;^UTILITY(U,$J,358.3,2770,1,4,0)
 ;;=4^M16.7
 ;;^UTILITY(U,$J,358.3,2770,2)
 ;;=^5010782
 ;;^UTILITY(U,$J,358.3,2771,0)
 ;;=M16.6^^12^109^18
 ;;^UTILITY(U,$J,358.3,2771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2771,1,3,0)
 ;;=3^Second osteoarthritis, hip, bilat, oth
 ;;^UTILITY(U,$J,358.3,2771,1,4,0)
 ;;=4^M16.6
 ;;^UTILITY(U,$J,358.3,2771,2)
 ;;=^5010781
 ;;^UTILITY(U,$J,358.3,2772,0)
 ;;=M17.5^^12^109^21
 ;;^UTILITY(U,$J,358.3,2772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2772,1,3,0)
 ;;=3^Second osteoarthritis, knee, unilat, oth
 ;;^UTILITY(U,$J,358.3,2772,1,4,0)
 ;;=4^M17.5
 ;;^UTILITY(U,$J,358.3,2772,2)
 ;;=^5010793
 ;;^UTILITY(U,$J,358.3,2773,0)
 ;;=M17.4^^12^109^20
 ;;^UTILITY(U,$J,358.3,2773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2773,1,3,0)
 ;;=3^Second osteoarthritis, knee, bilat, oth
 ;;^UTILITY(U,$J,358.3,2773,1,4,0)
 ;;=4^M17.4
 ;;^UTILITY(U,$J,358.3,2773,2)
 ;;=^5010792
 ;;^UTILITY(U,$J,358.3,2774,0)
 ;;=M86.10^^12^110^18
 ;;^UTILITY(U,$J,358.3,2774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2774,1,3,0)
 ;;=3^Osteomyelitis, acute, unspec site, oth
 ;;^UTILITY(U,$J,358.3,2774,1,4,0)
 ;;=4^M86.10
 ;;^UTILITY(U,$J,358.3,2774,2)
 ;;=^5014521
 ;;^UTILITY(U,$J,358.3,2775,0)
 ;;=M86.20^^12^110^48
 ;;^UTILITY(U,$J,358.3,2775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2775,1,3,0)
 ;;=3^Osteomyelitis, subacute, unspec site
 ;;^UTILITY(U,$J,358.3,2775,1,4,0)
 ;;=4^M86.20
 ;;^UTILITY(U,$J,358.3,2775,2)
 ;;=^5014535
 ;;^UTILITY(U,$J,358.3,2776,0)
 ;;=M86.111^^12^110^16
 ;;^UTILITY(U,$J,358.3,2776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2776,1,3,0)
 ;;=3^Osteomyelitis, acute, rt shldr, oth
 ;;^UTILITY(U,$J,358.3,2776,1,4,0)
 ;;=4^M86.111
 ;;^UTILITY(U,$J,358.3,2776,2)
 ;;=^5014522
 ;;^UTILITY(U,$J,358.3,2777,0)
 ;;=M86.112^^12^110^7
 ;;^UTILITY(U,$J,358.3,2777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2777,1,3,0)
 ;;=3^Osteomyelitis, acute, lft shldr, oth
 ;;^UTILITY(U,$J,358.3,2777,1,4,0)
 ;;=4^M86.112
 ;;^UTILITY(U,$J,358.3,2777,2)
 ;;=^5014523
 ;;^UTILITY(U,$J,358.3,2778,0)
 ;;=M86.121^^12^110^14
 ;;^UTILITY(U,$J,358.3,2778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2778,1,3,0)
 ;;=3^Osteomyelitis, acute, rt humerus, oth
 ;;^UTILITY(U,$J,358.3,2778,1,4,0)
 ;;=4^M86.121
 ;;^UTILITY(U,$J,358.3,2778,2)
 ;;=^5014525
 ;;^UTILITY(U,$J,358.3,2779,0)
 ;;=M86.122^^12^110^5
 ;;^UTILITY(U,$J,358.3,2779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2779,1,3,0)
 ;;=3^Osteomyelitis, acute, lft humerus, otho
 ;;^UTILITY(U,$J,358.3,2779,1,4,0)
 ;;=4^M86.122
 ;;^UTILITY(U,$J,358.3,2779,2)
 ;;=^5134060
 ;;^UTILITY(U,$J,358.3,2780,0)
 ;;=M86.211^^12^110^46
 ;;^UTILITY(U,$J,358.3,2780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2780,1,3,0)
 ;;=3^Osteomyelitis, subacute, rt shldr
 ;;^UTILITY(U,$J,358.3,2780,1,4,0)
 ;;=4^M86.211
 ;;^UTILITY(U,$J,358.3,2780,2)
 ;;=^5014536
 ;;^UTILITY(U,$J,358.3,2781,0)
 ;;=M86.212^^12^110^39
 ;;^UTILITY(U,$J,358.3,2781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2781,1,3,0)
 ;;=3^Osteomyelitis, subacute, lft shldr
 ;;^UTILITY(U,$J,358.3,2781,1,4,0)
 ;;=4^M86.212
 ;;^UTILITY(U,$J,358.3,2781,2)
 ;;=^5014537
 ;;^UTILITY(U,$J,358.3,2782,0)
 ;;=M86.121^^12^110^15
 ;;^UTILITY(U,$J,358.3,2782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2782,1,3,0)
 ;;=3^Osteomyelitis, acute, rt humerus, oth
 ;;^UTILITY(U,$J,358.3,2782,1,4,0)
 ;;=4^M86.121
 ;;^UTILITY(U,$J,358.3,2782,2)
 ;;=^5014525
 ;;^UTILITY(U,$J,358.3,2783,0)
 ;;=M86.122^^12^110^4
 ;;^UTILITY(U,$J,358.3,2783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2783,1,3,0)
 ;;=3^Osteomyelitis, acute, lft humerus, oth
 ;;^UTILITY(U,$J,358.3,2783,1,4,0)
 ;;=4^M86.122
 ;;^UTILITY(U,$J,358.3,2783,2)
 ;;=^5134060
 ;;^UTILITY(U,$J,358.3,2784,0)
 ;;=M86.221^^12^110^45
 ;;^UTILITY(U,$J,358.3,2784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2784,1,3,0)
 ;;=3^Osteomyelitis, subacute, rt humerus
 ;;^UTILITY(U,$J,358.3,2784,1,4,0)
 ;;=4^M86.221
 ;;^UTILITY(U,$J,358.3,2784,2)
 ;;=^5014539
 ;;^UTILITY(U,$J,358.3,2785,0)
 ;;=M86.222^^12^110^38
 ;;^UTILITY(U,$J,358.3,2785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2785,1,3,0)
 ;;=3^Osteomyelitis, subacute, lft humerus
 ;;^UTILITY(U,$J,358.3,2785,1,4,0)
 ;;=4^M86.222
 ;;^UTILITY(U,$J,358.3,2785,2)
 ;;=^5014540
 ;;^UTILITY(U,$J,358.3,2786,0)
 ;;=M86.131^^12^110^67
 ;;^UTILITY(U,$J,358.3,2786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2786,1,3,0)
 ;;=3^Ostoemyelitis, acute, rt radius & ulna, oth
 ;;^UTILITY(U,$J,358.3,2786,1,4,0)
 ;;=4^M86.131
 ;;^UTILITY(U,$J,358.3,2786,2)
 ;;=^5014526
 ;;^UTILITY(U,$J,358.3,2787,0)
 ;;=M86.132^^12^110^6
 ;;^UTILITY(U,$J,358.3,2787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2787,1,3,0)
 ;;=3^Osteomyelitis, acute, lft radius & ulna, oth
 ;;^UTILITY(U,$J,358.3,2787,1,4,0)
 ;;=4^M86.132
 ;;^UTILITY(U,$J,358.3,2787,2)
 ;;=^5134062
 ;;^UTILITY(U,$J,358.3,2788,0)
 ;;=M86.141^^12^110^13
 ;;^UTILITY(U,$J,358.3,2788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2788,1,3,0)
 ;;=3^Osteomyelitis, acute, rt hand, oth
 ;;^UTILITY(U,$J,358.3,2788,1,4,0)
 ;;=4^M86.141
 ;;^UTILITY(U,$J,358.3,2788,2)
 ;;=^5014527
 ;;^UTILITY(U,$J,358.3,2789,0)
 ;;=M86.142^^12^110^3
 ;;^UTILITY(U,$J,358.3,2789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2789,1,3,0)
 ;;=3^Osteomyelitis, acute, lft hand, oth
 ;;^UTILITY(U,$J,358.3,2789,1,4,0)
 ;;=4^M86.142
 ;;^UTILITY(U,$J,358.3,2789,2)
 ;;=^5134064
 ;;^UTILITY(U,$J,358.3,2790,0)
 ;;=M86.151^^12^110^12
 ;;^UTILITY(U,$J,358.3,2790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2790,1,3,0)
 ;;=3^Osteomyelitis, acute, rt femur, oth
 ;;^UTILITY(U,$J,358.3,2790,1,4,0)
 ;;=4^M86.151
 ;;^UTILITY(U,$J,358.3,2790,2)
 ;;=^5014528
 ;;^UTILITY(U,$J,358.3,2791,0)
 ;;=M86.152^^12^110^2
 ;;^UTILITY(U,$J,358.3,2791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2791,1,3,0)
 ;;=3^Osteomyelitis, acute, lft femur, oth
 ;;^UTILITY(U,$J,358.3,2791,1,4,0)
 ;;=4^M86.152
 ;;^UTILITY(U,$J,358.3,2791,2)
 ;;=^5134066
 ;;^UTILITY(U,$J,358.3,2792,0)
 ;;=M86.251^^12^110^44
