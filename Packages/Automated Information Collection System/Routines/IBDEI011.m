IBDEI011 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,509,2)
 ;;=^5003085
 ;;^UTILITY(U,$J,358.3,510,0)
 ;;=F10.929^^3^46^30
 ;;^UTILITY(U,$J,358.3,510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,510,1,3,0)
 ;;=3^Alcohol Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,510,1,4,0)
 ;;=4^F10.929
 ;;^UTILITY(U,$J,358.3,510,2)
 ;;=^5003103
 ;;^UTILITY(U,$J,358.3,511,0)
 ;;=F10.99^^3^46^31
 ;;^UTILITY(U,$J,358.3,511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,511,1,3,0)
 ;;=3^Alcohol Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,511,1,4,0)
 ;;=4^F10.99
 ;;^UTILITY(U,$J,358.3,511,2)
 ;;=^5133351
 ;;^UTILITY(U,$J,358.3,512,0)
 ;;=F10.14^^3^46^4
 ;;^UTILITY(U,$J,358.3,512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,512,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,512,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,512,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,513,0)
 ;;=F10.24^^3^46^5
 ;;^UTILITY(U,$J,358.3,513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,513,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/ Modera/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,513,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,513,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,514,0)
 ;;=F10.94^^3^46^6
 ;;^UTILITY(U,$J,358.3,514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,514,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,514,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,514,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,515,0)
 ;;=F10.14^^3^46^7
 ;;^UTILITY(U,$J,358.3,515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,515,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,515,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,515,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,516,0)
 ;;=F10.24^^3^46^8
 ;;^UTILITY(U,$J,358.3,516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,516,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,516,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,516,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,517,0)
 ;;=F10.20^^3^46^34
 ;;^UTILITY(U,$J,358.3,517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,517,1,3,0)
 ;;=3^Alcohol Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,517,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,517,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,518,0)
 ;;=F10.231^^3^46^35
 ;;^UTILITY(U,$J,358.3,518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,518,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,518,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,518,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,519,0)
 ;;=F10.232^^3^46^36
 ;;^UTILITY(U,$J,358.3,519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,519,1,3,0)
 ;;=3^Alcohol Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,519,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,519,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,520,0)
 ;;=F12.10^^3^47^19
 ;;^UTILITY(U,$J,358.3,520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,520,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,520,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,520,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,521,0)
 ;;=F12.20^^3^47^20
 ;;^UTILITY(U,$J,358.3,521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,521,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,521,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,521,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,522,0)
 ;;=F12.288^^3^47^22
 ;;^UTILITY(U,$J,358.3,522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,522,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,522,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,522,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,523,0)
 ;;=F12.121^^3^47^10
 ;;^UTILITY(U,$J,358.3,523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,523,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,523,1,4,0)
 ;;=4^F12.121
 ;;^UTILITY(U,$J,358.3,523,2)
 ;;=^5003157
 ;;^UTILITY(U,$J,358.3,524,0)
 ;;=F12.221^^3^47^11
 ;;^UTILITY(U,$J,358.3,524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,524,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,524,1,4,0)
 ;;=4^F12.221
 ;;^UTILITY(U,$J,358.3,524,2)
 ;;=^5003169
 ;;^UTILITY(U,$J,358.3,525,0)
 ;;=F12.921^^3^47^12
 ;;^UTILITY(U,$J,358.3,525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,525,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,525,1,4,0)
 ;;=4^F12.921
 ;;^UTILITY(U,$J,358.3,525,2)
 ;;=^5003180
 ;;^UTILITY(U,$J,358.3,526,0)
 ;;=F12.229^^3^47^16
 ;;^UTILITY(U,$J,358.3,526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,526,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,526,1,4,0)
 ;;=4^F12.229
 ;;^UTILITY(U,$J,358.3,526,2)
 ;;=^5003171
 ;;^UTILITY(U,$J,358.3,527,0)
 ;;=F12.122^^3^47^13
 ;;^UTILITY(U,$J,358.3,527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,527,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,527,1,4,0)
 ;;=4^F12.122
 ;;^UTILITY(U,$J,358.3,527,2)
 ;;=^5003158
 ;;^UTILITY(U,$J,358.3,528,0)
 ;;=F12.222^^3^47^14
 ;;^UTILITY(U,$J,358.3,528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,528,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,528,1,4,0)
 ;;=4^F12.222
 ;;^UTILITY(U,$J,358.3,528,2)
 ;;=^5003170
 ;;^UTILITY(U,$J,358.3,529,0)
 ;;=F12.922^^3^47^15
 ;;^UTILITY(U,$J,358.3,529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,529,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,529,1,4,0)
 ;;=4^F12.922
 ;;^UTILITY(U,$J,358.3,529,2)
 ;;=^5003181
 ;;^UTILITY(U,$J,358.3,530,0)
 ;;=F12.980^^3^47^3
 ;;^UTILITY(U,$J,358.3,530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,530,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,530,1,4,0)
 ;;=4^F12.980
 ;;^UTILITY(U,$J,358.3,530,2)
 ;;=^5003186
 ;;^UTILITY(U,$J,358.3,531,0)
 ;;=F12.159^^3^47^4
 ;;^UTILITY(U,$J,358.3,531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,531,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,531,1,4,0)
 ;;=4^F12.159
 ;;^UTILITY(U,$J,358.3,531,2)
 ;;=^5003162
 ;;^UTILITY(U,$J,358.3,532,0)
 ;;=F12.259^^3^47^5
 ;;^UTILITY(U,$J,358.3,532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,532,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,532,1,4,0)
 ;;=4^F12.259
 ;;^UTILITY(U,$J,358.3,532,2)
 ;;=^5003174
 ;;^UTILITY(U,$J,358.3,533,0)
 ;;=F12.959^^3^47^6
 ;;^UTILITY(U,$J,358.3,533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,533,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,533,1,4,0)
 ;;=4^F12.959
 ;;^UTILITY(U,$J,358.3,533,2)
 ;;=^5003185
 ;;^UTILITY(U,$J,358.3,534,0)
 ;;=F12.988^^3^47^9
 ;;^UTILITY(U,$J,358.3,534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,534,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,534,1,4,0)
 ;;=4^F12.988
 ;;^UTILITY(U,$J,358.3,534,2)
 ;;=^5003187
 ;;^UTILITY(U,$J,358.3,535,0)
 ;;=F12.929^^3^47^17
 ;;^UTILITY(U,$J,358.3,535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,535,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,535,1,4,0)
 ;;=4^F12.929
 ;;^UTILITY(U,$J,358.3,535,2)
 ;;=^5003182
 ;;^UTILITY(U,$J,358.3,536,0)
 ;;=F12.180^^3^47^1
 ;;^UTILITY(U,$J,358.3,536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,536,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,536,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,536,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,537,0)
 ;;=F12.280^^3^47^2
