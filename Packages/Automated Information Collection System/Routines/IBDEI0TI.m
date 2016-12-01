IBDEI0TI ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38823,1,3,0)
 ;;=3^Rotatr-cuff tear/rptr of lft shldr, not trauma, unsp
 ;;^UTILITY(U,$J,358.3,38823,1,4,0)
 ;;=4^M75.102
 ;;^UTILITY(U,$J,358.3,38823,2)
 ;;=^5013243
 ;;^UTILITY(U,$J,358.3,38824,0)
 ;;=M75.51^^109^1612^70
 ;;^UTILITY(U,$J,358.3,38824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38824,1,3,0)
 ;;=3^Bursitis, rt shoulder
 ;;^UTILITY(U,$J,358.3,38824,1,4,0)
 ;;=4^M75.51
 ;;^UTILITY(U,$J,358.3,38824,2)
 ;;=^5133690
 ;;^UTILITY(U,$J,358.3,38825,0)
 ;;=M75.52^^109^1612^68
 ;;^UTILITY(U,$J,358.3,38825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38825,1,3,0)
 ;;=3^Bursitis, lft shoulder
 ;;^UTILITY(U,$J,358.3,38825,1,4,0)
 ;;=4^M75.52
 ;;^UTILITY(U,$J,358.3,38825,2)
 ;;=^5133691
 ;;^UTILITY(U,$J,358.3,38826,0)
 ;;=M75.31^^109^1612^91
 ;;^UTILITY(U,$J,358.3,38826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38826,1,3,0)
 ;;=3^Calcific tendinitis, rt shoulder
 ;;^UTILITY(U,$J,358.3,38826,1,4,0)
 ;;=4^M75.31
 ;;^UTILITY(U,$J,358.3,38826,2)
 ;;=^5013254
 ;;^UTILITY(U,$J,358.3,38827,0)
 ;;=M75.32^^109^1612^90
 ;;^UTILITY(U,$J,358.3,38827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38827,1,3,0)
 ;;=3^Calcific tendinitis, lft shoulder
 ;;^UTILITY(U,$J,358.3,38827,1,4,0)
 ;;=4^M75.32
 ;;^UTILITY(U,$J,358.3,38827,2)
 ;;=^5013255
 ;;^UTILITY(U,$J,358.3,38828,0)
 ;;=M75.21^^109^1612^64
 ;;^UTILITY(U,$J,358.3,38828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38828,1,3,0)
 ;;=3^Bicipital tendinitis, rt shoulder
 ;;^UTILITY(U,$J,358.3,38828,1,4,0)
 ;;=4^M75.21
 ;;^UTILITY(U,$J,358.3,38828,2)
 ;;=^5013251
 ;;^UTILITY(U,$J,358.3,38829,0)
 ;;=M75.22^^109^1612^63
 ;;^UTILITY(U,$J,358.3,38829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38829,1,3,0)
 ;;=3^Bicipital tendinitis, lft shoulder
 ;;^UTILITY(U,$J,358.3,38829,1,4,0)
 ;;=4^M75.22
 ;;^UTILITY(U,$J,358.3,38829,2)
 ;;=^5013252
 ;;^UTILITY(U,$J,358.3,38830,0)
 ;;=M75.111^^109^1612^163
 ;;^UTILITY(U,$J,358.3,38830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38830,1,3,0)
 ;;=3^Incmpl rotatr-cuff tear/rptr of rt shldr, not trauma
 ;;^UTILITY(U,$J,358.3,38830,1,4,0)
 ;;=4^M75.111
 ;;^UTILITY(U,$J,358.3,38830,2)
 ;;=^5013245
 ;;^UTILITY(U,$J,358.3,38831,0)
 ;;=M75.112^^109^1612^162
 ;;^UTILITY(U,$J,358.3,38831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38831,1,3,0)
 ;;=3^Incmpl rotatr-cuff tear/rptr of lft shlder, not trauma
 ;;^UTILITY(U,$J,358.3,38831,1,4,0)
 ;;=4^M75.112
 ;;^UTILITY(U,$J,358.3,38831,2)
 ;;=^5013246
 ;;^UTILITY(U,$J,358.3,38832,0)
 ;;=M75.81^^109^1612^225
 ;;^UTILITY(U,$J,358.3,38832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38832,1,3,0)
 ;;=3^Shoulder lesions, rt shldr, oth
 ;;^UTILITY(U,$J,358.3,38832,1,4,0)
 ;;=4^M75.81
 ;;^UTILITY(U,$J,358.3,38832,2)
 ;;=^5013261
 ;;^UTILITY(U,$J,358.3,38833,0)
 ;;=M75.82^^109^1612^224
 ;;^UTILITY(U,$J,358.3,38833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38833,1,3,0)
 ;;=3^Shoulder lesions, lft shldr, oth
 ;;^UTILITY(U,$J,358.3,38833,1,4,0)
 ;;=4^M75.82
 ;;^UTILITY(U,$J,358.3,38833,2)
 ;;=^5013262
 ;;^UTILITY(U,$J,358.3,38834,0)
 ;;=M65.9^^109^1612^279
 ;;^UTILITY(U,$J,358.3,38834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38834,1,3,0)
 ;;=3^Synovitis & tenosynovitis, unspec
 ;;^UTILITY(U,$J,358.3,38834,1,4,0)
 ;;=4^M65.9
 ;;^UTILITY(U,$J,358.3,38834,2)
 ;;=^5012816
 ;;^UTILITY(U,$J,358.3,38835,0)
 ;;=D48.1^^109^1612^198
 ;;^UTILITY(U,$J,358.3,38835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38835,1,3,0)
 ;;=3^Neoplasm of uncertn bhvior of connctv/soft tiss
 ;;^UTILITY(U,$J,358.3,38835,1,4,0)
 ;;=4^D48.1
 ;;^UTILITY(U,$J,358.3,38835,2)
 ;;=^267776
 ;;^UTILITY(U,$J,358.3,38836,0)
 ;;=M65.311^^109^1612^303
 ;;^UTILITY(U,$J,358.3,38836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38836,1,3,0)
 ;;=3^Trigger finger, rt thumb
 ;;^UTILITY(U,$J,358.3,38836,1,4,0)
 ;;=4^M65.311
 ;;^UTILITY(U,$J,358.3,38836,2)
 ;;=^5012777
 ;;^UTILITY(U,$J,358.3,38837,0)
 ;;=M65.312^^109^1612^298
 ;;^UTILITY(U,$J,358.3,38837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38837,1,3,0)
 ;;=3^Trigger finger, lft thumb
 ;;^UTILITY(U,$J,358.3,38837,1,4,0)
 ;;=4^M65.312
 ;;^UTILITY(U,$J,358.3,38837,2)
 ;;=^5012778
 ;;^UTILITY(U,$J,358.3,38838,0)
 ;;=M65.321^^109^1612^299
 ;;^UTILITY(U,$J,358.3,38838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38838,1,3,0)
 ;;=3^Trigger finger, rt index finger
 ;;^UTILITY(U,$J,358.3,38838,1,4,0)
 ;;=4^M65.321
 ;;^UTILITY(U,$J,358.3,38838,2)
 ;;=^5012780
 ;;^UTILITY(U,$J,358.3,38839,0)
 ;;=M65.322^^109^1612^294
 ;;^UTILITY(U,$J,358.3,38839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38839,1,3,0)
 ;;=3^Trigger finger, lft index finger
 ;;^UTILITY(U,$J,358.3,38839,1,4,0)
 ;;=4^M65.322
 ;;^UTILITY(U,$J,358.3,38839,2)
 ;;=^5012781
 ;;^UTILITY(U,$J,358.3,38840,0)
 ;;=M65.331^^109^1612^301
 ;;^UTILITY(U,$J,358.3,38840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38840,1,3,0)
 ;;=3^Trigger finger, rt middle finger
 ;;^UTILITY(U,$J,358.3,38840,1,4,0)
 ;;=4^M65.331
 ;;^UTILITY(U,$J,358.3,38840,2)
 ;;=^5012783
 ;;^UTILITY(U,$J,358.3,38841,0)
 ;;=M65.332^^109^1612^296
 ;;^UTILITY(U,$J,358.3,38841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38841,1,3,0)
 ;;=3^Trigger finger, lft middle finger
 ;;^UTILITY(U,$J,358.3,38841,1,4,0)
 ;;=4^M65.332
 ;;^UTILITY(U,$J,358.3,38841,2)
 ;;=^5012784
 ;;^UTILITY(U,$J,358.3,38842,0)
 ;;=M65.341^^109^1612^302
 ;;^UTILITY(U,$J,358.3,38842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38842,1,3,0)
 ;;=3^Trigger finger, rt ring finger
 ;;^UTILITY(U,$J,358.3,38842,1,4,0)
 ;;=4^M65.341
 ;;^UTILITY(U,$J,358.3,38842,2)
 ;;=^5012786
 ;;^UTILITY(U,$J,358.3,38843,0)
 ;;=M65.342^^109^1612^297
 ;;^UTILITY(U,$J,358.3,38843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38843,1,3,0)
 ;;=3^Trigger finger, lft ring finger
 ;;^UTILITY(U,$J,358.3,38843,1,4,0)
 ;;=4^M65.342
 ;;^UTILITY(U,$J,358.3,38843,2)
 ;;=^5012787
 ;;^UTILITY(U,$J,358.3,38844,0)
 ;;=M65.351^^109^1612^300
 ;;^UTILITY(U,$J,358.3,38844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38844,1,3,0)
 ;;=3^Trigger finger, rt little finger
 ;;^UTILITY(U,$J,358.3,38844,1,4,0)
 ;;=4^M65.351
 ;;^UTILITY(U,$J,358.3,38844,2)
 ;;=^5012789
 ;;^UTILITY(U,$J,358.3,38845,0)
 ;;=M65.352^^109^1612^295
 ;;^UTILITY(U,$J,358.3,38845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38845,1,3,0)
 ;;=3^Trigger finger, lft little finger
 ;;^UTILITY(U,$J,358.3,38845,1,4,0)
 ;;=4^M65.352
 ;;^UTILITY(U,$J,358.3,38845,2)
 ;;=^5012790
 ;;^UTILITY(U,$J,358.3,38846,0)
 ;;=M65.4^^109^1612^212
 ;;^UTILITY(U,$J,358.3,38846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38846,1,3,0)
 ;;=3^Radial styloid tenosynovitis [de Quervain]
 ;;^UTILITY(U,$J,358.3,38846,1,4,0)
 ;;=4^M65.4
 ;;^UTILITY(U,$J,358.3,38846,2)
 ;;=^5012792
 ;;^UTILITY(U,$J,358.3,38847,0)
 ;;=M65.841^^109^1612^278
 ;;^UTILITY(U,$J,358.3,38847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38847,1,3,0)
 ;;=3^Synovitis & Tenosynovitis, rt hand, oth
 ;;^UTILITY(U,$J,358.3,38847,1,4,0)
 ;;=4^M65.841
 ;;^UTILITY(U,$J,358.3,38847,2)
 ;;=^5012803
 ;;^UTILITY(U,$J,358.3,38848,0)
 ;;=M65.842^^109^1612^276
 ;;^UTILITY(U,$J,358.3,38848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38848,1,3,0)
 ;;=3^Synovitis & Tenosynovitis, lft hand, oth
 ;;^UTILITY(U,$J,358.3,38848,1,4,0)
 ;;=4^M65.842
 ;;^UTILITY(U,$J,358.3,38848,2)
 ;;=^5012804
 ;;^UTILITY(U,$J,358.3,38849,0)
 ;;=M65.871^^109^1612^277
 ;;^UTILITY(U,$J,358.3,38849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38849,1,3,0)
 ;;=3^Synovitis & Tenosynovitis, rt ankle & foot, oth
 ;;^UTILITY(U,$J,358.3,38849,1,4,0)
 ;;=4^M65.871
 ;;^UTILITY(U,$J,358.3,38849,2)
 ;;=^5012812
 ;;^UTILITY(U,$J,358.3,38850,0)
 ;;=M65.872^^109^1612^275
 ;;^UTILITY(U,$J,358.3,38850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38850,1,3,0)
 ;;=3^Synovitis & Tenosynovitis, lft ankle & foot, oth
 ;;^UTILITY(U,$J,358.3,38850,1,4,0)
 ;;=4^M65.872
 ;;^UTILITY(U,$J,358.3,38850,2)
 ;;=^5012813
 ;;^UTILITY(U,$J,358.3,38851,0)
 ;;=M20.11^^109^1612^161
 ;;^UTILITY(U,$J,358.3,38851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38851,1,3,0)
 ;;=3^Hallux valgus (acquired), rt foot
 ;;^UTILITY(U,$J,358.3,38851,1,4,0)
 ;;=4^M20.11
 ;;^UTILITY(U,$J,358.3,38851,2)
 ;;=^5011042
 ;;^UTILITY(U,$J,358.3,38852,0)
 ;;=M20.12^^109^1612^160
 ;;^UTILITY(U,$J,358.3,38852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38852,1,3,0)
 ;;=3^Hallux valgus (acquired), lft foot
 ;;^UTILITY(U,$J,358.3,38852,1,4,0)
 ;;=4^M20.12
 ;;^UTILITY(U,$J,358.3,38852,2)
 ;;=^5011043
 ;;^UTILITY(U,$J,358.3,38853,0)
 ;;=M70.031^^109^1612^98
 ;;^UTILITY(U,$J,358.3,38853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38853,1,3,0)
 ;;=3^Crepitant synovitis (acute/chronic), rt wrist
 ;;^UTILITY(U,$J,358.3,38853,1,4,0)
 ;;=4^M70.031
 ;;^UTILITY(U,$J,358.3,38853,2)
 ;;=^5013037
 ;;^UTILITY(U,$J,358.3,38854,0)
 ;;=M70.032^^109^1612^97
 ;;^UTILITY(U,$J,358.3,38854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38854,1,3,0)
 ;;=3^Crepitant synovitis (acute/chronic), lft wrist
 ;;^UTILITY(U,$J,358.3,38854,1,4,0)
 ;;=4^M70.032
 ;;^UTILITY(U,$J,358.3,38854,2)
 ;;=^5013038
 ;;^UTILITY(U,$J,358.3,38855,0)
 ;;=M70.31^^109^1612^69
 ;;^UTILITY(U,$J,358.3,38855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38855,1,3,0)
 ;;=3^Bursitis, rt elbow
 ;;^UTILITY(U,$J,358.3,38855,1,4,0)
 ;;=4^M70.31
 ;;^UTILITY(U,$J,358.3,38855,2)
 ;;=^5013050
 ;;^UTILITY(U,$J,358.3,38856,0)
 ;;=M70.32^^109^1612^67
 ;;^UTILITY(U,$J,358.3,38856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38856,1,3,0)
 ;;=3^Bursitis, lft elbow
 ;;^UTILITY(U,$J,358.3,38856,1,4,0)
 ;;=4^M70.32
 ;;^UTILITY(U,$J,358.3,38856,2)
 ;;=^5013051
 ;;^UTILITY(U,$J,358.3,38857,0)
 ;;=M70.41^^109^1612^206
 ;;^UTILITY(U,$J,358.3,38857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38857,1,3,0)
 ;;=3^Prepatellar bursitis, rt knee
 ;;^UTILITY(U,$J,358.3,38857,1,4,0)
 ;;=4^M70.41
 ;;^UTILITY(U,$J,358.3,38857,2)
 ;;=^5013053
