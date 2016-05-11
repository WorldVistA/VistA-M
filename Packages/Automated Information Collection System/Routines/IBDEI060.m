IBDEI060 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2473,1,4,0)
 ;;=4^G54.3
 ;;^UTILITY(U,$J,358.3,2473,2)
 ;;=^5004010
 ;;^UTILITY(U,$J,358.3,2474,0)
 ;;=M99.83^^15^190^1
 ;;^UTILITY(U,$J,358.3,2474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2474,1,3,0)
 ;;=3^Biomechanical lesions of lumbar region
 ;;^UTILITY(U,$J,358.3,2474,1,4,0)
 ;;=4^M99.83
 ;;^UTILITY(U,$J,358.3,2474,2)
 ;;=^5015483
 ;;^UTILITY(U,$J,358.3,2475,0)
 ;;=M51.36^^15^190^2
 ;;^UTILITY(U,$J,358.3,2475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2475,1,3,0)
 ;;=3^Intervertebral disc degeneration, lumbar region
 ;;^UTILITY(U,$J,358.3,2475,1,4,0)
 ;;=4^M51.36
 ;;^UTILITY(U,$J,358.3,2475,2)
 ;;=^5012253
 ;;^UTILITY(U,$J,358.3,2476,0)
 ;;=M51.37^^15^190^3
 ;;^UTILITY(U,$J,358.3,2476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2476,1,3,0)
 ;;=3^Intervertebral disc degeneration, lumbosacral region
 ;;^UTILITY(U,$J,358.3,2476,1,4,0)
 ;;=4^M51.37
 ;;^UTILITY(U,$J,358.3,2476,2)
 ;;=^5012254
 ;;^UTILITY(U,$J,358.3,2477,0)
 ;;=M51.06^^15^190^4
 ;;^UTILITY(U,$J,358.3,2477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2477,1,3,0)
 ;;=3^Intervertebral disc disorders w/ myelopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,2477,1,4,0)
 ;;=4^M51.06
 ;;^UTILITY(U,$J,358.3,2477,2)
 ;;=^5012241
 ;;^UTILITY(U,$J,358.3,2478,0)
 ;;=M51.16^^15^190^5
 ;;^UTILITY(U,$J,358.3,2478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2478,1,3,0)
 ;;=3^Intervertebral disc disorders w/ radiculopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,2478,1,4,0)
 ;;=4^M51.16
 ;;^UTILITY(U,$J,358.3,2478,2)
 ;;=^5012245
 ;;^UTILITY(U,$J,358.3,2479,0)
 ;;=M51.17^^15^190^6
 ;;^UTILITY(U,$J,358.3,2479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2479,1,3,0)
 ;;=3^Intervertebral disc disorders w/ radiculopathy, lumbosacral region
 ;;^UTILITY(U,$J,358.3,2479,1,4,0)
 ;;=4^M51.17
 ;;^UTILITY(U,$J,358.3,2479,2)
 ;;=^5012246
 ;;^UTILITY(U,$J,358.3,2480,0)
 ;;=M54.5^^15^190^7
 ;;^UTILITY(U,$J,358.3,2480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2480,1,3,0)
 ;;=3^Low back pain
 ;;^UTILITY(U,$J,358.3,2480,1,4,0)
 ;;=4^M54.5
 ;;^UTILITY(U,$J,358.3,2480,2)
 ;;=^5012311
 ;;^UTILITY(U,$J,358.3,2481,0)
 ;;=G54.1^^15^190^8
 ;;^UTILITY(U,$J,358.3,2481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2481,1,3,0)
 ;;=3^Lumbosacral plexus disorders
 ;;^UTILITY(U,$J,358.3,2481,1,4,0)
 ;;=4^G54.1
 ;;^UTILITY(U,$J,358.3,2481,2)
 ;;=^5004008
 ;;^UTILITY(U,$J,358.3,2482,0)
 ;;=G54.4^^15^190^9
 ;;^UTILITY(U,$J,358.3,2482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2482,1,3,0)
 ;;=3^Lumbosacral root disorders NEC
 ;;^UTILITY(U,$J,358.3,2482,1,4,0)
 ;;=4^G54.4
 ;;^UTILITY(U,$J,358.3,2482,2)
 ;;=^5004011
 ;;^UTILITY(U,$J,358.3,2483,0)
 ;;=M54.16^^15^190^10
 ;;^UTILITY(U,$J,358.3,2483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2483,1,3,0)
 ;;=3^Radiculopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,2483,1,4,0)
 ;;=4^M54.16
 ;;^UTILITY(U,$J,358.3,2483,2)
 ;;=^5012301
 ;;^UTILITY(U,$J,358.3,2484,0)
 ;;=M54.17^^15^190^11
 ;;^UTILITY(U,$J,358.3,2484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2484,1,3,0)
 ;;=3^Radiculopathy, lumbosacral region
 ;;^UTILITY(U,$J,358.3,2484,1,4,0)
 ;;=4^M54.17
 ;;^UTILITY(U,$J,358.3,2484,2)
 ;;=^5012302
 ;;^UTILITY(U,$J,358.3,2485,0)
 ;;=M51.46^^15^190^12
 ;;^UTILITY(U,$J,358.3,2485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2485,1,3,0)
 ;;=3^Schmorl's nodes, lumbar region
 ;;^UTILITY(U,$J,358.3,2485,1,4,0)
 ;;=4^M51.46
 ;;^UTILITY(U,$J,358.3,2485,2)
 ;;=^5012257
 ;;^UTILITY(U,$J,358.3,2486,0)
 ;;=M99.03^^15^190^13
 ;;^UTILITY(U,$J,358.3,2486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2486,1,3,0)
 ;;=3^Segmental and somatic dysfunction of lumbar region
