IBDEI0LB ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26960,2)
 ;;=^5133351
 ;;^UTILITY(U,$J,358.3,26961,0)
 ;;=F10.14^^71^1136^5
 ;;^UTILITY(U,$J,358.3,26961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26961,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26961,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,26961,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,26962,0)
 ;;=F10.24^^71^1136^6
 ;;^UTILITY(U,$J,358.3,26962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26962,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/ Modera/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26962,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,26962,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,26963,0)
 ;;=F10.94^^71^1136^7
 ;;^UTILITY(U,$J,358.3,26963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26963,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26963,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,26963,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,26964,0)
 ;;=F10.14^^71^1136^8
 ;;^UTILITY(U,$J,358.3,26964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26964,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26964,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,26964,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,26965,0)
 ;;=F10.24^^71^1136^9
 ;;^UTILITY(U,$J,358.3,26965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26965,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26965,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,26965,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,26966,0)
 ;;=F10.20^^71^1136^35
 ;;^UTILITY(U,$J,358.3,26966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26966,1,3,0)
 ;;=3^Alcohol Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,26966,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,26966,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,26967,0)
 ;;=F10.231^^71^1136^36
 ;;^UTILITY(U,$J,358.3,26967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26967,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,26967,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,26967,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,26968,0)
 ;;=F10.232^^71^1136^37
 ;;^UTILITY(U,$J,358.3,26968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26968,1,3,0)
 ;;=3^Alcohol Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,26968,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,26968,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,26969,0)
 ;;=F10.21^^71^1136^1
 ;;^UTILITY(U,$J,358.3,26969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26969,1,3,0)
 ;;=3^Alcohol Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,26969,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,26969,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,26970,0)
 ;;=F12.10^^71^1137^19
 ;;^UTILITY(U,$J,358.3,26970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26970,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,26970,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,26970,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,26971,0)
 ;;=F12.20^^71^1137^20
 ;;^UTILITY(U,$J,358.3,26971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26971,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,26971,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,26971,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,26972,0)
 ;;=F12.288^^71^1137^22
 ;;^UTILITY(U,$J,358.3,26972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26972,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,26972,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,26972,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,26973,0)
 ;;=F12.121^^71^1137^10
 ;;^UTILITY(U,$J,358.3,26973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26973,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26973,1,4,0)
 ;;=4^F12.121
 ;;^UTILITY(U,$J,358.3,26973,2)
 ;;=^5003157
 ;;^UTILITY(U,$J,358.3,26974,0)
 ;;=F12.221^^71^1137^11
 ;;^UTILITY(U,$J,358.3,26974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26974,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26974,1,4,0)
 ;;=4^F12.221
 ;;^UTILITY(U,$J,358.3,26974,2)
 ;;=^5003169
 ;;^UTILITY(U,$J,358.3,26975,0)
 ;;=F12.921^^71^1137^12
 ;;^UTILITY(U,$J,358.3,26975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26975,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26975,1,4,0)
 ;;=4^F12.921
 ;;^UTILITY(U,$J,358.3,26975,2)
 ;;=^5003180
 ;;^UTILITY(U,$J,358.3,26976,0)
 ;;=F12.229^^71^1137^16
 ;;^UTILITY(U,$J,358.3,26976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26976,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26976,1,4,0)
 ;;=4^F12.229
 ;;^UTILITY(U,$J,358.3,26976,2)
 ;;=^5003171
 ;;^UTILITY(U,$J,358.3,26977,0)
 ;;=F12.122^^71^1137^13
 ;;^UTILITY(U,$J,358.3,26977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26977,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26977,1,4,0)
 ;;=4^F12.122
 ;;^UTILITY(U,$J,358.3,26977,2)
 ;;=^5003158
 ;;^UTILITY(U,$J,358.3,26978,0)
 ;;=F12.222^^71^1137^14
 ;;^UTILITY(U,$J,358.3,26978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26978,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26978,1,4,0)
 ;;=4^F12.222
 ;;^UTILITY(U,$J,358.3,26978,2)
 ;;=^5003170
 ;;^UTILITY(U,$J,358.3,26979,0)
 ;;=F12.922^^71^1137^15
 ;;^UTILITY(U,$J,358.3,26979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26979,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26979,1,4,0)
 ;;=4^F12.922
 ;;^UTILITY(U,$J,358.3,26979,2)
 ;;=^5003181
 ;;^UTILITY(U,$J,358.3,26980,0)
 ;;=F12.980^^71^1137^3
 ;;^UTILITY(U,$J,358.3,26980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26980,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26980,1,4,0)
 ;;=4^F12.980
 ;;^UTILITY(U,$J,358.3,26980,2)
 ;;=^5003186
 ;;^UTILITY(U,$J,358.3,26981,0)
 ;;=F12.159^^71^1137^4
 ;;^UTILITY(U,$J,358.3,26981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26981,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26981,1,4,0)
 ;;=4^F12.159
 ;;^UTILITY(U,$J,358.3,26981,2)
 ;;=^5003162
 ;;^UTILITY(U,$J,358.3,26982,0)
 ;;=F12.259^^71^1137^5
 ;;^UTILITY(U,$J,358.3,26982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26982,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26982,1,4,0)
 ;;=4^F12.259
 ;;^UTILITY(U,$J,358.3,26982,2)
 ;;=^5003174
 ;;^UTILITY(U,$J,358.3,26983,0)
 ;;=F12.959^^71^1137^6
 ;;^UTILITY(U,$J,358.3,26983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26983,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26983,1,4,0)
 ;;=4^F12.959
 ;;^UTILITY(U,$J,358.3,26983,2)
 ;;=^5003185
 ;;^UTILITY(U,$J,358.3,26984,0)
 ;;=F12.988^^71^1137^9
 ;;^UTILITY(U,$J,358.3,26984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26984,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26984,1,4,0)
 ;;=4^F12.988
 ;;^UTILITY(U,$J,358.3,26984,2)
 ;;=^5003187
 ;;^UTILITY(U,$J,358.3,26985,0)
 ;;=F12.929^^71^1137^17
 ;;^UTILITY(U,$J,358.3,26985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26985,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26985,1,4,0)
 ;;=4^F12.929
 ;;^UTILITY(U,$J,358.3,26985,2)
 ;;=^5003182
 ;;^UTILITY(U,$J,358.3,26986,0)
 ;;=F12.180^^71^1137^1
 ;;^UTILITY(U,$J,358.3,26986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26986,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26986,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,26986,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,26987,0)
 ;;=F12.280^^71^1137^2
 ;;^UTILITY(U,$J,358.3,26987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26987,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26987,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,26987,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,26988,0)
 ;;=F12.188^^71^1137^7
 ;;^UTILITY(U,$J,358.3,26988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26988,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26988,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,26988,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,26989,0)
 ;;=F12.288^^71^1137^8
 ;;^UTILITY(U,$J,358.3,26989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26989,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26989,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,26989,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,26990,0)
 ;;=F12.20^^71^1137^21
 ;;^UTILITY(U,$J,358.3,26990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26990,1,3,0)
 ;;=3^Cannabis Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,26990,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,26990,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,26991,0)
 ;;=F12.99^^71^1137^18
 ;;^UTILITY(U,$J,358.3,26991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26991,1,3,0)
 ;;=3^Cannabis Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26991,1,4,0)
 ;;=4^F12.99
 ;;^UTILITY(U,$J,358.3,26991,2)
 ;;=^5003188
 ;;^UTILITY(U,$J,358.3,26992,0)
 ;;=F16.10^^71^1138^35
 ;;^UTILITY(U,$J,358.3,26992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26992,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,26992,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,26992,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,26993,0)
 ;;=F16.20^^71^1138^36
 ;;^UTILITY(U,$J,358.3,26993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26993,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,26993,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,26993,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,26994,0)
 ;;=F16.121^^71^1138^10
