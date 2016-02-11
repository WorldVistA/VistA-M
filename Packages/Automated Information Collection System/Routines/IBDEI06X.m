IBDEI06X ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2658,1,3,0)
 ;;=3^Trochanteric bursitis, rt hip
 ;;^UTILITY(U,$J,358.3,2658,1,4,0)
 ;;=4^M70.61
 ;;^UTILITY(U,$J,358.3,2658,2)
 ;;=^5013059
 ;;^UTILITY(U,$J,358.3,2659,0)
 ;;=M70.62^^25^225^107
 ;;^UTILITY(U,$J,358.3,2659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2659,1,3,0)
 ;;=3^Trochanteric bursitis, lft hip
 ;;^UTILITY(U,$J,358.3,2659,1,4,0)
 ;;=4^M70.62
 ;;^UTILITY(U,$J,358.3,2659,2)
 ;;=^5013060
 ;;^UTILITY(U,$J,358.3,2660,0)
 ;;=M25.751^^25^225^73
 ;;^UTILITY(U,$J,358.3,2660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2660,1,3,0)
 ;;=3^Osteophyte, right hip
 ;;^UTILITY(U,$J,358.3,2660,1,4,0)
 ;;=4^M25.751
 ;;^UTILITY(U,$J,358.3,2660,2)
 ;;=^5011658
 ;;^UTILITY(U,$J,358.3,2661,0)
 ;;=M25.752^^25^225^72
 ;;^UTILITY(U,$J,358.3,2661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2661,1,3,0)
 ;;=3^Osteophyte, left hip
 ;;^UTILITY(U,$J,358.3,2661,1,4,0)
 ;;=4^M25.752
 ;;^UTILITY(U,$J,358.3,2661,2)
 ;;=^5011659
 ;;^UTILITY(U,$J,358.3,2662,0)
 ;;=M76.31^^25^225^35
 ;;^UTILITY(U,$J,358.3,2662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2662,1,3,0)
 ;;=3^Iliotibial band syndrome, rt leg
 ;;^UTILITY(U,$J,358.3,2662,1,4,0)
 ;;=4^M76.31
 ;;^UTILITY(U,$J,358.3,2662,2)
 ;;=^5013276
 ;;^UTILITY(U,$J,358.3,2663,0)
 ;;=M76.32^^25^225^34
 ;;^UTILITY(U,$J,358.3,2663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2663,1,3,0)
 ;;=3^Iliotibial band syndrome, lft leg
 ;;^UTILITY(U,$J,358.3,2663,1,4,0)
 ;;=4^M76.32
 ;;^UTILITY(U,$J,358.3,2663,2)
 ;;=^5013277
 ;;^UTILITY(U,$J,358.3,2664,0)
 ;;=M76.51^^25^225^78
 ;;^UTILITY(U,$J,358.3,2664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2664,1,3,0)
 ;;=3^Patellar tendinitis, right knee
 ;;^UTILITY(U,$J,358.3,2664,1,4,0)
 ;;=4^M76.51
 ;;^UTILITY(U,$J,358.3,2664,2)
 ;;=^5013282
 ;;^UTILITY(U,$J,358.3,2665,0)
 ;;=M76.52^^25^225^77
 ;;^UTILITY(U,$J,358.3,2665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2665,1,3,0)
 ;;=3^Patellar tendinitis, left knee
 ;;^UTILITY(U,$J,358.3,2665,1,4,0)
 ;;=4^M76.52
 ;;^UTILITY(U,$J,358.3,2665,2)
 ;;=^5013283
 ;;^UTILITY(U,$J,358.3,2666,0)
 ;;=M76.61^^25^225^3
 ;;^UTILITY(U,$J,358.3,2666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2666,1,3,0)
 ;;=3^Achilles tendinitis, right leg
 ;;^UTILITY(U,$J,358.3,2666,1,4,0)
 ;;=4^M76.61
 ;;^UTILITY(U,$J,358.3,2666,2)
 ;;=^5013285
 ;;^UTILITY(U,$J,358.3,2667,0)
 ;;=M76.62^^25^225^2
 ;;^UTILITY(U,$J,358.3,2667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2667,1,3,0)
 ;;=3^Achilles tendinitis, left leg
 ;;^UTILITY(U,$J,358.3,2667,1,4,0)
 ;;=4^M76.62
 ;;^UTILITY(U,$J,358.3,2667,2)
 ;;=^5013286
 ;;^UTILITY(U,$J,358.3,2668,0)
 ;;=M65.4^^25^225^88
 ;;^UTILITY(U,$J,358.3,2668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2668,1,3,0)
 ;;=3^Radial styloid tenosynovitis [de Quervain]
 ;;^UTILITY(U,$J,358.3,2668,1,4,0)
 ;;=4^M65.4
 ;;^UTILITY(U,$J,358.3,2668,2)
 ;;=^5012792
 ;;^UTILITY(U,$J,358.3,2669,0)
 ;;=M65.831^^25^225^105
 ;;^UTILITY(U,$J,358.3,2669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2669,1,3,0)
 ;;=3^Synovitis & tenosynvts, rt forearm, oth
 ;;^UTILITY(U,$J,358.3,2669,1,4,0)
 ;;=4^M65.831
 ;;^UTILITY(U,$J,358.3,2669,2)
 ;;=^5012800
 ;;^UTILITY(U,$J,358.3,2670,0)
 ;;=M65.832^^25^225^103
 ;;^UTILITY(U,$J,358.3,2670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2670,1,3,0)
 ;;=3^Synovitis & tenosynvts, lft forearm, oth
 ;;^UTILITY(U,$J,358.3,2670,1,4,0)
 ;;=4^M65.832
 ;;^UTILITY(U,$J,358.3,2670,2)
 ;;=^5012801
 ;;^UTILITY(U,$J,358.3,2671,0)
 ;;=M65.841^^25^225^106
 ;;^UTILITY(U,$J,358.3,2671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2671,1,3,0)
 ;;=3^Synovitis & tenosynvts, rt hand, oth
