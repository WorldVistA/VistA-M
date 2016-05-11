IBDEI062 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2499,1,4,0)
 ;;=4^M54.18
 ;;^UTILITY(U,$J,358.3,2499,2)
 ;;=^5012303
 ;;^UTILITY(U,$J,358.3,2500,0)
 ;;=M54.32^^15^191^9
 ;;^UTILITY(U,$J,358.3,2500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2500,1,3,0)
 ;;=3^Sciatica, left side
 ;;^UTILITY(U,$J,358.3,2500,1,4,0)
 ;;=4^M54.32
 ;;^UTILITY(U,$J,358.3,2500,2)
 ;;=^5012307
 ;;^UTILITY(U,$J,358.3,2501,0)
 ;;=M54.31^^15^191^10
 ;;^UTILITY(U,$J,358.3,2501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2501,1,3,0)
 ;;=3^Sciatica, right side
 ;;^UTILITY(U,$J,358.3,2501,1,4,0)
 ;;=4^M54.31
 ;;^UTILITY(U,$J,358.3,2501,2)
 ;;=^5012306
 ;;^UTILITY(U,$J,358.3,2502,0)
 ;;=M99.04^^15^191^12
 ;;^UTILITY(U,$J,358.3,2502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2502,1,3,0)
 ;;=3^Segmental and somatic dysfunction of sacral region
 ;;^UTILITY(U,$J,358.3,2502,1,4,0)
 ;;=4^M99.04
 ;;^UTILITY(U,$J,358.3,2502,2)
 ;;=^5015404
 ;;^UTILITY(U,$J,358.3,2503,0)
 ;;=M99.05^^15^191^11
 ;;^UTILITY(U,$J,358.3,2503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2503,1,3,0)
 ;;=3^Segmental and somatic dysfunction of pelvic region
 ;;^UTILITY(U,$J,358.3,2503,1,4,0)
 ;;=4^M99.05
 ;;^UTILITY(U,$J,358.3,2503,2)
 ;;=^5015405
 ;;^UTILITY(U,$J,358.3,2504,0)
 ;;=S33.6XXA^^15^191^13
 ;;^UTILITY(U,$J,358.3,2504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2504,1,3,0)
 ;;=3^Sprain of sacroiliac joint, initial encounter
 ;;^UTILITY(U,$J,358.3,2504,1,4,0)
 ;;=4^S33.6XXA
 ;;^UTILITY(U,$J,358.3,2504,2)
 ;;=^5025175
 ;;^UTILITY(U,$J,358.3,2505,0)
 ;;=S33.6XXS^^15^191^14
 ;;^UTILITY(U,$J,358.3,2505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2505,1,3,0)
 ;;=3^Sprain of sacroiliac joint, sequela
 ;;^UTILITY(U,$J,358.3,2505,1,4,0)
 ;;=4^S33.6XXS
 ;;^UTILITY(U,$J,358.3,2505,2)
 ;;=^5025177
 ;;^UTILITY(U,$J,358.3,2506,0)
 ;;=S33.6XXD^^15^191^15
 ;;^UTILITY(U,$J,358.3,2506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2506,1,3,0)
 ;;=3^Sprain of sacroiliac joint, subsequent encounter
 ;;^UTILITY(U,$J,358.3,2506,1,4,0)
 ;;=4^S33.6XXD
 ;;^UTILITY(U,$J,358.3,2506,2)
 ;;=^5025176
 ;;^UTILITY(U,$J,358.3,2507,0)
 ;;=M12.9^^15^192^1
 ;;^UTILITY(U,$J,358.3,2507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2507,1,3,0)
 ;;=3^Arthropathy, unspecified
 ;;^UTILITY(U,$J,358.3,2507,1,4,0)
 ;;=4^M12.9
 ;;^UTILITY(U,$J,358.3,2507,2)
 ;;=^5010666
 ;;^UTILITY(U,$J,358.3,2508,0)
 ;;=M71.50^^15^192^2
 ;;^UTILITY(U,$J,358.3,2508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2508,1,3,0)
 ;;=3^Bursitis, unspec site NEC
 ;;^UTILITY(U,$J,358.3,2508,1,4,0)
 ;;=4^M71.50
 ;;^UTILITY(U,$J,358.3,2508,2)
 ;;=^5013190
 ;;^UTILITY(U,$J,358.3,2509,0)
 ;;=M62.9^^15^192^3
 ;;^UTILITY(U,$J,358.3,2509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2509,1,3,0)
 ;;=3^Disorder of muscle, unspecified
 ;;^UTILITY(U,$J,358.3,2509,1,4,0)
 ;;=4^M62.9
 ;;^UTILITY(U,$J,358.3,2509,2)
 ;;=^5012684
 ;;^UTILITY(U,$J,358.3,2510,0)
 ;;=M71.10^^15^192^5
 ;;^UTILITY(U,$J,358.3,2510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2510,1,3,0)
 ;;=3^Infective bursitis, unspecified site
 ;;^UTILITY(U,$J,358.3,2510,1,4,0)
 ;;=4^M71.10
 ;;^UTILITY(U,$J,358.3,2510,2)
 ;;=^5013123
 ;;^UTILITY(U,$J,358.3,2511,0)
 ;;=M62.838^^15^192^6
 ;;^UTILITY(U,$J,358.3,2511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2511,1,3,0)
 ;;=3^Muscle spasm, other
 ;;^UTILITY(U,$J,358.3,2511,1,4,0)
 ;;=4^M62.838
 ;;^UTILITY(U,$J,358.3,2511,2)
 ;;=^5012682
 ;;^UTILITY(U,$J,358.3,2512,0)
 ;;=M79.2^^15^192^8
 ;;^UTILITY(U,$J,358.3,2512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2512,1,3,0)
 ;;=3^Neuralgia and neuritis, unspecified
 ;;^UTILITY(U,$J,358.3,2512,1,4,0)
 ;;=4^M79.2
