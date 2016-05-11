IBDEI05Z ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2461,1,3,0)
 ;;=3^Intervertebral disc degeneration, thoracic region
 ;;^UTILITY(U,$J,358.3,2461,1,4,0)
 ;;=4^M51.34
 ;;^UTILITY(U,$J,358.3,2461,2)
 ;;=^5012251
 ;;^UTILITY(U,$J,358.3,2462,0)
 ;;=M51.35^^15^189^4
 ;;^UTILITY(U,$J,358.3,2462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2462,1,3,0)
 ;;=3^Intervertebral disc degeneration, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,2462,1,4,0)
 ;;=4^M51.35
 ;;^UTILITY(U,$J,358.3,2462,2)
 ;;=^5012252
 ;;^UTILITY(U,$J,358.3,2463,0)
 ;;=M51.04^^15^189^6
 ;;^UTILITY(U,$J,358.3,2463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2463,1,3,0)
 ;;=3^Intvrt disc disorders w/ myelopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,2463,1,4,0)
 ;;=4^M51.04
 ;;^UTILITY(U,$J,358.3,2463,2)
 ;;=^5012239
 ;;^UTILITY(U,$J,358.3,2464,0)
 ;;=M51.05^^15^189^7
 ;;^UTILITY(U,$J,358.3,2464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2464,1,3,0)
 ;;=3^Intvrt disc disorders w/ myelopathy, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,2464,1,4,0)
 ;;=4^M51.05
 ;;^UTILITY(U,$J,358.3,2464,2)
 ;;=^5012240
 ;;^UTILITY(U,$J,358.3,2465,0)
 ;;=M51.14^^15^189^8
 ;;^UTILITY(U,$J,358.3,2465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2465,1,3,0)
 ;;=3^Intvrt disc disorders w/ radiculopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,2465,1,4,0)
 ;;=4^M51.14
 ;;^UTILITY(U,$J,358.3,2465,2)
 ;;=^5012243
 ;;^UTILITY(U,$J,358.3,2466,0)
 ;;=M51.15^^15^189^9
 ;;^UTILITY(U,$J,358.3,2466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2466,1,3,0)
 ;;=3^Intvrt disc disorders w/ radiculopathy, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,2466,1,4,0)
 ;;=4^M51.15
 ;;^UTILITY(U,$J,358.3,2466,2)
 ;;=^5012244
 ;;^UTILITY(U,$J,358.3,2467,0)
 ;;=M54.6^^15^189^10
 ;;^UTILITY(U,$J,358.3,2467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2467,1,3,0)
 ;;=3^Pain in thoracic spine
 ;;^UTILITY(U,$J,358.3,2467,1,4,0)
 ;;=4^M54.6
 ;;^UTILITY(U,$J,358.3,2467,2)
 ;;=^272507
 ;;^UTILITY(U,$J,358.3,2468,0)
 ;;=M51.44^^15^189^11
 ;;^UTILITY(U,$J,358.3,2468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2468,1,3,0)
 ;;=3^Schmorl's nodes, thoracic region
 ;;^UTILITY(U,$J,358.3,2468,1,4,0)
 ;;=4^M51.44
 ;;^UTILITY(U,$J,358.3,2468,2)
 ;;=^5012255
 ;;^UTILITY(U,$J,358.3,2469,0)
 ;;=M99.02^^15^189^12
 ;;^UTILITY(U,$J,358.3,2469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2469,1,3,0)
 ;;=3^Segmental and somatic dysfunction of thoracic region
 ;;^UTILITY(U,$J,358.3,2469,1,4,0)
 ;;=4^M99.02
 ;;^UTILITY(U,$J,358.3,2469,2)
 ;;=^5015402
 ;;^UTILITY(U,$J,358.3,2470,0)
 ;;=M47.814^^15^189^13
 ;;^UTILITY(U,$J,358.3,2470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2470,1,3,0)
 ;;=3^Spondylosis w/o myelopathy or radiculopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,2470,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,2470,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,2471,0)
 ;;=S23.9XXS^^15^189^14
 ;;^UTILITY(U,$J,358.3,2471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2471,1,3,0)
 ;;=3^Sprain of unspecified parts of thorax, sequela
 ;;^UTILITY(U,$J,358.3,2471,1,4,0)
 ;;=4^S23.9XXS
 ;;^UTILITY(U,$J,358.3,2471,2)
 ;;=^5023269
 ;;^UTILITY(U,$J,358.3,2472,0)
 ;;=S23.9XXD^^15^189^15
 ;;^UTILITY(U,$J,358.3,2472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2472,1,3,0)
 ;;=3^Sprain of unspecified parts of thorax, subsequent encounter
 ;;^UTILITY(U,$J,358.3,2472,1,4,0)
 ;;=4^S23.9XXD
 ;;^UTILITY(U,$J,358.3,2472,2)
 ;;=^5023268
 ;;^UTILITY(U,$J,358.3,2473,0)
 ;;=G54.3^^15^189^16
 ;;^UTILITY(U,$J,358.3,2473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2473,1,3,0)
 ;;=3^Thoracic root disorders, not elsewhere classified
