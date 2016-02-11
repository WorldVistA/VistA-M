IBDEI074 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2750,2)
 ;;=^5012304
 ;;^UTILITY(U,$J,358.3,2751,0)
 ;;=M53.0^^25^227^8
 ;;^UTILITY(U,$J,358.3,2751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2751,1,3,0)
 ;;=3^Cervicocranial syndrome
 ;;^UTILITY(U,$J,358.3,2751,1,4,0)
 ;;=4^M53.0
 ;;^UTILITY(U,$J,358.3,2751,2)
 ;;=^21952
 ;;^UTILITY(U,$J,358.3,2752,0)
 ;;=M50.90^^25^227^5
 ;;^UTILITY(U,$J,358.3,2752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2752,1,3,0)
 ;;=3^Cervical disc disorder, unsp, unspecified cervical region
 ;;^UTILITY(U,$J,358.3,2752,1,4,0)
 ;;=4^M50.90
 ;;^UTILITY(U,$J,358.3,2752,2)
 ;;=^5012235
 ;;^UTILITY(U,$J,358.3,2753,0)
 ;;=M50.00^^25^227^4
 ;;^UTILITY(U,$J,358.3,2753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2753,1,3,0)
 ;;=3^Cervical disc disorder with myelopathy, unsp cervical region
 ;;^UTILITY(U,$J,358.3,2753,1,4,0)
 ;;=4^M50.00
 ;;^UTILITY(U,$J,358.3,2753,2)
 ;;=^5012215
 ;;^UTILITY(U,$J,358.3,2754,0)
 ;;=M54.12^^25^227^9
 ;;^UTILITY(U,$J,358.3,2754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2754,1,3,0)
 ;;=3^Radiculopathy, cervical region
 ;;^UTILITY(U,$J,358.3,2754,1,4,0)
 ;;=4^M54.12
 ;;^UTILITY(U,$J,358.3,2754,2)
 ;;=^5012297
 ;;^UTILITY(U,$J,358.3,2755,0)
 ;;=M99.01^^25^227^10
 ;;^UTILITY(U,$J,358.3,2755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2755,1,3,0)
 ;;=3^Segmental and somatic dysfunction of cervical region
 ;;^UTILITY(U,$J,358.3,2755,1,4,0)
 ;;=4^M99.01
 ;;^UTILITY(U,$J,358.3,2755,2)
 ;;=^5015401
 ;;^UTILITY(U,$J,358.3,2756,0)
 ;;=M48.02^^25^227^11
 ;;^UTILITY(U,$J,358.3,2756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2756,1,3,0)
 ;;=3^Spinal stenosis, cervical region
 ;;^UTILITY(U,$J,358.3,2756,1,4,0)
 ;;=4^M48.02
 ;;^UTILITY(U,$J,358.3,2756,2)
 ;;=^5012089
 ;;^UTILITY(U,$J,358.3,2757,0)
 ;;=M47.812^^25^227^12
 ;;^UTILITY(U,$J,358.3,2757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2757,1,3,0)
 ;;=3^Spondylosis w/o myelopathy or radiculopathy, cervical region
 ;;^UTILITY(U,$J,358.3,2757,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,2757,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,2758,0)
 ;;=S13.9XXA^^25^227^13
 ;;^UTILITY(U,$J,358.3,2758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2758,1,3,0)
 ;;=3^Sprain of joints/ligaments of unsp parts of neck, init
 ;;^UTILITY(U,$J,358.3,2758,1,4,0)
 ;;=4^S13.9XXA
 ;;^UTILITY(U,$J,358.3,2758,2)
 ;;=^5022037
 ;;^UTILITY(U,$J,358.3,2759,0)
 ;;=M99.88^^25^228^1
 ;;^UTILITY(U,$J,358.3,2759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2759,1,3,0)
 ;;=3^Biomechanical lesions of rib cage
 ;;^UTILITY(U,$J,358.3,2759,1,4,0)
 ;;=4^M99.88
 ;;^UTILITY(U,$J,358.3,2759,2)
 ;;=^5015488
 ;;^UTILITY(U,$J,358.3,2760,0)
 ;;=M99.82^^25^228^2
 ;;^UTILITY(U,$J,358.3,2760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2760,1,3,0)
 ;;=3^Biomechanical lesions of thoracic region
 ;;^UTILITY(U,$J,358.3,2760,1,4,0)
 ;;=4^M99.82
 ;;^UTILITY(U,$J,358.3,2760,2)
 ;;=^5015482
 ;;^UTILITY(U,$J,358.3,2761,0)
 ;;=M51.24^^25^228^5
 ;;^UTILITY(U,$J,358.3,2761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2761,1,3,0)
 ;;=3^Intervertebral disc displacement, thoracic region
 ;;^UTILITY(U,$J,358.3,2761,1,4,0)
 ;;=4^M51.24
 ;;^UTILITY(U,$J,358.3,2761,2)
 ;;=^5012247
 ;;^UTILITY(U,$J,358.3,2762,0)
 ;;=M51.34^^25^228^3
 ;;^UTILITY(U,$J,358.3,2762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2762,1,3,0)
 ;;=3^Intervertebral disc degeneration, thoracic region
 ;;^UTILITY(U,$J,358.3,2762,1,4,0)
 ;;=4^M51.34
 ;;^UTILITY(U,$J,358.3,2762,2)
 ;;=^5012251
 ;;^UTILITY(U,$J,358.3,2763,0)
 ;;=M51.35^^25^228^4
 ;;^UTILITY(U,$J,358.3,2763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2763,1,3,0)
 ;;=3^Intervertebral disc degeneration, thoracolumbar region
