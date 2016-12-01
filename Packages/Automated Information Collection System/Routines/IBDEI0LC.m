IBDEI0LC ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26994,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26994,1,4,0)
 ;;=4^F16.121
 ;;^UTILITY(U,$J,358.3,26994,2)
 ;;=^5003325
 ;;^UTILITY(U,$J,358.3,26995,0)
 ;;=F16.221^^71^1138^11
 ;;^UTILITY(U,$J,358.3,26995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26995,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26995,1,4,0)
 ;;=4^F16.221
 ;;^UTILITY(U,$J,358.3,26995,2)
 ;;=^5003339
 ;;^UTILITY(U,$J,358.3,26996,0)
 ;;=F16.921^^71^1138^12
 ;;^UTILITY(U,$J,358.3,26996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26996,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26996,1,4,0)
 ;;=4^F16.921
 ;;^UTILITY(U,$J,358.3,26996,2)
 ;;=^5003351
 ;;^UTILITY(U,$J,358.3,26997,0)
 ;;=F16.129^^71^1138^13
 ;;^UTILITY(U,$J,358.3,26997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26997,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26997,1,4,0)
 ;;=4^F16.129
 ;;^UTILITY(U,$J,358.3,26997,2)
 ;;=^5003327
 ;;^UTILITY(U,$J,358.3,26998,0)
 ;;=F16.229^^71^1138^14
 ;;^UTILITY(U,$J,358.3,26998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26998,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26998,1,4,0)
 ;;=4^F16.229
 ;;^UTILITY(U,$J,358.3,26998,2)
 ;;=^5003340
 ;;^UTILITY(U,$J,358.3,26999,0)
 ;;=F16.929^^71^1138^15
 ;;^UTILITY(U,$J,358.3,26999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26999,1,3,0)
 ;;=3^Hallucinogen Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26999,1,4,0)
 ;;=4^F16.929
 ;;^UTILITY(U,$J,358.3,26999,2)
 ;;=^5003352
 ;;^UTILITY(U,$J,358.3,27000,0)
 ;;=F16.180^^71^1138^1
 ;;^UTILITY(U,$J,358.3,27000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27000,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27000,1,4,0)
 ;;=4^F16.180
 ;;^UTILITY(U,$J,358.3,27000,2)
 ;;=^5003332
 ;;^UTILITY(U,$J,358.3,27001,0)
 ;;=F16.280^^71^1138^2
 ;;^UTILITY(U,$J,358.3,27001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27001,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27001,1,4,0)
 ;;=4^F16.280
 ;;^UTILITY(U,$J,358.3,27001,2)
 ;;=^5003345
 ;;^UTILITY(U,$J,358.3,27002,0)
 ;;=F16.980^^71^1138^3
 ;;^UTILITY(U,$J,358.3,27002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27002,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27002,1,4,0)
 ;;=4^F16.980
 ;;^UTILITY(U,$J,358.3,27002,2)
 ;;=^5003357
 ;;^UTILITY(U,$J,358.3,27003,0)
 ;;=F16.14^^71^1138^4
 ;;^UTILITY(U,$J,358.3,27003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27003,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27003,1,4,0)
 ;;=4^F16.14
 ;;^UTILITY(U,$J,358.3,27003,2)
 ;;=^5003328
 ;;^UTILITY(U,$J,358.3,27004,0)
 ;;=F16.24^^71^1138^5
 ;;^UTILITY(U,$J,358.3,27004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27004,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27004,1,4,0)
 ;;=4^F16.24
 ;;^UTILITY(U,$J,358.3,27004,2)
 ;;=^5003341
 ;;^UTILITY(U,$J,358.3,27005,0)
 ;;=F16.94^^71^1138^6
 ;;^UTILITY(U,$J,358.3,27005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27005,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27005,1,4,0)
 ;;=4^F16.94
 ;;^UTILITY(U,$J,358.3,27005,2)
 ;;=^5003353
 ;;^UTILITY(U,$J,358.3,27006,0)
 ;;=F16.159^^71^1138^7
 ;;^UTILITY(U,$J,358.3,27006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27006,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27006,1,4,0)
 ;;=4^F16.159
 ;;^UTILITY(U,$J,358.3,27006,2)
 ;;=^5003331
 ;;^UTILITY(U,$J,358.3,27007,0)
 ;;=F16.259^^71^1138^8
 ;;^UTILITY(U,$J,358.3,27007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27007,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27007,1,4,0)
 ;;=4^F16.259
 ;;^UTILITY(U,$J,358.3,27007,2)
 ;;=^5003344
 ;;^UTILITY(U,$J,358.3,27008,0)
 ;;=F16.959^^71^1138^9
 ;;^UTILITY(U,$J,358.3,27008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27008,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27008,1,4,0)
 ;;=4^F16.959
 ;;^UTILITY(U,$J,358.3,27008,2)
 ;;=^5003356
 ;;^UTILITY(U,$J,358.3,27009,0)
 ;;=F16.99^^71^1138^38
 ;;^UTILITY(U,$J,358.3,27009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27009,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,27009,1,4,0)
 ;;=4^F16.99
 ;;^UTILITY(U,$J,358.3,27009,2)
 ;;=^5133359
 ;;^UTILITY(U,$J,358.3,27010,0)
 ;;=F16.983^^71^1138^16
 ;;^UTILITY(U,$J,358.3,27010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27010,1,3,0)
 ;;=3^Hallucinogen Persisting Perception Disorder
 ;;^UTILITY(U,$J,358.3,27010,1,4,0)
 ;;=4^F16.983
 ;;^UTILITY(U,$J,358.3,27010,2)
 ;;=^5003358
 ;;^UTILITY(U,$J,358.3,27011,0)
 ;;=F16.20^^71^1138^37
 ;;^UTILITY(U,$J,358.3,27011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27011,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,27011,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,27011,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,27012,0)
 ;;=F16.180^^71^1138^17
 ;;^UTILITY(U,$J,358.3,27012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27012,1,3,0)
 ;;=3^Phencyclidine Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27012,1,4,0)
 ;;=4^F16.180
 ;;^UTILITY(U,$J,358.3,27012,2)
 ;;=^5003332
 ;;^UTILITY(U,$J,358.3,27013,0)
 ;;=F16.280^^71^1138^18
 ;;^UTILITY(U,$J,358.3,27013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27013,1,3,0)
 ;;=3^Phencyclidine Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27013,1,4,0)
 ;;=4^F16.280
 ;;^UTILITY(U,$J,358.3,27013,2)
 ;;=^5003345
 ;;^UTILITY(U,$J,358.3,27014,0)
 ;;=F16.980^^71^1138^19
 ;;^UTILITY(U,$J,358.3,27014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27014,1,3,0)
 ;;=3^Phencyclidine Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27014,1,4,0)
 ;;=4^F16.980
 ;;^UTILITY(U,$J,358.3,27014,2)
 ;;=^5003357
 ;;^UTILITY(U,$J,358.3,27015,0)
 ;;=F16.14^^71^1138^20
 ;;^UTILITY(U,$J,358.3,27015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27015,1,3,0)
 ;;=3^Phencyclidine Induced Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27015,1,4,0)
 ;;=4^F16.14
 ;;^UTILITY(U,$J,358.3,27015,2)
 ;;=^5003328
 ;;^UTILITY(U,$J,358.3,27016,0)
 ;;=F16.24^^71^1138^21
 ;;^UTILITY(U,$J,358.3,27016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27016,1,3,0)
 ;;=3^Phencyclidine Induced Bipolar & Related Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27016,1,4,0)
 ;;=4^F16.24
 ;;^UTILITY(U,$J,358.3,27016,2)
 ;;=^5003341
 ;;^UTILITY(U,$J,358.3,27017,0)
 ;;=F16.94^^71^1138^22
 ;;^UTILITY(U,$J,358.3,27017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27017,1,3,0)
 ;;=3^Phencyclidine Induced Bipolar & Related Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27017,1,4,0)
 ;;=4^F16.94
 ;;^UTILITY(U,$J,358.3,27017,2)
 ;;=^5003353
 ;;^UTILITY(U,$J,358.3,27018,0)
 ;;=F16.14^^71^1138^23
 ;;^UTILITY(U,$J,358.3,27018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27018,1,3,0)
 ;;=3^Phencyclidine Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27018,1,4,0)
 ;;=4^F16.14
 ;;^UTILITY(U,$J,358.3,27018,2)
 ;;=^5003328
 ;;^UTILITY(U,$J,358.3,27019,0)
 ;;=F16.24^^71^1138^24
 ;;^UTILITY(U,$J,358.3,27019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27019,1,3,0)
 ;;=3^Phencyclidine Induced Depressive Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27019,1,4,0)
 ;;=4^F16.24
 ;;^UTILITY(U,$J,358.3,27019,2)
 ;;=^5003341
 ;;^UTILITY(U,$J,358.3,27020,0)
 ;;=F16.94^^71^1138^25
 ;;^UTILITY(U,$J,358.3,27020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27020,1,3,0)
 ;;=3^Phencyclidine Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27020,1,4,0)
 ;;=4^F16.94
 ;;^UTILITY(U,$J,358.3,27020,2)
 ;;=^5003353
 ;;^UTILITY(U,$J,358.3,27021,0)
 ;;=F16.159^^71^1138^26
 ;;^UTILITY(U,$J,358.3,27021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27021,1,3,0)
 ;;=3^Phencyclidine Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27021,1,4,0)
 ;;=4^F16.159
 ;;^UTILITY(U,$J,358.3,27021,2)
 ;;=^5003331
 ;;^UTILITY(U,$J,358.3,27022,0)
 ;;=F16.259^^71^1138^27
 ;;^UTILITY(U,$J,358.3,27022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27022,1,3,0)
 ;;=3^Phencyclidine Induced Psychotic Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27022,1,4,0)
 ;;=4^F16.259
 ;;^UTILITY(U,$J,358.3,27022,2)
 ;;=^5003344
 ;;^UTILITY(U,$J,358.3,27023,0)
 ;;=F16.959^^71^1138^28
 ;;^UTILITY(U,$J,358.3,27023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27023,1,3,0)
 ;;=3^Phencyclidine Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27023,1,4,0)
 ;;=4^F16.959
 ;;^UTILITY(U,$J,358.3,27023,2)
 ;;=^5003356
 ;;^UTILITY(U,$J,358.3,27024,0)
 ;;=F16.129^^71^1138^32
 ;;^UTILITY(U,$J,358.3,27024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27024,1,3,0)
 ;;=3^Phencyclidine Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27024,1,4,0)
 ;;=4^F16.129
 ;;^UTILITY(U,$J,358.3,27024,2)
 ;;=^5003327
 ;;^UTILITY(U,$J,358.3,27025,0)
 ;;=F16.229^^71^1138^33
 ;;^UTILITY(U,$J,358.3,27025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27025,1,3,0)
 ;;=3^Phencyclidine Intoxication w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27025,1,4,0)
 ;;=4^F16.229
 ;;^UTILITY(U,$J,358.3,27025,2)
 ;;=^5003340
 ;;^UTILITY(U,$J,358.3,27026,0)
 ;;=F16.929^^71^1138^34
 ;;^UTILITY(U,$J,358.3,27026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27026,1,3,0)
 ;;=3^Phencyclidine Intoxication w/o Use Disorder
