IBDEI01C ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2759,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,2759,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,2759,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,2760,0)
 ;;=M99.81^^26^200^1
 ;;^UTILITY(U,$J,358.3,2760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2760,1,3,0)
 ;;=3^Biomechanical lesions of cervial region, other
 ;;^UTILITY(U,$J,358.3,2760,1,4,0)
 ;;=4^M99.81
 ;;^UTILITY(U,$J,358.3,2760,2)
 ;;=^5015481
 ;;^UTILITY(U,$J,358.3,2761,0)
 ;;=M99.80^^26^200^2
 ;;^UTILITY(U,$J,358.3,2761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2761,1,3,0)
 ;;=3^Biomechanical lesions of head region, other
 ;;^UTILITY(U,$J,358.3,2761,1,4,0)
 ;;=4^M99.80
 ;;^UTILITY(U,$J,358.3,2761,2)
 ;;=^5015480
 ;;^UTILITY(U,$J,358.3,2762,0)
 ;;=M50.30^^26^200^6
 ;;^UTILITY(U,$J,358.3,2762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2762,1,3,0)
 ;;=3^Cervical Disc Degeneration,Unspec Cervical Region
 ;;^UTILITY(U,$J,358.3,2762,1,4,0)
 ;;=4^M50.30
 ;;^UTILITY(U,$J,358.3,2762,2)
 ;;=^5012227
 ;;^UTILITY(U,$J,358.3,2763,0)
 ;;=G54.2^^26^200^24
 ;;^UTILITY(U,$J,358.3,2763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2763,1,3,0)
 ;;=3^Cervical root disorders NEC
 ;;^UTILITY(U,$J,358.3,2763,1,4,0)
 ;;=4^G54.2
 ;;^UTILITY(U,$J,358.3,2763,2)
 ;;=^5004009
 ;;^UTILITY(U,$J,358.3,2764,0)
 ;;=M54.2^^26^200^25
 ;;^UTILITY(U,$J,358.3,2764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2764,1,3,0)
 ;;=3^Cervicalgia
 ;;^UTILITY(U,$J,358.3,2764,1,4,0)
 ;;=4^M54.2
 ;;^UTILITY(U,$J,358.3,2764,2)
 ;;=^5012304
 ;;^UTILITY(U,$J,358.3,2765,0)
 ;;=M53.0^^26^200^26
 ;;^UTILITY(U,$J,358.3,2765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2765,1,3,0)
 ;;=3^Cervicocranial syndrome
 ;;^UTILITY(U,$J,358.3,2765,1,4,0)
 ;;=4^M53.0
 ;;^UTILITY(U,$J,358.3,2765,2)
 ;;=^21952
 ;;^UTILITY(U,$J,358.3,2766,0)
 ;;=M50.90^^26^200^8
 ;;^UTILITY(U,$J,358.3,2766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2766,1,3,0)
 ;;=3^Cervical Disc Disorder,Unspec Cervical Region
 ;;^UTILITY(U,$J,358.3,2766,1,4,0)
 ;;=4^M50.90
 ;;^UTILITY(U,$J,358.3,2766,2)
 ;;=^5012235
 ;;^UTILITY(U,$J,358.3,2767,0)
 ;;=M50.00^^26^200^7
 ;;^UTILITY(U,$J,358.3,2767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2767,1,3,0)
 ;;=3^Cervical Disc Disorder w/ Melopathy,Unspec Cervical Region
 ;;^UTILITY(U,$J,358.3,2767,1,4,0)
 ;;=4^M50.00
 ;;^UTILITY(U,$J,358.3,2767,2)
 ;;=^5012215
 ;;^UTILITY(U,$J,358.3,2768,0)
 ;;=M54.12^^26^200^27
 ;;^UTILITY(U,$J,358.3,2768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2768,1,3,0)
 ;;=3^Radiculopathy, cervical region
 ;;^UTILITY(U,$J,358.3,2768,1,4,0)
 ;;=4^M54.12
 ;;^UTILITY(U,$J,358.3,2768,2)
 ;;=^5012297
 ;;^UTILITY(U,$J,358.3,2769,0)
 ;;=M99.01^^26^200^28
 ;;^UTILITY(U,$J,358.3,2769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2769,1,3,0)
 ;;=3^Segmental and somatic dysfunction of cervical region
 ;;^UTILITY(U,$J,358.3,2769,1,4,0)
 ;;=4^M99.01
 ;;^UTILITY(U,$J,358.3,2769,2)
 ;;=^5015401
 ;;^UTILITY(U,$J,358.3,2770,0)
 ;;=M48.02^^26^200^29
 ;;^UTILITY(U,$J,358.3,2770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2770,1,3,0)
 ;;=3^Spinal stenosis, cervical region
 ;;^UTILITY(U,$J,358.3,2770,1,4,0)
 ;;=4^M48.02
 ;;^UTILITY(U,$J,358.3,2770,2)
 ;;=^5012089
 ;;^UTILITY(U,$J,358.3,2771,0)
 ;;=M47.812^^26^200^31
 ;;^UTILITY(U,$J,358.3,2771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2771,1,3,0)
 ;;=3^Spondylosis w/o myelopathy or radiculopathy, cervical region
 ;;^UTILITY(U,$J,358.3,2771,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,2771,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,2772,0)
 ;;=S13.9XXA^^26^200^32
 ;;^UTILITY(U,$J,358.3,2772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2772,1,3,0)
 ;;=3^Sprain of joints/ligaments of unsp parts of neck, init
 ;;^UTILITY(U,$J,358.3,2772,1,4,0)
 ;;=4^S13.9XXA
 ;;^UTILITY(U,$J,358.3,2772,2)
 ;;=^5022037
 ;;^UTILITY(U,$J,358.3,2773,0)
 ;;=M43.12^^26^200^30
 ;;^UTILITY(U,$J,358.3,2773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2773,1,3,0)
 ;;=3^Spondylolisthesis,Cervical Region
 ;;^UTILITY(U,$J,358.3,2773,1,4,0)
 ;;=4^M43.12
 ;;^UTILITY(U,$J,358.3,2773,2)
 ;;=^5011923
 ;;^UTILITY(U,$J,358.3,2774,0)
 ;;=M50.321^^26^200^3
 ;;^UTILITY(U,$J,358.3,2774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2774,1,3,0)
 ;;=3^Cervical Disc Degeneration at C4-C5
 ;;^UTILITY(U,$J,358.3,2774,1,4,0)
 ;;=4^M50.321
 ;;^UTILITY(U,$J,358.3,2774,2)
 ;;=^5138821
 ;;^UTILITY(U,$J,358.3,2775,0)
 ;;=M50.322^^26^200^4
 ;;^UTILITY(U,$J,358.3,2775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2775,1,3,0)
 ;;=3^Cervical Disc Degeneration at C5-C6
 ;;^UTILITY(U,$J,358.3,2775,1,4,0)
 ;;=4^M50.322
 ;;^UTILITY(U,$J,358.3,2775,2)
 ;;=^5138822
 ;;^UTILITY(U,$J,358.3,2776,0)
 ;;=M50.323^^26^200^5
 ;;^UTILITY(U,$J,358.3,2776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2776,1,3,0)
 ;;=3^Cervical Disc Degeneration at C6-C7
 ;;^UTILITY(U,$J,358.3,2776,1,4,0)
 ;;=4^M50.323
 ;;^UTILITY(U,$J,358.3,2776,2)
 ;;=^5138823
 ;;^UTILITY(U,$J,358.3,2777,0)
 ;;=M50.821^^26^200^11
 ;;^UTILITY(U,$J,358.3,2777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2777,1,3,0)
 ;;=3^Cervical Disc Disorders at C4-C5,Other
 ;;^UTILITY(U,$J,358.3,2777,1,4,0)
 ;;=4^M50.821
 ;;^UTILITY(U,$J,358.3,2777,2)
 ;;=^5138825
 ;;^UTILITY(U,$J,358.3,2778,0)
 ;;=M50.822^^26^200^15
 ;;^UTILITY(U,$J,358.3,2778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2778,1,3,0)
 ;;=3^Cervical Disc Disorders at C5-C6,Other
 ;;^UTILITY(U,$J,358.3,2778,1,4,0)
 ;;=4^M50.822
 ;;^UTILITY(U,$J,358.3,2778,2)
 ;;=^5138826
 ;;^UTILITY(U,$J,358.3,2779,0)
 ;;=M50.823^^26^200^19
 ;;^UTILITY(U,$J,358.3,2779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2779,1,3,0)
 ;;=3^Cervical Disc Disorders at C6-C7,Other
 ;;^UTILITY(U,$J,358.3,2779,1,4,0)
 ;;=4^M50.823
 ;;^UTILITY(U,$J,358.3,2779,2)
 ;;=^5138827
 ;;^UTILITY(U,$J,358.3,2780,0)
 ;;=M50.921^^26^200^12
 ;;^UTILITY(U,$J,358.3,2780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2780,1,3,0)
 ;;=3^Cervical Disc Disorders at C4-C5,Unspec
 ;;^UTILITY(U,$J,358.3,2780,1,4,0)
 ;;=4^M50.921
 ;;^UTILITY(U,$J,358.3,2780,2)
 ;;=^5138829
 ;;^UTILITY(U,$J,358.3,2781,0)
 ;;=M50.922^^26^200^16
 ;;^UTILITY(U,$J,358.3,2781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2781,1,3,0)
 ;;=3^Cervical Disc Disorders at C5-C6,Unspec
 ;;^UTILITY(U,$J,358.3,2781,1,4,0)
 ;;=4^M50.922
 ;;^UTILITY(U,$J,358.3,2781,2)
 ;;=^5138830
 ;;^UTILITY(U,$J,358.3,2782,0)
 ;;=M50.923^^26^200^20
 ;;^UTILITY(U,$J,358.3,2782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2782,1,3,0)
 ;;=3^Cervical Disc Disorders at C6-C7,Unspec
 ;;^UTILITY(U,$J,358.3,2782,1,4,0)
 ;;=4^M50.923
 ;;^UTILITY(U,$J,358.3,2782,2)
 ;;=^5138831
 ;;^UTILITY(U,$J,358.3,2783,0)
 ;;=M50.021^^26^200^9
 ;;^UTILITY(U,$J,358.3,2783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2783,1,3,0)
 ;;=3^Cervical Disc Disorders at C4-C5 w/ Myelopathy
 ;;^UTILITY(U,$J,358.3,2783,1,4,0)
 ;;=4^M50.021
 ;;^UTILITY(U,$J,358.3,2783,2)
 ;;=^5138809
 ;;^UTILITY(U,$J,358.3,2784,0)
 ;;=M50.022^^26^200^13
 ;;^UTILITY(U,$J,358.3,2784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2784,1,3,0)
 ;;=3^Cervical Disc Disorders at C5-C6 w/ Myelopathy
 ;;^UTILITY(U,$J,358.3,2784,1,4,0)
 ;;=4^M50.022
 ;;^UTILITY(U,$J,358.3,2784,2)
 ;;=^5138810
 ;;^UTILITY(U,$J,358.3,2785,0)
 ;;=M50.023^^26^200^17
 ;;^UTILITY(U,$J,358.3,2785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2785,1,3,0)
 ;;=3^Cervical Disc Disorders at C6-C7 w/ Myelopathy
 ;;^UTILITY(U,$J,358.3,2785,1,4,0)
 ;;=4^M50.023
 ;;^UTILITY(U,$J,358.3,2785,2)
 ;;=^5138811
 ;;^UTILITY(U,$J,358.3,2786,0)
 ;;=M50.121^^26^200^10
 ;;^UTILITY(U,$J,358.3,2786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2786,1,3,0)
 ;;=3^Cervical Disc Disorders at C4-C5 w/ Radiculopathy
 ;;^UTILITY(U,$J,358.3,2786,1,4,0)
 ;;=4^M50.121
 ;;^UTILITY(U,$J,358.3,2786,2)
 ;;=^5138813
 ;;^UTILITY(U,$J,358.3,2787,0)
 ;;=M50.122^^26^200^14
 ;;^UTILITY(U,$J,358.3,2787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2787,1,3,0)
 ;;=3^Cervical Disc Disorders at C5-C6 w/ Radiculopathy
 ;;^UTILITY(U,$J,358.3,2787,1,4,0)
 ;;=4^M50.122
 ;;^UTILITY(U,$J,358.3,2787,2)
 ;;=^5138814
 ;;^UTILITY(U,$J,358.3,2788,0)
 ;;=M50.123^^26^200^18
 ;;^UTILITY(U,$J,358.3,2788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2788,1,3,0)
 ;;=3^Cervical Disc Disorders at C6-C7 w/ Radiculopathy
 ;;^UTILITY(U,$J,358.3,2788,1,4,0)
 ;;=4^M50.123
 ;;^UTILITY(U,$J,358.3,2788,2)
 ;;=^5138815
 ;;^UTILITY(U,$J,358.3,2789,0)
 ;;=M50.221^^26^200^21
 ;;^UTILITY(U,$J,358.3,2789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2789,1,3,0)
 ;;=3^Cervical Disc Displacement at C4-C5
 ;;^UTILITY(U,$J,358.3,2789,1,4,0)
 ;;=4^M50.221
 ;;^UTILITY(U,$J,358.3,2789,2)
 ;;=^5138817
 ;;^UTILITY(U,$J,358.3,2790,0)
 ;;=M50.222^^26^200^22
 ;;^UTILITY(U,$J,358.3,2790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2790,1,3,0)
 ;;=3^Cervical Disc Displacement at C5-C6
 ;;^UTILITY(U,$J,358.3,2790,1,4,0)
 ;;=4^M50.222
 ;;^UTILITY(U,$J,358.3,2790,2)
 ;;=^5138818
 ;;^UTILITY(U,$J,358.3,2791,0)
 ;;=M50.223^^26^200^23
 ;;^UTILITY(U,$J,358.3,2791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2791,1,3,0)
 ;;=3^Cervical Disc Displacement at C6-C7
 ;;^UTILITY(U,$J,358.3,2791,1,4,0)
 ;;=4^M50.223
 ;;^UTILITY(U,$J,358.3,2791,2)
 ;;=^5138819
 ;;^UTILITY(U,$J,358.3,2792,0)
 ;;=M99.88^^26^201^1
 ;;^UTILITY(U,$J,358.3,2792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2792,1,3,0)
 ;;=3^Biomechanical lesions of rib cage
 ;;^UTILITY(U,$J,358.3,2792,1,4,0)
 ;;=4^M99.88
 ;;^UTILITY(U,$J,358.3,2792,2)
 ;;=^5015488
 ;;^UTILITY(U,$J,358.3,2793,0)
 ;;=M99.82^^26^201^2
 ;;^UTILITY(U,$J,358.3,2793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2793,1,3,0)
 ;;=3^Biomechanical lesions of thoracic region
 ;;^UTILITY(U,$J,358.3,2793,1,4,0)
 ;;=4^M99.82
 ;;^UTILITY(U,$J,358.3,2793,2)
 ;;=^5015482
 ;;^UTILITY(U,$J,358.3,2794,0)
 ;;=M51.24^^26^201^5
 ;;^UTILITY(U,$J,358.3,2794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2794,1,3,0)
 ;;=3^Intervertebral disc displacement, thoracic region
 ;;^UTILITY(U,$J,358.3,2794,1,4,0)
 ;;=4^M51.24
 ;;^UTILITY(U,$J,358.3,2794,2)
 ;;=^5012247
 ;;^UTILITY(U,$J,358.3,2795,0)
 ;;=M51.34^^26^201^3
 ;;^UTILITY(U,$J,358.3,2795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2795,1,3,0)
 ;;=3^Intervertebral disc degeneration, thoracic region
 ;;^UTILITY(U,$J,358.3,2795,1,4,0)
 ;;=4^M51.34
 ;;^UTILITY(U,$J,358.3,2795,2)
 ;;=^5012251
 ;;^UTILITY(U,$J,358.3,2796,0)
 ;;=M51.35^^26^201^4
 ;;^UTILITY(U,$J,358.3,2796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2796,1,3,0)
 ;;=3^Intervertebral disc degeneration, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,2796,1,4,0)
 ;;=4^M51.35
 ;;^UTILITY(U,$J,358.3,2796,2)
 ;;=^5012252
 ;;^UTILITY(U,$J,358.3,2797,0)
 ;;=M51.04^^26^201^7
 ;;^UTILITY(U,$J,358.3,2797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2797,1,3,0)
 ;;=3^Intvrt disc disorders w/ myelopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,2797,1,4,0)
 ;;=4^M51.04
 ;;^UTILITY(U,$J,358.3,2797,2)
 ;;=^5012239
 ;;^UTILITY(U,$J,358.3,2798,0)
 ;;=M51.05^^26^201^8
 ;;^UTILITY(U,$J,358.3,2798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2798,1,3,0)
 ;;=3^Intvrt disc disorders w/ myelopathy, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,2798,1,4,0)
 ;;=4^M51.05
 ;;^UTILITY(U,$J,358.3,2798,2)
 ;;=^5012240
 ;;^UTILITY(U,$J,358.3,2799,0)
 ;;=M51.14^^26^201^9
 ;;^UTILITY(U,$J,358.3,2799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2799,1,3,0)
 ;;=3^Intvrt disc disorders w/ radiculopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,2799,1,4,0)
 ;;=4^M51.14
 ;;^UTILITY(U,$J,358.3,2799,2)
 ;;=^5012243
 ;;^UTILITY(U,$J,358.3,2800,0)
 ;;=M51.15^^26^201^10
 ;;^UTILITY(U,$J,358.3,2800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2800,1,3,0)
 ;;=3^Intvrt disc disorders w/ radiculopathy, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,2800,1,4,0)
 ;;=4^M51.15
 ;;^UTILITY(U,$J,358.3,2800,2)
 ;;=^5012244
 ;;^UTILITY(U,$J,358.3,2801,0)
 ;;=M54.6^^26^201^11
 ;;^UTILITY(U,$J,358.3,2801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2801,1,3,0)
 ;;=3^Pain in thoracic spine
 ;;^UTILITY(U,$J,358.3,2801,1,4,0)
 ;;=4^M54.6
 ;;^UTILITY(U,$J,358.3,2801,2)
 ;;=^272507
 ;;^UTILITY(U,$J,358.3,2802,0)
 ;;=M51.44^^26^201^12
 ;;^UTILITY(U,$J,358.3,2802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2802,1,3,0)
 ;;=3^Schmorl's nodes, thoracic region
 ;;^UTILITY(U,$J,358.3,2802,1,4,0)
 ;;=4^M51.44
 ;;^UTILITY(U,$J,358.3,2802,2)
 ;;=^5012255
 ;;^UTILITY(U,$J,358.3,2803,0)
 ;;=M99.02^^26^201^13
 ;;^UTILITY(U,$J,358.3,2803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2803,1,3,0)
 ;;=3^Segmental and somatic dysfunction of thoracic region
 ;;^UTILITY(U,$J,358.3,2803,1,4,0)
 ;;=4^M99.02
 ;;^UTILITY(U,$J,358.3,2803,2)
 ;;=^5015402
 ;;^UTILITY(U,$J,358.3,2804,0)
 ;;=M47.814^^26^201^14
 ;;^UTILITY(U,$J,358.3,2804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2804,1,3,0)
 ;;=3^Spondylosis w/o myelopathy or radiculopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,2804,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,2804,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,2805,0)
 ;;=S23.9XXS^^26^201^15
 ;;^UTILITY(U,$J,358.3,2805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2805,1,3,0)
 ;;=3^Sprain of unspecified parts of thorax, sequela
 ;;^UTILITY(U,$J,358.3,2805,1,4,0)
 ;;=4^S23.9XXS
 ;;^UTILITY(U,$J,358.3,2805,2)
 ;;=^5023269
 ;;^UTILITY(U,$J,358.3,2806,0)
 ;;=S23.9XXD^^26^201^16
 ;;^UTILITY(U,$J,358.3,2806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2806,1,3,0)
 ;;=3^Sprain of unspecified parts of thorax, subsequent encounter
 ;;^UTILITY(U,$J,358.3,2806,1,4,0)
 ;;=4^S23.9XXD
 ;;^UTILITY(U,$J,358.3,2806,2)
 ;;=^5023268
 ;;^UTILITY(U,$J,358.3,2807,0)
 ;;=G54.3^^26^201^17
 ;;^UTILITY(U,$J,358.3,2807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2807,1,3,0)
 ;;=3^Thoracic root disorders, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,2807,1,4,0)
 ;;=4^G54.3
 ;;^UTILITY(U,$J,358.3,2807,2)
 ;;=^5004010
 ;;^UTILITY(U,$J,358.3,2808,0)
 ;;=M51.25^^26^201^6
 ;;^UTILITY(U,$J,358.3,2808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2808,1,3,0)
 ;;=3^Intervertebral disc displacement,thoraclmbr Regn
 ;;^UTILITY(U,$J,358.3,2808,1,4,0)
 ;;=4^M51.25
 ;;^UTILITY(U,$J,358.3,2808,2)
 ;;=^5012248
 ;;^UTILITY(U,$J,358.3,2809,0)
 ;;=M99.83^^26^202^1
 ;;^UTILITY(U,$J,358.3,2809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2809,1,3,0)
 ;;=3^Biomechanical lesions of lumbar region
 ;;^UTILITY(U,$J,358.3,2809,1,4,0)
 ;;=4^M99.83
 ;;^UTILITY(U,$J,358.3,2809,2)
 ;;=^5015483
 ;;^UTILITY(U,$J,358.3,2810,0)
 ;;=M51.36^^26^202^2
 ;;^UTILITY(U,$J,358.3,2810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2810,1,3,0)
 ;;=3^Intervertebral disc degeneration, lumbar region
 ;;^UTILITY(U,$J,358.3,2810,1,4,0)
 ;;=4^M51.36
 ;;^UTILITY(U,$J,358.3,2810,2)
 ;;=^5012253
 ;;^UTILITY(U,$J,358.3,2811,0)
 ;;=M51.37^^26^202^3
 ;;^UTILITY(U,$J,358.3,2811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2811,1,3,0)
 ;;=3^Intervertebral disc degeneration, lumbosacral region
 ;;^UTILITY(U,$J,358.3,2811,1,4,0)
 ;;=4^M51.37
 ;;^UTILITY(U,$J,358.3,2811,2)
 ;;=^5012254
 ;;^UTILITY(U,$J,358.3,2812,0)
 ;;=M51.06^^26^202^4
 ;;^UTILITY(U,$J,358.3,2812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2812,1,3,0)
 ;;=3^Intervertebral disc disorders w/ myelopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,2812,1,4,0)
 ;;=4^M51.06
 ;;^UTILITY(U,$J,358.3,2812,2)
 ;;=^5012241
 ;;^UTILITY(U,$J,358.3,2813,0)
 ;;=M51.16^^26^202^5
 ;;^UTILITY(U,$J,358.3,2813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2813,1,3,0)
 ;;=3^Intervertebral disc disorders w/ radiculopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,2813,1,4,0)
 ;;=4^M51.16
 ;;^UTILITY(U,$J,358.3,2813,2)
 ;;=^5012245
 ;;^UTILITY(U,$J,358.3,2814,0)
 ;;=M51.17^^26^202^6
 ;;^UTILITY(U,$J,358.3,2814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2814,1,3,0)
 ;;=3^Intervertebral disc disorders w/ radiculopathy, lumbosacral region
 ;;^UTILITY(U,$J,358.3,2814,1,4,0)
 ;;=4^M51.17
 ;;^UTILITY(U,$J,358.3,2814,2)
 ;;=^5012246
 ;;^UTILITY(U,$J,358.3,2815,0)
 ;;=M54.5^^26^202^9
 ;;^UTILITY(U,$J,358.3,2815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2815,1,3,0)
 ;;=3^Low back pain
 ;;^UTILITY(U,$J,358.3,2815,1,4,0)
 ;;=4^M54.5
 ;;^UTILITY(U,$J,358.3,2815,2)
 ;;=^5012311
 ;;^UTILITY(U,$J,358.3,2816,0)
 ;;=G54.1^^26^202^10
 ;;^UTILITY(U,$J,358.3,2816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2816,1,3,0)
 ;;=3^Lumbosacral plexus disorders
 ;;^UTILITY(U,$J,358.3,2816,1,4,0)
 ;;=4^G54.1
 ;;^UTILITY(U,$J,358.3,2816,2)
 ;;=^5004008
 ;;^UTILITY(U,$J,358.3,2817,0)
 ;;=G54.4^^26^202^11
 ;;^UTILITY(U,$J,358.3,2817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2817,1,3,0)
 ;;=3^Lumbosacral root disorders NEC
 ;;^UTILITY(U,$J,358.3,2817,1,4,0)
 ;;=4^G54.4
 ;;^UTILITY(U,$J,358.3,2817,2)
 ;;=^5004011
 ;;^UTILITY(U,$J,358.3,2818,0)
 ;;=M54.16^^26^202^12
 ;;^UTILITY(U,$J,358.3,2818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2818,1,3,0)
 ;;=3^Radiculopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,2818,1,4,0)
 ;;=4^M54.16
 ;;^UTILITY(U,$J,358.3,2818,2)
 ;;=^5012301
 ;;^UTILITY(U,$J,358.3,2819,0)
 ;;=M54.17^^26^202^13
 ;;^UTILITY(U,$J,358.3,2819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2819,1,3,0)
 ;;=3^Radiculopathy, lumbosacral region
 ;;^UTILITY(U,$J,358.3,2819,1,4,0)
 ;;=4^M54.17
 ;;^UTILITY(U,$J,358.3,2819,2)
 ;;=^5012302
 ;;^UTILITY(U,$J,358.3,2820,0)
 ;;=M51.46^^26^202^14
 ;;^UTILITY(U,$J,358.3,2820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2820,1,3,0)
 ;;=3^Schmorl's nodes, lumbar region
 ;;^UTILITY(U,$J,358.3,2820,1,4,0)
 ;;=4^M51.46
 ;;^UTILITY(U,$J,358.3,2820,2)
 ;;=^5012257
 ;;^UTILITY(U,$J,358.3,2821,0)
 ;;=M99.03^^26^202^16
 ;;^UTILITY(U,$J,358.3,2821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2821,1,3,0)
 ;;=3^Segmental and somatic dysfunction of lumbar region
 ;;^UTILITY(U,$J,358.3,2821,1,4,0)
 ;;=4^M99.03
 ;;^UTILITY(U,$J,358.3,2821,2)
 ;;=^5015403
 ;;^UTILITY(U,$J,358.3,2822,0)
 ;;=S33.5XXA^^26^202^21
 ;;^UTILITY(U,$J,358.3,2822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2822,1,3,0)
 ;;=3^Sprain of ligaments of lumbar spine, initial encounter
 ;;^UTILITY(U,$J,358.3,2822,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,2822,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,2823,0)
 ;;=S33.5XXS^^26^202^22
 ;;^UTILITY(U,$J,358.3,2823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2823,1,3,0)
 ;;=3^Sprain of ligaments of lumbar spine, sequela
 ;;^UTILITY(U,$J,358.3,2823,1,4,0)
 ;;=4^S33.5XXS
 ;;^UTILITY(U,$J,358.3,2823,2)
 ;;=^5025174
 ;;^UTILITY(U,$J,358.3,2824,0)
 ;;=S33.5XXD^^26^202^23
 ;;^UTILITY(U,$J,358.3,2824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2824,1,3,0)
 ;;=3^Sprain of ligaments of lumbar spine, subsequent encounter
 ;;^UTILITY(U,$J,358.3,2824,1,4,0)
 ;;=4^S33.5XXD
 ;;^UTILITY(U,$J,358.3,2824,2)
 ;;=^5025173
 ;;^UTILITY(U,$J,358.3,2825,0)
 ;;=M43.16^^26^202^20
 ;;^UTILITY(U,$J,358.3,2825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2825,1,3,0)
 ;;=3^Spondylolisthesis, lumbar region
 ;;^UTILITY(U,$J,358.3,2825,1,4,0)
 ;;=4^M43.16
 ;;^UTILITY(U,$J,358.3,2825,2)
 ;;=^5011927
 ;;^UTILITY(U,$J,358.3,2826,0)
 ;;=M51.26^^26^202^7
 ;;^UTILITY(U,$J,358.3,2826,1,0)
 ;;=^358.31IA^4^2
