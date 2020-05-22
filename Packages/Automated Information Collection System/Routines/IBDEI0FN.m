IBDEI0FN ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6753,1,3,0)
 ;;=3^Postlaminectomy syndrome, NEC
 ;;^UTILITY(U,$J,358.3,6753,1,4,0)
 ;;=4^M96.1
 ;;^UTILITY(U,$J,358.3,6753,2)
 ;;=^5015374
 ;;^UTILITY(U,$J,358.3,6754,0)
 ;;=M54.31^^56^439^94
 ;;^UTILITY(U,$J,358.3,6754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6754,1,3,0)
 ;;=3^Sciatica, right side
 ;;^UTILITY(U,$J,358.3,6754,1,4,0)
 ;;=4^M54.31
 ;;^UTILITY(U,$J,358.3,6754,2)
 ;;=^5012306
 ;;^UTILITY(U,$J,358.3,6755,0)
 ;;=M54.32^^56^439^93
 ;;^UTILITY(U,$J,358.3,6755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6755,1,3,0)
 ;;=3^Sciatica, left side
 ;;^UTILITY(U,$J,358.3,6755,1,4,0)
 ;;=4^M54.32
 ;;^UTILITY(U,$J,358.3,6755,2)
 ;;=^5012307
 ;;^UTILITY(U,$J,358.3,6756,0)
 ;;=M75.21^^56^439^6
 ;;^UTILITY(U,$J,358.3,6756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6756,1,3,0)
 ;;=3^Bicipital tendinitis, rt shldr
 ;;^UTILITY(U,$J,358.3,6756,1,4,0)
 ;;=4^M75.21
 ;;^UTILITY(U,$J,358.3,6756,2)
 ;;=^5013251
 ;;^UTILITY(U,$J,358.3,6757,0)
 ;;=M75.22^^56^439^5
 ;;^UTILITY(U,$J,358.3,6757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6757,1,3,0)
 ;;=3^Bicipital tendinitis, lft shldr
 ;;^UTILITY(U,$J,358.3,6757,1,4,0)
 ;;=4^M75.22
 ;;^UTILITY(U,$J,358.3,6757,2)
 ;;=^5013252
 ;;^UTILITY(U,$J,358.3,6758,0)
 ;;=M77.01^^56^439^67
 ;;^UTILITY(U,$J,358.3,6758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6758,1,3,0)
 ;;=3^Medial epicondylitis, rt elbow
 ;;^UTILITY(U,$J,358.3,6758,1,4,0)
 ;;=4^M77.01
 ;;^UTILITY(U,$J,358.3,6758,2)
 ;;=^5013301
 ;;^UTILITY(U,$J,358.3,6759,0)
 ;;=M77.02^^56^439^66
 ;;^UTILITY(U,$J,358.3,6759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6759,1,3,0)
 ;;=3^Medial epicondylitis, lft elbow
 ;;^UTILITY(U,$J,358.3,6759,1,4,0)
 ;;=4^M77.02
 ;;^UTILITY(U,$J,358.3,6759,2)
 ;;=^5013302
 ;;^UTILITY(U,$J,358.3,6760,0)
 ;;=M77.11^^56^439^65
 ;;^UTILITY(U,$J,358.3,6760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6760,1,3,0)
 ;;=3^Lateral epicondylitis, rt elbow
 ;;^UTILITY(U,$J,358.3,6760,1,4,0)
 ;;=4^M77.11
 ;;^UTILITY(U,$J,358.3,6760,2)
 ;;=^5013304
 ;;^UTILITY(U,$J,358.3,6761,0)
 ;;=M77.12^^56^439^64
 ;;^UTILITY(U,$J,358.3,6761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6761,1,3,0)
 ;;=3^Lateral epicondylitis, lft elbow
 ;;^UTILITY(U,$J,358.3,6761,1,4,0)
 ;;=4^M77.12
 ;;^UTILITY(U,$J,358.3,6761,2)
 ;;=^5013305
 ;;^UTILITY(U,$J,358.3,6762,0)
 ;;=M70.61^^56^439^112
 ;;^UTILITY(U,$J,358.3,6762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6762,1,3,0)
 ;;=3^Trochanteric bursitis, rt hip
 ;;^UTILITY(U,$J,358.3,6762,1,4,0)
 ;;=4^M70.61
 ;;^UTILITY(U,$J,358.3,6762,2)
 ;;=^5013059
 ;;^UTILITY(U,$J,358.3,6763,0)
 ;;=M70.62^^56^439^111
 ;;^UTILITY(U,$J,358.3,6763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6763,1,3,0)
 ;;=3^Trochanteric bursitis, lft hip
 ;;^UTILITY(U,$J,358.3,6763,1,4,0)
 ;;=4^M70.62
 ;;^UTILITY(U,$J,358.3,6763,2)
 ;;=^5013060
 ;;^UTILITY(U,$J,358.3,6764,0)
 ;;=M25.751^^56^439^77
 ;;^UTILITY(U,$J,358.3,6764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6764,1,3,0)
 ;;=3^Osteophyte, right hip
 ;;^UTILITY(U,$J,358.3,6764,1,4,0)
 ;;=4^M25.751
 ;;^UTILITY(U,$J,358.3,6764,2)
 ;;=^5011658
 ;;^UTILITY(U,$J,358.3,6765,0)
 ;;=M25.752^^56^439^76
 ;;^UTILITY(U,$J,358.3,6765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6765,1,3,0)
 ;;=3^Osteophyte, left hip
 ;;^UTILITY(U,$J,358.3,6765,1,4,0)
 ;;=4^M25.752
 ;;^UTILITY(U,$J,358.3,6765,2)
 ;;=^5011659
 ;;^UTILITY(U,$J,358.3,6766,0)
 ;;=M76.31^^56^439^35
