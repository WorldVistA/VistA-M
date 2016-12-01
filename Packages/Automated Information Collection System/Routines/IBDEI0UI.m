IBDEI0UI ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40104,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40104,1,4,0)
 ;;=4^F16.24
 ;;^UTILITY(U,$J,358.3,40104,2)
 ;;=^5003341
 ;;^UTILITY(U,$J,358.3,40105,0)
 ;;=F16.94^^114^1693^6
 ;;^UTILITY(U,$J,358.3,40105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40105,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40105,1,4,0)
 ;;=4^F16.94
 ;;^UTILITY(U,$J,358.3,40105,2)
 ;;=^5003353
 ;;^UTILITY(U,$J,358.3,40106,0)
 ;;=F16.159^^114^1693^7
 ;;^UTILITY(U,$J,358.3,40106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40106,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40106,1,4,0)
 ;;=4^F16.159
 ;;^UTILITY(U,$J,358.3,40106,2)
 ;;=^5003331
 ;;^UTILITY(U,$J,358.3,40107,0)
 ;;=F16.259^^114^1693^8
 ;;^UTILITY(U,$J,358.3,40107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40107,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40107,1,4,0)
 ;;=4^F16.259
 ;;^UTILITY(U,$J,358.3,40107,2)
 ;;=^5003344
 ;;^UTILITY(U,$J,358.3,40108,0)
 ;;=F16.959^^114^1693^9
 ;;^UTILITY(U,$J,358.3,40108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40108,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40108,1,4,0)
 ;;=4^F16.959
 ;;^UTILITY(U,$J,358.3,40108,2)
 ;;=^5003356
 ;;^UTILITY(U,$J,358.3,40109,0)
 ;;=F16.99^^114^1693^38
 ;;^UTILITY(U,$J,358.3,40109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40109,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,40109,1,4,0)
 ;;=4^F16.99
 ;;^UTILITY(U,$J,358.3,40109,2)
 ;;=^5133359
 ;;^UTILITY(U,$J,358.3,40110,0)
 ;;=F16.983^^114^1693^16
 ;;^UTILITY(U,$J,358.3,40110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40110,1,3,0)
 ;;=3^Hallucinogen Persisting Perception Disorder
 ;;^UTILITY(U,$J,358.3,40110,1,4,0)
 ;;=4^F16.983
 ;;^UTILITY(U,$J,358.3,40110,2)
 ;;=^5003358
 ;;^UTILITY(U,$J,358.3,40111,0)
 ;;=F16.20^^114^1693^37
 ;;^UTILITY(U,$J,358.3,40111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40111,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,40111,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,40111,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,40112,0)
 ;;=F16.180^^114^1693^17
 ;;^UTILITY(U,$J,358.3,40112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40112,1,3,0)
 ;;=3^Phencyclidine Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40112,1,4,0)
 ;;=4^F16.180
 ;;^UTILITY(U,$J,358.3,40112,2)
 ;;=^5003332
 ;;^UTILITY(U,$J,358.3,40113,0)
 ;;=F16.280^^114^1693^18
 ;;^UTILITY(U,$J,358.3,40113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40113,1,3,0)
 ;;=3^Phencyclidine Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40113,1,4,0)
 ;;=4^F16.280
 ;;^UTILITY(U,$J,358.3,40113,2)
 ;;=^5003345
 ;;^UTILITY(U,$J,358.3,40114,0)
 ;;=F16.980^^114^1693^19
 ;;^UTILITY(U,$J,358.3,40114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40114,1,3,0)
 ;;=3^Phencyclidine Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40114,1,4,0)
 ;;=4^F16.980
 ;;^UTILITY(U,$J,358.3,40114,2)
 ;;=^5003357
 ;;^UTILITY(U,$J,358.3,40115,0)
 ;;=F16.14^^114^1693^20
 ;;^UTILITY(U,$J,358.3,40115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40115,1,3,0)
 ;;=3^Phencyclidine Induced Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40115,1,4,0)
 ;;=4^F16.14
 ;;^UTILITY(U,$J,358.3,40115,2)
 ;;=^5003328
 ;;^UTILITY(U,$J,358.3,40116,0)
 ;;=F16.24^^114^1693^21
 ;;^UTILITY(U,$J,358.3,40116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40116,1,3,0)
 ;;=3^Phencyclidine Induced Bipolar & Related Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40116,1,4,0)
 ;;=4^F16.24
 ;;^UTILITY(U,$J,358.3,40116,2)
 ;;=^5003341
 ;;^UTILITY(U,$J,358.3,40117,0)
 ;;=F16.94^^114^1693^22
 ;;^UTILITY(U,$J,358.3,40117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40117,1,3,0)
 ;;=3^Phencyclidine Induced Bipolar & Related Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40117,1,4,0)
 ;;=4^F16.94
 ;;^UTILITY(U,$J,358.3,40117,2)
 ;;=^5003353
 ;;^UTILITY(U,$J,358.3,40118,0)
 ;;=F16.14^^114^1693^23
 ;;^UTILITY(U,$J,358.3,40118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40118,1,3,0)
 ;;=3^Phencyclidine Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40118,1,4,0)
 ;;=4^F16.14
 ;;^UTILITY(U,$J,358.3,40118,2)
 ;;=^5003328
 ;;^UTILITY(U,$J,358.3,40119,0)
 ;;=F16.24^^114^1693^24
 ;;^UTILITY(U,$J,358.3,40119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40119,1,3,0)
 ;;=3^Phencyclidine Induced Depressive Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40119,1,4,0)
 ;;=4^F16.24
 ;;^UTILITY(U,$J,358.3,40119,2)
 ;;=^5003341
 ;;^UTILITY(U,$J,358.3,40120,0)
 ;;=F16.94^^114^1693^25
 ;;^UTILITY(U,$J,358.3,40120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40120,1,3,0)
 ;;=3^Phencyclidine Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40120,1,4,0)
 ;;=4^F16.94
 ;;^UTILITY(U,$J,358.3,40120,2)
 ;;=^5003353
 ;;^UTILITY(U,$J,358.3,40121,0)
 ;;=F16.159^^114^1693^26
 ;;^UTILITY(U,$J,358.3,40121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40121,1,3,0)
 ;;=3^Phencyclidine Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40121,1,4,0)
 ;;=4^F16.159
 ;;^UTILITY(U,$J,358.3,40121,2)
 ;;=^5003331
 ;;^UTILITY(U,$J,358.3,40122,0)
 ;;=F16.259^^114^1693^27
 ;;^UTILITY(U,$J,358.3,40122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40122,1,3,0)
 ;;=3^Phencyclidine Induced Psychotic Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40122,1,4,0)
 ;;=4^F16.259
 ;;^UTILITY(U,$J,358.3,40122,2)
 ;;=^5003344
 ;;^UTILITY(U,$J,358.3,40123,0)
 ;;=F16.959^^114^1693^28
 ;;^UTILITY(U,$J,358.3,40123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40123,1,3,0)
 ;;=3^Phencyclidine Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40123,1,4,0)
 ;;=4^F16.959
 ;;^UTILITY(U,$J,358.3,40123,2)
 ;;=^5003356
 ;;^UTILITY(U,$J,358.3,40124,0)
 ;;=F16.129^^114^1693^32
 ;;^UTILITY(U,$J,358.3,40124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40124,1,3,0)
 ;;=3^Phencyclidine Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40124,1,4,0)
 ;;=4^F16.129
 ;;^UTILITY(U,$J,358.3,40124,2)
 ;;=^5003327
 ;;^UTILITY(U,$J,358.3,40125,0)
 ;;=F16.229^^114^1693^33
 ;;^UTILITY(U,$J,358.3,40125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40125,1,3,0)
 ;;=3^Phencyclidine Intoxication w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40125,1,4,0)
 ;;=4^F16.229
 ;;^UTILITY(U,$J,358.3,40125,2)
 ;;=^5003340
 ;;^UTILITY(U,$J,358.3,40126,0)
 ;;=F16.929^^114^1693^34
 ;;^UTILITY(U,$J,358.3,40126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40126,1,3,0)
 ;;=3^Phencyclidine Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40126,1,4,0)
 ;;=4^F16.929
 ;;^UTILITY(U,$J,358.3,40126,2)
 ;;=^5003352
 ;;^UTILITY(U,$J,358.3,40127,0)
 ;;=F16.121^^114^1693^29
 ;;^UTILITY(U,$J,358.3,40127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40127,1,3,0)
 ;;=3^Phencyclidine Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40127,1,4,0)
 ;;=4^F16.121
 ;;^UTILITY(U,$J,358.3,40127,2)
 ;;=^5003325
 ;;^UTILITY(U,$J,358.3,40128,0)
 ;;=F16.221^^114^1693^30
 ;;^UTILITY(U,$J,358.3,40128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40128,1,3,0)
 ;;=3^Phencyclidine Intoxication Delirium w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40128,1,4,0)
 ;;=4^F16.221
 ;;^UTILITY(U,$J,358.3,40128,2)
 ;;=^5003339
 ;;^UTILITY(U,$J,358.3,40129,0)
 ;;=F16.921^^114^1693^31
 ;;^UTILITY(U,$J,358.3,40129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40129,1,3,0)
 ;;=3^Phencyclidine Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40129,1,4,0)
 ;;=4^F16.921
 ;;^UTILITY(U,$J,358.3,40129,2)
 ;;=^5003351
 ;;^UTILITY(U,$J,358.3,40130,0)
 ;;=F11.10^^114^1694^24
 ;;^UTILITY(U,$J,358.3,40130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40130,1,3,0)
 ;;=3^Opioid Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,40130,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,40130,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,40131,0)
 ;;=F11.129^^114^1694^20
 ;;^UTILITY(U,$J,358.3,40131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40131,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbances w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40131,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,40131,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,40132,0)
 ;;=F11.14^^114^1694^5
 ;;^UTILITY(U,$J,358.3,40132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40132,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40132,1,4,0)
 ;;=4^F11.14
 ;;^UTILITY(U,$J,358.3,40132,2)
 ;;=^5003119
 ;;^UTILITY(U,$J,358.3,40133,0)
 ;;=F11.182^^114^1694^11
 ;;^UTILITY(U,$J,358.3,40133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40133,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40133,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,40133,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,40134,0)
 ;;=F11.20^^114^1694^25
 ;;^UTILITY(U,$J,358.3,40134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40134,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,40134,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,40134,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,40135,0)
 ;;=F11.23^^114^1694^27
 ;;^UTILITY(U,$J,358.3,40135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40135,1,3,0)
 ;;=3^Opioid Withdrawal
 ;;^UTILITY(U,$J,358.3,40135,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,40135,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,40136,0)
 ;;=F11.24^^114^1694^6
 ;;^UTILITY(U,$J,358.3,40136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40136,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40136,1,4,0)
 ;;=4^F11.24
