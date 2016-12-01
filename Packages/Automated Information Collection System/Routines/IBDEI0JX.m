IBDEI0JX ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25224,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,25224,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,25225,0)
 ;;=F12.20^^66^1017^21
 ;;^UTILITY(U,$J,358.3,25225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25225,1,3,0)
 ;;=3^Cannabis Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,25225,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,25225,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,25226,0)
 ;;=F12.99^^66^1017^18
 ;;^UTILITY(U,$J,358.3,25226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25226,1,3,0)
 ;;=3^Cannabis Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25226,1,4,0)
 ;;=4^F12.99
 ;;^UTILITY(U,$J,358.3,25226,2)
 ;;=^5003188
 ;;^UTILITY(U,$J,358.3,25227,0)
 ;;=F16.10^^66^1018^35
 ;;^UTILITY(U,$J,358.3,25227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25227,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,25227,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,25227,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,25228,0)
 ;;=F16.20^^66^1018^36
 ;;^UTILITY(U,$J,358.3,25228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25228,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,25228,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,25228,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,25229,0)
 ;;=F16.121^^66^1018^10
 ;;^UTILITY(U,$J,358.3,25229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25229,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25229,1,4,0)
 ;;=4^F16.121
 ;;^UTILITY(U,$J,358.3,25229,2)
 ;;=^5003325
 ;;^UTILITY(U,$J,358.3,25230,0)
 ;;=F16.221^^66^1018^11
 ;;^UTILITY(U,$J,358.3,25230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25230,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25230,1,4,0)
 ;;=4^F16.221
 ;;^UTILITY(U,$J,358.3,25230,2)
 ;;=^5003339
 ;;^UTILITY(U,$J,358.3,25231,0)
 ;;=F16.921^^66^1018^12
 ;;^UTILITY(U,$J,358.3,25231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25231,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25231,1,4,0)
 ;;=4^F16.921
 ;;^UTILITY(U,$J,358.3,25231,2)
 ;;=^5003351
 ;;^UTILITY(U,$J,358.3,25232,0)
 ;;=F16.129^^66^1018^13
 ;;^UTILITY(U,$J,358.3,25232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25232,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25232,1,4,0)
 ;;=4^F16.129
 ;;^UTILITY(U,$J,358.3,25232,2)
 ;;=^5003327
 ;;^UTILITY(U,$J,358.3,25233,0)
 ;;=F16.229^^66^1018^14
 ;;^UTILITY(U,$J,358.3,25233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25233,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25233,1,4,0)
 ;;=4^F16.229
 ;;^UTILITY(U,$J,358.3,25233,2)
 ;;=^5003340
 ;;^UTILITY(U,$J,358.3,25234,0)
 ;;=F16.929^^66^1018^15
 ;;^UTILITY(U,$J,358.3,25234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25234,1,3,0)
 ;;=3^Hallucinogen Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25234,1,4,0)
 ;;=4^F16.929
 ;;^UTILITY(U,$J,358.3,25234,2)
 ;;=^5003352
 ;;^UTILITY(U,$J,358.3,25235,0)
 ;;=F16.180^^66^1018^1
 ;;^UTILITY(U,$J,358.3,25235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25235,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25235,1,4,0)
 ;;=4^F16.180
 ;;^UTILITY(U,$J,358.3,25235,2)
 ;;=^5003332
 ;;^UTILITY(U,$J,358.3,25236,0)
 ;;=F16.280^^66^1018^2
 ;;^UTILITY(U,$J,358.3,25236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25236,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25236,1,4,0)
 ;;=4^F16.280
 ;;^UTILITY(U,$J,358.3,25236,2)
 ;;=^5003345
 ;;^UTILITY(U,$J,358.3,25237,0)
 ;;=F16.980^^66^1018^3
 ;;^UTILITY(U,$J,358.3,25237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25237,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25237,1,4,0)
 ;;=4^F16.980
 ;;^UTILITY(U,$J,358.3,25237,2)
 ;;=^5003357
 ;;^UTILITY(U,$J,358.3,25238,0)
 ;;=F16.14^^66^1018^4
 ;;^UTILITY(U,$J,358.3,25238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25238,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25238,1,4,0)
 ;;=4^F16.14
 ;;^UTILITY(U,$J,358.3,25238,2)
 ;;=^5003328
 ;;^UTILITY(U,$J,358.3,25239,0)
 ;;=F16.24^^66^1018^5
 ;;^UTILITY(U,$J,358.3,25239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25239,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25239,1,4,0)
 ;;=4^F16.24
 ;;^UTILITY(U,$J,358.3,25239,2)
 ;;=^5003341
 ;;^UTILITY(U,$J,358.3,25240,0)
 ;;=F16.94^^66^1018^6
 ;;^UTILITY(U,$J,358.3,25240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25240,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25240,1,4,0)
 ;;=4^F16.94
 ;;^UTILITY(U,$J,358.3,25240,2)
 ;;=^5003353
 ;;^UTILITY(U,$J,358.3,25241,0)
 ;;=F16.159^^66^1018^7
 ;;^UTILITY(U,$J,358.3,25241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25241,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25241,1,4,0)
 ;;=4^F16.159
 ;;^UTILITY(U,$J,358.3,25241,2)
 ;;=^5003331
 ;;^UTILITY(U,$J,358.3,25242,0)
 ;;=F16.259^^66^1018^8
 ;;^UTILITY(U,$J,358.3,25242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25242,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25242,1,4,0)
 ;;=4^F16.259
 ;;^UTILITY(U,$J,358.3,25242,2)
 ;;=^5003344
 ;;^UTILITY(U,$J,358.3,25243,0)
 ;;=F16.959^^66^1018^9
 ;;^UTILITY(U,$J,358.3,25243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25243,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25243,1,4,0)
 ;;=4^F16.959
 ;;^UTILITY(U,$J,358.3,25243,2)
 ;;=^5003356
 ;;^UTILITY(U,$J,358.3,25244,0)
 ;;=F16.99^^66^1018^38
 ;;^UTILITY(U,$J,358.3,25244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25244,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25244,1,4,0)
 ;;=4^F16.99
 ;;^UTILITY(U,$J,358.3,25244,2)
 ;;=^5133359
 ;;^UTILITY(U,$J,358.3,25245,0)
 ;;=F16.983^^66^1018^16
 ;;^UTILITY(U,$J,358.3,25245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25245,1,3,0)
 ;;=3^Hallucinogen Persisting Perception Disorder
 ;;^UTILITY(U,$J,358.3,25245,1,4,0)
 ;;=4^F16.983
 ;;^UTILITY(U,$J,358.3,25245,2)
 ;;=^5003358
 ;;^UTILITY(U,$J,358.3,25246,0)
 ;;=F16.20^^66^1018^37
 ;;^UTILITY(U,$J,358.3,25246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25246,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,25246,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,25246,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,25247,0)
 ;;=F16.180^^66^1018^17
 ;;^UTILITY(U,$J,358.3,25247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25247,1,3,0)
 ;;=3^Phencyclidine Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25247,1,4,0)
 ;;=4^F16.180
 ;;^UTILITY(U,$J,358.3,25247,2)
 ;;=^5003332
 ;;^UTILITY(U,$J,358.3,25248,0)
 ;;=F16.280^^66^1018^18
 ;;^UTILITY(U,$J,358.3,25248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25248,1,3,0)
 ;;=3^Phencyclidine Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25248,1,4,0)
 ;;=4^F16.280
 ;;^UTILITY(U,$J,358.3,25248,2)
 ;;=^5003345
 ;;^UTILITY(U,$J,358.3,25249,0)
 ;;=F16.980^^66^1018^19
 ;;^UTILITY(U,$J,358.3,25249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25249,1,3,0)
 ;;=3^Phencyclidine Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25249,1,4,0)
 ;;=4^F16.980
 ;;^UTILITY(U,$J,358.3,25249,2)
 ;;=^5003357
 ;;^UTILITY(U,$J,358.3,25250,0)
 ;;=F16.14^^66^1018^20
 ;;^UTILITY(U,$J,358.3,25250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25250,1,3,0)
 ;;=3^Phencyclidine Induced Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25250,1,4,0)
 ;;=4^F16.14
 ;;^UTILITY(U,$J,358.3,25250,2)
 ;;=^5003328
 ;;^UTILITY(U,$J,358.3,25251,0)
 ;;=F16.24^^66^1018^21
 ;;^UTILITY(U,$J,358.3,25251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25251,1,3,0)
 ;;=3^Phencyclidine Induced Bipolar & Related Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25251,1,4,0)
 ;;=4^F16.24
 ;;^UTILITY(U,$J,358.3,25251,2)
 ;;=^5003341
 ;;^UTILITY(U,$J,358.3,25252,0)
 ;;=F16.94^^66^1018^22
 ;;^UTILITY(U,$J,358.3,25252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25252,1,3,0)
 ;;=3^Phencyclidine Induced Bipolar & Related Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25252,1,4,0)
 ;;=4^F16.94
 ;;^UTILITY(U,$J,358.3,25252,2)
 ;;=^5003353
 ;;^UTILITY(U,$J,358.3,25253,0)
 ;;=F16.14^^66^1018^23
 ;;^UTILITY(U,$J,358.3,25253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25253,1,3,0)
 ;;=3^Phencyclidine Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25253,1,4,0)
 ;;=4^F16.14
 ;;^UTILITY(U,$J,358.3,25253,2)
 ;;=^5003328
 ;;^UTILITY(U,$J,358.3,25254,0)
 ;;=F16.24^^66^1018^24
 ;;^UTILITY(U,$J,358.3,25254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25254,1,3,0)
 ;;=3^Phencyclidine Induced Depressive Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25254,1,4,0)
 ;;=4^F16.24
 ;;^UTILITY(U,$J,358.3,25254,2)
 ;;=^5003341
 ;;^UTILITY(U,$J,358.3,25255,0)
 ;;=F16.94^^66^1018^25
 ;;^UTILITY(U,$J,358.3,25255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25255,1,3,0)
 ;;=3^Phencyclidine Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25255,1,4,0)
 ;;=4^F16.94
 ;;^UTILITY(U,$J,358.3,25255,2)
 ;;=^5003353
 ;;^UTILITY(U,$J,358.3,25256,0)
 ;;=F16.159^^66^1018^26
 ;;^UTILITY(U,$J,358.3,25256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25256,1,3,0)
 ;;=3^Phencyclidine Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25256,1,4,0)
 ;;=4^F16.159
 ;;^UTILITY(U,$J,358.3,25256,2)
 ;;=^5003331
 ;;^UTILITY(U,$J,358.3,25257,0)
 ;;=F16.259^^66^1018^27
 ;;^UTILITY(U,$J,358.3,25257,1,0)
 ;;=^358.31IA^4^2
