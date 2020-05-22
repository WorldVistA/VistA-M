IBDEI01D ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2826,1,3,0)
 ;;=3^Intervrtbrl Disc Displacement,Lumbar
 ;;^UTILITY(U,$J,358.3,2826,1,4,0)
 ;;=4^M51.26
 ;;^UTILITY(U,$J,358.3,2826,2)
 ;;=^5012249
 ;;^UTILITY(U,$J,358.3,2827,0)
 ;;=M51.27^^26^202^8
 ;;^UTILITY(U,$J,358.3,2827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2827,1,3,0)
 ;;=3^Intervrtbrl Disc Displcmnt,Lumbosacral
 ;;^UTILITY(U,$J,358.3,2827,1,4,0)
 ;;=4^M51.27
 ;;^UTILITY(U,$J,358.3,2827,2)
 ;;=^5012250
 ;;^UTILITY(U,$J,358.3,2828,0)
 ;;=M51.47^^26^202^15
 ;;^UTILITY(U,$J,358.3,2828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2828,1,3,0)
 ;;=3^Schmorl's nodes, lumbosacral region
 ;;^UTILITY(U,$J,358.3,2828,1,4,0)
 ;;=4^M51.47
 ;;^UTILITY(U,$J,358.3,2828,2)
 ;;=^5012258
 ;;^UTILITY(U,$J,358.3,2829,0)
 ;;=M48.07^^26^202^19
 ;;^UTILITY(U,$J,358.3,2829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2829,1,3,0)
 ;;=3^Spinal stenosis, lumbosacral region
 ;;^UTILITY(U,$J,358.3,2829,1,4,0)
 ;;=4^M48.07
 ;;^UTILITY(U,$J,358.3,2829,2)
 ;;=^5012094
 ;;^UTILITY(U,$J,358.3,2830,0)
 ;;=M48.061^^26^202^18
 ;;^UTILITY(U,$J,358.3,2830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2830,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/o Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,2830,1,4,0)
 ;;=4^M48.061
 ;;^UTILITY(U,$J,358.3,2830,2)
 ;;=^5151513
 ;;^UTILITY(U,$J,358.3,2831,0)
 ;;=M48.062^^26^202^17
 ;;^UTILITY(U,$J,358.3,2831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2831,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/ Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,2831,1,4,0)
 ;;=4^M48.062
 ;;^UTILITY(U,$J,358.3,2831,2)
 ;;=^5151514
 ;;^UTILITY(U,$J,358.3,2832,0)
 ;;=M99.85^^26^203^1
 ;;^UTILITY(U,$J,358.3,2832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2832,1,3,0)
 ;;=3^Biomechanical lesions of pelvic region
 ;;^UTILITY(U,$J,358.3,2832,1,4,0)
 ;;=4^M99.85
 ;;^UTILITY(U,$J,358.3,2832,2)
 ;;=^5015485
 ;;^UTILITY(U,$J,358.3,2833,0)
 ;;=M99.84^^26^203^2
 ;;^UTILITY(U,$J,358.3,2833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2833,1,3,0)
 ;;=3^Biomechanical lesions of sacral region
 ;;^UTILITY(U,$J,358.3,2833,1,4,0)
 ;;=4^M99.84
 ;;^UTILITY(U,$J,358.3,2833,2)
 ;;=^5015484
 ;;^UTILITY(U,$J,358.3,2834,0)
 ;;=G54.0^^26^203^3
 ;;^UTILITY(U,$J,358.3,2834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2834,1,3,0)
 ;;=3^Brachial plexus disorders
 ;;^UTILITY(U,$J,358.3,2834,1,4,0)
 ;;=4^G54.0
 ;;^UTILITY(U,$J,358.3,2834,2)
 ;;=^5004007
 ;;^UTILITY(U,$J,358.3,2835,0)
 ;;=M76.02^^26^203^4
 ;;^UTILITY(U,$J,358.3,2835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2835,1,3,0)
 ;;=3^Gluteal tendinitis, left hip
 ;;^UTILITY(U,$J,358.3,2835,1,4,0)
 ;;=4^M76.02
 ;;^UTILITY(U,$J,358.3,2835,2)
 ;;=^5013268
 ;;^UTILITY(U,$J,358.3,2836,0)
 ;;=M76.01^^26^203^5
 ;;^UTILITY(U,$J,358.3,2836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2836,1,3,0)
 ;;=3^Gluteal tendinitis, right hip
 ;;^UTILITY(U,$J,358.3,2836,1,4,0)
 ;;=4^M76.01
 ;;^UTILITY(U,$J,358.3,2836,2)
 ;;=^5013267
 ;;^UTILITY(U,$J,358.3,2837,0)
 ;;=M76.22^^26^203^6
 ;;^UTILITY(U,$J,358.3,2837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2837,1,3,0)
 ;;=3^Iliac crest spur, left hip
 ;;^UTILITY(U,$J,358.3,2837,1,4,0)
 ;;=4^M76.22
 ;;^UTILITY(U,$J,358.3,2837,2)
 ;;=^5013274
 ;;^UTILITY(U,$J,358.3,2838,0)
 ;;=M76.21^^26^203^7
 ;;^UTILITY(U,$J,358.3,2838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2838,1,3,0)
 ;;=3^Iliac crest spur, right hip
 ;;^UTILITY(U,$J,358.3,2838,1,4,0)
 ;;=4^M76.21
 ;;^UTILITY(U,$J,358.3,2838,2)
 ;;=^5013273
 ;;^UTILITY(U,$J,358.3,2839,0)
 ;;=M54.18^^26^203^8
 ;;^UTILITY(U,$J,358.3,2839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2839,1,3,0)
 ;;=3^Radiculopathy, sacral and sacrococcygeal region
 ;;^UTILITY(U,$J,358.3,2839,1,4,0)
 ;;=4^M54.18
 ;;^UTILITY(U,$J,358.3,2839,2)
 ;;=^5012303
 ;;^UTILITY(U,$J,358.3,2840,0)
 ;;=M54.32^^26^203^9
 ;;^UTILITY(U,$J,358.3,2840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2840,1,3,0)
 ;;=3^Sciatica, left side
 ;;^UTILITY(U,$J,358.3,2840,1,4,0)
 ;;=4^M54.32
 ;;^UTILITY(U,$J,358.3,2840,2)
 ;;=^5012307
 ;;^UTILITY(U,$J,358.3,2841,0)
 ;;=M54.31^^26^203^10
 ;;^UTILITY(U,$J,358.3,2841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2841,1,3,0)
 ;;=3^Sciatica, right side
 ;;^UTILITY(U,$J,358.3,2841,1,4,0)
 ;;=4^M54.31
 ;;^UTILITY(U,$J,358.3,2841,2)
 ;;=^5012306
 ;;^UTILITY(U,$J,358.3,2842,0)
 ;;=M99.04^^26^203^12
 ;;^UTILITY(U,$J,358.3,2842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2842,1,3,0)
 ;;=3^Segmental and somatic dysfunction of sacral region
 ;;^UTILITY(U,$J,358.3,2842,1,4,0)
 ;;=4^M99.04
 ;;^UTILITY(U,$J,358.3,2842,2)
 ;;=^5015404
 ;;^UTILITY(U,$J,358.3,2843,0)
 ;;=M99.05^^26^203^11
 ;;^UTILITY(U,$J,358.3,2843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2843,1,3,0)
 ;;=3^Segmental and somatic dysfunction of pelvic region
 ;;^UTILITY(U,$J,358.3,2843,1,4,0)
 ;;=4^M99.05
 ;;^UTILITY(U,$J,358.3,2843,2)
 ;;=^5015405
 ;;^UTILITY(U,$J,358.3,2844,0)
 ;;=S33.6XXA^^26^203^13
 ;;^UTILITY(U,$J,358.3,2844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2844,1,3,0)
 ;;=3^Sprain of sacroiliac joint, initial encounter
 ;;^UTILITY(U,$J,358.3,2844,1,4,0)
 ;;=4^S33.6XXA
 ;;^UTILITY(U,$J,358.3,2844,2)
 ;;=^5025175
 ;;^UTILITY(U,$J,358.3,2845,0)
 ;;=S33.6XXS^^26^203^14
 ;;^UTILITY(U,$J,358.3,2845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2845,1,3,0)
 ;;=3^Sprain of sacroiliac joint, sequela
 ;;^UTILITY(U,$J,358.3,2845,1,4,0)
 ;;=4^S33.6XXS
 ;;^UTILITY(U,$J,358.3,2845,2)
 ;;=^5025177
 ;;^UTILITY(U,$J,358.3,2846,0)
 ;;=S33.6XXD^^26^203^15
 ;;^UTILITY(U,$J,358.3,2846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2846,1,3,0)
 ;;=3^Sprain of sacroiliac joint, subsequent encounter
 ;;^UTILITY(U,$J,358.3,2846,1,4,0)
 ;;=4^S33.6XXD
 ;;^UTILITY(U,$J,358.3,2846,2)
 ;;=^5025176
 ;;^UTILITY(U,$J,358.3,2847,0)
 ;;=M12.9^^26^204^1
 ;;^UTILITY(U,$J,358.3,2847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2847,1,3,0)
 ;;=3^Arthropathy, unspecified
 ;;^UTILITY(U,$J,358.3,2847,1,4,0)
 ;;=4^M12.9
 ;;^UTILITY(U,$J,358.3,2847,2)
 ;;=^5010666
 ;;^UTILITY(U,$J,358.3,2848,0)
 ;;=M71.50^^26^204^2
 ;;^UTILITY(U,$J,358.3,2848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2848,1,3,0)
 ;;=3^Bursitis, unspec site NEC
 ;;^UTILITY(U,$J,358.3,2848,1,4,0)
 ;;=4^M71.50
 ;;^UTILITY(U,$J,358.3,2848,2)
 ;;=^5013190
 ;;^UTILITY(U,$J,358.3,2849,0)
 ;;=M62.9^^26^204^3
 ;;^UTILITY(U,$J,358.3,2849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2849,1,3,0)
 ;;=3^Disorder of muscle, unspecified
 ;;^UTILITY(U,$J,358.3,2849,1,4,0)
 ;;=4^M62.9
 ;;^UTILITY(U,$J,358.3,2849,2)
 ;;=^5012684
 ;;^UTILITY(U,$J,358.3,2850,0)
 ;;=M71.10^^26^204^5
 ;;^UTILITY(U,$J,358.3,2850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2850,1,3,0)
 ;;=3^Infective bursitis, unspecified site
 ;;^UTILITY(U,$J,358.3,2850,1,4,0)
 ;;=4^M71.10
 ;;^UTILITY(U,$J,358.3,2850,2)
 ;;=^5013123
 ;;^UTILITY(U,$J,358.3,2851,0)
 ;;=M62.838^^26^204^6
 ;;^UTILITY(U,$J,358.3,2851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2851,1,3,0)
 ;;=3^Muscle spasm, other
 ;;^UTILITY(U,$J,358.3,2851,1,4,0)
 ;;=4^M62.838
 ;;^UTILITY(U,$J,358.3,2851,2)
 ;;=^5012682
 ;;^UTILITY(U,$J,358.3,2852,0)
 ;;=M79.2^^26^204^8
 ;;^UTILITY(U,$J,358.3,2852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2852,1,3,0)
 ;;=3^Neuralgia and neuritis, unspecified
 ;;^UTILITY(U,$J,358.3,2852,1,4,0)
 ;;=4^M79.2
 ;;^UTILITY(U,$J,358.3,2852,2)
 ;;=^5013322
 ;;^UTILITY(U,$J,358.3,2853,0)
 ;;=M25.50^^26^204^9
 ;;^UTILITY(U,$J,358.3,2853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2853,1,3,0)
 ;;=3^Pain in unspecified joint
 ;;^UTILITY(U,$J,358.3,2853,1,4,0)
 ;;=4^M25.50
 ;;^UTILITY(U,$J,358.3,2853,2)
 ;;=^5011601
 ;;^UTILITY(U,$J,358.3,2854,0)
 ;;=M96.1^^26^204^10
 ;;^UTILITY(U,$J,358.3,2854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2854,1,3,0)
 ;;=3^Postlaminectomy syndrome NEC
 ;;^UTILITY(U,$J,358.3,2854,1,4,0)
 ;;=4^M96.1
 ;;^UTILITY(U,$J,358.3,2854,2)
 ;;=^5015374
 ;;^UTILITY(U,$J,358.3,2855,0)
 ;;=M54.10^^26^204^11
 ;;^UTILITY(U,$J,358.3,2855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2855,1,3,0)
 ;;=3^Radiculopathy, site unspecified
 ;;^UTILITY(U,$J,358.3,2855,1,4,0)
 ;;=4^M54.10
 ;;^UTILITY(U,$J,358.3,2855,2)
 ;;=^5012295
 ;;^UTILITY(U,$J,358.3,2856,0)
 ;;=M47.10^^26^204^13
 ;;^UTILITY(U,$J,358.3,2856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2856,1,3,0)
 ;;=3^Spondylosis w/ myelopathy, other, site unspec
 ;;^UTILITY(U,$J,358.3,2856,1,4,0)
 ;;=4^M47.10
 ;;^UTILITY(U,$J,358.3,2856,2)
 ;;=^5012050
 ;;^UTILITY(U,$J,358.3,2857,0)
 ;;=M43.10^^26^204^12
 ;;^UTILITY(U,$J,358.3,2857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2857,1,3,0)
 ;;=3^Spondylolisthesis, site unspecified
 ;;^UTILITY(U,$J,358.3,2857,1,4,0)
 ;;=4^M43.10
 ;;^UTILITY(U,$J,358.3,2857,2)
 ;;=^5011921
 ;;^UTILITY(U,$J,358.3,2858,0)
 ;;=M79.7^^26^204^4
 ;;^UTILITY(U,$J,358.3,2858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2858,1,3,0)
 ;;=3^Fibromyalgia
 ;;^UTILITY(U,$J,358.3,2858,1,4,0)
 ;;=4^M79.7
 ;;^UTILITY(U,$J,358.3,2858,2)
 ;;=^46261
 ;;^UTILITY(U,$J,358.3,2859,0)
 ;;=M79.10^^26^204^7
 ;;^UTILITY(U,$J,358.3,2859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2859,1,3,0)
 ;;=3^Myalgia,Unspec Site
 ;;^UTILITY(U,$J,358.3,2859,1,4,0)
 ;;=4^M79.10
 ;;^UTILITY(U,$J,358.3,2859,2)
 ;;=^5157394
 ;;^UTILITY(U,$J,358.3,2860,0)
 ;;=99401^^27^205^6^^^^1
 ;;^UTILITY(U,$J,358.3,2860,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2860,1,2,0)
 ;;=2^99401
 ;;^UTILITY(U,$J,358.3,2860,1,3,0)
 ;;=3^Preventive Medicine Counseling;Indiv 15 min
 ;;^UTILITY(U,$J,358.3,2861,0)
 ;;=99402^^27^205^7^^^^1
 ;;^UTILITY(U,$J,358.3,2861,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2861,1,2,0)
 ;;=2^99402
 ;;^UTILITY(U,$J,358.3,2861,1,3,0)
 ;;=3^Preventive Medicine Counseling;Indiv 30 min
 ;;^UTILITY(U,$J,358.3,2862,0)
 ;;=99403^^27^205^8^^^^1
 ;;^UTILITY(U,$J,358.3,2862,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2862,1,2,0)
 ;;=2^99403
 ;;^UTILITY(U,$J,358.3,2862,1,3,0)
 ;;=3^Preventive Medicine Counseling;Indiv 45 min
 ;;^UTILITY(U,$J,358.3,2863,0)
 ;;=99404^^27^205^9^^^^1
 ;;^UTILITY(U,$J,358.3,2863,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2863,1,2,0)
 ;;=2^99404
 ;;^UTILITY(U,$J,358.3,2863,1,3,0)
 ;;=3^Preventive Medicine Counseling;Indiv 60 min
 ;;^UTILITY(U,$J,358.3,2864,0)
 ;;=99411^^27^205^4^^^^1
 ;;^UTILITY(U,$J,358.3,2864,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2864,1,2,0)
 ;;=2^99411
 ;;^UTILITY(U,$J,358.3,2864,1,3,0)
 ;;=3^Preventive Medicine Counseling;Group 30 min
 ;;^UTILITY(U,$J,358.3,2865,0)
 ;;=99412^^27^205^5^^^^1
 ;;^UTILITY(U,$J,358.3,2865,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2865,1,2,0)
 ;;=2^99412
 ;;^UTILITY(U,$J,358.3,2865,1,3,0)
 ;;=3^Preventive Medicine Counseling;Group 60 min
 ;;^UTILITY(U,$J,358.3,2866,0)
 ;;=99078^^27^205^3^^^^1
 ;;^UTILITY(U,$J,358.3,2866,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2866,1,2,0)
 ;;=2^99078
 ;;^UTILITY(U,$J,358.3,2866,1,3,0)
 ;;=3^Phys/Qhp Edu Svcs Pts Grp Setting
 ;;^UTILITY(U,$J,358.3,2867,0)
 ;;=G0175^^27^205^10^^^^1
 ;;^UTILITY(U,$J,358.3,2867,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2867,1,2,0)
 ;;=2^G0175
 ;;^UTILITY(U,$J,358.3,2867,1,3,0)
 ;;=3^Scheduled Interdisciplinary Conference
 ;;^UTILITY(U,$J,358.3,2868,0)
 ;;=99406^^27^205^11^^^^1
 ;;^UTILITY(U,$J,358.3,2868,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2868,1,2,0)
 ;;=2^99406
 ;;^UTILITY(U,$J,358.3,2868,1,3,0)
 ;;=3^Tobacco Use Cessation Counsel,3-10 min
 ;;^UTILITY(U,$J,358.3,2869,0)
 ;;=99407^^27^205^12^^^^1
 ;;^UTILITY(U,$J,358.3,2869,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2869,1,2,0)
 ;;=2^99407
 ;;^UTILITY(U,$J,358.3,2869,1,3,0)
 ;;=3^Tobacco Use Cessation Counsel,10+ min
 ;;^UTILITY(U,$J,358.3,2870,0)
 ;;=99408^^27^205^1^^^^1
 ;;^UTILITY(U,$J,358.3,2870,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2870,1,2,0)
 ;;=2^99408
 ;;^UTILITY(U,$J,358.3,2870,1,3,0)
 ;;=3^Alcohol and/or Subs Abuse Counsel,15-30 min
 ;;^UTILITY(U,$J,358.3,2871,0)
 ;;=99409^^27^205^2^^^^1
 ;;^UTILITY(U,$J,358.3,2871,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2871,1,2,0)
 ;;=2^99409
 ;;^UTILITY(U,$J,358.3,2871,1,3,0)
 ;;=3^Alcohol and/or Subs Abuse Counsel,30+ min
 ;;^UTILITY(U,$J,358.3,2872,0)
 ;;=90853^^27^206^1^^^^1
 ;;^UTILITY(U,$J,358.3,2872,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2872,1,2,0)
 ;;=2^90853
 ;;^UTILITY(U,$J,358.3,2872,1,3,0)
 ;;=3^Group Psychotherapy
 ;;^UTILITY(U,$J,358.3,2873,0)
 ;;=90876^^27^206^4^^^^1
 ;;^UTILITY(U,$J,358.3,2873,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2873,1,2,0)
 ;;=2^90876
 ;;^UTILITY(U,$J,358.3,2873,1,3,0)
 ;;=3^Psychophysiological Therapy,45 min
 ;;^UTILITY(U,$J,358.3,2874,0)
 ;;=90880^^27^206^2^^^^1
 ;;^UTILITY(U,$J,358.3,2874,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2874,1,2,0)
 ;;=2^90880
 ;;^UTILITY(U,$J,358.3,2874,1,3,0)
 ;;=3^Hypnotherapy
 ;;^UTILITY(U,$J,358.3,2875,0)
 ;;=90875^^27^206^3^^^^1
 ;;^UTILITY(U,$J,358.3,2875,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2875,1,2,0)
 ;;=2^90875
 ;;^UTILITY(U,$J,358.3,2875,1,3,0)
 ;;=3^Psychophysiological Therapy,30 min
 ;;^UTILITY(U,$J,358.3,2876,0)
 ;;=90901^^27^207^1^^^^1
 ;;^UTILITY(U,$J,358.3,2876,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2876,1,2,0)
 ;;=2^90901
 ;;^UTILITY(U,$J,358.3,2876,1,3,0)
 ;;=3^Biofeedback Training,Any Method
 ;;^UTILITY(U,$J,358.3,2877,0)
 ;;=96156^^27^208^1^^^^1
 ;;^UTILITY(U,$J,358.3,2877,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2877,1,2,0)
 ;;=2^96156
 ;;^UTILITY(U,$J,358.3,2877,1,3,0)
 ;;=3^Hlth/Behav Assess/Re-Assess
 ;;^UTILITY(U,$J,358.3,2878,0)
 ;;=96158^^27^208^8^^^^1
 ;;^UTILITY(U,$J,358.3,2878,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2878,1,2,0)
 ;;=2^96158
 ;;^UTILITY(U,$J,358.3,2878,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Ind,1st 30 min
 ;;^UTILITY(U,$J,358.3,2879,0)
 ;;=96159^^27^208^9^^^^1
 ;;^UTILITY(U,$J,358.3,2879,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2879,1,2,0)
 ;;=2^96159
 ;;^UTILITY(U,$J,358.3,2879,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Ind,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,2880,0)
 ;;=96164^^27^208^6^^^^1
 ;;^UTILITY(U,$J,358.3,2880,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2880,1,2,0)
 ;;=2^96164
 ;;^UTILITY(U,$J,358.3,2880,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Grp,1st 30 min
 ;;^UTILITY(U,$J,358.3,2881,0)
 ;;=96165^^27^208^7^^^^1
 ;;^UTILITY(U,$J,358.3,2881,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2881,1,2,0)
 ;;=2^96165
 ;;^UTILITY(U,$J,358.3,2881,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Grp,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,2882,0)
 ;;=96167^^27^208^2^^^^1
 ;;^UTILITY(U,$J,358.3,2882,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2882,1,2,0)
 ;;=2^96167
 ;;^UTILITY(U,$J,358.3,2882,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/ Pt,1st 30 min
 ;;^UTILITY(U,$J,358.3,2883,0)
 ;;=96168^^27^208^3^^^^1
 ;;^UTILITY(U,$J,358.3,2883,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2883,1,2,0)
 ;;=2^96168
 ;;^UTILITY(U,$J,358.3,2883,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/ Pt,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,2884,0)
 ;;=96170^^27^208^4^^^^1
 ;;^UTILITY(U,$J,358.3,2884,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2884,1,2,0)
 ;;=2^96170
 ;;^UTILITY(U,$J,358.3,2884,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/o Pt,1st 30 min
 ;;^UTILITY(U,$J,358.3,2885,0)
 ;;=96171^^27^208^5^^^^1
 ;;^UTILITY(U,$J,358.3,2885,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2885,1,2,0)
 ;;=2^96171
 ;;^UTILITY(U,$J,358.3,2885,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/o Pt,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,2886,0)
 ;;=97010^^27^209^3^^^^1
 ;;^UTILITY(U,$J,358.3,2886,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2886,1,2,0)
 ;;=2^97010
 ;;^UTILITY(U,$J,358.3,2886,1,3,0)
 ;;=3^Hot or Cold Packs Therapy
 ;;^UTILITY(U,$J,358.3,2887,0)
 ;;=97012^^27^209^5^^^^1
 ;;^UTILITY(U,$J,358.3,2887,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2887,1,2,0)
 ;;=2^97012
 ;;^UTILITY(U,$J,358.3,2887,1,3,0)
 ;;=3^Mechanical Traction Therapy
 ;;^UTILITY(U,$J,358.3,2888,0)
 ;;=97014^^27^209^1^^^^1
 ;;^UTILITY(U,$J,358.3,2888,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2888,1,2,0)
 ;;=2^97014
 ;;^UTILITY(U,$J,358.3,2888,1,3,0)
 ;;=3^Electrical Stimulation Therapy
 ;;^UTILITY(U,$J,358.3,2889,0)
 ;;=97026^^27^209^4^^^^1
 ;;^UTILITY(U,$J,358.3,2889,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2889,1,2,0)
 ;;=2^97026
 ;;^UTILITY(U,$J,358.3,2889,1,3,0)
 ;;=3^Infrared Therapy
 ;;^UTILITY(U,$J,358.3,2890,0)
 ;;=97032^^27^209^2^^^^1
 ;;^UTILITY(U,$J,358.3,2890,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2890,1,2,0)
 ;;=2^97032
 ;;^UTILITY(U,$J,358.3,2890,1,3,0)
 ;;=3^Electrical Stimulation-Constant Attendance
 ;;^UTILITY(U,$J,358.3,2891,0)
 ;;=97110^^27^210^11^^^^1
 ;;^UTILITY(U,$J,358.3,2891,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2891,1,2,0)
 ;;=2^97110
 ;;^UTILITY(U,$J,358.3,2891,1,3,0)
 ;;=3^Therapeutic Exercises
 ;;^UTILITY(U,$J,358.3,2892,0)
 ;;=97112^^27^210^8^^^^1
 ;;^UTILITY(U,$J,358.3,2892,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2892,1,2,0)
 ;;=2^97112
 ;;^UTILITY(U,$J,358.3,2892,1,3,0)
 ;;=3^Neuromuscular Re-Education
 ;;^UTILITY(U,$J,358.3,2893,0)
 ;;=97124^^27^210^7^^^^1
 ;;^UTILITY(U,$J,358.3,2893,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2893,1,2,0)
 ;;=2^97124
 ;;^UTILITY(U,$J,358.3,2893,1,3,0)
 ;;=3^Massage Therapy/Acupressure
 ;;^UTILITY(U,$J,358.3,2894,0)
 ;;=97140^^27^210^6^^^^1
 ;;^UTILITY(U,$J,358.3,2894,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2894,1,2,0)
 ;;=2^97140
 ;;^UTILITY(U,$J,358.3,2894,1,3,0)
 ;;=3^Manual Therapy
 ;;^UTILITY(U,$J,358.3,2895,0)
 ;;=97150^^27^210^5^^^^1
 ;;^UTILITY(U,$J,358.3,2895,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2895,1,2,0)
 ;;=2^97150
 ;;^UTILITY(U,$J,358.3,2895,1,3,0)
 ;;=3^Group Therapeutic Procedures
 ;;^UTILITY(U,$J,358.3,2896,0)
 ;;=97530^^27^210^10^^^^1
 ;;^UTILITY(U,$J,358.3,2896,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2896,1,2,0)
 ;;=2^97530
 ;;^UTILITY(U,$J,358.3,2896,1,3,0)
 ;;=3^Therapeutic Activities
 ;;^UTILITY(U,$J,358.3,2897,0)
 ;;=97535^^27^210^9^^^^1
 ;;^UTILITY(U,$J,358.3,2897,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2897,1,2,0)
 ;;=2^97535
 ;;^UTILITY(U,$J,358.3,2897,1,3,0)
 ;;=3^Self Care Management Training
 ;;^UTILITY(U,$J,358.3,2898,0)
 ;;=97139^^27^210^13^^^^1
 ;;^UTILITY(U,$J,358.3,2898,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2898,1,2,0)
 ;;=2^97139
 ;;^UTILITY(U,$J,358.3,2898,1,3,0)
 ;;=3^Unlisted Therapeutic Procedure
 ;;^UTILITY(U,$J,358.3,2899,0)
 ;;=97799^^27^210^12^^^^1
 ;;^UTILITY(U,$J,358.3,2899,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2899,1,2,0)
 ;;=2^97799
 ;;^UTILITY(U,$J,358.3,2899,1,3,0)
 ;;=3^Unlisted Physical Medicine/Rehab Service/Procedure
 ;;^UTILITY(U,$J,358.3,2900,0)
 ;;=G0176^^27^210^1^^^^1
 ;;^UTILITY(U,$J,358.3,2900,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2900,1,2,0)
 ;;=2^G0176
 ;;^UTILITY(U,$J,358.3,2900,1,3,0)
 ;;=3^Activity Therapy,Not For Rec,Per Session,> 45 min
 ;;^UTILITY(U,$J,358.3,2901,0)
 ;;=S9451^^27^210^4^^^^1
 ;;^UTILITY(U,$J,358.3,2901,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2901,1,2,0)
 ;;=2^S9451
 ;;^UTILITY(U,$J,358.3,2901,1,3,0)
 ;;=3^Exercise Class
 ;;^UTILITY(U,$J,358.3,2902,0)
 ;;=S8940^^27^210^3^^^^1
 ;;^UTILITY(U,$J,358.3,2902,1,0)
 ;;=^358.31IA^3^2
