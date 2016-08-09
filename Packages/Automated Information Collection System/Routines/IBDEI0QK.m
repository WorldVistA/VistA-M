IBDEI0QK ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26704,0)
 ;;=F11.10^^100^1289^24
 ;;^UTILITY(U,$J,358.3,26704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26704,1,3,0)
 ;;=3^Opioid Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,26704,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,26704,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,26705,0)
 ;;=F11.129^^100^1289^20
 ;;^UTILITY(U,$J,358.3,26705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26705,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbances w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26705,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,26705,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,26706,0)
 ;;=F11.14^^100^1289^5
 ;;^UTILITY(U,$J,358.3,26706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26706,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26706,1,4,0)
 ;;=4^F11.14
 ;;^UTILITY(U,$J,358.3,26706,2)
 ;;=^5003119
 ;;^UTILITY(U,$J,358.3,26707,0)
 ;;=F11.182^^100^1289^11
 ;;^UTILITY(U,$J,358.3,26707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26707,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26707,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,26707,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,26708,0)
 ;;=F11.20^^100^1289^25
 ;;^UTILITY(U,$J,358.3,26708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26708,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,26708,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,26708,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,26709,0)
 ;;=F11.23^^100^1289^27
 ;;^UTILITY(U,$J,358.3,26709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26709,1,3,0)
 ;;=3^Opioid Withdrawal
 ;;^UTILITY(U,$J,358.3,26709,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,26709,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,26710,0)
 ;;=F11.24^^100^1289^6
 ;;^UTILITY(U,$J,358.3,26710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26710,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26710,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,26710,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,26711,0)
 ;;=F11.188^^100^1289^1
 ;;^UTILITY(U,$J,358.3,26711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26711,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26711,1,4,0)
 ;;=4^F11.188
 ;;^UTILITY(U,$J,358.3,26711,2)
 ;;=^5003125
 ;;^UTILITY(U,$J,358.3,26712,0)
 ;;=F11.288^^100^1289^2
 ;;^UTILITY(U,$J,358.3,26712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26712,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26712,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,26712,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,26713,0)
 ;;=F11.988^^100^1289^3
 ;;^UTILITY(U,$J,358.3,26713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26713,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26713,1,4,0)
 ;;=4^F11.988
 ;;^UTILITY(U,$J,358.3,26713,2)
 ;;=^5003154
 ;;^UTILITY(U,$J,358.3,26714,0)
 ;;=F11.921^^100^1289^4
 ;;^UTILITY(U,$J,358.3,26714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26714,1,3,0)
 ;;=3^Opioid Induced Delirium
 ;;^UTILITY(U,$J,358.3,26714,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,26714,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,26715,0)
 ;;=F11.94^^100^1289^7
 ;;^UTILITY(U,$J,358.3,26715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26715,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26715,1,4,0)
 ;;=4^F11.94
 ;;^UTILITY(U,$J,358.3,26715,2)
 ;;=^5003148
 ;;^UTILITY(U,$J,358.3,26716,0)
 ;;=F11.181^^100^1289^8
 ;;^UTILITY(U,$J,358.3,26716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26716,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26716,1,4,0)
 ;;=4^F11.181
 ;;^UTILITY(U,$J,358.3,26716,2)
 ;;=^5003123
 ;;^UTILITY(U,$J,358.3,26717,0)
 ;;=F11.281^^100^1289^9
 ;;^UTILITY(U,$J,358.3,26717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26717,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26717,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,26717,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,26718,0)
 ;;=F11.981^^100^1289^10
 ;;^UTILITY(U,$J,358.3,26718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26718,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26718,1,4,0)
 ;;=4^F11.981
 ;;^UTILITY(U,$J,358.3,26718,2)
 ;;=^5003152
 ;;^UTILITY(U,$J,358.3,26719,0)
 ;;=F11.282^^100^1289^12
 ;;^UTILITY(U,$J,358.3,26719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26719,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26719,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,26719,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,26720,0)
 ;;=F11.982^^100^1289^13
 ;;^UTILITY(U,$J,358.3,26720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26720,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26720,1,4,0)
 ;;=4^F11.982
 ;;^UTILITY(U,$J,358.3,26720,2)
 ;;=^5003153
 ;;^UTILITY(U,$J,358.3,26721,0)
 ;;=F11.121^^100^1289^14
 ;;^UTILITY(U,$J,358.3,26721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26721,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26721,1,4,0)
 ;;=4^F11.121
 ;;^UTILITY(U,$J,358.3,26721,2)
 ;;=^5003116
 ;;^UTILITY(U,$J,358.3,26722,0)
 ;;=F11.221^^100^1289^15
 ;;^UTILITY(U,$J,358.3,26722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26722,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26722,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,26722,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,26723,0)
 ;;=F11.921^^100^1289^16
 ;;^UTILITY(U,$J,358.3,26723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26723,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26723,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,26723,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,26724,0)
 ;;=F11.229^^100^1289^21
 ;;^UTILITY(U,$J,358.3,26724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26724,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26724,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,26724,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,26725,0)
 ;;=F11.929^^100^1289^22
 ;;^UTILITY(U,$J,358.3,26725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26725,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26725,1,4,0)
 ;;=4^F11.929
 ;;^UTILITY(U,$J,358.3,26725,2)
 ;;=^5003146
 ;;^UTILITY(U,$J,358.3,26726,0)
 ;;=F11.122^^100^1289^17
 ;;^UTILITY(U,$J,358.3,26726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26726,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26726,1,4,0)
 ;;=4^F11.122
 ;;^UTILITY(U,$J,358.3,26726,2)
 ;;=^5003117
 ;;^UTILITY(U,$J,358.3,26727,0)
 ;;=F11.222^^100^1289^18
 ;;^UTILITY(U,$J,358.3,26727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26727,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26727,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,26727,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,26728,0)
 ;;=F11.922^^100^1289^19
 ;;^UTILITY(U,$J,358.3,26728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26728,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26728,1,4,0)
 ;;=4^F11.922
 ;;^UTILITY(U,$J,358.3,26728,2)
 ;;=^5003145
 ;;^UTILITY(U,$J,358.3,26729,0)
 ;;=F11.99^^100^1289^23
 ;;^UTILITY(U,$J,358.3,26729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26729,1,3,0)
 ;;=3^Opioid Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26729,1,4,0)
 ;;=4^F11.99
 ;;^UTILITY(U,$J,358.3,26729,2)
 ;;=^5133352
