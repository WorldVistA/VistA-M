IBDEI078 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2802,1,3,0)
 ;;=3^Segmental and somatic dysfunction of sacral region
 ;;^UTILITY(U,$J,358.3,2802,1,4,0)
 ;;=4^M99.04
 ;;^UTILITY(U,$J,358.3,2802,2)
 ;;=^5015404
 ;;^UTILITY(U,$J,358.3,2803,0)
 ;;=M99.05^^25^230^11
 ;;^UTILITY(U,$J,358.3,2803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2803,1,3,0)
 ;;=3^Segmental and somatic dysfunction of pelvic region
 ;;^UTILITY(U,$J,358.3,2803,1,4,0)
 ;;=4^M99.05
 ;;^UTILITY(U,$J,358.3,2803,2)
 ;;=^5015405
 ;;^UTILITY(U,$J,358.3,2804,0)
 ;;=S33.6XXA^^25^230^13
 ;;^UTILITY(U,$J,358.3,2804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2804,1,3,0)
 ;;=3^Sprain of sacroiliac joint, initial encounter
 ;;^UTILITY(U,$J,358.3,2804,1,4,0)
 ;;=4^S33.6XXA
 ;;^UTILITY(U,$J,358.3,2804,2)
 ;;=^5025175
 ;;^UTILITY(U,$J,358.3,2805,0)
 ;;=S33.6XXS^^25^230^14
 ;;^UTILITY(U,$J,358.3,2805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2805,1,3,0)
 ;;=3^Sprain of sacroiliac joint, sequela
 ;;^UTILITY(U,$J,358.3,2805,1,4,0)
 ;;=4^S33.6XXS
 ;;^UTILITY(U,$J,358.3,2805,2)
 ;;=^5025177
 ;;^UTILITY(U,$J,358.3,2806,0)
 ;;=S33.6XXD^^25^230^15
 ;;^UTILITY(U,$J,358.3,2806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2806,1,3,0)
 ;;=3^Sprain of sacroiliac joint, subsequent encounter
 ;;^UTILITY(U,$J,358.3,2806,1,4,0)
 ;;=4^S33.6XXD
 ;;^UTILITY(U,$J,358.3,2806,2)
 ;;=^5025176
 ;;^UTILITY(U,$J,358.3,2807,0)
 ;;=M12.9^^25^231^1
 ;;^UTILITY(U,$J,358.3,2807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2807,1,3,0)
 ;;=3^Arthropathy, unspecified
 ;;^UTILITY(U,$J,358.3,2807,1,4,0)
 ;;=4^M12.9
 ;;^UTILITY(U,$J,358.3,2807,2)
 ;;=^5010666
 ;;^UTILITY(U,$J,358.3,2808,0)
 ;;=M71.50^^25^231^2
 ;;^UTILITY(U,$J,358.3,2808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2808,1,3,0)
 ;;=3^Bursitis, unspec site NEC
 ;;^UTILITY(U,$J,358.3,2808,1,4,0)
 ;;=4^M71.50
 ;;^UTILITY(U,$J,358.3,2808,2)
 ;;=^5013190
 ;;^UTILITY(U,$J,358.3,2809,0)
 ;;=M62.9^^25^231^3
 ;;^UTILITY(U,$J,358.3,2809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2809,1,3,0)
 ;;=3^Disorder of muscle, unspecified
 ;;^UTILITY(U,$J,358.3,2809,1,4,0)
 ;;=4^M62.9
 ;;^UTILITY(U,$J,358.3,2809,2)
 ;;=^5012684
 ;;^UTILITY(U,$J,358.3,2810,0)
 ;;=M71.10^^25^231^4
 ;;^UTILITY(U,$J,358.3,2810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2810,1,3,0)
 ;;=3^Infective bursitis, unspecified site
 ;;^UTILITY(U,$J,358.3,2810,1,4,0)
 ;;=4^M71.10
 ;;^UTILITY(U,$J,358.3,2810,2)
 ;;=^5013123
 ;;^UTILITY(U,$J,358.3,2811,0)
 ;;=M62.838^^25^231^5
 ;;^UTILITY(U,$J,358.3,2811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2811,1,3,0)
 ;;=3^Muscle spasm, other
 ;;^UTILITY(U,$J,358.3,2811,1,4,0)
 ;;=4^M62.838
 ;;^UTILITY(U,$J,358.3,2811,2)
 ;;=^5012682
 ;;^UTILITY(U,$J,358.3,2812,0)
 ;;=M79.2^^25^231^6
 ;;^UTILITY(U,$J,358.3,2812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2812,1,3,0)
 ;;=3^Neuralgia and neuritis, unspecified
 ;;^UTILITY(U,$J,358.3,2812,1,4,0)
 ;;=4^M79.2
 ;;^UTILITY(U,$J,358.3,2812,2)
 ;;=^5013322
 ;;^UTILITY(U,$J,358.3,2813,0)
 ;;=M25.50^^25^231^7
 ;;^UTILITY(U,$J,358.3,2813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2813,1,3,0)
 ;;=3^Pain in unspecified joint
 ;;^UTILITY(U,$J,358.3,2813,1,4,0)
 ;;=4^M25.50
 ;;^UTILITY(U,$J,358.3,2813,2)
 ;;=^5011601
 ;;^UTILITY(U,$J,358.3,2814,0)
 ;;=M96.1^^25^231^8
 ;;^UTILITY(U,$J,358.3,2814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2814,1,3,0)
 ;;=3^Postlaminectomy syndrome NEC
 ;;^UTILITY(U,$J,358.3,2814,1,4,0)
 ;;=4^M96.1
 ;;^UTILITY(U,$J,358.3,2814,2)
 ;;=^5015374
 ;;^UTILITY(U,$J,358.3,2815,0)
 ;;=M54.10^^25^231^9
 ;;^UTILITY(U,$J,358.3,2815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2815,1,3,0)
 ;;=3^Radiculopathy, site unspecified
