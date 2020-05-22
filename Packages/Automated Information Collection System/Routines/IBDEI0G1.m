IBDEI0G1 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6926,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/ Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,6926,1,4,0)
 ;;=4^M48.062
 ;;^UTILITY(U,$J,358.3,6926,2)
 ;;=^5151514
 ;;^UTILITY(U,$J,358.3,6927,0)
 ;;=M99.85^^56^444^1
 ;;^UTILITY(U,$J,358.3,6927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6927,1,3,0)
 ;;=3^Biomechanical lesions of pelvic region
 ;;^UTILITY(U,$J,358.3,6927,1,4,0)
 ;;=4^M99.85
 ;;^UTILITY(U,$J,358.3,6927,2)
 ;;=^5015485
 ;;^UTILITY(U,$J,358.3,6928,0)
 ;;=M99.84^^56^444^2
 ;;^UTILITY(U,$J,358.3,6928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6928,1,3,0)
 ;;=3^Biomechanical lesions of sacral region
 ;;^UTILITY(U,$J,358.3,6928,1,4,0)
 ;;=4^M99.84
 ;;^UTILITY(U,$J,358.3,6928,2)
 ;;=^5015484
 ;;^UTILITY(U,$J,358.3,6929,0)
 ;;=G54.0^^56^444^3
 ;;^UTILITY(U,$J,358.3,6929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6929,1,3,0)
 ;;=3^Brachial plexus disorders
 ;;^UTILITY(U,$J,358.3,6929,1,4,0)
 ;;=4^G54.0
 ;;^UTILITY(U,$J,358.3,6929,2)
 ;;=^5004007
 ;;^UTILITY(U,$J,358.3,6930,0)
 ;;=M76.02^^56^444^4
 ;;^UTILITY(U,$J,358.3,6930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6930,1,3,0)
 ;;=3^Gluteal tendinitis, left hip
 ;;^UTILITY(U,$J,358.3,6930,1,4,0)
 ;;=4^M76.02
 ;;^UTILITY(U,$J,358.3,6930,2)
 ;;=^5013268
 ;;^UTILITY(U,$J,358.3,6931,0)
 ;;=M76.01^^56^444^5
 ;;^UTILITY(U,$J,358.3,6931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6931,1,3,0)
 ;;=3^Gluteal tendinitis, right hip
 ;;^UTILITY(U,$J,358.3,6931,1,4,0)
 ;;=4^M76.01
 ;;^UTILITY(U,$J,358.3,6931,2)
 ;;=^5013267
 ;;^UTILITY(U,$J,358.3,6932,0)
 ;;=M76.22^^56^444^6
 ;;^UTILITY(U,$J,358.3,6932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6932,1,3,0)
 ;;=3^Iliac crest spur, left hip
 ;;^UTILITY(U,$J,358.3,6932,1,4,0)
 ;;=4^M76.22
 ;;^UTILITY(U,$J,358.3,6932,2)
 ;;=^5013274
 ;;^UTILITY(U,$J,358.3,6933,0)
 ;;=M76.21^^56^444^7
 ;;^UTILITY(U,$J,358.3,6933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6933,1,3,0)
 ;;=3^Iliac crest spur, right hip
 ;;^UTILITY(U,$J,358.3,6933,1,4,0)
 ;;=4^M76.21
 ;;^UTILITY(U,$J,358.3,6933,2)
 ;;=^5013273
 ;;^UTILITY(U,$J,358.3,6934,0)
 ;;=M54.18^^56^444^8
 ;;^UTILITY(U,$J,358.3,6934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6934,1,3,0)
 ;;=3^Radiculopathy, sacral and sacrococcygeal region
 ;;^UTILITY(U,$J,358.3,6934,1,4,0)
 ;;=4^M54.18
 ;;^UTILITY(U,$J,358.3,6934,2)
 ;;=^5012303
 ;;^UTILITY(U,$J,358.3,6935,0)
 ;;=M54.32^^56^444^9
 ;;^UTILITY(U,$J,358.3,6935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6935,1,3,0)
 ;;=3^Sciatica, left side
 ;;^UTILITY(U,$J,358.3,6935,1,4,0)
 ;;=4^M54.32
 ;;^UTILITY(U,$J,358.3,6935,2)
 ;;=^5012307
 ;;^UTILITY(U,$J,358.3,6936,0)
 ;;=M54.31^^56^444^10
 ;;^UTILITY(U,$J,358.3,6936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6936,1,3,0)
 ;;=3^Sciatica, right side
 ;;^UTILITY(U,$J,358.3,6936,1,4,0)
 ;;=4^M54.31
 ;;^UTILITY(U,$J,358.3,6936,2)
 ;;=^5012306
 ;;^UTILITY(U,$J,358.3,6937,0)
 ;;=M99.04^^56^444^12
 ;;^UTILITY(U,$J,358.3,6937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6937,1,3,0)
 ;;=3^Segmental and somatic dysfunction of sacral region
 ;;^UTILITY(U,$J,358.3,6937,1,4,0)
 ;;=4^M99.04
 ;;^UTILITY(U,$J,358.3,6937,2)
 ;;=^5015404
 ;;^UTILITY(U,$J,358.3,6938,0)
 ;;=M99.05^^56^444^11
 ;;^UTILITY(U,$J,358.3,6938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6938,1,3,0)
 ;;=3^Segmental and somatic dysfunction of pelvic region
 ;;^UTILITY(U,$J,358.3,6938,1,4,0)
 ;;=4^M99.05
