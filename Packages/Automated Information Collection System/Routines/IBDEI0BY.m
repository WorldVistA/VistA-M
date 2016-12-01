IBDEI0BY ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15161,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15161,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,15161,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,15162,0)
 ;;=F10.129^^45^677^29
 ;;^UTILITY(U,$J,358.3,15162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15162,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15162,1,4,0)
 ;;=4^F10.129
 ;;^UTILITY(U,$J,358.3,15162,2)
 ;;=^5003071
 ;;^UTILITY(U,$J,358.3,15163,0)
 ;;=F10.229^^45^677^30
 ;;^UTILITY(U,$J,358.3,15163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15163,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15163,1,4,0)
 ;;=4^F10.229
 ;;^UTILITY(U,$J,358.3,15163,2)
 ;;=^5003085
 ;;^UTILITY(U,$J,358.3,15164,0)
 ;;=F10.929^^45^677^31
 ;;^UTILITY(U,$J,358.3,15164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15164,1,3,0)
 ;;=3^Alcohol Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15164,1,4,0)
 ;;=4^F10.929
 ;;^UTILITY(U,$J,358.3,15164,2)
 ;;=^5003103
 ;;^UTILITY(U,$J,358.3,15165,0)
 ;;=F10.99^^45^677^32
 ;;^UTILITY(U,$J,358.3,15165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15165,1,3,0)
 ;;=3^Alcohol Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15165,1,4,0)
 ;;=4^F10.99
 ;;^UTILITY(U,$J,358.3,15165,2)
 ;;=^5133351
 ;;^UTILITY(U,$J,358.3,15166,0)
 ;;=F10.14^^45^677^5
 ;;^UTILITY(U,$J,358.3,15166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15166,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15166,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,15166,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,15167,0)
 ;;=F10.24^^45^677^6
 ;;^UTILITY(U,$J,358.3,15167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15167,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/ Modera/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15167,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,15167,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,15168,0)
 ;;=F10.94^^45^677^7
 ;;^UTILITY(U,$J,358.3,15168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15168,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15168,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,15168,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,15169,0)
 ;;=F10.14^^45^677^8
 ;;^UTILITY(U,$J,358.3,15169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15169,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15169,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,15169,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,15170,0)
 ;;=F10.24^^45^677^9
 ;;^UTILITY(U,$J,358.3,15170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15170,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15170,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,15170,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,15171,0)
 ;;=F10.20^^45^677^35
 ;;^UTILITY(U,$J,358.3,15171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15171,1,3,0)
 ;;=3^Alcohol Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,15171,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,15171,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,15172,0)
 ;;=F10.231^^45^677^36
 ;;^UTILITY(U,$J,358.3,15172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15172,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,15172,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,15172,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,15173,0)
 ;;=F10.232^^45^677^37
 ;;^UTILITY(U,$J,358.3,15173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15173,1,3,0)
 ;;=3^Alcohol Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,15173,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,15173,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,15174,0)
 ;;=F10.21^^45^677^1
 ;;^UTILITY(U,$J,358.3,15174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15174,1,3,0)
 ;;=3^Alcohol Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,15174,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,15174,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,15175,0)
 ;;=F12.10^^45^678^19
 ;;^UTILITY(U,$J,358.3,15175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15175,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,15175,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,15175,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,15176,0)
 ;;=F12.20^^45^678^20
 ;;^UTILITY(U,$J,358.3,15176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15176,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,15176,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,15176,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,15177,0)
 ;;=F12.288^^45^678^22
 ;;^UTILITY(U,$J,358.3,15177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15177,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,15177,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,15177,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,15178,0)
 ;;=F12.121^^45^678^10
 ;;^UTILITY(U,$J,358.3,15178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15178,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15178,1,4,0)
 ;;=4^F12.121
 ;;^UTILITY(U,$J,358.3,15178,2)
 ;;=^5003157
 ;;^UTILITY(U,$J,358.3,15179,0)
 ;;=F12.221^^45^678^11
 ;;^UTILITY(U,$J,358.3,15179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15179,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15179,1,4,0)
 ;;=4^F12.221
 ;;^UTILITY(U,$J,358.3,15179,2)
 ;;=^5003169
 ;;^UTILITY(U,$J,358.3,15180,0)
 ;;=F12.921^^45^678^12
 ;;^UTILITY(U,$J,358.3,15180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15180,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15180,1,4,0)
 ;;=4^F12.921
 ;;^UTILITY(U,$J,358.3,15180,2)
 ;;=^5003180
 ;;^UTILITY(U,$J,358.3,15181,0)
 ;;=F12.229^^45^678^16
 ;;^UTILITY(U,$J,358.3,15181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15181,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15181,1,4,0)
 ;;=4^F12.229
 ;;^UTILITY(U,$J,358.3,15181,2)
 ;;=^5003171
 ;;^UTILITY(U,$J,358.3,15182,0)
 ;;=F12.122^^45^678^13
 ;;^UTILITY(U,$J,358.3,15182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15182,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15182,1,4,0)
 ;;=4^F12.122
 ;;^UTILITY(U,$J,358.3,15182,2)
 ;;=^5003158
 ;;^UTILITY(U,$J,358.3,15183,0)
 ;;=F12.222^^45^678^14
 ;;^UTILITY(U,$J,358.3,15183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15183,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15183,1,4,0)
 ;;=4^F12.222
 ;;^UTILITY(U,$J,358.3,15183,2)
 ;;=^5003170
 ;;^UTILITY(U,$J,358.3,15184,0)
 ;;=F12.922^^45^678^15
 ;;^UTILITY(U,$J,358.3,15184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15184,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15184,1,4,0)
 ;;=4^F12.922
 ;;^UTILITY(U,$J,358.3,15184,2)
 ;;=^5003181
 ;;^UTILITY(U,$J,358.3,15185,0)
 ;;=F12.980^^45^678^3
 ;;^UTILITY(U,$J,358.3,15185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15185,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15185,1,4,0)
 ;;=4^F12.980
 ;;^UTILITY(U,$J,358.3,15185,2)
 ;;=^5003186
 ;;^UTILITY(U,$J,358.3,15186,0)
 ;;=F12.159^^45^678^4
 ;;^UTILITY(U,$J,358.3,15186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15186,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15186,1,4,0)
 ;;=4^F12.159
 ;;^UTILITY(U,$J,358.3,15186,2)
 ;;=^5003162
 ;;^UTILITY(U,$J,358.3,15187,0)
 ;;=F12.259^^45^678^5
 ;;^UTILITY(U,$J,358.3,15187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15187,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15187,1,4,0)
 ;;=4^F12.259
 ;;^UTILITY(U,$J,358.3,15187,2)
 ;;=^5003174
 ;;^UTILITY(U,$J,358.3,15188,0)
 ;;=F12.959^^45^678^6
 ;;^UTILITY(U,$J,358.3,15188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15188,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15188,1,4,0)
 ;;=4^F12.959
 ;;^UTILITY(U,$J,358.3,15188,2)
 ;;=^5003185
 ;;^UTILITY(U,$J,358.3,15189,0)
 ;;=F12.988^^45^678^9
 ;;^UTILITY(U,$J,358.3,15189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15189,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15189,1,4,0)
 ;;=4^F12.988
 ;;^UTILITY(U,$J,358.3,15189,2)
 ;;=^5003187
 ;;^UTILITY(U,$J,358.3,15190,0)
 ;;=F12.929^^45^678^17
 ;;^UTILITY(U,$J,358.3,15190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15190,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15190,1,4,0)
 ;;=4^F12.929
 ;;^UTILITY(U,$J,358.3,15190,2)
 ;;=^5003182
 ;;^UTILITY(U,$J,358.3,15191,0)
 ;;=F12.180^^45^678^1
 ;;^UTILITY(U,$J,358.3,15191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15191,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15191,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,15191,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,15192,0)
 ;;=F12.280^^45^678^2
 ;;^UTILITY(U,$J,358.3,15192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15192,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15192,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,15192,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,15193,0)
 ;;=F12.188^^45^678^7
 ;;^UTILITY(U,$J,358.3,15193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15193,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15193,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,15193,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,15194,0)
 ;;=F12.288^^45^678^8
 ;;^UTILITY(U,$J,358.3,15194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15194,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/ Moderate/Severe Use Disorder
