IBDEI0UH ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40071,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,40071,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,40072,0)
 ;;=F12.288^^114^1692^22
 ;;^UTILITY(U,$J,358.3,40072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40072,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,40072,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,40072,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,40073,0)
 ;;=F12.121^^114^1692^10
 ;;^UTILITY(U,$J,358.3,40073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40073,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40073,1,4,0)
 ;;=4^F12.121
 ;;^UTILITY(U,$J,358.3,40073,2)
 ;;=^5003157
 ;;^UTILITY(U,$J,358.3,40074,0)
 ;;=F12.221^^114^1692^11
 ;;^UTILITY(U,$J,358.3,40074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40074,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40074,1,4,0)
 ;;=4^F12.221
 ;;^UTILITY(U,$J,358.3,40074,2)
 ;;=^5003169
 ;;^UTILITY(U,$J,358.3,40075,0)
 ;;=F12.921^^114^1692^12
 ;;^UTILITY(U,$J,358.3,40075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40075,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40075,1,4,0)
 ;;=4^F12.921
 ;;^UTILITY(U,$J,358.3,40075,2)
 ;;=^5003180
 ;;^UTILITY(U,$J,358.3,40076,0)
 ;;=F12.229^^114^1692^16
 ;;^UTILITY(U,$J,358.3,40076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40076,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40076,1,4,0)
 ;;=4^F12.229
 ;;^UTILITY(U,$J,358.3,40076,2)
 ;;=^5003171
 ;;^UTILITY(U,$J,358.3,40077,0)
 ;;=F12.122^^114^1692^13
 ;;^UTILITY(U,$J,358.3,40077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40077,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40077,1,4,0)
 ;;=4^F12.122
 ;;^UTILITY(U,$J,358.3,40077,2)
 ;;=^5003158
 ;;^UTILITY(U,$J,358.3,40078,0)
 ;;=F12.222^^114^1692^14
 ;;^UTILITY(U,$J,358.3,40078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40078,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40078,1,4,0)
 ;;=4^F12.222
 ;;^UTILITY(U,$J,358.3,40078,2)
 ;;=^5003170
 ;;^UTILITY(U,$J,358.3,40079,0)
 ;;=F12.922^^114^1692^15
 ;;^UTILITY(U,$J,358.3,40079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40079,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40079,1,4,0)
 ;;=4^F12.922
 ;;^UTILITY(U,$J,358.3,40079,2)
 ;;=^5003181
 ;;^UTILITY(U,$J,358.3,40080,0)
 ;;=F12.980^^114^1692^3
 ;;^UTILITY(U,$J,358.3,40080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40080,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40080,1,4,0)
 ;;=4^F12.980
 ;;^UTILITY(U,$J,358.3,40080,2)
 ;;=^5003186
 ;;^UTILITY(U,$J,358.3,40081,0)
 ;;=F12.159^^114^1692^4
 ;;^UTILITY(U,$J,358.3,40081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40081,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40081,1,4,0)
 ;;=4^F12.159
 ;;^UTILITY(U,$J,358.3,40081,2)
 ;;=^5003162
 ;;^UTILITY(U,$J,358.3,40082,0)
 ;;=F12.259^^114^1692^5
 ;;^UTILITY(U,$J,358.3,40082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40082,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40082,1,4,0)
 ;;=4^F12.259
 ;;^UTILITY(U,$J,358.3,40082,2)
 ;;=^5003174
 ;;^UTILITY(U,$J,358.3,40083,0)
 ;;=F12.959^^114^1692^6
 ;;^UTILITY(U,$J,358.3,40083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40083,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40083,1,4,0)
 ;;=4^F12.959
 ;;^UTILITY(U,$J,358.3,40083,2)
 ;;=^5003185
 ;;^UTILITY(U,$J,358.3,40084,0)
 ;;=F12.988^^114^1692^9
 ;;^UTILITY(U,$J,358.3,40084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40084,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40084,1,4,0)
 ;;=4^F12.988
 ;;^UTILITY(U,$J,358.3,40084,2)
 ;;=^5003187
 ;;^UTILITY(U,$J,358.3,40085,0)
 ;;=F12.929^^114^1692^17
 ;;^UTILITY(U,$J,358.3,40085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40085,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40085,1,4,0)
 ;;=4^F12.929
 ;;^UTILITY(U,$J,358.3,40085,2)
 ;;=^5003182
 ;;^UTILITY(U,$J,358.3,40086,0)
 ;;=F12.180^^114^1692^1
 ;;^UTILITY(U,$J,358.3,40086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40086,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40086,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,40086,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,40087,0)
 ;;=F12.280^^114^1692^2
 ;;^UTILITY(U,$J,358.3,40087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40087,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40087,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,40087,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,40088,0)
 ;;=F12.188^^114^1692^7
 ;;^UTILITY(U,$J,358.3,40088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40088,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40088,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,40088,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,40089,0)
 ;;=F12.288^^114^1692^8
 ;;^UTILITY(U,$J,358.3,40089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40089,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40089,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,40089,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,40090,0)
 ;;=F12.20^^114^1692^21
 ;;^UTILITY(U,$J,358.3,40090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40090,1,3,0)
 ;;=3^Cannabis Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,40090,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,40090,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,40091,0)
 ;;=F12.99^^114^1692^18
 ;;^UTILITY(U,$J,358.3,40091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40091,1,3,0)
 ;;=3^Cannabis Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,40091,1,4,0)
 ;;=4^F12.99
 ;;^UTILITY(U,$J,358.3,40091,2)
 ;;=^5003188
 ;;^UTILITY(U,$J,358.3,40092,0)
 ;;=F16.10^^114^1693^35
 ;;^UTILITY(U,$J,358.3,40092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40092,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,40092,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,40092,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,40093,0)
 ;;=F16.20^^114^1693^36
 ;;^UTILITY(U,$J,358.3,40093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40093,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,40093,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,40093,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,40094,0)
 ;;=F16.121^^114^1693^10
 ;;^UTILITY(U,$J,358.3,40094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40094,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40094,1,4,0)
 ;;=4^F16.121
 ;;^UTILITY(U,$J,358.3,40094,2)
 ;;=^5003325
 ;;^UTILITY(U,$J,358.3,40095,0)
 ;;=F16.221^^114^1693^11
 ;;^UTILITY(U,$J,358.3,40095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40095,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40095,1,4,0)
 ;;=4^F16.221
 ;;^UTILITY(U,$J,358.3,40095,2)
 ;;=^5003339
 ;;^UTILITY(U,$J,358.3,40096,0)
 ;;=F16.921^^114^1693^12
 ;;^UTILITY(U,$J,358.3,40096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40096,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40096,1,4,0)
 ;;=4^F16.921
 ;;^UTILITY(U,$J,358.3,40096,2)
 ;;=^5003351
 ;;^UTILITY(U,$J,358.3,40097,0)
 ;;=F16.129^^114^1693^13
 ;;^UTILITY(U,$J,358.3,40097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40097,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40097,1,4,0)
 ;;=4^F16.129
 ;;^UTILITY(U,$J,358.3,40097,2)
 ;;=^5003327
 ;;^UTILITY(U,$J,358.3,40098,0)
 ;;=F16.229^^114^1693^14
 ;;^UTILITY(U,$J,358.3,40098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40098,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40098,1,4,0)
 ;;=4^F16.229
 ;;^UTILITY(U,$J,358.3,40098,2)
 ;;=^5003340
 ;;^UTILITY(U,$J,358.3,40099,0)
 ;;=F16.929^^114^1693^15
 ;;^UTILITY(U,$J,358.3,40099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40099,1,3,0)
 ;;=3^Hallucinogen Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40099,1,4,0)
 ;;=4^F16.929
 ;;^UTILITY(U,$J,358.3,40099,2)
 ;;=^5003352
 ;;^UTILITY(U,$J,358.3,40100,0)
 ;;=F16.180^^114^1693^1
 ;;^UTILITY(U,$J,358.3,40100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40100,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40100,1,4,0)
 ;;=4^F16.180
 ;;^UTILITY(U,$J,358.3,40100,2)
 ;;=^5003332
 ;;^UTILITY(U,$J,358.3,40101,0)
 ;;=F16.280^^114^1693^2
 ;;^UTILITY(U,$J,358.3,40101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40101,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40101,1,4,0)
 ;;=4^F16.280
 ;;^UTILITY(U,$J,358.3,40101,2)
 ;;=^5003345
 ;;^UTILITY(U,$J,358.3,40102,0)
 ;;=F16.980^^114^1693^3
 ;;^UTILITY(U,$J,358.3,40102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40102,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40102,1,4,0)
 ;;=4^F16.980
 ;;^UTILITY(U,$J,358.3,40102,2)
 ;;=^5003357
 ;;^UTILITY(U,$J,358.3,40103,0)
 ;;=F16.14^^114^1693^4
 ;;^UTILITY(U,$J,358.3,40103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40103,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40103,1,4,0)
 ;;=4^F16.14
 ;;^UTILITY(U,$J,358.3,40103,2)
 ;;=^5003328
 ;;^UTILITY(U,$J,358.3,40104,0)
 ;;=F16.24^^114^1693^5
 ;;^UTILITY(U,$J,358.3,40104,1,0)
 ;;=^358.31IA^4^2
