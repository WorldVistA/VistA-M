IBDEI061 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2486,1,4,0)
 ;;=4^M99.03
 ;;^UTILITY(U,$J,358.3,2486,2)
 ;;=^5015403
 ;;^UTILITY(U,$J,358.3,2487,0)
 ;;=M48.06^^15^190^14
 ;;^UTILITY(U,$J,358.3,2487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2487,1,3,0)
 ;;=3^Spinal stenosis, lumbar region
 ;;^UTILITY(U,$J,358.3,2487,1,4,0)
 ;;=4^M48.06
 ;;^UTILITY(U,$J,358.3,2487,2)
 ;;=^5012093
 ;;^UTILITY(U,$J,358.3,2488,0)
 ;;=S33.5XXA^^15^190^16
 ;;^UTILITY(U,$J,358.3,2488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2488,1,3,0)
 ;;=3^Sprain of ligaments of lumbar spine, initial encounter
 ;;^UTILITY(U,$J,358.3,2488,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,2488,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,2489,0)
 ;;=S33.5XXS^^15^190^17
 ;;^UTILITY(U,$J,358.3,2489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2489,1,3,0)
 ;;=3^Sprain of ligaments of lumbar spine, sequela
 ;;^UTILITY(U,$J,358.3,2489,1,4,0)
 ;;=4^S33.5XXS
 ;;^UTILITY(U,$J,358.3,2489,2)
 ;;=^5025174
 ;;^UTILITY(U,$J,358.3,2490,0)
 ;;=S33.5XXD^^15^190^18
 ;;^UTILITY(U,$J,358.3,2490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2490,1,3,0)
 ;;=3^Sprain of ligaments of lumbar spine, subsequent encounter
 ;;^UTILITY(U,$J,358.3,2490,1,4,0)
 ;;=4^S33.5XXD
 ;;^UTILITY(U,$J,358.3,2490,2)
 ;;=^5025173
 ;;^UTILITY(U,$J,358.3,2491,0)
 ;;=M43.16^^15^190^15
 ;;^UTILITY(U,$J,358.3,2491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2491,1,3,0)
 ;;=3^Spondylolisthesis, lumbar region
 ;;^UTILITY(U,$J,358.3,2491,1,4,0)
 ;;=4^M43.16
 ;;^UTILITY(U,$J,358.3,2491,2)
 ;;=^5011927
 ;;^UTILITY(U,$J,358.3,2492,0)
 ;;=M99.85^^15^191^1
 ;;^UTILITY(U,$J,358.3,2492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2492,1,3,0)
 ;;=3^Biomechanical lesions of pelvic region
 ;;^UTILITY(U,$J,358.3,2492,1,4,0)
 ;;=4^M99.85
 ;;^UTILITY(U,$J,358.3,2492,2)
 ;;=^5015485
 ;;^UTILITY(U,$J,358.3,2493,0)
 ;;=M99.84^^15^191^2
 ;;^UTILITY(U,$J,358.3,2493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2493,1,3,0)
 ;;=3^Biomechanical lesions of sacral region
 ;;^UTILITY(U,$J,358.3,2493,1,4,0)
 ;;=4^M99.84
 ;;^UTILITY(U,$J,358.3,2493,2)
 ;;=^5015484
 ;;^UTILITY(U,$J,358.3,2494,0)
 ;;=G54.0^^15^191^3
 ;;^UTILITY(U,$J,358.3,2494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2494,1,3,0)
 ;;=3^Brachial plexus disorders
 ;;^UTILITY(U,$J,358.3,2494,1,4,0)
 ;;=4^G54.0
 ;;^UTILITY(U,$J,358.3,2494,2)
 ;;=^5004007
 ;;^UTILITY(U,$J,358.3,2495,0)
 ;;=M76.02^^15^191^4
 ;;^UTILITY(U,$J,358.3,2495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2495,1,3,0)
 ;;=3^Gluteal tendinitis, left hip
 ;;^UTILITY(U,$J,358.3,2495,1,4,0)
 ;;=4^M76.02
 ;;^UTILITY(U,$J,358.3,2495,2)
 ;;=^5013268
 ;;^UTILITY(U,$J,358.3,2496,0)
 ;;=M76.01^^15^191^5
 ;;^UTILITY(U,$J,358.3,2496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2496,1,3,0)
 ;;=3^Gluteal tendinitis, right hip
 ;;^UTILITY(U,$J,358.3,2496,1,4,0)
 ;;=4^M76.01
 ;;^UTILITY(U,$J,358.3,2496,2)
 ;;=^5013267
 ;;^UTILITY(U,$J,358.3,2497,0)
 ;;=M76.22^^15^191^6
 ;;^UTILITY(U,$J,358.3,2497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2497,1,3,0)
 ;;=3^Iliac crest spur, left hip
 ;;^UTILITY(U,$J,358.3,2497,1,4,0)
 ;;=4^M76.22
 ;;^UTILITY(U,$J,358.3,2497,2)
 ;;=^5013274
 ;;^UTILITY(U,$J,358.3,2498,0)
 ;;=M76.21^^15^191^7
 ;;^UTILITY(U,$J,358.3,2498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2498,1,3,0)
 ;;=3^Iliac crest spur, right hip
 ;;^UTILITY(U,$J,358.3,2498,1,4,0)
 ;;=4^M76.21
 ;;^UTILITY(U,$J,358.3,2498,2)
 ;;=^5013273
 ;;^UTILITY(U,$J,358.3,2499,0)
 ;;=M54.18^^15^191^8
 ;;^UTILITY(U,$J,358.3,2499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2499,1,3,0)
 ;;=3^Radiculopathy, sacral and sacrococcygeal region
