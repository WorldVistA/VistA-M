IBDEI01L ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3443,1,4,0)
 ;;=4^M51.37
 ;;^UTILITY(U,$J,358.3,3443,2)
 ;;=^5012254
 ;;^UTILITY(U,$J,358.3,3444,0)
 ;;=M51.06^^24^209^4
 ;;^UTILITY(U,$J,358.3,3444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3444,1,3,0)
 ;;=3^Intervertebral disc disorders w/ myelopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,3444,1,4,0)
 ;;=4^M51.06
 ;;^UTILITY(U,$J,358.3,3444,2)
 ;;=^5012241
 ;;^UTILITY(U,$J,358.3,3445,0)
 ;;=M51.16^^24^209^5
 ;;^UTILITY(U,$J,358.3,3445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3445,1,3,0)
 ;;=3^Intervertebral disc disorders w/ radiculopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,3445,1,4,0)
 ;;=4^M51.16
 ;;^UTILITY(U,$J,358.3,3445,2)
 ;;=^5012245
 ;;^UTILITY(U,$J,358.3,3446,0)
 ;;=M51.17^^24^209^6
 ;;^UTILITY(U,$J,358.3,3446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3446,1,3,0)
 ;;=3^Intervertebral disc disorders w/ radiculopathy, lumbosacral region
 ;;^UTILITY(U,$J,358.3,3446,1,4,0)
 ;;=4^M51.17
 ;;^UTILITY(U,$J,358.3,3446,2)
 ;;=^5012246
 ;;^UTILITY(U,$J,358.3,3447,0)
 ;;=G54.1^^24^209^12
 ;;^UTILITY(U,$J,358.3,3447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3447,1,3,0)
 ;;=3^Lumbosacral plexus disorders
 ;;^UTILITY(U,$J,358.3,3447,1,4,0)
 ;;=4^G54.1
 ;;^UTILITY(U,$J,358.3,3447,2)
 ;;=^5004008
 ;;^UTILITY(U,$J,358.3,3448,0)
 ;;=G54.4^^24^209^13
 ;;^UTILITY(U,$J,358.3,3448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3448,1,3,0)
 ;;=3^Lumbosacral root disorders NEC
 ;;^UTILITY(U,$J,358.3,3448,1,4,0)
 ;;=4^G54.4
 ;;^UTILITY(U,$J,358.3,3448,2)
 ;;=^5004011
 ;;^UTILITY(U,$J,358.3,3449,0)
 ;;=M54.16^^24^209^14
 ;;^UTILITY(U,$J,358.3,3449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3449,1,3,0)
 ;;=3^Radiculopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,3449,1,4,0)
 ;;=4^M54.16
 ;;^UTILITY(U,$J,358.3,3449,2)
 ;;=^5012301
 ;;^UTILITY(U,$J,358.3,3450,0)
 ;;=M54.17^^24^209^15
 ;;^UTILITY(U,$J,358.3,3450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3450,1,3,0)
 ;;=3^Radiculopathy, lumbosacral region
 ;;^UTILITY(U,$J,358.3,3450,1,4,0)
 ;;=4^M54.17
 ;;^UTILITY(U,$J,358.3,3450,2)
 ;;=^5012302
 ;;^UTILITY(U,$J,358.3,3451,0)
 ;;=M51.46^^24^209^16
 ;;^UTILITY(U,$J,358.3,3451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3451,1,3,0)
 ;;=3^Schmorl's nodes, lumbar region
 ;;^UTILITY(U,$J,358.3,3451,1,4,0)
 ;;=4^M51.46
 ;;^UTILITY(U,$J,358.3,3451,2)
 ;;=^5012257
 ;;^UTILITY(U,$J,358.3,3452,0)
 ;;=M99.03^^24^209^18
 ;;^UTILITY(U,$J,358.3,3452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3452,1,3,0)
 ;;=3^Segmental and somatic dysfunction of lumbar region
 ;;^UTILITY(U,$J,358.3,3452,1,4,0)
 ;;=4^M99.03
 ;;^UTILITY(U,$J,358.3,3452,2)
 ;;=^5015403
 ;;^UTILITY(U,$J,358.3,3453,0)
 ;;=S33.5XXA^^24^209^23
 ;;^UTILITY(U,$J,358.3,3453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3453,1,3,0)
 ;;=3^Sprain of ligaments of lumbar spine, initial encounter
 ;;^UTILITY(U,$J,358.3,3453,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,3453,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,3454,0)
 ;;=S33.5XXS^^24^209^24
 ;;^UTILITY(U,$J,358.3,3454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3454,1,3,0)
 ;;=3^Sprain of ligaments of lumbar spine, sequela
 ;;^UTILITY(U,$J,358.3,3454,1,4,0)
 ;;=4^S33.5XXS
 ;;^UTILITY(U,$J,358.3,3454,2)
 ;;=^5025174
 ;;^UTILITY(U,$J,358.3,3455,0)
 ;;=S33.5XXD^^24^209^25
 ;;^UTILITY(U,$J,358.3,3455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3455,1,3,0)
 ;;=3^Sprain of ligaments of lumbar spine, subsequent encounter
 ;;^UTILITY(U,$J,358.3,3455,1,4,0)
 ;;=4^S33.5XXD
 ;;^UTILITY(U,$J,358.3,3455,2)
 ;;=^5025173
 ;;^UTILITY(U,$J,358.3,3456,0)
 ;;=M43.16^^24^209^22
 ;;^UTILITY(U,$J,358.3,3456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3456,1,3,0)
 ;;=3^Spondylolisthesis, lumbar region
 ;;^UTILITY(U,$J,358.3,3456,1,4,0)
 ;;=4^M43.16
 ;;^UTILITY(U,$J,358.3,3456,2)
 ;;=^5011927
 ;;^UTILITY(U,$J,358.3,3457,0)
 ;;=M51.26^^24^209^7
 ;;^UTILITY(U,$J,358.3,3457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3457,1,3,0)
 ;;=3^Intervrtbrl Disc Displacement,Lumbar
 ;;^UTILITY(U,$J,358.3,3457,1,4,0)
 ;;=4^M51.26
 ;;^UTILITY(U,$J,358.3,3457,2)
 ;;=^5012249
 ;;^UTILITY(U,$J,358.3,3458,0)
 ;;=M51.27^^24^209^8
 ;;^UTILITY(U,$J,358.3,3458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3458,1,3,0)
 ;;=3^Intervrtbrl Disc Displcmnt,Lumbosacral
 ;;^UTILITY(U,$J,358.3,3458,1,4,0)
 ;;=4^M51.27
 ;;^UTILITY(U,$J,358.3,3458,2)
 ;;=^5012250
 ;;^UTILITY(U,$J,358.3,3459,0)
 ;;=M51.47^^24^209^17
 ;;^UTILITY(U,$J,358.3,3459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3459,1,3,0)
 ;;=3^Schmorl's nodes, lumbosacral region
 ;;^UTILITY(U,$J,358.3,3459,1,4,0)
 ;;=4^M51.47
 ;;^UTILITY(U,$J,358.3,3459,2)
 ;;=^5012258
 ;;^UTILITY(U,$J,358.3,3460,0)
 ;;=M48.07^^24^209^21
 ;;^UTILITY(U,$J,358.3,3460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3460,1,3,0)
 ;;=3^Spinal stenosis, lumbosacral region
 ;;^UTILITY(U,$J,358.3,3460,1,4,0)
 ;;=4^M48.07
 ;;^UTILITY(U,$J,358.3,3460,2)
 ;;=^5012094
 ;;^UTILITY(U,$J,358.3,3461,0)
 ;;=M48.061^^24^209^20
 ;;^UTILITY(U,$J,358.3,3461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3461,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/o Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,3461,1,4,0)
 ;;=4^M48.061
 ;;^UTILITY(U,$J,358.3,3461,2)
 ;;=^5151513
 ;;^UTILITY(U,$J,358.3,3462,0)
 ;;=M48.062^^24^209^19
 ;;^UTILITY(U,$J,358.3,3462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3462,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/ Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,3462,1,4,0)
 ;;=4^M48.062
 ;;^UTILITY(U,$J,358.3,3462,2)
 ;;=^5151514
 ;;^UTILITY(U,$J,358.3,3463,0)
 ;;=M54.50^^24^209^10
 ;;^UTILITY(U,$J,358.3,3463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3463,1,3,0)
 ;;=3^Low Back Pain,Unspec
 ;;^UTILITY(U,$J,358.3,3463,1,4,0)
 ;;=4^M54.50
 ;;^UTILITY(U,$J,358.3,3463,2)
 ;;=^5161215
 ;;^UTILITY(U,$J,358.3,3464,0)
 ;;=M54.51^^24^209^11
 ;;^UTILITY(U,$J,358.3,3464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3464,1,3,0)
 ;;=3^Low Back Pain,Vertebrogenic
 ;;^UTILITY(U,$J,358.3,3464,1,4,0)
 ;;=4^M54.51
 ;;^UTILITY(U,$J,358.3,3464,2)
 ;;=^5161216
 ;;^UTILITY(U,$J,358.3,3465,0)
 ;;=M54.59^^24^209^9
 ;;^UTILITY(U,$J,358.3,3465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3465,1,3,0)
 ;;=3^Low Back Pain,Other
 ;;^UTILITY(U,$J,358.3,3465,1,4,0)
 ;;=4^M54.59
 ;;^UTILITY(U,$J,358.3,3465,2)
 ;;=^5161217
 ;;^UTILITY(U,$J,358.3,3466,0)
 ;;=S39.012A^^24^209^26
 ;;^UTILITY(U,$J,358.3,3466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3466,1,3,0)
 ;;=3^Strain of Muscle,Fascia,Tendon of Lower Back,Init Enctr
 ;;^UTILITY(U,$J,358.3,3466,1,4,0)
 ;;=4^S39.012A
 ;;^UTILITY(U,$J,358.3,3466,2)
 ;;=^5026102
 ;;^UTILITY(U,$J,358.3,3467,0)
 ;;=S39.012D^^24^209^27
 ;;^UTILITY(U,$J,358.3,3467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3467,1,3,0)
 ;;=3^Strain of Muscle,Fascia,Tendon of Lower Back,Subs Enctr
 ;;^UTILITY(U,$J,358.3,3467,1,4,0)
 ;;=4^S39.012D
 ;;^UTILITY(U,$J,358.3,3467,2)
 ;;=^5026103
 ;;^UTILITY(U,$J,358.3,3468,0)
 ;;=S39.012S^^24^209^28
 ;;^UTILITY(U,$J,358.3,3468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3468,1,3,0)
 ;;=3^Strain of Muscle,Fascia,Tendon of Lower Back,Sequela
 ;;^UTILITY(U,$J,358.3,3468,1,4,0)
 ;;=4^S39.012S
 ;;^UTILITY(U,$J,358.3,3468,2)
 ;;=^5026104
 ;;^UTILITY(U,$J,358.3,3469,0)
 ;;=M99.85^^24^210^1
 ;;^UTILITY(U,$J,358.3,3469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3469,1,3,0)
 ;;=3^Biomechanical lesions of pelvic region
 ;;^UTILITY(U,$J,358.3,3469,1,4,0)
 ;;=4^M99.85
 ;;^UTILITY(U,$J,358.3,3469,2)
 ;;=^5015485
 ;;^UTILITY(U,$J,358.3,3470,0)
 ;;=M99.84^^24^210^2
 ;;^UTILITY(U,$J,358.3,3470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3470,1,3,0)
 ;;=3^Biomechanical lesions of sacral region
 ;;^UTILITY(U,$J,358.3,3470,1,4,0)
 ;;=4^M99.84
 ;;^UTILITY(U,$J,358.3,3470,2)
 ;;=^5015484
 ;;^UTILITY(U,$J,358.3,3471,0)
 ;;=G54.0^^24^210^3
 ;;^UTILITY(U,$J,358.3,3471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3471,1,3,0)
 ;;=3^Brachial plexus disorders
 ;;^UTILITY(U,$J,358.3,3471,1,4,0)
 ;;=4^G54.0
 ;;^UTILITY(U,$J,358.3,3471,2)
 ;;=^5004007
 ;;^UTILITY(U,$J,358.3,3472,0)
 ;;=M76.02^^24^210^4
 ;;^UTILITY(U,$J,358.3,3472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3472,1,3,0)
 ;;=3^Gluteal tendinitis, left hip
 ;;^UTILITY(U,$J,358.3,3472,1,4,0)
 ;;=4^M76.02
 ;;^UTILITY(U,$J,358.3,3472,2)
 ;;=^5013268
 ;;^UTILITY(U,$J,358.3,3473,0)
 ;;=M76.01^^24^210^5
 ;;^UTILITY(U,$J,358.3,3473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3473,1,3,0)
 ;;=3^Gluteal tendinitis, right hip
 ;;^UTILITY(U,$J,358.3,3473,1,4,0)
 ;;=4^M76.01
 ;;^UTILITY(U,$J,358.3,3473,2)
 ;;=^5013267
 ;;^UTILITY(U,$J,358.3,3474,0)
 ;;=M76.22^^24^210^6
 ;;^UTILITY(U,$J,358.3,3474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3474,1,3,0)
 ;;=3^Iliac crest spur, left hip
 ;;^UTILITY(U,$J,358.3,3474,1,4,0)
 ;;=4^M76.22
 ;;^UTILITY(U,$J,358.3,3474,2)
 ;;=^5013274
 ;;^UTILITY(U,$J,358.3,3475,0)
 ;;=M76.21^^24^210^7
 ;;^UTILITY(U,$J,358.3,3475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3475,1,3,0)
 ;;=3^Iliac crest spur, right hip
 ;;^UTILITY(U,$J,358.3,3475,1,4,0)
 ;;=4^M76.21
 ;;^UTILITY(U,$J,358.3,3475,2)
 ;;=^5013273
 ;;^UTILITY(U,$J,358.3,3476,0)
 ;;=M54.18^^24^210^8
 ;;^UTILITY(U,$J,358.3,3476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3476,1,3,0)
 ;;=3^Radiculopathy, sacral and sacrococcygeal region
 ;;^UTILITY(U,$J,358.3,3476,1,4,0)
 ;;=4^M54.18
 ;;^UTILITY(U,$J,358.3,3476,2)
 ;;=^5012303
 ;;^UTILITY(U,$J,358.3,3477,0)
 ;;=M54.32^^24^210^9
 ;;^UTILITY(U,$J,358.3,3477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3477,1,3,0)
 ;;=3^Sciatica, left side
 ;;^UTILITY(U,$J,358.3,3477,1,4,0)
 ;;=4^M54.32
 ;;^UTILITY(U,$J,358.3,3477,2)
 ;;=^5012307
 ;;^UTILITY(U,$J,358.3,3478,0)
 ;;=M54.31^^24^210^10
 ;;^UTILITY(U,$J,358.3,3478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3478,1,3,0)
 ;;=3^Sciatica, right side
 ;;^UTILITY(U,$J,358.3,3478,1,4,0)
 ;;=4^M54.31
 ;;^UTILITY(U,$J,358.3,3478,2)
 ;;=^5012306
 ;;^UTILITY(U,$J,358.3,3479,0)
 ;;=M99.04^^24^210^12
 ;;^UTILITY(U,$J,358.3,3479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3479,1,3,0)
 ;;=3^Segmental and somatic dysfunction of sacral region
 ;;^UTILITY(U,$J,358.3,3479,1,4,0)
 ;;=4^M99.04
 ;;^UTILITY(U,$J,358.3,3479,2)
 ;;=^5015404
 ;;^UTILITY(U,$J,358.3,3480,0)
 ;;=M99.05^^24^210^11
 ;;^UTILITY(U,$J,358.3,3480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3480,1,3,0)
 ;;=3^Segmental and somatic dysfunction of pelvic region
 ;;^UTILITY(U,$J,358.3,3480,1,4,0)
 ;;=4^M99.05
 ;;^UTILITY(U,$J,358.3,3480,2)
 ;;=^5015405
 ;;^UTILITY(U,$J,358.3,3481,0)
 ;;=S33.6XXA^^24^210^13
 ;;^UTILITY(U,$J,358.3,3481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3481,1,3,0)
 ;;=3^Sprain of sacroiliac joint, initial encounter
 ;;^UTILITY(U,$J,358.3,3481,1,4,0)
 ;;=4^S33.6XXA
 ;;^UTILITY(U,$J,358.3,3481,2)
 ;;=^5025175
 ;;^UTILITY(U,$J,358.3,3482,0)
 ;;=S33.6XXS^^24^210^14
 ;;^UTILITY(U,$J,358.3,3482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3482,1,3,0)
 ;;=3^Sprain of sacroiliac joint, sequela
 ;;^UTILITY(U,$J,358.3,3482,1,4,0)
 ;;=4^S33.6XXS
 ;;^UTILITY(U,$J,358.3,3482,2)
 ;;=^5025177
 ;;^UTILITY(U,$J,358.3,3483,0)
 ;;=S33.6XXD^^24^210^15
 ;;^UTILITY(U,$J,358.3,3483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3483,1,3,0)
 ;;=3^Sprain of sacroiliac joint, subsequent encounter
 ;;^UTILITY(U,$J,358.3,3483,1,4,0)
 ;;=4^S33.6XXD
 ;;^UTILITY(U,$J,358.3,3483,2)
 ;;=^5025176
 ;;^UTILITY(U,$J,358.3,3484,0)
 ;;=M12.9^^24^211^1
 ;;^UTILITY(U,$J,358.3,3484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3484,1,3,0)
 ;;=3^Arthropathy, unspecified
 ;;^UTILITY(U,$J,358.3,3484,1,4,0)
 ;;=4^M12.9
 ;;^UTILITY(U,$J,358.3,3484,2)
 ;;=^5010666
 ;;^UTILITY(U,$J,358.3,3485,0)
 ;;=M71.50^^24^211^2
 ;;^UTILITY(U,$J,358.3,3485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3485,1,3,0)
 ;;=3^Bursitis, unspec site NEC
 ;;^UTILITY(U,$J,358.3,3485,1,4,0)
 ;;=4^M71.50
 ;;^UTILITY(U,$J,358.3,3485,2)
 ;;=^5013190
 ;;^UTILITY(U,$J,358.3,3486,0)
 ;;=M62.9^^24^211^3
 ;;^UTILITY(U,$J,358.3,3486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3486,1,3,0)
 ;;=3^Disorder of muscle, unspecified
 ;;^UTILITY(U,$J,358.3,3486,1,4,0)
 ;;=4^M62.9
 ;;^UTILITY(U,$J,358.3,3486,2)
 ;;=^5012684
 ;;^UTILITY(U,$J,358.3,3487,0)
 ;;=M71.10^^24^211^5
 ;;^UTILITY(U,$J,358.3,3487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3487,1,3,0)
 ;;=3^Infective bursitis, unspecified site
 ;;^UTILITY(U,$J,358.3,3487,1,4,0)
 ;;=4^M71.10
 ;;^UTILITY(U,$J,358.3,3487,2)
 ;;=^5013123
 ;;^UTILITY(U,$J,358.3,3488,0)
 ;;=M62.838^^24^211^6
 ;;^UTILITY(U,$J,358.3,3488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3488,1,3,0)
 ;;=3^Muscle spasm, other
 ;;^UTILITY(U,$J,358.3,3488,1,4,0)
 ;;=4^M62.838
 ;;^UTILITY(U,$J,358.3,3488,2)
 ;;=^5012682
 ;;^UTILITY(U,$J,358.3,3489,0)
 ;;=M79.2^^24^211^8
 ;;^UTILITY(U,$J,358.3,3489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3489,1,3,0)
 ;;=3^Neuralgia and neuritis, unspecified
 ;;^UTILITY(U,$J,358.3,3489,1,4,0)
 ;;=4^M79.2
 ;;^UTILITY(U,$J,358.3,3489,2)
 ;;=^5013322
 ;;^UTILITY(U,$J,358.3,3490,0)
 ;;=M25.50^^24^211^9
 ;;^UTILITY(U,$J,358.3,3490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3490,1,3,0)
 ;;=3^Pain in unspecified joint
 ;;^UTILITY(U,$J,358.3,3490,1,4,0)
 ;;=4^M25.50
 ;;^UTILITY(U,$J,358.3,3490,2)
 ;;=^5011601
 ;;^UTILITY(U,$J,358.3,3491,0)
 ;;=M96.1^^24^211^10
 ;;^UTILITY(U,$J,358.3,3491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3491,1,3,0)
 ;;=3^Postlaminectomy syndrome NEC
 ;;^UTILITY(U,$J,358.3,3491,1,4,0)
 ;;=4^M96.1
 ;;^UTILITY(U,$J,358.3,3491,2)
 ;;=^5015374
 ;;^UTILITY(U,$J,358.3,3492,0)
 ;;=M54.10^^24^211^11
 ;;^UTILITY(U,$J,358.3,3492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3492,1,3,0)
 ;;=3^Radiculopathy, site unspecified
 ;;^UTILITY(U,$J,358.3,3492,1,4,0)
 ;;=4^M54.10
 ;;^UTILITY(U,$J,358.3,3492,2)
 ;;=^5012295
 ;;^UTILITY(U,$J,358.3,3493,0)
 ;;=M47.10^^24^211^13
 ;;^UTILITY(U,$J,358.3,3493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3493,1,3,0)
 ;;=3^Spondylosis w/ myelopathy, other, site unspec
 ;;^UTILITY(U,$J,358.3,3493,1,4,0)
 ;;=4^M47.10
 ;;^UTILITY(U,$J,358.3,3493,2)
 ;;=^5012050
 ;;^UTILITY(U,$J,358.3,3494,0)
 ;;=M43.10^^24^211^12
 ;;^UTILITY(U,$J,358.3,3494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3494,1,3,0)
 ;;=3^Spondylolisthesis, site unspecified
 ;;^UTILITY(U,$J,358.3,3494,1,4,0)
 ;;=4^M43.10
 ;;^UTILITY(U,$J,358.3,3494,2)
 ;;=^5011921
 ;;^UTILITY(U,$J,358.3,3495,0)
 ;;=M79.7^^24^211^4
 ;;^UTILITY(U,$J,358.3,3495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3495,1,3,0)
 ;;=3^Fibromyalgia
 ;;^UTILITY(U,$J,358.3,3495,1,4,0)
 ;;=4^M79.7
 ;;^UTILITY(U,$J,358.3,3495,2)
 ;;=^46261
 ;;^UTILITY(U,$J,358.3,3496,0)
 ;;=M79.10^^24^211^7
 ;;^UTILITY(U,$J,358.3,3496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3496,1,3,0)
 ;;=3^Myalgia,Unspec Site
 ;;^UTILITY(U,$J,358.3,3496,1,4,0)
 ;;=4^M79.10
 ;;^UTILITY(U,$J,358.3,3496,2)
 ;;=^5157394
 ;;^UTILITY(U,$J,358.3,3497,0)
 ;;=R45.851^^24^212^3
 ;;^UTILITY(U,$J,358.3,3497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3497,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,3497,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,3497,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,3498,0)
 ;;=T14.91XA^^24^212^4
 ;;^UTILITY(U,$J,358.3,3498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3498,1,3,0)
 ;;=3^Suicide Attempt,Initial Encntr
 ;;^UTILITY(U,$J,358.3,3498,1,4,0)
 ;;=4^T14.91XA
 ;;^UTILITY(U,$J,358.3,3498,2)
 ;;=^5151779
 ;;^UTILITY(U,$J,358.3,3499,0)
 ;;=T14.91XD^^24^212^6
 ;;^UTILITY(U,$J,358.3,3499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3499,1,3,0)
 ;;=3^Suicide Attempt,Subsequent Encntr
 ;;^UTILITY(U,$J,358.3,3499,1,4,0)
 ;;=4^T14.91XD
 ;;^UTILITY(U,$J,358.3,3499,2)
 ;;=^5151780
 ;;^UTILITY(U,$J,358.3,3500,0)
 ;;=T14.91XS^^24^212^5
 ;;^UTILITY(U,$J,358.3,3500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3500,1,3,0)
 ;;=3^Suicide Attempt,Sequela
 ;;^UTILITY(U,$J,358.3,3500,1,4,0)
 ;;=4^T14.91XS
 ;;^UTILITY(U,$J,358.3,3500,2)
 ;;=^5151781
 ;;^UTILITY(U,$J,358.3,3501,0)
 ;;=Z91.52^^24^212^1
 ;;^UTILITY(U,$J,358.3,3501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3501,1,3,0)
 ;;=3^Personal Hx of Non-Suicidal Self-Harm
 ;;^UTILITY(U,$J,358.3,3501,1,4,0)
 ;;=4^Z91.52
 ;;^UTILITY(U,$J,358.3,3501,2)
 ;;=^5161318
 ;;^UTILITY(U,$J,358.3,3502,0)
 ;;=Z91.51^^24^212^2
 ;;^UTILITY(U,$J,358.3,3502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3502,1,3,0)
 ;;=3^Personal Hx of Suicidal Behavior     
 ;;^UTILITY(U,$J,358.3,3502,1,4,0)
 ;;=4^Z91.51
 ;;^UTILITY(U,$J,358.3,3502,2)
 ;;=^5161317
 ;;^UTILITY(U,$J,358.3,3503,0)
 ;;=99605^^25^213^1^^^^1
 ;;^UTILITY(U,$J,358.3,3503,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3503,1,2,0)
 ;;=2^MTMS BY PHARM,INIT 15 MIN
 ;;^UTILITY(U,$J,358.3,3503,1,3,0)
 ;;=3^99605
 ;;^UTILITY(U,$J,358.3,3503,3,0)
 ;;=^357.33
 ;;^UTILITY(U,$J,358.3,3504,0)
 ;;=99607^^25^213^2^^^^1
 ;;^UTILITY(U,$J,358.3,3504,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3504,1,2,0)
 ;;=2^MTMS BY PHARM, EA ADDL 15 MIN
 ;;^UTILITY(U,$J,358.3,3504,1,3,0)
 ;;=3^99607
 ;;^UTILITY(U,$J,358.3,3505,0)
 ;;=99606^^25^214^1^^^^1
 ;;^UTILITY(U,$J,358.3,3505,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3505,1,2,0)
 ;;=2^MTMS BY PHARM,INIT 15 MIN
 ;;^UTILITY(U,$J,358.3,3505,1,3,0)
 ;;=3^99606
 ;;^UTILITY(U,$J,358.3,3506,0)
 ;;=99607^^25^214^2^^^^1
 ;;^UTILITY(U,$J,358.3,3506,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3506,1,2,0)
 ;;=2^MTMS BY PHARM, EA ADDL 15 MIN
 ;;^UTILITY(U,$J,358.3,3506,1,3,0)
 ;;=3^99607
 ;;^UTILITY(U,$J,358.3,3507,0)
 ;;=98960^^25^215^1^^^^1
 ;;^UTILITY(U,$J,358.3,3507,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3507,1,2,0)
 ;;=2^INDIVIDUAL PATIENT, EA 30 MIN
 ;;^UTILITY(U,$J,358.3,3507,1,3,0)
 ;;=3^98960
 ;;^UTILITY(U,$J,358.3,3508,0)
 ;;=98961^^25^215^2^^^^1
 ;;^UTILITY(U,$J,358.3,3508,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3508,1,2,0)
 ;;=2^2-4 PATIENTS, EA 30 MIN
 ;;^UTILITY(U,$J,358.3,3508,1,3,0)
 ;;=3^98961
 ;;^UTILITY(U,$J,358.3,3509,0)
 ;;=98962^^25^215^3^^^^1
 ;;^UTILITY(U,$J,358.3,3509,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3509,1,2,0)
 ;;=2^5-8 PATIENTS, EA 30 MIN
 ;;^UTILITY(U,$J,358.3,3509,1,3,0)
 ;;=3^98962
 ;;^UTILITY(U,$J,358.3,3510,0)
 ;;=S9810^^25^216^1^^^^1
 ;;^UTILITY(U,$J,358.3,3510,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3510,1,2,0)
 ;;=2^Infusion/Drug Admin per Hr,Home Therapy
 ;;^UTILITY(U,$J,358.3,3510,1,3,0)
 ;;=3^S9810
 ;;^UTILITY(U,$J,358.3,3511,0)
 ;;=90471^^25^217^1^^^^1
 ;;^UTILITY(U,$J,358.3,3511,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3511,1,2,0)
 ;;=2^Immunization Admin,1 Vaccine
 ;;^UTILITY(U,$J,358.3,3511,1,3,0)
 ;;=3^90471
 ;;^UTILITY(U,$J,358.3,3512,0)
 ;;=90472^^25^217^2^^^^1
 ;;^UTILITY(U,$J,358.3,3512,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3512,1,2,0)
 ;;=2^Immunization Admin,Ea Addl Vaccine
 ;;^UTILITY(U,$J,358.3,3512,1,3,0)
 ;;=3^90472
 ;;^UTILITY(U,$J,358.3,3513,0)
 ;;=90686^^25^218^7^^^^1
 ;;^UTILITY(U,$J,358.3,3513,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3513,1,2,0)
 ;;=2^Flu Vacc Sgl Dose Syr (AFLURIA IIV4)
 ;;^UTILITY(U,$J,358.3,3513,1,3,0)
 ;;=3^90686
 ;;^UTILITY(U,$J,358.3,3514,0)
 ;;=90662^^25^218^1^^^^1
