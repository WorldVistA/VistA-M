IBDEI0FY ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6890,1,3,0)
 ;;=3^Intervertebral disc degeneration, thoracic region
 ;;^UTILITY(U,$J,358.3,6890,1,4,0)
 ;;=4^M51.34
 ;;^UTILITY(U,$J,358.3,6890,2)
 ;;=^5012251
 ;;^UTILITY(U,$J,358.3,6891,0)
 ;;=M51.35^^56^442^4
 ;;^UTILITY(U,$J,358.3,6891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6891,1,3,0)
 ;;=3^Intervertebral disc degeneration, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,6891,1,4,0)
 ;;=4^M51.35
 ;;^UTILITY(U,$J,358.3,6891,2)
 ;;=^5012252
 ;;^UTILITY(U,$J,358.3,6892,0)
 ;;=M51.04^^56^442^7
 ;;^UTILITY(U,$J,358.3,6892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6892,1,3,0)
 ;;=3^Intvrt disc disorders w/ myelopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,6892,1,4,0)
 ;;=4^M51.04
 ;;^UTILITY(U,$J,358.3,6892,2)
 ;;=^5012239
 ;;^UTILITY(U,$J,358.3,6893,0)
 ;;=M51.05^^56^442^8
 ;;^UTILITY(U,$J,358.3,6893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6893,1,3,0)
 ;;=3^Intvrt disc disorders w/ myelopathy, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,6893,1,4,0)
 ;;=4^M51.05
 ;;^UTILITY(U,$J,358.3,6893,2)
 ;;=^5012240
 ;;^UTILITY(U,$J,358.3,6894,0)
 ;;=M51.14^^56^442^9
 ;;^UTILITY(U,$J,358.3,6894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6894,1,3,0)
 ;;=3^Intvrt disc disorders w/ radiculopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,6894,1,4,0)
 ;;=4^M51.14
 ;;^UTILITY(U,$J,358.3,6894,2)
 ;;=^5012243
 ;;^UTILITY(U,$J,358.3,6895,0)
 ;;=M51.15^^56^442^10
 ;;^UTILITY(U,$J,358.3,6895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6895,1,3,0)
 ;;=3^Intvrt disc disorders w/ radiculopathy, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,6895,1,4,0)
 ;;=4^M51.15
 ;;^UTILITY(U,$J,358.3,6895,2)
 ;;=^5012244
 ;;^UTILITY(U,$J,358.3,6896,0)
 ;;=M54.6^^56^442^11
 ;;^UTILITY(U,$J,358.3,6896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6896,1,3,0)
 ;;=3^Pain in thoracic spine
 ;;^UTILITY(U,$J,358.3,6896,1,4,0)
 ;;=4^M54.6
 ;;^UTILITY(U,$J,358.3,6896,2)
 ;;=^272507
 ;;^UTILITY(U,$J,358.3,6897,0)
 ;;=M51.44^^56^442^12
 ;;^UTILITY(U,$J,358.3,6897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6897,1,3,0)
 ;;=3^Schmorl's nodes, thoracic region
 ;;^UTILITY(U,$J,358.3,6897,1,4,0)
 ;;=4^M51.44
 ;;^UTILITY(U,$J,358.3,6897,2)
 ;;=^5012255
 ;;^UTILITY(U,$J,358.3,6898,0)
 ;;=M99.02^^56^442^13
 ;;^UTILITY(U,$J,358.3,6898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6898,1,3,0)
 ;;=3^Segmental and somatic dysfunction of thoracic region
 ;;^UTILITY(U,$J,358.3,6898,1,4,0)
 ;;=4^M99.02
 ;;^UTILITY(U,$J,358.3,6898,2)
 ;;=^5015402
 ;;^UTILITY(U,$J,358.3,6899,0)
 ;;=M47.814^^56^442^14
 ;;^UTILITY(U,$J,358.3,6899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6899,1,3,0)
 ;;=3^Spondylosis w/o myelopathy or radiculopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,6899,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,6899,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,6900,0)
 ;;=S23.9XXS^^56^442^15
 ;;^UTILITY(U,$J,358.3,6900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6900,1,3,0)
 ;;=3^Sprain of unspecified parts of thorax, sequela
 ;;^UTILITY(U,$J,358.3,6900,1,4,0)
 ;;=4^S23.9XXS
 ;;^UTILITY(U,$J,358.3,6900,2)
 ;;=^5023269
 ;;^UTILITY(U,$J,358.3,6901,0)
 ;;=S23.9XXD^^56^442^16
 ;;^UTILITY(U,$J,358.3,6901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6901,1,3,0)
 ;;=3^Sprain of unspecified parts of thorax, subsequent encounter
 ;;^UTILITY(U,$J,358.3,6901,1,4,0)
 ;;=4^S23.9XXD
 ;;^UTILITY(U,$J,358.3,6901,2)
 ;;=^5023268
 ;;^UTILITY(U,$J,358.3,6902,0)
 ;;=G54.3^^56^442^17
