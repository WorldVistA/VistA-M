IBDEI02H ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2898,1,4,0)
 ;;=4^M00.272
 ;;^UTILITY(U,$J,358.3,2898,2)
 ;;=^5009665
 ;;^UTILITY(U,$J,358.3,2899,0)
 ;;=M00.871^^12^112^9
 ;;^UTILITY(U,$J,358.3,2899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2899,1,3,0)
 ;;=3^Arthritis d/t other bacteria, rt ankle & foot
 ;;^UTILITY(U,$J,358.3,2899,1,4,0)
 ;;=4^M00.871
 ;;^UTILITY(U,$J,358.3,2899,2)
 ;;=^5009688
 ;;^UTILITY(U,$J,358.3,2900,0)
 ;;=M00.872^^12^112^3
 ;;^UTILITY(U,$J,358.3,2900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2900,1,3,0)
 ;;=3^Arthritis d/t other bacteria, lft ankle & foot
 ;;^UTILITY(U,$J,358.3,2900,1,4,0)
 ;;=4^M00.872
 ;;^UTILITY(U,$J,358.3,2900,2)
 ;;=^5009689
 ;;^UTILITY(U,$J,358.3,2901,0)
 ;;=M00.08^^12^112^49
 ;;^UTILITY(U,$J,358.3,2901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2901,1,3,0)
 ;;=3^Staphylococcal arthritis, vertebrae
 ;;^UTILITY(U,$J,358.3,2901,1,4,0)
 ;;=4^M00.08
 ;;^UTILITY(U,$J,358.3,2901,2)
 ;;=^5009619
 ;;^UTILITY(U,$J,358.3,2902,0)
 ;;=M00.18^^12^112^31
 ;;^UTILITY(U,$J,358.3,2902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2902,1,3,0)
 ;;=3^Pneumococcal arthritis, vertebrae
 ;;^UTILITY(U,$J,358.3,2902,1,4,0)
 ;;=4^M00.18
 ;;^UTILITY(U,$J,358.3,2902,2)
 ;;=^5009643
 ;;^UTILITY(U,$J,358.3,2903,0)
 ;;=M00.28^^12^112^64
 ;;^UTILITY(U,$J,358.3,2903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2903,1,3,0)
 ;;=3^Streptococcal arthritis, vertebrae, oth
 ;;^UTILITY(U,$J,358.3,2903,1,4,0)
 ;;=4^M00.28
 ;;^UTILITY(U,$J,358.3,2903,2)
 ;;=^5009667
 ;;^UTILITY(U,$J,358.3,2904,0)
 ;;=M00.88^^12^112^15
 ;;^UTILITY(U,$J,358.3,2904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2904,1,3,0)
 ;;=3^Arthritis d/t other bacteria, vertebrae
 ;;^UTILITY(U,$J,358.3,2904,1,4,0)
 ;;=4^M00.88
 ;;^UTILITY(U,$J,358.3,2904,2)
 ;;=^5009691
 ;;^UTILITY(U,$J,358.3,2905,0)
 ;;=M00.09^^12^112^50
 ;;^UTILITY(U,$J,358.3,2905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2905,1,3,0)
 ;;=3^Staphylococcal polyarthritis
 ;;^UTILITY(U,$J,358.3,2905,1,4,0)
 ;;=4^M00.09
 ;;^UTILITY(U,$J,358.3,2905,2)
 ;;=^5009620
 ;;^UTILITY(U,$J,358.3,2906,0)
 ;;=M00.19^^12^112^32
 ;;^UTILITY(U,$J,358.3,2906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2906,1,3,0)
 ;;=3^Pneumococcal polyarthritis
 ;;^UTILITY(U,$J,358.3,2906,1,4,0)
 ;;=4^M00.19
 ;;^UTILITY(U,$J,358.3,2906,2)
 ;;=^5009644
 ;;^UTILITY(U,$J,358.3,2907,0)
 ;;=M00.29^^12^112^65
 ;;^UTILITY(U,$J,358.3,2907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2907,1,3,0)
 ;;=3^Streptococcal polyarthritis, oth
 ;;^UTILITY(U,$J,358.3,2907,1,4,0)
 ;;=4^M00.29
 ;;^UTILITY(U,$J,358.3,2907,2)
 ;;=^5009668
 ;;^UTILITY(U,$J,358.3,2908,0)
 ;;=M00.89^^12^112^33
 ;;^UTILITY(U,$J,358.3,2908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2908,1,3,0)
 ;;=3^Polyarthritis d/t other bacteria
 ;;^UTILITY(U,$J,358.3,2908,1,4,0)
 ;;=4^M00.89
 ;;^UTILITY(U,$J,358.3,2908,2)
 ;;=^5009692
 ;;^UTILITY(U,$J,358.3,2909,0)
 ;;=M45.9^^12^113^1
 ;;^UTILITY(U,$J,358.3,2909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2909,1,3,0)
 ;;=3^Ankylsng spndylsis of unspec sites in spine
 ;;^UTILITY(U,$J,358.3,2909,1,4,0)
 ;;=4^M45.9
 ;;^UTILITY(U,$J,358.3,2909,2)
 ;;=^5011969
 ;;^UTILITY(U,$J,358.3,2910,0)
 ;;=M46.90^^12^113^4
 ;;^UTILITY(U,$J,358.3,2910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2910,1,3,0)
 ;;=3^Inflammatory spondylopathy, site unspec, unspec
 ;;^UTILITY(U,$J,358.3,2910,1,4,0)
 ;;=4^M46.90
 ;;^UTILITY(U,$J,358.3,2910,2)
 ;;=^5012030
 ;;^UTILITY(U,$J,358.3,2911,0)
 ;;=M47.817^^12^113^18
 ;;^UTILITY(U,$J,358.3,2911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2911,1,3,0)
 ;;=3^Spndylsis w/o mylopthy or radclpthy, lumboscrl regn
 ;;^UTILITY(U,$J,358.3,2911,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,2911,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,2912,0)
 ;;=M51.34^^12^113^7
 ;;^UTILITY(U,$J,358.3,2912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2912,1,3,0)
 ;;=3^Intrvrtbrl disc degen, thor regn, oth
 ;;^UTILITY(U,$J,358.3,2912,1,4,0)
 ;;=4^M51.34
 ;;^UTILITY(U,$J,358.3,2912,2)
 ;;=^5012251
 ;;^UTILITY(U,$J,358.3,2913,0)
 ;;=M51.35^^12^113^8
 ;;^UTILITY(U,$J,358.3,2913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2913,1,3,0)
 ;;=3^Intrvrtbrl disc degen, thorclmbr regn, oth
 ;;^UTILITY(U,$J,358.3,2913,1,4,0)
 ;;=4^M51.35
 ;;^UTILITY(U,$J,358.3,2913,2)
 ;;=^5012252
 ;;^UTILITY(U,$J,358.3,2914,0)
 ;;=M51.36^^12^113^6
 ;;^UTILITY(U,$J,358.3,2914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2914,1,3,0)
 ;;=3^Intrvrtbrl disc degen, lumb regn, oth
 ;;^UTILITY(U,$J,358.3,2914,1,4,0)
 ;;=4^M51.36
 ;;^UTILITY(U,$J,358.3,2914,2)
 ;;=^5012253
 ;;^UTILITY(U,$J,358.3,2915,0)
 ;;=M51.37^^12^113^5
 ;;^UTILITY(U,$J,358.3,2915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2915,1,3,0)
 ;;=3^Intrvrtbrl disc degen, lmboscrl regn, oth
 ;;^UTILITY(U,$J,358.3,2915,1,4,0)
 ;;=4^M51.37
 ;;^UTILITY(U,$J,358.3,2915,2)
 ;;=^5012254
 ;;^UTILITY(U,$J,358.3,2916,0)
 ;;=M54.2^^12^113^2
 ;;^UTILITY(U,$J,358.3,2916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2916,1,3,0)
 ;;=3^Cervicalgia
 ;;^UTILITY(U,$J,358.3,2916,1,4,0)
 ;;=4^M54.2
 ;;^UTILITY(U,$J,358.3,2916,2)
 ;;=^5012304
 ;;^UTILITY(U,$J,358.3,2917,0)
 ;;=M48.00^^12^113^17
 ;;^UTILITY(U,$J,358.3,2917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2917,1,3,0)
 ;;=3^Spinal stenosis, site unspec
 ;;^UTILITY(U,$J,358.3,2917,1,4,0)
 ;;=4^M48.00
 ;;^UTILITY(U,$J,358.3,2917,2)
 ;;=^5012087
 ;;^UTILITY(U,$J,358.3,2918,0)
 ;;=M54.5^^12^113^9
 ;;^UTILITY(U,$J,358.3,2918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2918,1,3,0)
 ;;=3^Low back pain
 ;;^UTILITY(U,$J,358.3,2918,1,4,0)
 ;;=4^M54.5
 ;;^UTILITY(U,$J,358.3,2918,2)
 ;;=^5012311
 ;;^UTILITY(U,$J,358.3,2919,0)
 ;;=M54.31^^12^113^16
 ;;^UTILITY(U,$J,358.3,2919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2919,1,3,0)
 ;;=3^Sciatica, rt side
 ;;^UTILITY(U,$J,358.3,2919,1,4,0)
 ;;=4^M54.31
 ;;^UTILITY(U,$J,358.3,2919,2)
 ;;=^5012306
 ;;^UTILITY(U,$J,358.3,2920,0)
 ;;=M54.32^^12^113^15
 ;;^UTILITY(U,$J,358.3,2920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2920,1,3,0)
 ;;=3^Sciatica, lft side
 ;;^UTILITY(U,$J,358.3,2920,1,4,0)
 ;;=4^M54.32
 ;;^UTILITY(U,$J,358.3,2920,2)
 ;;=^5012307
 ;;^UTILITY(U,$J,358.3,2921,0)
 ;;=M54.14^^12^113^13
 ;;^UTILITY(U,$J,358.3,2921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2921,1,3,0)
 ;;=3^Radiculopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,2921,1,4,0)
 ;;=4^M54.14
 ;;^UTILITY(U,$J,358.3,2921,2)
 ;;=^5012299
 ;;^UTILITY(U,$J,358.3,2922,0)
 ;;=M54.15^^12^113^14
 ;;^UTILITY(U,$J,358.3,2922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2922,1,3,0)
 ;;=3^Radiculopathy, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,2922,1,4,0)
 ;;=4^M54.15
 ;;^UTILITY(U,$J,358.3,2922,2)
 ;;=^5012300
 ;;^UTILITY(U,$J,358.3,2923,0)
 ;;=M54.16^^12^113^11
 ;;^UTILITY(U,$J,358.3,2923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2923,1,3,0)
 ;;=3^Radiculopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,2923,1,4,0)
 ;;=4^M54.16
 ;;^UTILITY(U,$J,358.3,2923,2)
 ;;=^5012301
 ;;^UTILITY(U,$J,358.3,2924,0)
 ;;=M54.17^^12^113^12
 ;;^UTILITY(U,$J,358.3,2924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2924,1,3,0)
 ;;=3^Radiculopathy, lumbosacral region
 ;;^UTILITY(U,$J,358.3,2924,1,4,0)
 ;;=4^M54.17
 ;;^UTILITY(U,$J,358.3,2924,2)
 ;;=^5012302
 ;;^UTILITY(U,$J,358.3,2925,0)
 ;;=M84.40XA^^12^113^10
 ;;^UTILITY(U,$J,358.3,2925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2925,1,3,0)
 ;;=3^Path fx, unspec site, init encntr for fx
 ;;^UTILITY(U,$J,358.3,2925,1,4,0)
 ;;=4^M84.40XA
 ;;^UTILITY(U,$J,358.3,2925,2)
 ;;=^5013794
 ;;^UTILITY(U,$J,358.3,2926,0)
 ;;=M94.0^^12^113^3
 ;;^UTILITY(U,$J,358.3,2926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2926,1,3,0)
 ;;=3^Chondrocostal junction syndrome [Tietze]
 ;;^UTILITY(U,$J,358.3,2926,1,4,0)
 ;;=4^M94.0
 ;;^UTILITY(U,$J,358.3,2926,2)
 ;;=^5015327
 ;;^UTILITY(U,$J,358.3,2927,0)
 ;;=G56.01^^12^114^17
 ;;^UTILITY(U,$J,358.3,2927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2927,1,3,0)
 ;;=3^Carpal tunnel syndrome, rt upper limb
 ;;^UTILITY(U,$J,358.3,2927,1,4,0)
 ;;=4^G56.01
 ;;^UTILITY(U,$J,358.3,2927,2)
 ;;=^5004018
 ;;^UTILITY(U,$J,358.3,2928,0)
 ;;=G56.02^^12^114^16
 ;;^UTILITY(U,$J,358.3,2928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2928,1,3,0)
 ;;=3^Carpal tunnel syndrome, lft upper limb
 ;;^UTILITY(U,$J,358.3,2928,1,4,0)
 ;;=4^G56.02
 ;;^UTILITY(U,$J,358.3,2928,2)
 ;;=^5004019
 ;;^UTILITY(U,$J,358.3,2929,0)
 ;;=M75.01^^12^114^4
 ;;^UTILITY(U,$J,358.3,2929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2929,1,3,0)
 ;;=3^Adhesive capsulitis of rt shoulder
 ;;^UTILITY(U,$J,358.3,2929,1,4,0)
 ;;=4^M75.01
 ;;^UTILITY(U,$J,358.3,2929,2)
 ;;=^5013239
 ;;^UTILITY(U,$J,358.3,2930,0)
 ;;=M75.02^^12^114^3
 ;;^UTILITY(U,$J,358.3,2930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2930,1,3,0)
 ;;=3^Adhesive capsulitis of lft shoulder
 ;;^UTILITY(U,$J,358.3,2930,1,4,0)
 ;;=4^M75.02
 ;;^UTILITY(U,$J,358.3,2930,2)
 ;;=^5013240
 ;;^UTILITY(U,$J,358.3,2931,0)
 ;;=M75.51^^12^114^12
 ;;^UTILITY(U,$J,358.3,2931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2931,1,3,0)
 ;;=3^Bursitis of rt shoulder
 ;;^UTILITY(U,$J,358.3,2931,1,4,0)
 ;;=4^M75.51
 ;;^UTILITY(U,$J,358.3,2931,2)
 ;;=^5133690
 ;;^UTILITY(U,$J,358.3,2932,0)
 ;;=M75.52^^12^114^11
 ;;^UTILITY(U,$J,358.3,2932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2932,1,3,0)
 ;;=3^Bursitis of lft shoulder
 ;;^UTILITY(U,$J,358.3,2932,1,4,0)
 ;;=4^M75.52
 ;;^UTILITY(U,$J,358.3,2932,2)
 ;;=^5133691
 ;;^UTILITY(U,$J,358.3,2933,0)
 ;;=M75.101^^12^114^42
 ;;^UTILITY(U,$J,358.3,2933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2933,1,3,0)
 ;;=3^Rotatr-cuff tear/ruptr of rt shldr, not trauma, unspec
 ;;^UTILITY(U,$J,358.3,2933,1,4,0)
 ;;=4^M75.101
 ;;^UTILITY(U,$J,358.3,2933,2)
 ;;=^5013242
 ;;^UTILITY(U,$J,358.3,2934,0)
 ;;=M75.102^^12^114^41
 ;;^UTILITY(U,$J,358.3,2934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2934,1,3,0)
 ;;=3^Rotatr-cuff tear/ruptr of lft shldr, not trauma, unspec
