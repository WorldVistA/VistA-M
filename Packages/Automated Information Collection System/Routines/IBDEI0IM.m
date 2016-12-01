IBDEI0IM ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23616,2)
 ;;=^5003171
 ;;^UTILITY(U,$J,358.3,23617,0)
 ;;=F12.122^^61^919^13
 ;;^UTILITY(U,$J,358.3,23617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23617,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23617,1,4,0)
 ;;=4^F12.122
 ;;^UTILITY(U,$J,358.3,23617,2)
 ;;=^5003158
 ;;^UTILITY(U,$J,358.3,23618,0)
 ;;=F12.222^^61^919^14
 ;;^UTILITY(U,$J,358.3,23618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23618,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23618,1,4,0)
 ;;=4^F12.222
 ;;^UTILITY(U,$J,358.3,23618,2)
 ;;=^5003170
 ;;^UTILITY(U,$J,358.3,23619,0)
 ;;=F12.922^^61^919^15
 ;;^UTILITY(U,$J,358.3,23619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23619,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23619,1,4,0)
 ;;=4^F12.922
 ;;^UTILITY(U,$J,358.3,23619,2)
 ;;=^5003181
 ;;^UTILITY(U,$J,358.3,23620,0)
 ;;=F12.980^^61^919^3
 ;;^UTILITY(U,$J,358.3,23620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23620,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23620,1,4,0)
 ;;=4^F12.980
 ;;^UTILITY(U,$J,358.3,23620,2)
 ;;=^5003186
 ;;^UTILITY(U,$J,358.3,23621,0)
 ;;=F12.159^^61^919^4
 ;;^UTILITY(U,$J,358.3,23621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23621,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23621,1,4,0)
 ;;=4^F12.159
 ;;^UTILITY(U,$J,358.3,23621,2)
 ;;=^5003162
 ;;^UTILITY(U,$J,358.3,23622,0)
 ;;=F12.259^^61^919^5
 ;;^UTILITY(U,$J,358.3,23622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23622,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23622,1,4,0)
 ;;=4^F12.259
 ;;^UTILITY(U,$J,358.3,23622,2)
 ;;=^5003174
 ;;^UTILITY(U,$J,358.3,23623,0)
 ;;=F12.959^^61^919^6
 ;;^UTILITY(U,$J,358.3,23623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23623,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23623,1,4,0)
 ;;=4^F12.959
 ;;^UTILITY(U,$J,358.3,23623,2)
 ;;=^5003185
 ;;^UTILITY(U,$J,358.3,23624,0)
 ;;=F12.988^^61^919^9
 ;;^UTILITY(U,$J,358.3,23624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23624,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23624,1,4,0)
 ;;=4^F12.988
 ;;^UTILITY(U,$J,358.3,23624,2)
 ;;=^5003187
 ;;^UTILITY(U,$J,358.3,23625,0)
 ;;=F12.929^^61^919^17
 ;;^UTILITY(U,$J,358.3,23625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23625,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23625,1,4,0)
 ;;=4^F12.929
 ;;^UTILITY(U,$J,358.3,23625,2)
 ;;=^5003182
 ;;^UTILITY(U,$J,358.3,23626,0)
 ;;=F12.180^^61^919^1
 ;;^UTILITY(U,$J,358.3,23626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23626,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23626,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,23626,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,23627,0)
 ;;=F12.280^^61^919^2
 ;;^UTILITY(U,$J,358.3,23627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23627,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23627,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,23627,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,23628,0)
 ;;=F12.188^^61^919^7
 ;;^UTILITY(U,$J,358.3,23628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23628,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23628,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,23628,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,23629,0)
 ;;=F12.288^^61^919^8
 ;;^UTILITY(U,$J,358.3,23629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23629,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23629,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,23629,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,23630,0)
 ;;=F12.20^^61^919^21
 ;;^UTILITY(U,$J,358.3,23630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23630,1,3,0)
 ;;=3^Cannabis Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,23630,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,23630,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,23631,0)
 ;;=F12.99^^61^919^18
 ;;^UTILITY(U,$J,358.3,23631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23631,1,3,0)
 ;;=3^Cannabis Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,23631,1,4,0)
 ;;=4^F12.99
 ;;^UTILITY(U,$J,358.3,23631,2)
 ;;=^5003188
 ;;^UTILITY(U,$J,358.3,23632,0)
 ;;=F16.10^^61^920^35
 ;;^UTILITY(U,$J,358.3,23632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23632,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,23632,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,23632,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,23633,0)
 ;;=F16.20^^61^920^36
 ;;^UTILITY(U,$J,358.3,23633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23633,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,23633,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,23633,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,23634,0)
 ;;=F16.121^^61^920^10
 ;;^UTILITY(U,$J,358.3,23634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23634,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23634,1,4,0)
 ;;=4^F16.121
 ;;^UTILITY(U,$J,358.3,23634,2)
 ;;=^5003325
 ;;^UTILITY(U,$J,358.3,23635,0)
 ;;=F16.221^^61^920^11
 ;;^UTILITY(U,$J,358.3,23635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23635,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23635,1,4,0)
 ;;=4^F16.221
 ;;^UTILITY(U,$J,358.3,23635,2)
 ;;=^5003339
 ;;^UTILITY(U,$J,358.3,23636,0)
 ;;=F16.921^^61^920^12
 ;;^UTILITY(U,$J,358.3,23636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23636,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23636,1,4,0)
 ;;=4^F16.921
 ;;^UTILITY(U,$J,358.3,23636,2)
 ;;=^5003351
 ;;^UTILITY(U,$J,358.3,23637,0)
 ;;=F16.129^^61^920^13
 ;;^UTILITY(U,$J,358.3,23637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23637,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23637,1,4,0)
 ;;=4^F16.129
 ;;^UTILITY(U,$J,358.3,23637,2)
 ;;=^5003327
 ;;^UTILITY(U,$J,358.3,23638,0)
 ;;=F16.229^^61^920^14
 ;;^UTILITY(U,$J,358.3,23638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23638,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23638,1,4,0)
 ;;=4^F16.229
 ;;^UTILITY(U,$J,358.3,23638,2)
 ;;=^5003340
 ;;^UTILITY(U,$J,358.3,23639,0)
 ;;=F16.929^^61^920^15
 ;;^UTILITY(U,$J,358.3,23639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23639,1,3,0)
 ;;=3^Hallucinogen Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23639,1,4,0)
 ;;=4^F16.929
 ;;^UTILITY(U,$J,358.3,23639,2)
 ;;=^5003352
 ;;^UTILITY(U,$J,358.3,23640,0)
 ;;=F16.180^^61^920^1
 ;;^UTILITY(U,$J,358.3,23640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23640,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23640,1,4,0)
 ;;=4^F16.180
 ;;^UTILITY(U,$J,358.3,23640,2)
 ;;=^5003332
 ;;^UTILITY(U,$J,358.3,23641,0)
 ;;=F16.280^^61^920^2
 ;;^UTILITY(U,$J,358.3,23641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23641,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23641,1,4,0)
 ;;=4^F16.280
 ;;^UTILITY(U,$J,358.3,23641,2)
 ;;=^5003345
 ;;^UTILITY(U,$J,358.3,23642,0)
 ;;=F16.980^^61^920^3
 ;;^UTILITY(U,$J,358.3,23642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23642,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23642,1,4,0)
 ;;=4^F16.980
 ;;^UTILITY(U,$J,358.3,23642,2)
 ;;=^5003357
 ;;^UTILITY(U,$J,358.3,23643,0)
 ;;=F16.14^^61^920^4
 ;;^UTILITY(U,$J,358.3,23643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23643,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23643,1,4,0)
 ;;=4^F16.14
 ;;^UTILITY(U,$J,358.3,23643,2)
 ;;=^5003328
 ;;^UTILITY(U,$J,358.3,23644,0)
 ;;=F16.24^^61^920^5
 ;;^UTILITY(U,$J,358.3,23644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23644,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23644,1,4,0)
 ;;=4^F16.24
 ;;^UTILITY(U,$J,358.3,23644,2)
 ;;=^5003341
 ;;^UTILITY(U,$J,358.3,23645,0)
 ;;=F16.94^^61^920^6
 ;;^UTILITY(U,$J,358.3,23645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23645,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23645,1,4,0)
 ;;=4^F16.94
 ;;^UTILITY(U,$J,358.3,23645,2)
 ;;=^5003353
 ;;^UTILITY(U,$J,358.3,23646,0)
 ;;=F16.159^^61^920^7
 ;;^UTILITY(U,$J,358.3,23646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23646,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23646,1,4,0)
 ;;=4^F16.159
 ;;^UTILITY(U,$J,358.3,23646,2)
 ;;=^5003331
 ;;^UTILITY(U,$J,358.3,23647,0)
 ;;=F16.259^^61^920^8
 ;;^UTILITY(U,$J,358.3,23647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23647,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23647,1,4,0)
 ;;=4^F16.259
 ;;^UTILITY(U,$J,358.3,23647,2)
 ;;=^5003344
 ;;^UTILITY(U,$J,358.3,23648,0)
 ;;=F16.959^^61^920^9
 ;;^UTILITY(U,$J,358.3,23648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23648,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23648,1,4,0)
 ;;=4^F16.959
 ;;^UTILITY(U,$J,358.3,23648,2)
 ;;=^5003356
 ;;^UTILITY(U,$J,358.3,23649,0)
 ;;=F16.99^^61^920^38
 ;;^UTILITY(U,$J,358.3,23649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23649,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Unspec
