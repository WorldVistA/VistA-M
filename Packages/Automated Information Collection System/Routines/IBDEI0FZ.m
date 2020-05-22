IBDEI0FZ ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6902,1,3,0)
 ;;=3^Thoracic root disorders, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,6902,1,4,0)
 ;;=4^G54.3
 ;;^UTILITY(U,$J,358.3,6902,2)
 ;;=^5004010
 ;;^UTILITY(U,$J,358.3,6903,0)
 ;;=M51.25^^56^442^6
 ;;^UTILITY(U,$J,358.3,6903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6903,1,3,0)
 ;;=3^Intervertebral disc displacement,thoraclmbr Regn
 ;;^UTILITY(U,$J,358.3,6903,1,4,0)
 ;;=4^M51.25
 ;;^UTILITY(U,$J,358.3,6903,2)
 ;;=^5012248
 ;;^UTILITY(U,$J,358.3,6904,0)
 ;;=M99.83^^56^443^1
 ;;^UTILITY(U,$J,358.3,6904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6904,1,3,0)
 ;;=3^Biomechanical lesions of lumbar region
 ;;^UTILITY(U,$J,358.3,6904,1,4,0)
 ;;=4^M99.83
 ;;^UTILITY(U,$J,358.3,6904,2)
 ;;=^5015483
 ;;^UTILITY(U,$J,358.3,6905,0)
 ;;=M51.36^^56^443^2
 ;;^UTILITY(U,$J,358.3,6905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6905,1,3,0)
 ;;=3^Intervertebral disc degeneration, lumbar region
 ;;^UTILITY(U,$J,358.3,6905,1,4,0)
 ;;=4^M51.36
 ;;^UTILITY(U,$J,358.3,6905,2)
 ;;=^5012253
 ;;^UTILITY(U,$J,358.3,6906,0)
 ;;=M51.37^^56^443^3
 ;;^UTILITY(U,$J,358.3,6906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6906,1,3,0)
 ;;=3^Intervertebral disc degeneration, lumbosacral region
 ;;^UTILITY(U,$J,358.3,6906,1,4,0)
 ;;=4^M51.37
 ;;^UTILITY(U,$J,358.3,6906,2)
 ;;=^5012254
 ;;^UTILITY(U,$J,358.3,6907,0)
 ;;=M51.06^^56^443^4
 ;;^UTILITY(U,$J,358.3,6907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6907,1,3,0)
 ;;=3^Intervertebral disc disorders w/ myelopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,6907,1,4,0)
 ;;=4^M51.06
 ;;^UTILITY(U,$J,358.3,6907,2)
 ;;=^5012241
 ;;^UTILITY(U,$J,358.3,6908,0)
 ;;=M51.16^^56^443^5
 ;;^UTILITY(U,$J,358.3,6908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6908,1,3,0)
 ;;=3^Intervertebral disc disorders w/ radiculopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,6908,1,4,0)
 ;;=4^M51.16
 ;;^UTILITY(U,$J,358.3,6908,2)
 ;;=^5012245
 ;;^UTILITY(U,$J,358.3,6909,0)
 ;;=M51.17^^56^443^6
 ;;^UTILITY(U,$J,358.3,6909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6909,1,3,0)
 ;;=3^Intervertebral disc disorders w/ radiculopathy, lumbosacral region
 ;;^UTILITY(U,$J,358.3,6909,1,4,0)
 ;;=4^M51.17
 ;;^UTILITY(U,$J,358.3,6909,2)
 ;;=^5012246
 ;;^UTILITY(U,$J,358.3,6910,0)
 ;;=M54.5^^56^443^9
 ;;^UTILITY(U,$J,358.3,6910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6910,1,3,0)
 ;;=3^Low back pain
 ;;^UTILITY(U,$J,358.3,6910,1,4,0)
 ;;=4^M54.5
 ;;^UTILITY(U,$J,358.3,6910,2)
 ;;=^5012311
 ;;^UTILITY(U,$J,358.3,6911,0)
 ;;=G54.1^^56^443^10
 ;;^UTILITY(U,$J,358.3,6911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6911,1,3,0)
 ;;=3^Lumbosacral plexus disorders
 ;;^UTILITY(U,$J,358.3,6911,1,4,0)
 ;;=4^G54.1
 ;;^UTILITY(U,$J,358.3,6911,2)
 ;;=^5004008
 ;;^UTILITY(U,$J,358.3,6912,0)
 ;;=G54.4^^56^443^11
 ;;^UTILITY(U,$J,358.3,6912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6912,1,3,0)
 ;;=3^Lumbosacral root disorders NEC
 ;;^UTILITY(U,$J,358.3,6912,1,4,0)
 ;;=4^G54.4
 ;;^UTILITY(U,$J,358.3,6912,2)
 ;;=^5004011
 ;;^UTILITY(U,$J,358.3,6913,0)
 ;;=M54.16^^56^443^12
 ;;^UTILITY(U,$J,358.3,6913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6913,1,3,0)
 ;;=3^Radiculopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,6913,1,4,0)
 ;;=4^M54.16
 ;;^UTILITY(U,$J,358.3,6913,2)
 ;;=^5012301
 ;;^UTILITY(U,$J,358.3,6914,0)
 ;;=M54.17^^56^443^13
 ;;^UTILITY(U,$J,358.3,6914,1,0)
 ;;=^358.31IA^4^2
