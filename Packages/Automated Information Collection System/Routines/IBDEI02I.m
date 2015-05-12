IBDEI02I ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2934,1,4,0)
 ;;=4^M75.102
 ;;^UTILITY(U,$J,358.3,2934,2)
 ;;=^5013243
 ;;^UTILITY(U,$J,358.3,2935,0)
 ;;=M75.31^^12^114^15
 ;;^UTILITY(U,$J,358.3,2935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2935,1,3,0)
 ;;=3^Calcific tendinitis of rt shoulder
 ;;^UTILITY(U,$J,358.3,2935,1,4,0)
 ;;=4^M75.31
 ;;^UTILITY(U,$J,358.3,2935,2)
 ;;=^5013254
 ;;^UTILITY(U,$J,358.3,2936,0)
 ;;=M75.32^^12^114^14
 ;;^UTILITY(U,$J,358.3,2936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2936,1,3,0)
 ;;=3^Calcific tendinitis of lft shoulder
 ;;^UTILITY(U,$J,358.3,2936,1,4,0)
 ;;=4^M75.32
 ;;^UTILITY(U,$J,358.3,2936,2)
 ;;=^5013255
 ;;^UTILITY(U,$J,358.3,2937,0)
 ;;=M75.21^^12^114^6
 ;;^UTILITY(U,$J,358.3,2937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2937,1,3,0)
 ;;=3^Bicipital tendinitis, rt shoulder
 ;;^UTILITY(U,$J,358.3,2937,1,4,0)
 ;;=4^M75.21
 ;;^UTILITY(U,$J,358.3,2937,2)
 ;;=^5013251
 ;;^UTILITY(U,$J,358.3,2938,0)
 ;;=M75.22^^12^114^5
 ;;^UTILITY(U,$J,358.3,2938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2938,1,3,0)
 ;;=3^Bicipital tendinitis, lft shoulder
 ;;^UTILITY(U,$J,358.3,2938,1,4,0)
 ;;=4^M75.22
 ;;^UTILITY(U,$J,358.3,2938,2)
 ;;=^5013252
 ;;^UTILITY(U,$J,358.3,2939,0)
 ;;=M75.81^^12^114^44
 ;;^UTILITY(U,$J,358.3,2939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2939,1,3,0)
 ;;=3^Shoulder lesions, rt shoulder
 ;;^UTILITY(U,$J,358.3,2939,1,4,0)
 ;;=4^M75.81
 ;;^UTILITY(U,$J,358.3,2939,2)
 ;;=^5013261
 ;;^UTILITY(U,$J,358.3,2940,0)
 ;;=M75.82^^12^114^43
 ;;^UTILITY(U,$J,358.3,2940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2940,1,3,0)
 ;;=3^Shoulder lesions, lft shoulder
 ;;^UTILITY(U,$J,358.3,2940,1,4,0)
 ;;=4^M75.82
 ;;^UTILITY(U,$J,358.3,2940,2)
 ;;=^5013262
 ;;^UTILITY(U,$J,358.3,2941,0)
 ;;=M77.01^^12^114^27
 ;;^UTILITY(U,$J,358.3,2941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2941,1,3,0)
 ;;=3^Medial epicondylitis, rt elbow
 ;;^UTILITY(U,$J,358.3,2941,1,4,0)
 ;;=4^M77.01
 ;;^UTILITY(U,$J,358.3,2941,2)
 ;;=^5013301
 ;;^UTILITY(U,$J,358.3,2942,0)
 ;;=M77.02^^12^114^26
 ;;^UTILITY(U,$J,358.3,2942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2942,1,3,0)
 ;;=3^Medial epicondylitis, lft elbow
 ;;^UTILITY(U,$J,358.3,2942,1,4,0)
 ;;=4^M77.02
 ;;^UTILITY(U,$J,358.3,2942,2)
 ;;=^5013302
 ;;^UTILITY(U,$J,358.3,2943,0)
 ;;=M77.11^^12^114^25
 ;;^UTILITY(U,$J,358.3,2943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2943,1,3,0)
 ;;=3^Lateral epicondylitis, rt elbow
 ;;^UTILITY(U,$J,358.3,2943,1,4,0)
 ;;=4^M77.11
 ;;^UTILITY(U,$J,358.3,2943,2)
 ;;=^5013304
 ;;^UTILITY(U,$J,358.3,2944,0)
 ;;=M77.12^^12^114^24
 ;;^UTILITY(U,$J,358.3,2944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2944,1,3,0)
 ;;=3^Lateral epicondylitis, lft elbow
 ;;^UTILITY(U,$J,358.3,2944,1,4,0)
 ;;=4^M77.12
 ;;^UTILITY(U,$J,358.3,2944,2)
 ;;=^5013305
 ;;^UTILITY(U,$J,358.3,2945,0)
 ;;=M70.21^^12^114^31
 ;;^UTILITY(U,$J,358.3,2945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2945,1,3,0)
 ;;=3^Olecranon bursitis, rt elbow
 ;;^UTILITY(U,$J,358.3,2945,1,4,0)
 ;;=4^M70.21
 ;;^UTILITY(U,$J,358.3,2945,2)
 ;;=^5013047
 ;;^UTILITY(U,$J,358.3,2946,0)
 ;;=M70.22^^12^114^30
 ;;^UTILITY(U,$J,358.3,2946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2946,1,3,0)
 ;;=3^Olecranon bursitis, lft elbow
 ;;^UTILITY(U,$J,358.3,2946,1,4,0)
 ;;=4^M70.22
 ;;^UTILITY(U,$J,358.3,2946,2)
 ;;=^5013048
 ;;^UTILITY(U,$J,358.3,2947,0)
 ;;=M70.61^^12^114^48
 ;;^UTILITY(U,$J,358.3,2947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2947,1,3,0)
 ;;=3^Trochanteric bursitis, rt hip
 ;;^UTILITY(U,$J,358.3,2947,1,4,0)
 ;;=4^M70.61
 ;;^UTILITY(U,$J,358.3,2947,2)
 ;;=^5013059
 ;;^UTILITY(U,$J,358.3,2948,0)
 ;;=M70.62^^12^114^47
 ;;^UTILITY(U,$J,358.3,2948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2948,1,3,0)
 ;;=3^Trochanteric bursitis, lft hip
 ;;^UTILITY(U,$J,358.3,2948,1,4,0)
 ;;=4^M70.62
 ;;^UTILITY(U,$J,358.3,2948,2)
 ;;=^5013060
 ;;^UTILITY(U,$J,358.3,2949,0)
 ;;=M70.71^^12^114^8
 ;;^UTILITY(U,$J,358.3,2949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2949,1,3,0)
 ;;=3^Bursitis of hip, rt hip
 ;;^UTILITY(U,$J,358.3,2949,1,4,0)
 ;;=4^M70.71
 ;;^UTILITY(U,$J,358.3,2949,2)
 ;;=^5013062
 ;;^UTILITY(U,$J,358.3,2950,0)
 ;;=M70.72^^12^114^7
 ;;^UTILITY(U,$J,358.3,2950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2950,1,3,0)
 ;;=3^Bursitis of hip, lft hip
 ;;^UTILITY(U,$J,358.3,2950,1,4,0)
 ;;=4^M70.72
 ;;^UTILITY(U,$J,358.3,2950,2)
 ;;=^5013063
 ;;^UTILITY(U,$J,358.3,2951,0)
 ;;=M76.11^^12^114^38
 ;;^UTILITY(U,$J,358.3,2951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2951,1,3,0)
 ;;=3^Psoas tendinitis, rt hip
 ;;^UTILITY(U,$J,358.3,2951,1,4,0)
 ;;=4^M76.11
 ;;^UTILITY(U,$J,358.3,2951,2)
 ;;=^5013270
 ;;^UTILITY(U,$J,358.3,2952,0)
 ;;=M76.12^^12^114^37
 ;;^UTILITY(U,$J,358.3,2952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2952,1,3,0)
 ;;=3^Psoas tendinitis, lft hip
 ;;^UTILITY(U,$J,358.3,2952,1,4,0)
 ;;=4^M76.12
 ;;^UTILITY(U,$J,358.3,2952,2)
 ;;=^5013271
 ;;^UTILITY(U,$J,358.3,2953,0)
 ;;=M76.21^^12^114^23
 ;;^UTILITY(U,$J,358.3,2953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2953,1,3,0)
 ;;=3^Iliac crest spur, rt hip
 ;;^UTILITY(U,$J,358.3,2953,1,4,0)
 ;;=4^M76.21
 ;;^UTILITY(U,$J,358.3,2953,2)
 ;;=^5013273
 ;;^UTILITY(U,$J,358.3,2954,0)
 ;;=M76.22^^12^114^22
 ;;^UTILITY(U,$J,358.3,2954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2954,1,3,0)
 ;;=3^Iliac crest spur, lft hip
 ;;^UTILITY(U,$J,358.3,2954,1,4,0)
 ;;=4^M76.22
 ;;^UTILITY(U,$J,358.3,2954,2)
 ;;=^5013274
 ;;^UTILITY(U,$J,358.3,2955,0)
 ;;=M70.51^^12^114^10
 ;;^UTILITY(U,$J,358.3,2955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2955,1,3,0)
 ;;=3^Bursitis of knee, rt knee
 ;;^UTILITY(U,$J,358.3,2955,1,4,0)
 ;;=4^M70.51
 ;;^UTILITY(U,$J,358.3,2955,2)
 ;;=^5013056
 ;;^UTILITY(U,$J,358.3,2956,0)
 ;;=M70.52^^12^114^9
 ;;^UTILITY(U,$J,358.3,2956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2956,1,3,0)
 ;;=3^Bursitis of knee, lft knee
 ;;^UTILITY(U,$J,358.3,2956,1,4,0)
 ;;=4^M70.52
 ;;^UTILITY(U,$J,358.3,2956,2)
 ;;=^5013057
 ;;^UTILITY(U,$J,358.3,2957,0)
 ;;=M76.891^^12^114^19
 ;;^UTILITY(U,$J,358.3,2957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2957,1,3,0)
 ;;=3^Enthesopathies of rt lwr limb, excl foot, oth
 ;;^UTILITY(U,$J,358.3,2957,1,4,0)
 ;;=4^M76.891
 ;;^UTILITY(U,$J,358.3,2957,2)
 ;;=^5013296
 ;;^UTILITY(U,$J,358.3,2958,0)
 ;;=M76.892^^12^114^18
 ;;^UTILITY(U,$J,358.3,2958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2958,1,3,0)
 ;;=3^Enthesopathies of lft lwr limb, excl foot, oth
 ;;^UTILITY(U,$J,358.3,2958,1,4,0)
 ;;=4^M76.892
 ;;^UTILITY(U,$J,358.3,2958,2)
 ;;=^5013297
 ;;^UTILITY(U,$J,358.3,2959,0)
 ;;=M76.51^^12^114^33
 ;;^UTILITY(U,$J,358.3,2959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2959,1,3,0)
 ;;=3^Patellar tendinitis, rt knee
 ;;^UTILITY(U,$J,358.3,2959,1,4,0)
 ;;=4^M76.51
 ;;^UTILITY(U,$J,358.3,2959,2)
 ;;=^5013282
 ;;^UTILITY(U,$J,358.3,2960,0)
 ;;=M76.52^^12^114^32
 ;;^UTILITY(U,$J,358.3,2960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2960,1,3,0)
 ;;=3^Patellar tendinitis, lft knee
 ;;^UTILITY(U,$J,358.3,2960,1,4,0)
 ;;=4^M76.52
 ;;^UTILITY(U,$J,358.3,2960,2)
 ;;=^5013283
 ;;^UTILITY(U,$J,358.3,2961,0)
 ;;=M70.41^^12^114^36
 ;;^UTILITY(U,$J,358.3,2961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2961,1,3,0)
 ;;=3^Prepatellar bursitis, rt knee
 ;;^UTILITY(U,$J,358.3,2961,1,4,0)
 ;;=4^M70.41
 ;;^UTILITY(U,$J,358.3,2961,2)
 ;;=^5013053
 ;;^UTILITY(U,$J,358.3,2962,0)
 ;;=M70.42^^12^114^35
 ;;^UTILITY(U,$J,358.3,2962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2962,1,3,0)
 ;;=3^Prepatellar bursitis, lft knee
 ;;^UTILITY(U,$J,358.3,2962,1,4,0)
 ;;=4^M70.42
 ;;^UTILITY(U,$J,358.3,2962,2)
 ;;=^5013054
 ;;^UTILITY(U,$J,358.3,2963,0)
 ;;=M77.41^^12^114^29
 ;;^UTILITY(U,$J,358.3,2963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2963,1,3,0)
 ;;=3^Metatarsalgia, rt foot
 ;;^UTILITY(U,$J,358.3,2963,1,4,0)
 ;;=4^M77.41
 ;;^UTILITY(U,$J,358.3,2963,2)
 ;;=^5013313
 ;;^UTILITY(U,$J,358.3,2964,0)
 ;;=M77.42^^12^114^28
 ;;^UTILITY(U,$J,358.3,2964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2964,1,3,0)
 ;;=3^Metatarsalgia, lft foot
 ;;^UTILITY(U,$J,358.3,2964,1,4,0)
 ;;=4^M77.42
 ;;^UTILITY(U,$J,358.3,2964,2)
 ;;=^5013314
 ;;^UTILITY(U,$J,358.3,2965,0)
 ;;=M76.61^^12^114^2
 ;;^UTILITY(U,$J,358.3,2965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2965,1,3,0)
 ;;=3^Achilles tendinitis, rt leg
 ;;^UTILITY(U,$J,358.3,2965,1,4,0)
 ;;=4^M76.61
 ;;^UTILITY(U,$J,358.3,2965,2)
 ;;=^5013285
 ;;^UTILITY(U,$J,358.3,2966,0)
 ;;=M76.62^^12^114^1
 ;;^UTILITY(U,$J,358.3,2966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2966,1,3,0)
 ;;=3^Achilles tendinitis, lft leg
 ;;^UTILITY(U,$J,358.3,2966,1,4,0)
 ;;=4^M76.62
 ;;^UTILITY(U,$J,358.3,2966,2)
 ;;=^5013286
 ;;^UTILITY(U,$J,358.3,2967,0)
 ;;=M77.9^^12^114^20
 ;;^UTILITY(U,$J,358.3,2967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2967,1,3,0)
 ;;=3^Enthesopathy, unspec
 ;;^UTILITY(U,$J,358.3,2967,1,4,0)
 ;;=4^M77.9
 ;;^UTILITY(U,$J,358.3,2967,2)
 ;;=^5013319
 ;;^UTILITY(U,$J,358.3,2968,0)
 ;;=M65.4^^12^114^39
 ;;^UTILITY(U,$J,358.3,2968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2968,1,3,0)
 ;;=3^Radial styloid tenosynovitis [de Quervain]
 ;;^UTILITY(U,$J,358.3,2968,1,4,0)
 ;;=4^M65.4
 ;;^UTILITY(U,$J,358.3,2968,2)
 ;;=^5012792
 ;;^UTILITY(U,$J,358.3,2969,0)
 ;;=M71.50^^12^114^13
 ;;^UTILITY(U,$J,358.3,2969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2969,1,3,0)
 ;;=3^Bursitis, NEC, unspec site, oth
 ;;^UTILITY(U,$J,358.3,2969,1,4,0)
 ;;=4^M71.50
 ;;^UTILITY(U,$J,358.3,2969,2)
 ;;=^5013190
 ;;^UTILITY(U,$J,358.3,2970,0)
 ;;=M71.21^^12^114^45
 ;;^UTILITY(U,$J,358.3,2970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2970,1,3,0)
 ;;=3^Synvl cyst of popliteal space [Baker], rt knee
 ;;^UTILITY(U,$J,358.3,2970,1,4,0)
 ;;=4^M71.21
 ;;^UTILITY(U,$J,358.3,2970,2)
 ;;=^5013147
 ;;^UTILITY(U,$J,358.3,2971,0)
 ;;=M71.22^^12^114^46
 ;;^UTILITY(U,$J,358.3,2971,1,0)
 ;;=^358.31IA^4^2
