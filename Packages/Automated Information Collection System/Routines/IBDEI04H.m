IBDEI04H ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1569,1,3,0)
 ;;=3^Cervicalgia
 ;;^UTILITY(U,$J,358.3,1569,1,4,0)
 ;;=4^M54.2
 ;;^UTILITY(U,$J,358.3,1569,2)
 ;;=^5012304
 ;;^UTILITY(U,$J,358.3,1570,0)
 ;;=M48.00^^3^45^95
 ;;^UTILITY(U,$J,358.3,1570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1570,1,3,0)
 ;;=3^Spinal stenosis, site unspecified
 ;;^UTILITY(U,$J,358.3,1570,1,4,0)
 ;;=4^M48.00
 ;;^UTILITY(U,$J,358.3,1570,2)
 ;;=^5012087
 ;;^UTILITY(U,$J,358.3,1571,0)
 ;;=M54.5^^3^45^48
 ;;^UTILITY(U,$J,358.3,1571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1571,1,3,0)
 ;;=3^Low back pain
 ;;^UTILITY(U,$J,358.3,1571,1,4,0)
 ;;=4^M54.5
 ;;^UTILITY(U,$J,358.3,1571,2)
 ;;=^5012311
 ;;^UTILITY(U,$J,358.3,1572,0)
 ;;=M54.30^^3^45^91
 ;;^UTILITY(U,$J,358.3,1572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1572,1,3,0)
 ;;=3^Sciatica, unspecified side
 ;;^UTILITY(U,$J,358.3,1572,1,4,0)
 ;;=4^M54.30
 ;;^UTILITY(U,$J,358.3,1572,2)
 ;;=^5012305
 ;;^UTILITY(U,$J,358.3,1573,0)
 ;;=M54.14^^3^45^84
 ;;^UTILITY(U,$J,358.3,1573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1573,1,3,0)
 ;;=3^Radiculopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,1573,1,4,0)
 ;;=4^M54.14
 ;;^UTILITY(U,$J,358.3,1573,2)
 ;;=^5012299
 ;;^UTILITY(U,$J,358.3,1574,0)
 ;;=M54.16^^3^45^81
 ;;^UTILITY(U,$J,358.3,1574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1574,1,3,0)
 ;;=3^Radiculopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,1574,1,4,0)
 ;;=4^M54.16
 ;;^UTILITY(U,$J,358.3,1574,2)
 ;;=^5012301
 ;;^UTILITY(U,$J,358.3,1575,0)
 ;;=M54.15^^3^45^85
 ;;^UTILITY(U,$J,358.3,1575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1575,1,3,0)
 ;;=3^Radiculopathy, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,1575,1,4,0)
 ;;=4^M54.15
 ;;^UTILITY(U,$J,358.3,1575,2)
 ;;=^5012300
 ;;^UTILITY(U,$J,358.3,1576,0)
 ;;=M54.17^^3^45^82
 ;;^UTILITY(U,$J,358.3,1576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1576,1,3,0)
 ;;=3^Radiculopathy, lumbosacral region
 ;;^UTILITY(U,$J,358.3,1576,1,4,0)
 ;;=4^M54.17
 ;;^UTILITY(U,$J,358.3,1576,2)
 ;;=^5012302
 ;;^UTILITY(U,$J,358.3,1577,0)
 ;;=M54.9^^3^45^24
 ;;^UTILITY(U,$J,358.3,1577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1577,1,3,0)
 ;;=3^Dorsalgia, unspecified
 ;;^UTILITY(U,$J,358.3,1577,1,4,0)
 ;;=4^M54.9
 ;;^UTILITY(U,$J,358.3,1577,2)
 ;;=^5012314
 ;;^UTILITY(U,$J,358.3,1578,0)
 ;;=M75.101^^3^45^89
 ;;^UTILITY(U,$J,358.3,1578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1578,1,3,0)
 ;;=3^Rotatr-cuff tear/ruptr of right shoulder, not trauma,Unspec
 ;;^UTILITY(U,$J,358.3,1578,1,4,0)
 ;;=4^M75.101
 ;;^UTILITY(U,$J,358.3,1578,2)
 ;;=^5013242
 ;;^UTILITY(U,$J,358.3,1579,0)
 ;;=M75.102^^3^45^88
 ;;^UTILITY(U,$J,358.3,1579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1579,1,3,0)
 ;;=3^Rotatr-cuff tear/ruptr of left shoulder, not trauma,Unspec
 ;;^UTILITY(U,$J,358.3,1579,1,4,0)
 ;;=4^M75.102
 ;;^UTILITY(U,$J,358.3,1579,2)
 ;;=^5013243
 ;;^UTILITY(U,$J,358.3,1580,0)
 ;;=M75.81^^3^45^94
 ;;^UTILITY(U,$J,358.3,1580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1580,1,3,0)
 ;;=3^Shoulder NEC lesions, right shoulder
 ;;^UTILITY(U,$J,358.3,1580,1,4,0)
 ;;=4^M75.81
 ;;^UTILITY(U,$J,358.3,1580,2)
 ;;=^5013261
 ;;^UTILITY(U,$J,358.3,1581,0)
 ;;=M75.82^^3^45^93
 ;;^UTILITY(U,$J,358.3,1581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1581,1,3,0)
 ;;=3^Shoulder NEC lesions, left shoulder
 ;;^UTILITY(U,$J,358.3,1581,1,4,0)
 ;;=4^M75.82
 ;;^UTILITY(U,$J,358.3,1581,2)
 ;;=^5013262
 ;;^UTILITY(U,$J,358.3,1582,0)
 ;;=M77.11^^3^45^45
 ;;^UTILITY(U,$J,358.3,1582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1582,1,3,0)
 ;;=3^Lateral epicondylitis, right elbow
 ;;^UTILITY(U,$J,358.3,1582,1,4,0)
 ;;=4^M77.11
