IBDEI10M ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36842,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,36843,0)
 ;;=F10.94^^135^1820^6
 ;;^UTILITY(U,$J,358.3,36843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36843,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36843,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,36843,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,36844,0)
 ;;=F10.14^^135^1820^7
 ;;^UTILITY(U,$J,358.3,36844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36844,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,36844,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,36844,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,36845,0)
 ;;=F10.24^^135^1820^8
 ;;^UTILITY(U,$J,358.3,36845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36845,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36845,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,36845,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,36846,0)
 ;;=F10.20^^135^1820^34
 ;;^UTILITY(U,$J,358.3,36846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36846,1,3,0)
 ;;=3^Alcohol Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,36846,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,36846,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,36847,0)
 ;;=F10.231^^135^1820^35
 ;;^UTILITY(U,$J,358.3,36847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36847,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,36847,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,36847,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,36848,0)
 ;;=F10.232^^135^1820^36
 ;;^UTILITY(U,$J,358.3,36848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36848,1,3,0)
 ;;=3^Alcohol Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,36848,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,36848,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,36849,0)
 ;;=F12.10^^135^1821^19
 ;;^UTILITY(U,$J,358.3,36849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36849,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,36849,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,36849,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,36850,0)
 ;;=F12.20^^135^1821^20
 ;;^UTILITY(U,$J,358.3,36850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36850,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,36850,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,36850,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,36851,0)
 ;;=F12.288^^135^1821^22
 ;;^UTILITY(U,$J,358.3,36851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36851,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,36851,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,36851,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,36852,0)
 ;;=F12.121^^135^1821^10
 ;;^UTILITY(U,$J,358.3,36852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36852,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,36852,1,4,0)
 ;;=4^F12.121
 ;;^UTILITY(U,$J,358.3,36852,2)
 ;;=^5003157
 ;;^UTILITY(U,$J,358.3,36853,0)
 ;;=F12.221^^135^1821^11
 ;;^UTILITY(U,$J,358.3,36853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36853,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36853,1,4,0)
 ;;=4^F12.221
 ;;^UTILITY(U,$J,358.3,36853,2)
 ;;=^5003169
 ;;^UTILITY(U,$J,358.3,36854,0)
 ;;=F12.921^^135^1821^12
 ;;^UTILITY(U,$J,358.3,36854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36854,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36854,1,4,0)
 ;;=4^F12.921
 ;;^UTILITY(U,$J,358.3,36854,2)
 ;;=^5003180
 ;;^UTILITY(U,$J,358.3,36855,0)
 ;;=F12.229^^135^1821^16
 ;;^UTILITY(U,$J,358.3,36855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36855,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36855,1,4,0)
 ;;=4^F12.229
 ;;^UTILITY(U,$J,358.3,36855,2)
 ;;=^5003171
 ;;^UTILITY(U,$J,358.3,36856,0)
 ;;=F12.122^^135^1821^13
 ;;^UTILITY(U,$J,358.3,36856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36856,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,36856,1,4,0)
 ;;=4^F12.122
 ;;^UTILITY(U,$J,358.3,36856,2)
 ;;=^5003158
 ;;^UTILITY(U,$J,358.3,36857,0)
 ;;=F12.222^^135^1821^14
 ;;^UTILITY(U,$J,358.3,36857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36857,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36857,1,4,0)
 ;;=4^F12.222
 ;;^UTILITY(U,$J,358.3,36857,2)
 ;;=^5003170
 ;;^UTILITY(U,$J,358.3,36858,0)
 ;;=F12.922^^135^1821^15
 ;;^UTILITY(U,$J,358.3,36858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36858,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36858,1,4,0)
 ;;=4^F12.922
 ;;^UTILITY(U,$J,358.3,36858,2)
 ;;=^5003181
 ;;^UTILITY(U,$J,358.3,36859,0)
 ;;=F12.980^^135^1821^3
 ;;^UTILITY(U,$J,358.3,36859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36859,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36859,1,4,0)
 ;;=4^F12.980
 ;;^UTILITY(U,$J,358.3,36859,2)
 ;;=^5003186
 ;;^UTILITY(U,$J,358.3,36860,0)
 ;;=F12.159^^135^1821^4
 ;;^UTILITY(U,$J,358.3,36860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36860,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,36860,1,4,0)
 ;;=4^F12.159
 ;;^UTILITY(U,$J,358.3,36860,2)
 ;;=^5003162
 ;;^UTILITY(U,$J,358.3,36861,0)
 ;;=F12.259^^135^1821^5
 ;;^UTILITY(U,$J,358.3,36861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36861,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36861,1,4,0)
 ;;=4^F12.259
 ;;^UTILITY(U,$J,358.3,36861,2)
 ;;=^5003174
 ;;^UTILITY(U,$J,358.3,36862,0)
 ;;=F12.959^^135^1821^6
 ;;^UTILITY(U,$J,358.3,36862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36862,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36862,1,4,0)
 ;;=4^F12.959
 ;;^UTILITY(U,$J,358.3,36862,2)
 ;;=^5003185
 ;;^UTILITY(U,$J,358.3,36863,0)
 ;;=F12.988^^135^1821^9
 ;;^UTILITY(U,$J,358.3,36863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36863,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36863,1,4,0)
 ;;=4^F12.988
 ;;^UTILITY(U,$J,358.3,36863,2)
 ;;=^5003187
 ;;^UTILITY(U,$J,358.3,36864,0)
 ;;=F12.929^^135^1821^17
 ;;^UTILITY(U,$J,358.3,36864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36864,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36864,1,4,0)
 ;;=4^F12.929
 ;;^UTILITY(U,$J,358.3,36864,2)
 ;;=^5003182
 ;;^UTILITY(U,$J,358.3,36865,0)
 ;;=F12.180^^135^1821^1
 ;;^UTILITY(U,$J,358.3,36865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36865,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,36865,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,36865,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,36866,0)
 ;;=F12.280^^135^1821^2
 ;;^UTILITY(U,$J,358.3,36866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36866,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36866,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,36866,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,36867,0)
 ;;=F12.188^^135^1821^7
 ;;^UTILITY(U,$J,358.3,36867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36867,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,36867,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,36867,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,36868,0)
 ;;=F12.288^^135^1821^8
 ;;^UTILITY(U,$J,358.3,36868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36868,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/ Moderate/Severe Use Disorder
