IBDEI02Y ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3437,1,4,0)
 ;;=4^N60.12
 ;;^UTILITY(U,$J,358.3,3437,2)
 ;;=^5015774
 ;;^UTILITY(U,$J,358.3,3438,0)
 ;;=N61.^^20^253^7
 ;;^UTILITY(U,$J,358.3,3438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3438,1,3,0)
 ;;=3^Inflammatory Disorders of Breast
 ;;^UTILITY(U,$J,358.3,3438,1,4,0)
 ;;=4^N61.
 ;;^UTILITY(U,$J,358.3,3438,2)
 ;;=^5015789
 ;;^UTILITY(U,$J,358.3,3439,0)
 ;;=N63.^^20^253^8
 ;;^UTILITY(U,$J,358.3,3439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3439,1,3,0)
 ;;=3^Lump in Breast,Unspec
 ;;^UTILITY(U,$J,358.3,3439,1,4,0)
 ;;=4^N63.
 ;;^UTILITY(U,$J,358.3,3439,2)
 ;;=^5015791
 ;;^UTILITY(U,$J,358.3,3440,0)
 ;;=N64.4^^20^253^28
 ;;^UTILITY(U,$J,358.3,3440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3440,1,3,0)
 ;;=3^Mastodynia
 ;;^UTILITY(U,$J,358.3,3440,1,4,0)
 ;;=4^N64.4
 ;;^UTILITY(U,$J,358.3,3440,2)
 ;;=^5015794
 ;;^UTILITY(U,$J,358.3,3441,0)
 ;;=N64.51^^20^253^6
 ;;^UTILITY(U,$J,358.3,3441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3441,1,3,0)
 ;;=3^Induration of Breast
 ;;^UTILITY(U,$J,358.3,3441,1,4,0)
 ;;=4^N64.51
 ;;^UTILITY(U,$J,358.3,3441,2)
 ;;=^5015795
 ;;^UTILITY(U,$J,358.3,3442,0)
 ;;=N64.52^^20^253^29
 ;;^UTILITY(U,$J,358.3,3442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3442,1,3,0)
 ;;=3^Nipple Discharge
 ;;^UTILITY(U,$J,358.3,3442,1,4,0)
 ;;=4^N64.52
 ;;^UTILITY(U,$J,358.3,3442,2)
 ;;=^259531
 ;;^UTILITY(U,$J,358.3,3443,0)
 ;;=N64.53^^20^253^30
 ;;^UTILITY(U,$J,358.3,3443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3443,1,3,0)
 ;;=3^Retraction of Nipple
 ;;^UTILITY(U,$J,358.3,3443,1,4,0)
 ;;=4^N64.53
 ;;^UTILITY(U,$J,358.3,3443,2)
 ;;=^5015796
 ;;^UTILITY(U,$J,358.3,3444,0)
 ;;=N64.59^^20^253^33
 ;;^UTILITY(U,$J,358.3,3444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3444,1,3,0)
 ;;=3^Signs/Symptoms in Breast NEC
 ;;^UTILITY(U,$J,358.3,3444,1,4,0)
 ;;=4^N64.59
 ;;^UTILITY(U,$J,358.3,3444,2)
 ;;=^5015797
 ;;^UTILITY(U,$J,358.3,3445,0)
 ;;=N64.89^^20^253^3
 ;;^UTILITY(U,$J,358.3,3445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3445,1,3,0)
 ;;=3^Breast Disorders NEC
 ;;^UTILITY(U,$J,358.3,3445,1,4,0)
 ;;=4^N64.89
 ;;^UTILITY(U,$J,358.3,3445,2)
 ;;=^336616
 ;;^UTILITY(U,$J,358.3,3446,0)
 ;;=Z12.39^^20^253^31
 ;;^UTILITY(U,$J,358.3,3446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3446,1,3,0)
 ;;=3^Screening for Malig Neop of Breast
 ;;^UTILITY(U,$J,358.3,3446,1,4,0)
 ;;=4^Z12.39
 ;;^UTILITY(U,$J,358.3,3446,2)
 ;;=^5062686
 ;;^UTILITY(U,$J,358.3,3447,0)
 ;;=C50.021^^20^254^12
 ;;^UTILITY(U,$J,358.3,3447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3447,1,3,0)
 ;;=3^Malig Neop of Nipple/Areola,Right Breast
 ;;^UTILITY(U,$J,358.3,3447,1,4,0)
 ;;=4^C50.021
 ;;^UTILITY(U,$J,358.3,3447,2)
 ;;=^5001162
 ;;^UTILITY(U,$J,358.3,3448,0)
 ;;=C50.022^^20^254^11
 ;;^UTILITY(U,$J,358.3,3448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3448,1,3,0)
 ;;=3^Malig Neop of Nipple/Areola,Left Breast
 ;;^UTILITY(U,$J,358.3,3448,1,4,0)
 ;;=4^C50.022
 ;;^UTILITY(U,$J,358.3,3448,2)
 ;;=^5001163
 ;;^UTILITY(U,$J,358.3,3449,0)
 ;;=C50.121^^20^254^5
 ;;^UTILITY(U,$J,358.3,3449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3449,1,3,0)
 ;;=3^Malig Neop of Central Portion of Right Breast
 ;;^UTILITY(U,$J,358.3,3449,1,4,0)
 ;;=4^C50.121
 ;;^UTILITY(U,$J,358.3,3449,2)
 ;;=^5001168
 ;;^UTILITY(U,$J,358.3,3450,0)
 ;;=C50.122^^20^254^4
 ;;^UTILITY(U,$J,358.3,3450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3450,1,3,0)
 ;;=3^Malig Neop of Central Portion of Left Breast
 ;;^UTILITY(U,$J,358.3,3450,1,4,0)
 ;;=4^C50.122
 ;;^UTILITY(U,$J,358.3,3450,2)
 ;;=^5001169
 ;;^UTILITY(U,$J,358.3,3451,0)
 ;;=C50.221^^20^254^17
 ;;^UTILITY(U,$J,358.3,3451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3451,1,3,0)
 ;;=3^Malig Neop of Upper-Inner Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,3451,1,4,0)
 ;;=4^C50.221
 ;;^UTILITY(U,$J,358.3,3451,2)
 ;;=^5001174
 ;;^UTILITY(U,$J,358.3,3452,0)
 ;;=C50.222^^20^254^16
 ;;^UTILITY(U,$J,358.3,3452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3452,1,3,0)
 ;;=3^Malig Neop of Upper-Inner Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,3452,1,4,0)
 ;;=4^C50.222
 ;;^UTILITY(U,$J,358.3,3452,2)
 ;;=^5001175
 ;;^UTILITY(U,$J,358.3,3453,0)
 ;;=C50.321^^20^254^8
 ;;^UTILITY(U,$J,358.3,3453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3453,1,3,0)
 ;;=3^Malig Neop of Lower-Inner Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,3453,1,4,0)
 ;;=4^C50.321
 ;;^UTILITY(U,$J,358.3,3453,2)
 ;;=^5001178
 ;;^UTILITY(U,$J,358.3,3454,0)
 ;;=C50.322^^20^254^7
 ;;^UTILITY(U,$J,358.3,3454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3454,1,3,0)
 ;;=3^Malig Neop of Lower-Inner Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,3454,1,4,0)
 ;;=4^C50.322
 ;;^UTILITY(U,$J,358.3,3454,2)
 ;;=^5133334
 ;;^UTILITY(U,$J,358.3,3455,0)
 ;;=C50.421^^20^254^19
 ;;^UTILITY(U,$J,358.3,3455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3455,1,3,0)
 ;;=3^Malig Neop of Upper-Outer Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,3455,1,4,0)
 ;;=4^C50.421
 ;;^UTILITY(U,$J,358.3,3455,2)
 ;;=^5001180
 ;;^UTILITY(U,$J,358.3,3456,0)
 ;;=C50.422^^20^254^18
 ;;^UTILITY(U,$J,358.3,3456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3456,1,3,0)
 ;;=3^Malig Neop of Upper-Outer Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,3456,1,4,0)
 ;;=4^C50.422
 ;;^UTILITY(U,$J,358.3,3456,2)
 ;;=^5133336
 ;;^UTILITY(U,$J,358.3,3457,0)
 ;;=C50.521^^20^254^10
 ;;^UTILITY(U,$J,358.3,3457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3457,1,3,0)
 ;;=3^Malig Neop of Lower-Outer Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,3457,1,4,0)
 ;;=4^C50.521
 ;;^UTILITY(U,$J,358.3,3457,2)
 ;;=^5001182
 ;;^UTILITY(U,$J,358.3,3458,0)
 ;;=C50.522^^20^254^9
 ;;^UTILITY(U,$J,358.3,3458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3458,1,3,0)
 ;;=3^Malig Neop of Lower-Outer Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,3458,1,4,0)
 ;;=4^C50.522
 ;;^UTILITY(U,$J,358.3,3458,2)
 ;;=^5133338
 ;;^UTILITY(U,$J,358.3,3459,0)
 ;;=C50.621^^20^254^3
 ;;^UTILITY(U,$J,358.3,3459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3459,1,3,0)
 ;;=3^Malig Neop of Axillary Tail of Right Breast
 ;;^UTILITY(U,$J,358.3,3459,1,4,0)
 ;;=4^C50.621
 ;;^UTILITY(U,$J,358.3,3459,2)
 ;;=^5001186
 ;;^UTILITY(U,$J,358.3,3460,0)
 ;;=C50.622^^20^254^2
 ;;^UTILITY(U,$J,358.3,3460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3460,1,3,0)
 ;;=3^Malig Neop of Axillary Tail of Left Breast
 ;;^UTILITY(U,$J,358.3,3460,1,4,0)
 ;;=4^C50.622
 ;;^UTILITY(U,$J,358.3,3460,2)
 ;;=^5001187
 ;;^UTILITY(U,$J,358.3,3461,0)
 ;;=C50.821^^20^254^14
 ;;^UTILITY(U,$J,358.3,3461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3461,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Right Breast
 ;;^UTILITY(U,$J,358.3,3461,1,4,0)
 ;;=4^C50.821
 ;;^UTILITY(U,$J,358.3,3461,2)
 ;;=^5001192
 ;;^UTILITY(U,$J,358.3,3462,0)
 ;;=C50.822^^20^254^13
 ;;^UTILITY(U,$J,358.3,3462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3462,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Left Breast
 ;;^UTILITY(U,$J,358.3,3462,1,4,0)
 ;;=4^C50.822
 ;;^UTILITY(U,$J,358.3,3462,2)
 ;;=^5001193
 ;;^UTILITY(U,$J,358.3,3463,0)
 ;;=C50.921^^20^254^15
 ;;^UTILITY(U,$J,358.3,3463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3463,1,3,0)
 ;;=3^Malig Neop of Right Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,3463,1,4,0)
 ;;=4^C50.921
 ;;^UTILITY(U,$J,358.3,3463,2)
 ;;=^5001198
 ;;^UTILITY(U,$J,358.3,3464,0)
 ;;=C50.922^^20^254^6
 ;;^UTILITY(U,$J,358.3,3464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3464,1,3,0)
 ;;=3^Malig Neop of Left Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,3464,1,4,0)
 ;;=4^C50.922
 ;;^UTILITY(U,$J,358.3,3464,2)
 ;;=^5133340
 ;;^UTILITY(U,$J,358.3,3465,0)
 ;;=N62.^^20^254^1
 ;;^UTILITY(U,$J,358.3,3465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3465,1,3,0)
 ;;=3^Hypertrophy of Breast
 ;;^UTILITY(U,$J,358.3,3465,1,4,0)
 ;;=4^N62.
 ;;^UTILITY(U,$J,358.3,3465,2)
 ;;=^5015790
 ;;^UTILITY(U,$J,358.3,3466,0)
 ;;=I25.10^^20^255^8
 ;;^UTILITY(U,$J,358.3,3466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3466,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,3466,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,3466,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,3467,0)
 ;;=I50.9^^20^255^22
 ;;^UTILITY(U,$J,358.3,3467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3467,1,3,0)
 ;;=3^Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,3467,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,3467,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,3468,0)
 ;;=I50.43^^20^255^5
 ;;^UTILITY(U,$J,358.3,3468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3468,1,3,0)
 ;;=3^Acute on Chronic Combined Systolic/Diastolic Hrt Failure
 ;;^UTILITY(U,$J,358.3,3468,1,4,0)
 ;;=4^I50.43
 ;;^UTILITY(U,$J,358.3,3468,2)
 ;;=^5007250
 ;;^UTILITY(U,$J,358.3,3469,0)
 ;;=I50.42^^20^255^12
 ;;^UTILITY(U,$J,358.3,3469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3469,1,3,0)
 ;;=3^Chronic Combined Systolic/Diastolic Hrt Failure
 ;;^UTILITY(U,$J,358.3,3469,1,4,0)
 ;;=4^I50.42
 ;;^UTILITY(U,$J,358.3,3469,2)
 ;;=^5007249
 ;;^UTILITY(U,$J,358.3,3470,0)
 ;;=I50.40^^20^255^15
 ;;^UTILITY(U,$J,358.3,3470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3470,1,3,0)
 ;;=3^Combined Systolic/Diastolic Hrt Failure,Unspec
 ;;^UTILITY(U,$J,358.3,3470,1,4,0)
 ;;=4^I50.40
 ;;^UTILITY(U,$J,358.3,3470,2)
 ;;=^5007247
 ;;^UTILITY(U,$J,358.3,3471,0)
 ;;=I50.41^^20^255^2
 ;;^UTILITY(U,$J,358.3,3471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3471,1,3,0)
 ;;=3^Acute Combined Systolic/Diastolic Hrt Failure
 ;;^UTILITY(U,$J,358.3,3471,1,4,0)
 ;;=4^I50.41
 ;;^UTILITY(U,$J,358.3,3471,2)
 ;;=^5007248
 ;;^UTILITY(U,$J,358.3,3472,0)
 ;;=I50.30^^20^255^16
 ;;^UTILITY(U,$J,358.3,3472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3472,1,3,0)
 ;;=3^Diastolic Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,3472,1,4,0)
 ;;=4^I50.30
 ;;^UTILITY(U,$J,358.3,3472,2)
 ;;=^5007243
 ;;^UTILITY(U,$J,358.3,3473,0)
 ;;=I50.31^^20^255^3
