IBDEI0RC ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27465,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,27466,0)
 ;;=F10.94^^102^1338^6
 ;;^UTILITY(U,$J,358.3,27466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27466,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27466,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,27466,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,27467,0)
 ;;=F10.14^^102^1338^7
 ;;^UTILITY(U,$J,358.3,27467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27467,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27467,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,27467,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,27468,0)
 ;;=F10.24^^102^1338^8
 ;;^UTILITY(U,$J,358.3,27468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27468,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27468,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,27468,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,27469,0)
 ;;=F10.20^^102^1338^34
 ;;^UTILITY(U,$J,358.3,27469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27469,1,3,0)
 ;;=3^Alcohol Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,27469,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,27469,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,27470,0)
 ;;=F10.231^^102^1338^35
 ;;^UTILITY(U,$J,358.3,27470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27470,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,27470,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,27470,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,27471,0)
 ;;=F10.232^^102^1338^36
 ;;^UTILITY(U,$J,358.3,27471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27471,1,3,0)
 ;;=3^Alcohol Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,27471,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,27471,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,27472,0)
 ;;=F12.10^^102^1339^19
 ;;^UTILITY(U,$J,358.3,27472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27472,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,27472,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,27472,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,27473,0)
 ;;=F12.20^^102^1339^20
 ;;^UTILITY(U,$J,358.3,27473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27473,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,27473,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,27473,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,27474,0)
 ;;=F12.288^^102^1339^22
 ;;^UTILITY(U,$J,358.3,27474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27474,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,27474,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,27474,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,27475,0)
 ;;=F12.121^^102^1339^10
 ;;^UTILITY(U,$J,358.3,27475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27475,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27475,1,4,0)
 ;;=4^F12.121
 ;;^UTILITY(U,$J,358.3,27475,2)
 ;;=^5003157
 ;;^UTILITY(U,$J,358.3,27476,0)
 ;;=F12.221^^102^1339^11
 ;;^UTILITY(U,$J,358.3,27476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27476,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27476,1,4,0)
 ;;=4^F12.221
 ;;^UTILITY(U,$J,358.3,27476,2)
 ;;=^5003169
 ;;^UTILITY(U,$J,358.3,27477,0)
 ;;=F12.921^^102^1339^12
 ;;^UTILITY(U,$J,358.3,27477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27477,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27477,1,4,0)
 ;;=4^F12.921
 ;;^UTILITY(U,$J,358.3,27477,2)
 ;;=^5003180
 ;;^UTILITY(U,$J,358.3,27478,0)
 ;;=F12.229^^102^1339^16
 ;;^UTILITY(U,$J,358.3,27478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27478,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27478,1,4,0)
 ;;=4^F12.229
 ;;^UTILITY(U,$J,358.3,27478,2)
 ;;=^5003171
 ;;^UTILITY(U,$J,358.3,27479,0)
 ;;=F12.122^^102^1339^13
 ;;^UTILITY(U,$J,358.3,27479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27479,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27479,1,4,0)
 ;;=4^F12.122
 ;;^UTILITY(U,$J,358.3,27479,2)
 ;;=^5003158
 ;;^UTILITY(U,$J,358.3,27480,0)
 ;;=F12.222^^102^1339^14
 ;;^UTILITY(U,$J,358.3,27480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27480,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27480,1,4,0)
 ;;=4^F12.222
 ;;^UTILITY(U,$J,358.3,27480,2)
 ;;=^5003170
 ;;^UTILITY(U,$J,358.3,27481,0)
 ;;=F12.922^^102^1339^15
 ;;^UTILITY(U,$J,358.3,27481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27481,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27481,1,4,0)
 ;;=4^F12.922
 ;;^UTILITY(U,$J,358.3,27481,2)
 ;;=^5003181
 ;;^UTILITY(U,$J,358.3,27482,0)
 ;;=F12.980^^102^1339^3
 ;;^UTILITY(U,$J,358.3,27482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27482,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27482,1,4,0)
 ;;=4^F12.980
 ;;^UTILITY(U,$J,358.3,27482,2)
 ;;=^5003186
 ;;^UTILITY(U,$J,358.3,27483,0)
 ;;=F12.159^^102^1339^4
 ;;^UTILITY(U,$J,358.3,27483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27483,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27483,1,4,0)
 ;;=4^F12.159
 ;;^UTILITY(U,$J,358.3,27483,2)
 ;;=^5003162
 ;;^UTILITY(U,$J,358.3,27484,0)
 ;;=F12.259^^102^1339^5
 ;;^UTILITY(U,$J,358.3,27484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27484,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27484,1,4,0)
 ;;=4^F12.259
 ;;^UTILITY(U,$J,358.3,27484,2)
 ;;=^5003174
 ;;^UTILITY(U,$J,358.3,27485,0)
 ;;=F12.959^^102^1339^6
 ;;^UTILITY(U,$J,358.3,27485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27485,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27485,1,4,0)
 ;;=4^F12.959
 ;;^UTILITY(U,$J,358.3,27485,2)
 ;;=^5003185
 ;;^UTILITY(U,$J,358.3,27486,0)
 ;;=F12.988^^102^1339^9
 ;;^UTILITY(U,$J,358.3,27486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27486,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27486,1,4,0)
 ;;=4^F12.988
 ;;^UTILITY(U,$J,358.3,27486,2)
 ;;=^5003187
 ;;^UTILITY(U,$J,358.3,27487,0)
 ;;=F12.929^^102^1339^17
 ;;^UTILITY(U,$J,358.3,27487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27487,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27487,1,4,0)
 ;;=4^F12.929
 ;;^UTILITY(U,$J,358.3,27487,2)
 ;;=^5003182
 ;;^UTILITY(U,$J,358.3,27488,0)
 ;;=F12.180^^102^1339^1
 ;;^UTILITY(U,$J,358.3,27488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27488,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27488,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,27488,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,27489,0)
 ;;=F12.280^^102^1339^2
 ;;^UTILITY(U,$J,358.3,27489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27489,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27489,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,27489,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,27490,0)
 ;;=F12.188^^102^1339^7
 ;;^UTILITY(U,$J,358.3,27490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27490,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27490,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,27490,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,27491,0)
 ;;=F12.288^^102^1339^8
 ;;^UTILITY(U,$J,358.3,27491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27491,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/ Moderate/Severe Use Disorder
