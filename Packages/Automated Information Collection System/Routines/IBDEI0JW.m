IBDEI0JW ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25191,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25191,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,25191,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,25192,0)
 ;;=F10.129^^66^1016^29
 ;;^UTILITY(U,$J,358.3,25192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25192,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25192,1,4,0)
 ;;=4^F10.129
 ;;^UTILITY(U,$J,358.3,25192,2)
 ;;=^5003071
 ;;^UTILITY(U,$J,358.3,25193,0)
 ;;=F10.229^^66^1016^30
 ;;^UTILITY(U,$J,358.3,25193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25193,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25193,1,4,0)
 ;;=4^F10.229
 ;;^UTILITY(U,$J,358.3,25193,2)
 ;;=^5003085
 ;;^UTILITY(U,$J,358.3,25194,0)
 ;;=F10.929^^66^1016^31
 ;;^UTILITY(U,$J,358.3,25194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25194,1,3,0)
 ;;=3^Alcohol Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25194,1,4,0)
 ;;=4^F10.929
 ;;^UTILITY(U,$J,358.3,25194,2)
 ;;=^5003103
 ;;^UTILITY(U,$J,358.3,25195,0)
 ;;=F10.99^^66^1016^32
 ;;^UTILITY(U,$J,358.3,25195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25195,1,3,0)
 ;;=3^Alcohol Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25195,1,4,0)
 ;;=4^F10.99
 ;;^UTILITY(U,$J,358.3,25195,2)
 ;;=^5133351
 ;;^UTILITY(U,$J,358.3,25196,0)
 ;;=F10.14^^66^1016^5
 ;;^UTILITY(U,$J,358.3,25196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25196,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25196,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,25196,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,25197,0)
 ;;=F10.24^^66^1016^6
 ;;^UTILITY(U,$J,358.3,25197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25197,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/ Modera/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25197,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,25197,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,25198,0)
 ;;=F10.94^^66^1016^7
 ;;^UTILITY(U,$J,358.3,25198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25198,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25198,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,25198,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,25199,0)
 ;;=F10.14^^66^1016^8
 ;;^UTILITY(U,$J,358.3,25199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25199,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25199,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,25199,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,25200,0)
 ;;=F10.24^^66^1016^9
 ;;^UTILITY(U,$J,358.3,25200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25200,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25200,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,25200,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,25201,0)
 ;;=F10.20^^66^1016^35
 ;;^UTILITY(U,$J,358.3,25201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25201,1,3,0)
 ;;=3^Alcohol Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,25201,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,25201,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,25202,0)
 ;;=F10.231^^66^1016^36
 ;;^UTILITY(U,$J,358.3,25202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25202,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,25202,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,25202,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,25203,0)
 ;;=F10.232^^66^1016^37
 ;;^UTILITY(U,$J,358.3,25203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25203,1,3,0)
 ;;=3^Alcohol Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,25203,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,25203,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,25204,0)
 ;;=F10.21^^66^1016^1
 ;;^UTILITY(U,$J,358.3,25204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25204,1,3,0)
 ;;=3^Alcohol Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,25204,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,25204,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,25205,0)
 ;;=F12.10^^66^1017^19
 ;;^UTILITY(U,$J,358.3,25205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25205,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,25205,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,25205,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,25206,0)
 ;;=F12.20^^66^1017^20
 ;;^UTILITY(U,$J,358.3,25206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25206,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,25206,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,25206,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,25207,0)
 ;;=F12.288^^66^1017^22
 ;;^UTILITY(U,$J,358.3,25207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25207,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,25207,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,25207,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,25208,0)
 ;;=F12.121^^66^1017^10
 ;;^UTILITY(U,$J,358.3,25208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25208,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25208,1,4,0)
 ;;=4^F12.121
 ;;^UTILITY(U,$J,358.3,25208,2)
 ;;=^5003157
 ;;^UTILITY(U,$J,358.3,25209,0)
 ;;=F12.221^^66^1017^11
 ;;^UTILITY(U,$J,358.3,25209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25209,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25209,1,4,0)
 ;;=4^F12.221
 ;;^UTILITY(U,$J,358.3,25209,2)
 ;;=^5003169
 ;;^UTILITY(U,$J,358.3,25210,0)
 ;;=F12.921^^66^1017^12
 ;;^UTILITY(U,$J,358.3,25210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25210,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25210,1,4,0)
 ;;=4^F12.921
 ;;^UTILITY(U,$J,358.3,25210,2)
 ;;=^5003180
 ;;^UTILITY(U,$J,358.3,25211,0)
 ;;=F12.229^^66^1017^16
 ;;^UTILITY(U,$J,358.3,25211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25211,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25211,1,4,0)
 ;;=4^F12.229
 ;;^UTILITY(U,$J,358.3,25211,2)
 ;;=^5003171
 ;;^UTILITY(U,$J,358.3,25212,0)
 ;;=F12.122^^66^1017^13
 ;;^UTILITY(U,$J,358.3,25212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25212,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25212,1,4,0)
 ;;=4^F12.122
 ;;^UTILITY(U,$J,358.3,25212,2)
 ;;=^5003158
 ;;^UTILITY(U,$J,358.3,25213,0)
 ;;=F12.222^^66^1017^14
 ;;^UTILITY(U,$J,358.3,25213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25213,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25213,1,4,0)
 ;;=4^F12.222
 ;;^UTILITY(U,$J,358.3,25213,2)
 ;;=^5003170
 ;;^UTILITY(U,$J,358.3,25214,0)
 ;;=F12.922^^66^1017^15
 ;;^UTILITY(U,$J,358.3,25214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25214,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25214,1,4,0)
 ;;=4^F12.922
 ;;^UTILITY(U,$J,358.3,25214,2)
 ;;=^5003181
 ;;^UTILITY(U,$J,358.3,25215,0)
 ;;=F12.980^^66^1017^3
 ;;^UTILITY(U,$J,358.3,25215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25215,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25215,1,4,0)
 ;;=4^F12.980
 ;;^UTILITY(U,$J,358.3,25215,2)
 ;;=^5003186
 ;;^UTILITY(U,$J,358.3,25216,0)
 ;;=F12.159^^66^1017^4
 ;;^UTILITY(U,$J,358.3,25216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25216,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25216,1,4,0)
 ;;=4^F12.159
 ;;^UTILITY(U,$J,358.3,25216,2)
 ;;=^5003162
 ;;^UTILITY(U,$J,358.3,25217,0)
 ;;=F12.259^^66^1017^5
 ;;^UTILITY(U,$J,358.3,25217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25217,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25217,1,4,0)
 ;;=4^F12.259
 ;;^UTILITY(U,$J,358.3,25217,2)
 ;;=^5003174
 ;;^UTILITY(U,$J,358.3,25218,0)
 ;;=F12.959^^66^1017^6
 ;;^UTILITY(U,$J,358.3,25218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25218,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25218,1,4,0)
 ;;=4^F12.959
 ;;^UTILITY(U,$J,358.3,25218,2)
 ;;=^5003185
 ;;^UTILITY(U,$J,358.3,25219,0)
 ;;=F12.988^^66^1017^9
 ;;^UTILITY(U,$J,358.3,25219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25219,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25219,1,4,0)
 ;;=4^F12.988
 ;;^UTILITY(U,$J,358.3,25219,2)
 ;;=^5003187
 ;;^UTILITY(U,$J,358.3,25220,0)
 ;;=F12.929^^66^1017^17
 ;;^UTILITY(U,$J,358.3,25220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25220,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25220,1,4,0)
 ;;=4^F12.929
 ;;^UTILITY(U,$J,358.3,25220,2)
 ;;=^5003182
 ;;^UTILITY(U,$J,358.3,25221,0)
 ;;=F12.180^^66^1017^1
 ;;^UTILITY(U,$J,358.3,25221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25221,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25221,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,25221,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,25222,0)
 ;;=F12.280^^66^1017^2
 ;;^UTILITY(U,$J,358.3,25222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25222,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25222,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,25222,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,25223,0)
 ;;=F12.188^^66^1017^7
 ;;^UTILITY(U,$J,358.3,25223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25223,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25223,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,25223,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,25224,0)
 ;;=F12.288^^66^1017^8
 ;;^UTILITY(U,$J,358.3,25224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25224,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/ Moderate/Severe Use Disorder
