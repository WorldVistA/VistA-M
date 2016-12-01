IBDEI0TS ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39175,1,4,0)
 ;;=4^M19.241
 ;;^UTILITY(U,$J,358.3,39175,2)
 ;;=^5010847
 ;;^UTILITY(U,$J,358.3,39176,0)
 ;;=M19.242^^109^1617^24
 ;;^UTILITY(U,$J,358.3,39176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39176,1,3,0)
 ;;=3^Second osteoarthritis, lft hand
 ;;^UTILITY(U,$J,358.3,39176,1,4,0)
 ;;=4^M19.242
 ;;^UTILITY(U,$J,358.3,39176,2)
 ;;=^5010848
 ;;^UTILITY(U,$J,358.3,39177,0)
 ;;=M19.271^^109^1617^27
 ;;^UTILITY(U,$J,358.3,39177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39177,1,3,0)
 ;;=3^Second osteoarthritis, rt ankle & foot
 ;;^UTILITY(U,$J,358.3,39177,1,4,0)
 ;;=4^M19.271
 ;;^UTILITY(U,$J,358.3,39177,2)
 ;;=^5010850
 ;;^UTILITY(U,$J,358.3,39178,0)
 ;;=M19.272^^109^1617^22
 ;;^UTILITY(U,$J,358.3,39178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39178,1,3,0)
 ;;=3^Second osteoarthritis, lft ankle & foot
 ;;^UTILITY(U,$J,358.3,39178,1,4,0)
 ;;=4^M19.272
 ;;^UTILITY(U,$J,358.3,39178,2)
 ;;=^5010851
 ;;^UTILITY(U,$J,358.3,39179,0)
 ;;=M19.90^^109^1617^1
 ;;^UTILITY(U,$J,358.3,39179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39179,1,3,0)
 ;;=3^Osteoarthritis, unspec site, unspec
 ;;^UTILITY(U,$J,358.3,39179,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,39179,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,39180,0)
 ;;=M16.11^^109^1617^13
 ;;^UTILITY(U,$J,358.3,39180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39180,1,3,0)
 ;;=3^Prim osteoarthritis, rt hip
 ;;^UTILITY(U,$J,358.3,39180,1,4,0)
 ;;=4^M16.11
 ;;^UTILITY(U,$J,358.3,39180,2)
 ;;=^5010771
 ;;^UTILITY(U,$J,358.3,39181,0)
 ;;=M16.12^^109^1617^6
 ;;^UTILITY(U,$J,358.3,39181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39181,1,3,0)
 ;;=3^Prim osteoarthritis, lft hip
 ;;^UTILITY(U,$J,358.3,39181,1,4,0)
 ;;=4^M16.12
 ;;^UTILITY(U,$J,358.3,39181,2)
 ;;=^5010772
 ;;^UTILITY(U,$J,358.3,39182,0)
 ;;=M17.11^^109^1617^14
 ;;^UTILITY(U,$J,358.3,39182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39182,1,3,0)
 ;;=3^Prim osteoarthritis, rt knee
 ;;^UTILITY(U,$J,358.3,39182,1,4,0)
 ;;=4^M17.11
 ;;^UTILITY(U,$J,358.3,39182,2)
 ;;=^5010786
 ;;^UTILITY(U,$J,358.3,39183,0)
 ;;=M17.12^^109^1617^7
 ;;^UTILITY(U,$J,358.3,39183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39183,1,3,0)
 ;;=3^Prim osteoarthritis, lft knee
 ;;^UTILITY(U,$J,358.3,39183,1,4,0)
 ;;=4^M17.12
 ;;^UTILITY(U,$J,358.3,39183,2)
 ;;=^5010787
 ;;^UTILITY(U,$J,358.3,39184,0)
 ;;=M16.7^^109^1617^19
 ;;^UTILITY(U,$J,358.3,39184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39184,1,3,0)
 ;;=3^Second osteoarthritis, hip, unlit, oth
 ;;^UTILITY(U,$J,358.3,39184,1,4,0)
 ;;=4^M16.7
 ;;^UTILITY(U,$J,358.3,39184,2)
 ;;=^5010782
 ;;^UTILITY(U,$J,358.3,39185,0)
 ;;=M16.6^^109^1617^18
 ;;^UTILITY(U,$J,358.3,39185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39185,1,3,0)
 ;;=3^Second osteoarthritis, hip, bilat, oth
 ;;^UTILITY(U,$J,358.3,39185,1,4,0)
 ;;=4^M16.6
 ;;^UTILITY(U,$J,358.3,39185,2)
 ;;=^5010781
 ;;^UTILITY(U,$J,358.3,39186,0)
 ;;=M17.5^^109^1617^21
 ;;^UTILITY(U,$J,358.3,39186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39186,1,3,0)
 ;;=3^Second osteoarthritis, knee, unilat, oth
 ;;^UTILITY(U,$J,358.3,39186,1,4,0)
 ;;=4^M17.5
 ;;^UTILITY(U,$J,358.3,39186,2)
 ;;=^5010793
 ;;^UTILITY(U,$J,358.3,39187,0)
 ;;=M17.4^^109^1617^20
 ;;^UTILITY(U,$J,358.3,39187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39187,1,3,0)
 ;;=3^Second osteoarthritis, knee, bilat, oth
 ;;^UTILITY(U,$J,358.3,39187,1,4,0)
 ;;=4^M17.4
 ;;^UTILITY(U,$J,358.3,39187,2)
 ;;=^5010792
 ;;^UTILITY(U,$J,358.3,39188,0)
 ;;=M86.10^^109^1618^18
 ;;^UTILITY(U,$J,358.3,39188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39188,1,3,0)
 ;;=3^Osteomyelitis, acute, unspec site, oth
 ;;^UTILITY(U,$J,358.3,39188,1,4,0)
 ;;=4^M86.10
 ;;^UTILITY(U,$J,358.3,39188,2)
 ;;=^5014521
 ;;^UTILITY(U,$J,358.3,39189,0)
 ;;=M86.20^^109^1618^48
 ;;^UTILITY(U,$J,358.3,39189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39189,1,3,0)
 ;;=3^Osteomyelitis, subacute, unspec site
 ;;^UTILITY(U,$J,358.3,39189,1,4,0)
 ;;=4^M86.20
 ;;^UTILITY(U,$J,358.3,39189,2)
 ;;=^5014535
 ;;^UTILITY(U,$J,358.3,39190,0)
 ;;=M86.111^^109^1618^16
 ;;^UTILITY(U,$J,358.3,39190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39190,1,3,0)
 ;;=3^Osteomyelitis, acute, rt shldr, oth
 ;;^UTILITY(U,$J,358.3,39190,1,4,0)
 ;;=4^M86.111
 ;;^UTILITY(U,$J,358.3,39190,2)
 ;;=^5014522
 ;;^UTILITY(U,$J,358.3,39191,0)
 ;;=M86.112^^109^1618^7
 ;;^UTILITY(U,$J,358.3,39191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39191,1,3,0)
 ;;=3^Osteomyelitis, acute, lft shldr, oth
 ;;^UTILITY(U,$J,358.3,39191,1,4,0)
 ;;=4^M86.112
 ;;^UTILITY(U,$J,358.3,39191,2)
 ;;=^5014523
 ;;^UTILITY(U,$J,358.3,39192,0)
 ;;=M86.121^^109^1618^14
 ;;^UTILITY(U,$J,358.3,39192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39192,1,3,0)
 ;;=3^Osteomyelitis, acute, rt humerus, oth
 ;;^UTILITY(U,$J,358.3,39192,1,4,0)
 ;;=4^M86.121
 ;;^UTILITY(U,$J,358.3,39192,2)
 ;;=^5014525
 ;;^UTILITY(U,$J,358.3,39193,0)
 ;;=M86.122^^109^1618^5
 ;;^UTILITY(U,$J,358.3,39193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39193,1,3,0)
 ;;=3^Osteomyelitis, acute, lft humerus, otho
 ;;^UTILITY(U,$J,358.3,39193,1,4,0)
 ;;=4^M86.122
 ;;^UTILITY(U,$J,358.3,39193,2)
 ;;=^5134060
 ;;^UTILITY(U,$J,358.3,39194,0)
 ;;=M86.211^^109^1618^46
 ;;^UTILITY(U,$J,358.3,39194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39194,1,3,0)
 ;;=3^Osteomyelitis, subacute, rt shldr
 ;;^UTILITY(U,$J,358.3,39194,1,4,0)
 ;;=4^M86.211
 ;;^UTILITY(U,$J,358.3,39194,2)
 ;;=^5014536
 ;;^UTILITY(U,$J,358.3,39195,0)
 ;;=M86.212^^109^1618^39
 ;;^UTILITY(U,$J,358.3,39195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39195,1,3,0)
 ;;=3^Osteomyelitis, subacute, lft shldr
 ;;^UTILITY(U,$J,358.3,39195,1,4,0)
 ;;=4^M86.212
 ;;^UTILITY(U,$J,358.3,39195,2)
 ;;=^5014537
 ;;^UTILITY(U,$J,358.3,39196,0)
 ;;=M86.121^^109^1618^15
 ;;^UTILITY(U,$J,358.3,39196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39196,1,3,0)
 ;;=3^Osteomyelitis, acute, rt humerus, oth
 ;;^UTILITY(U,$J,358.3,39196,1,4,0)
 ;;=4^M86.121
 ;;^UTILITY(U,$J,358.3,39196,2)
 ;;=^5014525
 ;;^UTILITY(U,$J,358.3,39197,0)
 ;;=M86.122^^109^1618^4
 ;;^UTILITY(U,$J,358.3,39197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39197,1,3,0)
 ;;=3^Osteomyelitis, acute, lft humerus, oth
 ;;^UTILITY(U,$J,358.3,39197,1,4,0)
 ;;=4^M86.122
 ;;^UTILITY(U,$J,358.3,39197,2)
 ;;=^5134060
 ;;^UTILITY(U,$J,358.3,39198,0)
 ;;=M86.221^^109^1618^45
 ;;^UTILITY(U,$J,358.3,39198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39198,1,3,0)
 ;;=3^Osteomyelitis, subacute, rt humerus
 ;;^UTILITY(U,$J,358.3,39198,1,4,0)
 ;;=4^M86.221
 ;;^UTILITY(U,$J,358.3,39198,2)
 ;;=^5014539
 ;;^UTILITY(U,$J,358.3,39199,0)
 ;;=M86.222^^109^1618^38
 ;;^UTILITY(U,$J,358.3,39199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39199,1,3,0)
 ;;=3^Osteomyelitis, subacute, lft humerus
 ;;^UTILITY(U,$J,358.3,39199,1,4,0)
 ;;=4^M86.222
 ;;^UTILITY(U,$J,358.3,39199,2)
 ;;=^5014540
 ;;^UTILITY(U,$J,358.3,39200,0)
 ;;=M86.131^^109^1618^67
 ;;^UTILITY(U,$J,358.3,39200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39200,1,3,0)
 ;;=3^Ostoemyelitis, acute, rt radius & ulna, oth
 ;;^UTILITY(U,$J,358.3,39200,1,4,0)
 ;;=4^M86.131
 ;;^UTILITY(U,$J,358.3,39200,2)
 ;;=^5014526
 ;;^UTILITY(U,$J,358.3,39201,0)
 ;;=M86.132^^109^1618^6
 ;;^UTILITY(U,$J,358.3,39201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39201,1,3,0)
 ;;=3^Osteomyelitis, acute, lft radius & ulna, oth
 ;;^UTILITY(U,$J,358.3,39201,1,4,0)
 ;;=4^M86.132
 ;;^UTILITY(U,$J,358.3,39201,2)
 ;;=^5134062
 ;;^UTILITY(U,$J,358.3,39202,0)
 ;;=M86.141^^109^1618^13
 ;;^UTILITY(U,$J,358.3,39202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39202,1,3,0)
 ;;=3^Osteomyelitis, acute, rt hand, oth
 ;;^UTILITY(U,$J,358.3,39202,1,4,0)
 ;;=4^M86.141
 ;;^UTILITY(U,$J,358.3,39202,2)
 ;;=^5014527
 ;;^UTILITY(U,$J,358.3,39203,0)
 ;;=M86.142^^109^1618^3
 ;;^UTILITY(U,$J,358.3,39203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39203,1,3,0)
 ;;=3^Osteomyelitis, acute, lft hand, oth
 ;;^UTILITY(U,$J,358.3,39203,1,4,0)
 ;;=4^M86.142
 ;;^UTILITY(U,$J,358.3,39203,2)
 ;;=^5134064
 ;;^UTILITY(U,$J,358.3,39204,0)
 ;;=M86.151^^109^1618^12
 ;;^UTILITY(U,$J,358.3,39204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39204,1,3,0)
 ;;=3^Osteomyelitis, acute, rt femur, oth
 ;;^UTILITY(U,$J,358.3,39204,1,4,0)
 ;;=4^M86.151
 ;;^UTILITY(U,$J,358.3,39204,2)
 ;;=^5014528
 ;;^UTILITY(U,$J,358.3,39205,0)
 ;;=M86.152^^109^1618^2
 ;;^UTILITY(U,$J,358.3,39205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39205,1,3,0)
 ;;=3^Osteomyelitis, acute, lft femur, oth
 ;;^UTILITY(U,$J,358.3,39205,1,4,0)
 ;;=4^M86.152
 ;;^UTILITY(U,$J,358.3,39205,2)
 ;;=^5134066
 ;;^UTILITY(U,$J,358.3,39206,0)
 ;;=M86.251^^109^1618^44
 ;;^UTILITY(U,$J,358.3,39206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39206,1,3,0)
 ;;=3^Osteomyelitis, subacute, rt femur
 ;;^UTILITY(U,$J,358.3,39206,1,4,0)
 ;;=4^M86.251
 ;;^UTILITY(U,$J,358.3,39206,2)
 ;;=^5014548
 ;;^UTILITY(U,$J,358.3,39207,0)
 ;;=M86.252^^109^1618^37
 ;;^UTILITY(U,$J,358.3,39207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39207,1,3,0)
 ;;=3^Osteomyelitis, subacute, lft femur
 ;;^UTILITY(U,$J,358.3,39207,1,4,0)
 ;;=4^M86.252
 ;;^UTILITY(U,$J,358.3,39207,2)
 ;;=^5014549
 ;;^UTILITY(U,$J,358.3,39208,0)
 ;;=M86.161^^109^1618^17
 ;;^UTILITY(U,$J,358.3,39208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39208,1,3,0)
 ;;=3^Osteomyelitis, acute, rt tibia/fib, oth
 ;;^UTILITY(U,$J,358.3,39208,1,4,0)
 ;;=4^M86.161
 ;;^UTILITY(U,$J,358.3,39208,2)
 ;;=^5014529
 ;;^UTILITY(U,$J,358.3,39209,0)
 ;;=M86.162^^109^1618^8
 ;;^UTILITY(U,$J,358.3,39209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39209,1,3,0)
 ;;=3^Osteomyelitis, acute, lft tibia/fib, oth
 ;;^UTILITY(U,$J,358.3,39209,1,4,0)
 ;;=4^M86.162
 ;;^UTILITY(U,$J,358.3,39209,2)
 ;;=^5134068
 ;;^UTILITY(U,$J,358.3,39210,0)
 ;;=M86.261^^109^1618^47
 ;;^UTILITY(U,$J,358.3,39210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39210,1,3,0)
 ;;=3^Osteomyelitis, subacute, rt tib/fib
