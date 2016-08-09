IBDEI0PL ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25746,2)
 ;;=^5003085
 ;;^UTILITY(U,$J,358.3,25747,0)
 ;;=F10.929^^97^1220^30
 ;;^UTILITY(U,$J,358.3,25747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25747,1,3,0)
 ;;=3^Alcohol Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25747,1,4,0)
 ;;=4^F10.929
 ;;^UTILITY(U,$J,358.3,25747,2)
 ;;=^5003103
 ;;^UTILITY(U,$J,358.3,25748,0)
 ;;=F10.99^^97^1220^31
 ;;^UTILITY(U,$J,358.3,25748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25748,1,3,0)
 ;;=3^Alcohol Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25748,1,4,0)
 ;;=4^F10.99
 ;;^UTILITY(U,$J,358.3,25748,2)
 ;;=^5133351
 ;;^UTILITY(U,$J,358.3,25749,0)
 ;;=F10.14^^97^1220^4
 ;;^UTILITY(U,$J,358.3,25749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25749,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25749,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,25749,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,25750,0)
 ;;=F10.24^^97^1220^5
 ;;^UTILITY(U,$J,358.3,25750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25750,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/ Modera/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25750,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,25750,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,25751,0)
 ;;=F10.94^^97^1220^6
 ;;^UTILITY(U,$J,358.3,25751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25751,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25751,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,25751,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,25752,0)
 ;;=F10.14^^97^1220^7
 ;;^UTILITY(U,$J,358.3,25752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25752,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25752,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,25752,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,25753,0)
 ;;=F10.24^^97^1220^8
 ;;^UTILITY(U,$J,358.3,25753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25753,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25753,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,25753,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,25754,0)
 ;;=F10.20^^97^1220^34
 ;;^UTILITY(U,$J,358.3,25754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25754,1,3,0)
 ;;=3^Alcohol Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,25754,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,25754,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,25755,0)
 ;;=F10.231^^97^1220^35
 ;;^UTILITY(U,$J,358.3,25755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25755,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,25755,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,25755,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,25756,0)
 ;;=F10.232^^97^1220^36
 ;;^UTILITY(U,$J,358.3,25756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25756,1,3,0)
 ;;=3^Alcohol Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,25756,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,25756,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,25757,0)
 ;;=F12.10^^97^1221^19
 ;;^UTILITY(U,$J,358.3,25757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25757,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,25757,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,25757,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,25758,0)
 ;;=F12.20^^97^1221^20
 ;;^UTILITY(U,$J,358.3,25758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25758,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,25758,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,25758,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,25759,0)
 ;;=F12.288^^97^1221^22
 ;;^UTILITY(U,$J,358.3,25759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25759,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,25759,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,25759,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,25760,0)
 ;;=F12.121^^97^1221^10
 ;;^UTILITY(U,$J,358.3,25760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25760,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25760,1,4,0)
 ;;=4^F12.121
 ;;^UTILITY(U,$J,358.3,25760,2)
 ;;=^5003157
 ;;^UTILITY(U,$J,358.3,25761,0)
 ;;=F12.221^^97^1221^11
 ;;^UTILITY(U,$J,358.3,25761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25761,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25761,1,4,0)
 ;;=4^F12.221
 ;;^UTILITY(U,$J,358.3,25761,2)
 ;;=^5003169
 ;;^UTILITY(U,$J,358.3,25762,0)
 ;;=F12.921^^97^1221^12
 ;;^UTILITY(U,$J,358.3,25762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25762,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25762,1,4,0)
 ;;=4^F12.921
 ;;^UTILITY(U,$J,358.3,25762,2)
 ;;=^5003180
 ;;^UTILITY(U,$J,358.3,25763,0)
 ;;=F12.229^^97^1221^16
 ;;^UTILITY(U,$J,358.3,25763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25763,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25763,1,4,0)
 ;;=4^F12.229
 ;;^UTILITY(U,$J,358.3,25763,2)
 ;;=^5003171
 ;;^UTILITY(U,$J,358.3,25764,0)
 ;;=F12.122^^97^1221^13
 ;;^UTILITY(U,$J,358.3,25764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25764,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25764,1,4,0)
 ;;=4^F12.122
 ;;^UTILITY(U,$J,358.3,25764,2)
 ;;=^5003158
 ;;^UTILITY(U,$J,358.3,25765,0)
 ;;=F12.222^^97^1221^14
 ;;^UTILITY(U,$J,358.3,25765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25765,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25765,1,4,0)
 ;;=4^F12.222
 ;;^UTILITY(U,$J,358.3,25765,2)
 ;;=^5003170
 ;;^UTILITY(U,$J,358.3,25766,0)
 ;;=F12.922^^97^1221^15
 ;;^UTILITY(U,$J,358.3,25766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25766,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25766,1,4,0)
 ;;=4^F12.922
 ;;^UTILITY(U,$J,358.3,25766,2)
 ;;=^5003181
 ;;^UTILITY(U,$J,358.3,25767,0)
 ;;=F12.980^^97^1221^3
 ;;^UTILITY(U,$J,358.3,25767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25767,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25767,1,4,0)
 ;;=4^F12.980
 ;;^UTILITY(U,$J,358.3,25767,2)
 ;;=^5003186
 ;;^UTILITY(U,$J,358.3,25768,0)
 ;;=F12.159^^97^1221^4
 ;;^UTILITY(U,$J,358.3,25768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25768,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25768,1,4,0)
 ;;=4^F12.159
 ;;^UTILITY(U,$J,358.3,25768,2)
 ;;=^5003162
 ;;^UTILITY(U,$J,358.3,25769,0)
 ;;=F12.259^^97^1221^5
 ;;^UTILITY(U,$J,358.3,25769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25769,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25769,1,4,0)
 ;;=4^F12.259
 ;;^UTILITY(U,$J,358.3,25769,2)
 ;;=^5003174
 ;;^UTILITY(U,$J,358.3,25770,0)
 ;;=F12.959^^97^1221^6
 ;;^UTILITY(U,$J,358.3,25770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25770,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25770,1,4,0)
 ;;=4^F12.959
 ;;^UTILITY(U,$J,358.3,25770,2)
 ;;=^5003185
 ;;^UTILITY(U,$J,358.3,25771,0)
 ;;=F12.988^^97^1221^9
 ;;^UTILITY(U,$J,358.3,25771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25771,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25771,1,4,0)
 ;;=4^F12.988
 ;;^UTILITY(U,$J,358.3,25771,2)
 ;;=^5003187
 ;;^UTILITY(U,$J,358.3,25772,0)
 ;;=F12.929^^97^1221^17
 ;;^UTILITY(U,$J,358.3,25772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25772,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25772,1,4,0)
 ;;=4^F12.929
 ;;^UTILITY(U,$J,358.3,25772,2)
 ;;=^5003182
