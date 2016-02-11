IBDEI077 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2789,1,3,0)
 ;;=3^Sprain of ligaments of lumbar spine, initial encounter
 ;;^UTILITY(U,$J,358.3,2789,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,2789,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,2790,0)
 ;;=S33.5XXS^^25^229^16
 ;;^UTILITY(U,$J,358.3,2790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2790,1,3,0)
 ;;=3^Sprain of ligaments of lumbar spine, sequela
 ;;^UTILITY(U,$J,358.3,2790,1,4,0)
 ;;=4^S33.5XXS
 ;;^UTILITY(U,$J,358.3,2790,2)
 ;;=^5025174
 ;;^UTILITY(U,$J,358.3,2791,0)
 ;;=S33.5XXD^^25^229^17
 ;;^UTILITY(U,$J,358.3,2791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2791,1,3,0)
 ;;=3^Sprain of ligaments of lumbar spine, subsequent encounter
 ;;^UTILITY(U,$J,358.3,2791,1,4,0)
 ;;=4^S33.5XXD
 ;;^UTILITY(U,$J,358.3,2791,2)
 ;;=^5025173
 ;;^UTILITY(U,$J,358.3,2792,0)
 ;;=M99.85^^25^230^1
 ;;^UTILITY(U,$J,358.3,2792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2792,1,3,0)
 ;;=3^Biomechanical lesions of pelvic region
 ;;^UTILITY(U,$J,358.3,2792,1,4,0)
 ;;=4^M99.85
 ;;^UTILITY(U,$J,358.3,2792,2)
 ;;=^5015485
 ;;^UTILITY(U,$J,358.3,2793,0)
 ;;=M99.84^^25^230^2
 ;;^UTILITY(U,$J,358.3,2793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2793,1,3,0)
 ;;=3^Biomechanical lesions of sacral region
 ;;^UTILITY(U,$J,358.3,2793,1,4,0)
 ;;=4^M99.84
 ;;^UTILITY(U,$J,358.3,2793,2)
 ;;=^5015484
 ;;^UTILITY(U,$J,358.3,2794,0)
 ;;=G54.0^^25^230^3
 ;;^UTILITY(U,$J,358.3,2794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2794,1,3,0)
 ;;=3^Brachial plexus disorders
 ;;^UTILITY(U,$J,358.3,2794,1,4,0)
 ;;=4^G54.0
 ;;^UTILITY(U,$J,358.3,2794,2)
 ;;=^5004007
 ;;^UTILITY(U,$J,358.3,2795,0)
 ;;=M76.02^^25^230^4
 ;;^UTILITY(U,$J,358.3,2795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2795,1,3,0)
 ;;=3^Gluteal tendinitis, left hip
 ;;^UTILITY(U,$J,358.3,2795,1,4,0)
 ;;=4^M76.02
 ;;^UTILITY(U,$J,358.3,2795,2)
 ;;=^5013268
 ;;^UTILITY(U,$J,358.3,2796,0)
 ;;=M76.01^^25^230^5
 ;;^UTILITY(U,$J,358.3,2796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2796,1,3,0)
 ;;=3^Gluteal tendinitis, right hip
 ;;^UTILITY(U,$J,358.3,2796,1,4,0)
 ;;=4^M76.01
 ;;^UTILITY(U,$J,358.3,2796,2)
 ;;=^5013267
 ;;^UTILITY(U,$J,358.3,2797,0)
 ;;=M76.22^^25^230^6
 ;;^UTILITY(U,$J,358.3,2797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2797,1,3,0)
 ;;=3^Iliac crest spur, left hip
 ;;^UTILITY(U,$J,358.3,2797,1,4,0)
 ;;=4^M76.22
 ;;^UTILITY(U,$J,358.3,2797,2)
 ;;=^5013274
 ;;^UTILITY(U,$J,358.3,2798,0)
 ;;=M76.21^^25^230^7
 ;;^UTILITY(U,$J,358.3,2798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2798,1,3,0)
 ;;=3^Iliac crest spur, right hip
 ;;^UTILITY(U,$J,358.3,2798,1,4,0)
 ;;=4^M76.21
 ;;^UTILITY(U,$J,358.3,2798,2)
 ;;=^5013273
 ;;^UTILITY(U,$J,358.3,2799,0)
 ;;=M54.18^^25^230^8
 ;;^UTILITY(U,$J,358.3,2799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2799,1,3,0)
 ;;=3^Radiculopathy, sacral and sacrococcygeal region
 ;;^UTILITY(U,$J,358.3,2799,1,4,0)
 ;;=4^M54.18
 ;;^UTILITY(U,$J,358.3,2799,2)
 ;;=^5012303
 ;;^UTILITY(U,$J,358.3,2800,0)
 ;;=M54.32^^25^230^9
 ;;^UTILITY(U,$J,358.3,2800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2800,1,3,0)
 ;;=3^Sciatica, left side
 ;;^UTILITY(U,$J,358.3,2800,1,4,0)
 ;;=4^M54.32
 ;;^UTILITY(U,$J,358.3,2800,2)
 ;;=^5012307
 ;;^UTILITY(U,$J,358.3,2801,0)
 ;;=M54.31^^25^230^10
 ;;^UTILITY(U,$J,358.3,2801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2801,1,3,0)
 ;;=3^Sciatica, right side
 ;;^UTILITY(U,$J,358.3,2801,1,4,0)
 ;;=4^M54.31
 ;;^UTILITY(U,$J,358.3,2801,2)
 ;;=^5012306
 ;;^UTILITY(U,$J,358.3,2802,0)
 ;;=M99.04^^25^230^12
 ;;^UTILITY(U,$J,358.3,2802,1,0)
 ;;=^358.31IA^4^2
