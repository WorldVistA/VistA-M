IBDEI00U ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,531,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,532,0)
 ;;=F12.288^^3^47^22
 ;;^UTILITY(U,$J,358.3,532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,532,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,532,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,532,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,533,0)
 ;;=F12.121^^3^47^10
 ;;^UTILITY(U,$J,358.3,533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,533,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,533,1,4,0)
 ;;=4^F12.121
 ;;^UTILITY(U,$J,358.3,533,2)
 ;;=^5003157
 ;;^UTILITY(U,$J,358.3,534,0)
 ;;=F12.221^^3^47^11
 ;;^UTILITY(U,$J,358.3,534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,534,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,534,1,4,0)
 ;;=4^F12.221
 ;;^UTILITY(U,$J,358.3,534,2)
 ;;=^5003169
 ;;^UTILITY(U,$J,358.3,535,0)
 ;;=F12.921^^3^47^12
 ;;^UTILITY(U,$J,358.3,535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,535,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,535,1,4,0)
 ;;=4^F12.921
 ;;^UTILITY(U,$J,358.3,535,2)
 ;;=^5003180
 ;;^UTILITY(U,$J,358.3,536,0)
 ;;=F12.229^^3^47^16
 ;;^UTILITY(U,$J,358.3,536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,536,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,536,1,4,0)
 ;;=4^F12.229
 ;;^UTILITY(U,$J,358.3,536,2)
 ;;=^5003171
 ;;^UTILITY(U,$J,358.3,537,0)
 ;;=F12.122^^3^47^13
 ;;^UTILITY(U,$J,358.3,537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,537,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,537,1,4,0)
 ;;=4^F12.122
 ;;^UTILITY(U,$J,358.3,537,2)
 ;;=^5003158
 ;;^UTILITY(U,$J,358.3,538,0)
 ;;=F12.222^^3^47^14
 ;;^UTILITY(U,$J,358.3,538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,538,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,538,1,4,0)
 ;;=4^F12.222
 ;;^UTILITY(U,$J,358.3,538,2)
 ;;=^5003170
 ;;^UTILITY(U,$J,358.3,539,0)
 ;;=F12.922^^3^47^15
 ;;^UTILITY(U,$J,358.3,539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,539,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,539,1,4,0)
 ;;=4^F12.922
 ;;^UTILITY(U,$J,358.3,539,2)
 ;;=^5003181
 ;;^UTILITY(U,$J,358.3,540,0)
 ;;=F12.980^^3^47^3
 ;;^UTILITY(U,$J,358.3,540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,540,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,540,1,4,0)
 ;;=4^F12.980
 ;;^UTILITY(U,$J,358.3,540,2)
 ;;=^5003186
 ;;^UTILITY(U,$J,358.3,541,0)
 ;;=F12.159^^3^47^4
 ;;^UTILITY(U,$J,358.3,541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,541,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,541,1,4,0)
 ;;=4^F12.159
 ;;^UTILITY(U,$J,358.3,541,2)
 ;;=^5003162
 ;;^UTILITY(U,$J,358.3,542,0)
 ;;=F12.259^^3^47^5
 ;;^UTILITY(U,$J,358.3,542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,542,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,542,1,4,0)
 ;;=4^F12.259
 ;;^UTILITY(U,$J,358.3,542,2)
 ;;=^5003174
 ;;^UTILITY(U,$J,358.3,543,0)
 ;;=F12.959^^3^47^6
 ;;^UTILITY(U,$J,358.3,543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,543,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,543,1,4,0)
 ;;=4^F12.959
 ;;^UTILITY(U,$J,358.3,543,2)
 ;;=^5003185
 ;;^UTILITY(U,$J,358.3,544,0)
 ;;=F12.988^^3^47^9
 ;;^UTILITY(U,$J,358.3,544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,544,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,544,1,4,0)
 ;;=4^F12.988
 ;;^UTILITY(U,$J,358.3,544,2)
 ;;=^5003187
 ;;^UTILITY(U,$J,358.3,545,0)
 ;;=F12.929^^3^47^17
 ;;^UTILITY(U,$J,358.3,545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,545,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,545,1,4,0)
 ;;=4^F12.929
 ;;^UTILITY(U,$J,358.3,545,2)
 ;;=^5003182
 ;;^UTILITY(U,$J,358.3,546,0)
 ;;=F12.180^^3^47^1
 ;;^UTILITY(U,$J,358.3,546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,546,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,546,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,546,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,547,0)
 ;;=F12.280^^3^47^2
 ;;^UTILITY(U,$J,358.3,547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,547,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,547,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,547,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,548,0)
 ;;=F12.188^^3^47^7
 ;;^UTILITY(U,$J,358.3,548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,548,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,548,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,548,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,549,0)
 ;;=F12.288^^3^47^8
 ;;^UTILITY(U,$J,358.3,549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,549,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,549,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,549,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,550,0)
 ;;=F12.20^^3^47^21
 ;;^UTILITY(U,$J,358.3,550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,550,1,3,0)
 ;;=3^Cannabis Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,550,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,550,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,551,0)
 ;;=F12.99^^3^47^18
 ;;^UTILITY(U,$J,358.3,551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,551,1,3,0)
 ;;=3^Cannabis Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,551,1,4,0)
 ;;=4^F12.99
 ;;^UTILITY(U,$J,358.3,551,2)
 ;;=^5003188
 ;;^UTILITY(U,$J,358.3,552,0)
 ;;=F16.10^^3^48^35
 ;;^UTILITY(U,$J,358.3,552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,552,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,552,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,552,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,553,0)
 ;;=F16.20^^3^48^36
 ;;^UTILITY(U,$J,358.3,553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,553,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,553,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,553,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,554,0)
 ;;=F16.121^^3^48^10
 ;;^UTILITY(U,$J,358.3,554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,554,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,554,1,4,0)
 ;;=4^F16.121
 ;;^UTILITY(U,$J,358.3,554,2)
 ;;=^5003325
 ;;^UTILITY(U,$J,358.3,555,0)
 ;;=F16.221^^3^48^11
 ;;^UTILITY(U,$J,358.3,555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,555,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,555,1,4,0)
 ;;=4^F16.221
 ;;^UTILITY(U,$J,358.3,555,2)
 ;;=^5003339
 ;;^UTILITY(U,$J,358.3,556,0)
 ;;=F16.921^^3^48^12
 ;;^UTILITY(U,$J,358.3,556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,556,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,556,1,4,0)
 ;;=4^F16.921
 ;;^UTILITY(U,$J,358.3,556,2)
 ;;=^5003351
 ;;^UTILITY(U,$J,358.3,557,0)
 ;;=F16.129^^3^48^13
 ;;^UTILITY(U,$J,358.3,557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,557,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,557,1,4,0)
 ;;=4^F16.129
 ;;^UTILITY(U,$J,358.3,557,2)
 ;;=^5003327
 ;;^UTILITY(U,$J,358.3,558,0)
 ;;=F16.229^^3^48^14
 ;;^UTILITY(U,$J,358.3,558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,558,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,558,1,4,0)
 ;;=4^F16.229
 ;;^UTILITY(U,$J,358.3,558,2)
 ;;=^5003340
 ;;^UTILITY(U,$J,358.3,559,0)
 ;;=F16.929^^3^48^15
 ;;^UTILITY(U,$J,358.3,559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,559,1,3,0)
 ;;=3^Hallucinogen Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,559,1,4,0)
 ;;=4^F16.929
 ;;^UTILITY(U,$J,358.3,559,2)
 ;;=^5003352
 ;;^UTILITY(U,$J,358.3,560,0)
 ;;=F16.180^^3^48^1
 ;;^UTILITY(U,$J,358.3,560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,560,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,560,1,4,0)
 ;;=4^F16.180
 ;;^UTILITY(U,$J,358.3,560,2)
 ;;=^5003332
 ;;^UTILITY(U,$J,358.3,561,0)
 ;;=F16.280^^3^48^2
 ;;^UTILITY(U,$J,358.3,561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,561,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,561,1,4,0)
 ;;=4^F16.280
 ;;^UTILITY(U,$J,358.3,561,2)
 ;;=^5003345
 ;;^UTILITY(U,$J,358.3,562,0)
 ;;=F16.980^^3^48^3
 ;;^UTILITY(U,$J,358.3,562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,562,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,562,1,4,0)
 ;;=4^F16.980
 ;;^UTILITY(U,$J,358.3,562,2)
 ;;=^5003357
 ;;^UTILITY(U,$J,358.3,563,0)
 ;;=F16.14^^3^48^4
 ;;^UTILITY(U,$J,358.3,563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,563,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,563,1,4,0)
 ;;=4^F16.14
 ;;^UTILITY(U,$J,358.3,563,2)
 ;;=^5003328
 ;;^UTILITY(U,$J,358.3,564,0)
 ;;=F16.24^^3^48^5
 ;;^UTILITY(U,$J,358.3,564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,564,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,564,1,4,0)
 ;;=4^F16.24
 ;;^UTILITY(U,$J,358.3,564,2)
 ;;=^5003341
 ;;^UTILITY(U,$J,358.3,565,0)
 ;;=F16.94^^3^48^6
 ;;^UTILITY(U,$J,358.3,565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,565,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,565,1,4,0)
 ;;=4^F16.94
 ;;^UTILITY(U,$J,358.3,565,2)
 ;;=^5003353
 ;;^UTILITY(U,$J,358.3,566,0)
 ;;=F16.159^^3^48^7
