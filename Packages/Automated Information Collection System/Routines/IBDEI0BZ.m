IBDEI0BZ ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15194,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,15194,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,15195,0)
 ;;=F12.20^^45^678^21
 ;;^UTILITY(U,$J,358.3,15195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15195,1,3,0)
 ;;=3^Cannabis Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,15195,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,15195,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,15196,0)
 ;;=F12.99^^45^678^18
 ;;^UTILITY(U,$J,358.3,15196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15196,1,3,0)
 ;;=3^Cannabis Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15196,1,4,0)
 ;;=4^F12.99
 ;;^UTILITY(U,$J,358.3,15196,2)
 ;;=^5003188
 ;;^UTILITY(U,$J,358.3,15197,0)
 ;;=F16.10^^45^679^35
 ;;^UTILITY(U,$J,358.3,15197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15197,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,15197,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,15197,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,15198,0)
 ;;=F16.20^^45^679^36
 ;;^UTILITY(U,$J,358.3,15198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15198,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,15198,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,15198,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,15199,0)
 ;;=F16.121^^45^679^10
 ;;^UTILITY(U,$J,358.3,15199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15199,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15199,1,4,0)
 ;;=4^F16.121
 ;;^UTILITY(U,$J,358.3,15199,2)
 ;;=^5003325
 ;;^UTILITY(U,$J,358.3,15200,0)
 ;;=F16.221^^45^679^11
 ;;^UTILITY(U,$J,358.3,15200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15200,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15200,1,4,0)
 ;;=4^F16.221
 ;;^UTILITY(U,$J,358.3,15200,2)
 ;;=^5003339
 ;;^UTILITY(U,$J,358.3,15201,0)
 ;;=F16.921^^45^679^12
 ;;^UTILITY(U,$J,358.3,15201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15201,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15201,1,4,0)
 ;;=4^F16.921
 ;;^UTILITY(U,$J,358.3,15201,2)
 ;;=^5003351
 ;;^UTILITY(U,$J,358.3,15202,0)
 ;;=F16.129^^45^679^13
 ;;^UTILITY(U,$J,358.3,15202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15202,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15202,1,4,0)
 ;;=4^F16.129
 ;;^UTILITY(U,$J,358.3,15202,2)
 ;;=^5003327
 ;;^UTILITY(U,$J,358.3,15203,0)
 ;;=F16.229^^45^679^14
 ;;^UTILITY(U,$J,358.3,15203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15203,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15203,1,4,0)
 ;;=4^F16.229
 ;;^UTILITY(U,$J,358.3,15203,2)
 ;;=^5003340
 ;;^UTILITY(U,$J,358.3,15204,0)
 ;;=F16.929^^45^679^15
 ;;^UTILITY(U,$J,358.3,15204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15204,1,3,0)
 ;;=3^Hallucinogen Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15204,1,4,0)
 ;;=4^F16.929
 ;;^UTILITY(U,$J,358.3,15204,2)
 ;;=^5003352
 ;;^UTILITY(U,$J,358.3,15205,0)
 ;;=F16.180^^45^679^1
 ;;^UTILITY(U,$J,358.3,15205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15205,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15205,1,4,0)
 ;;=4^F16.180
 ;;^UTILITY(U,$J,358.3,15205,2)
 ;;=^5003332
 ;;^UTILITY(U,$J,358.3,15206,0)
 ;;=F16.280^^45^679^2
 ;;^UTILITY(U,$J,358.3,15206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15206,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15206,1,4,0)
 ;;=4^F16.280
 ;;^UTILITY(U,$J,358.3,15206,2)
 ;;=^5003345
 ;;^UTILITY(U,$J,358.3,15207,0)
 ;;=F16.980^^45^679^3
 ;;^UTILITY(U,$J,358.3,15207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15207,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15207,1,4,0)
 ;;=4^F16.980
 ;;^UTILITY(U,$J,358.3,15207,2)
 ;;=^5003357
 ;;^UTILITY(U,$J,358.3,15208,0)
 ;;=F16.14^^45^679^4
 ;;^UTILITY(U,$J,358.3,15208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15208,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15208,1,4,0)
 ;;=4^F16.14
 ;;^UTILITY(U,$J,358.3,15208,2)
 ;;=^5003328
 ;;^UTILITY(U,$J,358.3,15209,0)
 ;;=F16.24^^45^679^5
 ;;^UTILITY(U,$J,358.3,15209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15209,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15209,1,4,0)
 ;;=4^F16.24
 ;;^UTILITY(U,$J,358.3,15209,2)
 ;;=^5003341
 ;;^UTILITY(U,$J,358.3,15210,0)
 ;;=F16.94^^45^679^6
 ;;^UTILITY(U,$J,358.3,15210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15210,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15210,1,4,0)
 ;;=4^F16.94
 ;;^UTILITY(U,$J,358.3,15210,2)
 ;;=^5003353
 ;;^UTILITY(U,$J,358.3,15211,0)
 ;;=F16.159^^45^679^7
 ;;^UTILITY(U,$J,358.3,15211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15211,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15211,1,4,0)
 ;;=4^F16.159
 ;;^UTILITY(U,$J,358.3,15211,2)
 ;;=^5003331
 ;;^UTILITY(U,$J,358.3,15212,0)
 ;;=F16.259^^45^679^8
 ;;^UTILITY(U,$J,358.3,15212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15212,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15212,1,4,0)
 ;;=4^F16.259
 ;;^UTILITY(U,$J,358.3,15212,2)
 ;;=^5003344
 ;;^UTILITY(U,$J,358.3,15213,0)
 ;;=F16.959^^45^679^9
 ;;^UTILITY(U,$J,358.3,15213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15213,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15213,1,4,0)
 ;;=4^F16.959
 ;;^UTILITY(U,$J,358.3,15213,2)
 ;;=^5003356
 ;;^UTILITY(U,$J,358.3,15214,0)
 ;;=F16.99^^45^679^38
 ;;^UTILITY(U,$J,358.3,15214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15214,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15214,1,4,0)
 ;;=4^F16.99
 ;;^UTILITY(U,$J,358.3,15214,2)
 ;;=^5133359
 ;;^UTILITY(U,$J,358.3,15215,0)
 ;;=F16.983^^45^679^16
 ;;^UTILITY(U,$J,358.3,15215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15215,1,3,0)
 ;;=3^Hallucinogen Persisting Perception Disorder
 ;;^UTILITY(U,$J,358.3,15215,1,4,0)
 ;;=4^F16.983
 ;;^UTILITY(U,$J,358.3,15215,2)
 ;;=^5003358
 ;;^UTILITY(U,$J,358.3,15216,0)
 ;;=F16.20^^45^679^37
 ;;^UTILITY(U,$J,358.3,15216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15216,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,15216,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,15216,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,15217,0)
 ;;=F16.180^^45^679^17
 ;;^UTILITY(U,$J,358.3,15217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15217,1,3,0)
 ;;=3^Phencyclidine Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15217,1,4,0)
 ;;=4^F16.180
 ;;^UTILITY(U,$J,358.3,15217,2)
 ;;=^5003332
 ;;^UTILITY(U,$J,358.3,15218,0)
 ;;=F16.280^^45^679^18
 ;;^UTILITY(U,$J,358.3,15218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15218,1,3,0)
 ;;=3^Phencyclidine Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15218,1,4,0)
 ;;=4^F16.280
 ;;^UTILITY(U,$J,358.3,15218,2)
 ;;=^5003345
 ;;^UTILITY(U,$J,358.3,15219,0)
 ;;=F16.980^^45^679^19
 ;;^UTILITY(U,$J,358.3,15219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15219,1,3,0)
 ;;=3^Phencyclidine Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15219,1,4,0)
 ;;=4^F16.980
 ;;^UTILITY(U,$J,358.3,15219,2)
 ;;=^5003357
 ;;^UTILITY(U,$J,358.3,15220,0)
 ;;=F16.14^^45^679^20
 ;;^UTILITY(U,$J,358.3,15220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15220,1,3,0)
 ;;=3^Phencyclidine Induced Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15220,1,4,0)
 ;;=4^F16.14
 ;;^UTILITY(U,$J,358.3,15220,2)
 ;;=^5003328
 ;;^UTILITY(U,$J,358.3,15221,0)
 ;;=F16.24^^45^679^21
 ;;^UTILITY(U,$J,358.3,15221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15221,1,3,0)
 ;;=3^Phencyclidine Induced Bipolar & Related Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15221,1,4,0)
 ;;=4^F16.24
 ;;^UTILITY(U,$J,358.3,15221,2)
 ;;=^5003341
 ;;^UTILITY(U,$J,358.3,15222,0)
 ;;=F16.94^^45^679^22
 ;;^UTILITY(U,$J,358.3,15222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15222,1,3,0)
 ;;=3^Phencyclidine Induced Bipolar & Related Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15222,1,4,0)
 ;;=4^F16.94
 ;;^UTILITY(U,$J,358.3,15222,2)
 ;;=^5003353
 ;;^UTILITY(U,$J,358.3,15223,0)
 ;;=F16.14^^45^679^23
 ;;^UTILITY(U,$J,358.3,15223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15223,1,3,0)
 ;;=3^Phencyclidine Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15223,1,4,0)
 ;;=4^F16.14
 ;;^UTILITY(U,$J,358.3,15223,2)
 ;;=^5003328
 ;;^UTILITY(U,$J,358.3,15224,0)
 ;;=F16.24^^45^679^24
 ;;^UTILITY(U,$J,358.3,15224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15224,1,3,0)
 ;;=3^Phencyclidine Induced Depressive Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15224,1,4,0)
 ;;=4^F16.24
 ;;^UTILITY(U,$J,358.3,15224,2)
 ;;=^5003341
 ;;^UTILITY(U,$J,358.3,15225,0)
 ;;=F16.94^^45^679^25
 ;;^UTILITY(U,$J,358.3,15225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15225,1,3,0)
 ;;=3^Phencyclidine Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15225,1,4,0)
 ;;=4^F16.94
 ;;^UTILITY(U,$J,358.3,15225,2)
 ;;=^5003353
 ;;^UTILITY(U,$J,358.3,15226,0)
 ;;=F16.159^^45^679^26
 ;;^UTILITY(U,$J,358.3,15226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15226,1,3,0)
 ;;=3^Phencyclidine Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15226,1,4,0)
 ;;=4^F16.159
 ;;^UTILITY(U,$J,358.3,15226,2)
 ;;=^5003331
 ;;^UTILITY(U,$J,358.3,15227,0)
 ;;=F16.259^^45^679^27
 ;;^UTILITY(U,$J,358.3,15227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15227,1,3,0)
 ;;=3^Phencyclidine Induced Psychotic Disorder w/ Moderate/Severe Use Disorder
