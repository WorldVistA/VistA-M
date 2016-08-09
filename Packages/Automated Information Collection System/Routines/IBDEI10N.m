IBDEI10N ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36868,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,36868,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,36869,0)
 ;;=F12.20^^135^1821^21
 ;;^UTILITY(U,$J,358.3,36869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36869,1,3,0)
 ;;=3^Cannabis Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,36869,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,36869,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,36870,0)
 ;;=F12.99^^135^1821^18
 ;;^UTILITY(U,$J,358.3,36870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36870,1,3,0)
 ;;=3^Cannabis Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,36870,1,4,0)
 ;;=4^F12.99
 ;;^UTILITY(U,$J,358.3,36870,2)
 ;;=^5003188
 ;;^UTILITY(U,$J,358.3,36871,0)
 ;;=F16.10^^135^1822^35
 ;;^UTILITY(U,$J,358.3,36871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36871,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,36871,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,36871,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,36872,0)
 ;;=F16.20^^135^1822^36
 ;;^UTILITY(U,$J,358.3,36872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36872,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,36872,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,36872,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,36873,0)
 ;;=F16.121^^135^1822^10
 ;;^UTILITY(U,$J,358.3,36873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36873,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,36873,1,4,0)
 ;;=4^F16.121
 ;;^UTILITY(U,$J,358.3,36873,2)
 ;;=^5003325
 ;;^UTILITY(U,$J,358.3,36874,0)
 ;;=F16.221^^135^1822^11
 ;;^UTILITY(U,$J,358.3,36874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36874,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36874,1,4,0)
 ;;=4^F16.221
 ;;^UTILITY(U,$J,358.3,36874,2)
 ;;=^5003339
 ;;^UTILITY(U,$J,358.3,36875,0)
 ;;=F16.921^^135^1822^12
 ;;^UTILITY(U,$J,358.3,36875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36875,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36875,1,4,0)
 ;;=4^F16.921
 ;;^UTILITY(U,$J,358.3,36875,2)
 ;;=^5003351
 ;;^UTILITY(U,$J,358.3,36876,0)
 ;;=F16.129^^135^1822^13
 ;;^UTILITY(U,$J,358.3,36876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36876,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,36876,1,4,0)
 ;;=4^F16.129
 ;;^UTILITY(U,$J,358.3,36876,2)
 ;;=^5003327
 ;;^UTILITY(U,$J,358.3,36877,0)
 ;;=F16.229^^135^1822^14
 ;;^UTILITY(U,$J,358.3,36877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36877,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36877,1,4,0)
 ;;=4^F16.229
 ;;^UTILITY(U,$J,358.3,36877,2)
 ;;=^5003340
 ;;^UTILITY(U,$J,358.3,36878,0)
 ;;=F16.929^^135^1822^15
 ;;^UTILITY(U,$J,358.3,36878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36878,1,3,0)
 ;;=3^Hallucinogen Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36878,1,4,0)
 ;;=4^F16.929
 ;;^UTILITY(U,$J,358.3,36878,2)
 ;;=^5003352
 ;;^UTILITY(U,$J,358.3,36879,0)
 ;;=F16.180^^135^1822^1
 ;;^UTILITY(U,$J,358.3,36879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36879,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,36879,1,4,0)
 ;;=4^F16.180
 ;;^UTILITY(U,$J,358.3,36879,2)
 ;;=^5003332
 ;;^UTILITY(U,$J,358.3,36880,0)
 ;;=F16.280^^135^1822^2
 ;;^UTILITY(U,$J,358.3,36880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36880,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36880,1,4,0)
 ;;=4^F16.280
 ;;^UTILITY(U,$J,358.3,36880,2)
 ;;=^5003345
 ;;^UTILITY(U,$J,358.3,36881,0)
 ;;=F16.980^^135^1822^3
 ;;^UTILITY(U,$J,358.3,36881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36881,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36881,1,4,0)
 ;;=4^F16.980
 ;;^UTILITY(U,$J,358.3,36881,2)
 ;;=^5003357
 ;;^UTILITY(U,$J,358.3,36882,0)
 ;;=F16.14^^135^1822^4
 ;;^UTILITY(U,$J,358.3,36882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36882,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,36882,1,4,0)
 ;;=4^F16.14
 ;;^UTILITY(U,$J,358.3,36882,2)
 ;;=^5003328
 ;;^UTILITY(U,$J,358.3,36883,0)
 ;;=F16.24^^135^1822^5
 ;;^UTILITY(U,$J,358.3,36883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36883,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36883,1,4,0)
 ;;=4^F16.24
 ;;^UTILITY(U,$J,358.3,36883,2)
 ;;=^5003341
 ;;^UTILITY(U,$J,358.3,36884,0)
 ;;=F16.94^^135^1822^6
 ;;^UTILITY(U,$J,358.3,36884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36884,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36884,1,4,0)
 ;;=4^F16.94
 ;;^UTILITY(U,$J,358.3,36884,2)
 ;;=^5003353
 ;;^UTILITY(U,$J,358.3,36885,0)
 ;;=F16.159^^135^1822^7
 ;;^UTILITY(U,$J,358.3,36885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36885,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,36885,1,4,0)
 ;;=4^F16.159
 ;;^UTILITY(U,$J,358.3,36885,2)
 ;;=^5003331
 ;;^UTILITY(U,$J,358.3,36886,0)
 ;;=F16.259^^135^1822^8
 ;;^UTILITY(U,$J,358.3,36886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36886,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36886,1,4,0)
 ;;=4^F16.259
 ;;^UTILITY(U,$J,358.3,36886,2)
 ;;=^5003344
 ;;^UTILITY(U,$J,358.3,36887,0)
 ;;=F16.959^^135^1822^9
 ;;^UTILITY(U,$J,358.3,36887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36887,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36887,1,4,0)
 ;;=4^F16.959
 ;;^UTILITY(U,$J,358.3,36887,2)
 ;;=^5003356
 ;;^UTILITY(U,$J,358.3,36888,0)
 ;;=F16.99^^135^1822^38
 ;;^UTILITY(U,$J,358.3,36888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36888,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,36888,1,4,0)
 ;;=4^F16.99
 ;;^UTILITY(U,$J,358.3,36888,2)
 ;;=^5133359
 ;;^UTILITY(U,$J,358.3,36889,0)
 ;;=F16.983^^135^1822^16
 ;;^UTILITY(U,$J,358.3,36889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36889,1,3,0)
 ;;=3^Hallucinogen Persisting Perception Disorder
 ;;^UTILITY(U,$J,358.3,36889,1,4,0)
 ;;=4^F16.983
 ;;^UTILITY(U,$J,358.3,36889,2)
 ;;=^5003358
 ;;^UTILITY(U,$J,358.3,36890,0)
 ;;=F16.20^^135^1822^37
 ;;^UTILITY(U,$J,358.3,36890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36890,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,36890,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,36890,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,36891,0)
 ;;=F16.180^^135^1822^17
 ;;^UTILITY(U,$J,358.3,36891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36891,1,3,0)
 ;;=3^Phencyclidine Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,36891,1,4,0)
 ;;=4^F16.180
 ;;^UTILITY(U,$J,358.3,36891,2)
 ;;=^5003332
 ;;^UTILITY(U,$J,358.3,36892,0)
 ;;=F16.280^^135^1822^18
 ;;^UTILITY(U,$J,358.3,36892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36892,1,3,0)
 ;;=3^Phencyclidine Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36892,1,4,0)
 ;;=4^F16.280
 ;;^UTILITY(U,$J,358.3,36892,2)
 ;;=^5003345
 ;;^UTILITY(U,$J,358.3,36893,0)
 ;;=F16.980^^135^1822^19
 ;;^UTILITY(U,$J,358.3,36893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36893,1,3,0)
 ;;=3^Phencyclidine Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36893,1,4,0)
 ;;=4^F16.980
 ;;^UTILITY(U,$J,358.3,36893,2)
 ;;=^5003357
 ;;^UTILITY(U,$J,358.3,36894,0)
 ;;=F16.14^^135^1822^20
 ;;^UTILITY(U,$J,358.3,36894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36894,1,3,0)
 ;;=3^Phencyclidine Induced Bipolar & Related Disorder w/ Mild Use Disorder
