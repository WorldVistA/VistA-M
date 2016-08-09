IBDEI0RD ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27491,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,27491,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,27492,0)
 ;;=F12.20^^102^1339^21
 ;;^UTILITY(U,$J,358.3,27492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27492,1,3,0)
 ;;=3^Cannabis Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,27492,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,27492,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,27493,0)
 ;;=F12.99^^102^1339^18
 ;;^UTILITY(U,$J,358.3,27493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27493,1,3,0)
 ;;=3^Cannabis Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,27493,1,4,0)
 ;;=4^F12.99
 ;;^UTILITY(U,$J,358.3,27493,2)
 ;;=^5003188
 ;;^UTILITY(U,$J,358.3,27494,0)
 ;;=F16.10^^102^1340^35
 ;;^UTILITY(U,$J,358.3,27494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27494,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,27494,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,27494,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,27495,0)
 ;;=F16.20^^102^1340^36
 ;;^UTILITY(U,$J,358.3,27495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27495,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,27495,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,27495,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,27496,0)
 ;;=F16.121^^102^1340^10
 ;;^UTILITY(U,$J,358.3,27496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27496,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27496,1,4,0)
 ;;=4^F16.121
 ;;^UTILITY(U,$J,358.3,27496,2)
 ;;=^5003325
 ;;^UTILITY(U,$J,358.3,27497,0)
 ;;=F16.221^^102^1340^11
 ;;^UTILITY(U,$J,358.3,27497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27497,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27497,1,4,0)
 ;;=4^F16.221
 ;;^UTILITY(U,$J,358.3,27497,2)
 ;;=^5003339
 ;;^UTILITY(U,$J,358.3,27498,0)
 ;;=F16.921^^102^1340^12
 ;;^UTILITY(U,$J,358.3,27498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27498,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27498,1,4,0)
 ;;=4^F16.921
 ;;^UTILITY(U,$J,358.3,27498,2)
 ;;=^5003351
 ;;^UTILITY(U,$J,358.3,27499,0)
 ;;=F16.129^^102^1340^13
 ;;^UTILITY(U,$J,358.3,27499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27499,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27499,1,4,0)
 ;;=4^F16.129
 ;;^UTILITY(U,$J,358.3,27499,2)
 ;;=^5003327
 ;;^UTILITY(U,$J,358.3,27500,0)
 ;;=F16.229^^102^1340^14
 ;;^UTILITY(U,$J,358.3,27500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27500,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27500,1,4,0)
 ;;=4^F16.229
 ;;^UTILITY(U,$J,358.3,27500,2)
 ;;=^5003340
 ;;^UTILITY(U,$J,358.3,27501,0)
 ;;=F16.929^^102^1340^15
 ;;^UTILITY(U,$J,358.3,27501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27501,1,3,0)
 ;;=3^Hallucinogen Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27501,1,4,0)
 ;;=4^F16.929
 ;;^UTILITY(U,$J,358.3,27501,2)
 ;;=^5003352
 ;;^UTILITY(U,$J,358.3,27502,0)
 ;;=F16.180^^102^1340^1
 ;;^UTILITY(U,$J,358.3,27502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27502,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27502,1,4,0)
 ;;=4^F16.180
 ;;^UTILITY(U,$J,358.3,27502,2)
 ;;=^5003332
 ;;^UTILITY(U,$J,358.3,27503,0)
 ;;=F16.280^^102^1340^2
 ;;^UTILITY(U,$J,358.3,27503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27503,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27503,1,4,0)
 ;;=4^F16.280
 ;;^UTILITY(U,$J,358.3,27503,2)
 ;;=^5003345
 ;;^UTILITY(U,$J,358.3,27504,0)
 ;;=F16.980^^102^1340^3
 ;;^UTILITY(U,$J,358.3,27504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27504,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27504,1,4,0)
 ;;=4^F16.980
 ;;^UTILITY(U,$J,358.3,27504,2)
 ;;=^5003357
 ;;^UTILITY(U,$J,358.3,27505,0)
 ;;=F16.14^^102^1340^4
 ;;^UTILITY(U,$J,358.3,27505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27505,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27505,1,4,0)
 ;;=4^F16.14
 ;;^UTILITY(U,$J,358.3,27505,2)
 ;;=^5003328
 ;;^UTILITY(U,$J,358.3,27506,0)
 ;;=F16.24^^102^1340^5
 ;;^UTILITY(U,$J,358.3,27506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27506,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27506,1,4,0)
 ;;=4^F16.24
 ;;^UTILITY(U,$J,358.3,27506,2)
 ;;=^5003341
 ;;^UTILITY(U,$J,358.3,27507,0)
 ;;=F16.94^^102^1340^6
 ;;^UTILITY(U,$J,358.3,27507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27507,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27507,1,4,0)
 ;;=4^F16.94
 ;;^UTILITY(U,$J,358.3,27507,2)
 ;;=^5003353
 ;;^UTILITY(U,$J,358.3,27508,0)
 ;;=F16.159^^102^1340^7
 ;;^UTILITY(U,$J,358.3,27508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27508,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27508,1,4,0)
 ;;=4^F16.159
 ;;^UTILITY(U,$J,358.3,27508,2)
 ;;=^5003331
 ;;^UTILITY(U,$J,358.3,27509,0)
 ;;=F16.259^^102^1340^8
 ;;^UTILITY(U,$J,358.3,27509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27509,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27509,1,4,0)
 ;;=4^F16.259
 ;;^UTILITY(U,$J,358.3,27509,2)
 ;;=^5003344
 ;;^UTILITY(U,$J,358.3,27510,0)
 ;;=F16.959^^102^1340^9
 ;;^UTILITY(U,$J,358.3,27510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27510,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27510,1,4,0)
 ;;=4^F16.959
 ;;^UTILITY(U,$J,358.3,27510,2)
 ;;=^5003356
 ;;^UTILITY(U,$J,358.3,27511,0)
 ;;=F16.99^^102^1340^38
 ;;^UTILITY(U,$J,358.3,27511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27511,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,27511,1,4,0)
 ;;=4^F16.99
 ;;^UTILITY(U,$J,358.3,27511,2)
 ;;=^5133359
 ;;^UTILITY(U,$J,358.3,27512,0)
 ;;=F16.983^^102^1340^16
 ;;^UTILITY(U,$J,358.3,27512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27512,1,3,0)
 ;;=3^Hallucinogen Persisting Perception Disorder
 ;;^UTILITY(U,$J,358.3,27512,1,4,0)
 ;;=4^F16.983
 ;;^UTILITY(U,$J,358.3,27512,2)
 ;;=^5003358
 ;;^UTILITY(U,$J,358.3,27513,0)
 ;;=F16.20^^102^1340^37
 ;;^UTILITY(U,$J,358.3,27513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27513,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,27513,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,27513,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,27514,0)
 ;;=F16.180^^102^1340^17
 ;;^UTILITY(U,$J,358.3,27514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27514,1,3,0)
 ;;=3^Phencyclidine Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27514,1,4,0)
 ;;=4^F16.180
 ;;^UTILITY(U,$J,358.3,27514,2)
 ;;=^5003332
 ;;^UTILITY(U,$J,358.3,27515,0)
 ;;=F16.280^^102^1340^18
 ;;^UTILITY(U,$J,358.3,27515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27515,1,3,0)
 ;;=3^Phencyclidine Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27515,1,4,0)
 ;;=4^F16.280
 ;;^UTILITY(U,$J,358.3,27515,2)
 ;;=^5003345
 ;;^UTILITY(U,$J,358.3,27516,0)
 ;;=F16.980^^102^1340^19
 ;;^UTILITY(U,$J,358.3,27516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27516,1,3,0)
 ;;=3^Phencyclidine Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27516,1,4,0)
 ;;=4^F16.980
 ;;^UTILITY(U,$J,358.3,27516,2)
 ;;=^5003357
 ;;^UTILITY(U,$J,358.3,27517,0)
 ;;=F16.14^^102^1340^20
 ;;^UTILITY(U,$J,358.3,27517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27517,1,3,0)
 ;;=3^Phencyclidine Induced Bipolar & Related Disorder w/ Mild Use Disorder
