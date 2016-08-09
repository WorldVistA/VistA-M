IBDEI0UC ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30500,0)
 ;;=F43.10^^113^1470^9
 ;;^UTILITY(U,$J,358.3,30500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30500,1,3,0)
 ;;=3^Post-traumatic Stress Disorder
 ;;^UTILITY(U,$J,358.3,30500,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,30500,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,30501,0)
 ;;=F18.10^^113^1471^23
 ;;^UTILITY(U,$J,358.3,30501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30501,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,30501,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,30501,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,30502,0)
 ;;=F18.20^^113^1471^24
 ;;^UTILITY(U,$J,358.3,30502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30502,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,30502,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,30502,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,30503,0)
 ;;=F18.14^^113^1471^4
 ;;^UTILITY(U,$J,358.3,30503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30503,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,30503,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,30503,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,30504,0)
 ;;=F18.24^^113^1471^5
 ;;^UTILITY(U,$J,358.3,30504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30504,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,30504,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,30504,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,30505,0)
 ;;=F18.121^^113^1471^16
 ;;^UTILITY(U,$J,358.3,30505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30505,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,30505,1,4,0)
 ;;=4^F18.121
 ;;^UTILITY(U,$J,358.3,30505,2)
 ;;=^5003382
 ;;^UTILITY(U,$J,358.3,30506,0)
 ;;=F18.221^^113^1471^17
 ;;^UTILITY(U,$J,358.3,30506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30506,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,30506,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,30506,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,30507,0)
 ;;=F18.921^^113^1471^18
 ;;^UTILITY(U,$J,358.3,30507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30507,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,30507,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,30507,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,30508,0)
 ;;=F18.129^^113^1471^19
 ;;^UTILITY(U,$J,358.3,30508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30508,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,30508,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,30508,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,30509,0)
 ;;=F18.229^^113^1471^20
 ;;^UTILITY(U,$J,358.3,30509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30509,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,30509,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,30509,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,30510,0)
 ;;=F18.929^^113^1471^21
 ;;^UTILITY(U,$J,358.3,30510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30510,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,30510,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,30510,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,30511,0)
 ;;=F18.180^^113^1471^1
 ;;^UTILITY(U,$J,358.3,30511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30511,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,30511,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,30511,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,30512,0)
 ;;=F18.280^^113^1471^2
 ;;^UTILITY(U,$J,358.3,30512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30512,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,30512,1,4,0)
 ;;=4^F18.280
 ;;^UTILITY(U,$J,358.3,30512,2)
 ;;=^5003402
 ;;^UTILITY(U,$J,358.3,30513,0)
 ;;=F18.980^^113^1471^3
 ;;^UTILITY(U,$J,358.3,30513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30513,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,30513,1,4,0)
 ;;=4^F18.980
 ;;^UTILITY(U,$J,358.3,30513,2)
 ;;=^5003414
 ;;^UTILITY(U,$J,358.3,30514,0)
 ;;=F18.94^^113^1471^6
 ;;^UTILITY(U,$J,358.3,30514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30514,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,30514,1,4,0)
 ;;=4^F18.94
 ;;^UTILITY(U,$J,358.3,30514,2)
 ;;=^5003409
 ;;^UTILITY(U,$J,358.3,30515,0)
 ;;=F18.17^^113^1471^7
 ;;^UTILITY(U,$J,358.3,30515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30515,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,30515,1,4,0)
 ;;=4^F18.17
 ;;^UTILITY(U,$J,358.3,30515,2)
 ;;=^5003388
 ;;^UTILITY(U,$J,358.3,30516,0)
 ;;=F18.27^^113^1471^8
 ;;^UTILITY(U,$J,358.3,30516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30516,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,30516,1,4,0)
 ;;=4^F18.27
 ;;^UTILITY(U,$J,358.3,30516,2)
 ;;=^5003401
 ;;^UTILITY(U,$J,358.3,30517,0)
 ;;=F18.97^^113^1471^9
 ;;^UTILITY(U,$J,358.3,30517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30517,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,30517,1,4,0)
 ;;=4^F18.97
 ;;^UTILITY(U,$J,358.3,30517,2)
 ;;=^5003413
 ;;^UTILITY(U,$J,358.3,30518,0)
 ;;=F18.188^^113^1471^10
 ;;^UTILITY(U,$J,358.3,30518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30518,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,30518,1,4,0)
 ;;=4^F18.188
 ;;^UTILITY(U,$J,358.3,30518,2)
 ;;=^5003390
 ;;^UTILITY(U,$J,358.3,30519,0)
 ;;=F18.288^^113^1471^11
 ;;^UTILITY(U,$J,358.3,30519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30519,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,30519,1,4,0)
 ;;=4^F18.288
 ;;^UTILITY(U,$J,358.3,30519,2)
 ;;=^5003403
 ;;^UTILITY(U,$J,358.3,30520,0)
 ;;=F18.988^^113^1471^12
 ;;^UTILITY(U,$J,358.3,30520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30520,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,30520,1,4,0)
 ;;=4^F18.988
 ;;^UTILITY(U,$J,358.3,30520,2)
 ;;=^5003415
 ;;^UTILITY(U,$J,358.3,30521,0)
 ;;=F18.159^^113^1471^13
 ;;^UTILITY(U,$J,358.3,30521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30521,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,30521,1,4,0)
 ;;=4^F18.159
 ;;^UTILITY(U,$J,358.3,30521,2)
 ;;=^5003387
 ;;^UTILITY(U,$J,358.3,30522,0)
 ;;=F18.259^^113^1471^14
 ;;^UTILITY(U,$J,358.3,30522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30522,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,30522,1,4,0)
 ;;=4^F18.259
 ;;^UTILITY(U,$J,358.3,30522,2)
 ;;=^5003400
 ;;^UTILITY(U,$J,358.3,30523,0)
 ;;=F18.959^^113^1471^15
 ;;^UTILITY(U,$J,358.3,30523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30523,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,30523,1,4,0)
 ;;=4^F18.959
 ;;^UTILITY(U,$J,358.3,30523,2)
 ;;=^5003412
 ;;^UTILITY(U,$J,358.3,30524,0)
 ;;=F18.99^^113^1471^22
 ;;^UTILITY(U,$J,358.3,30524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30524,1,3,0)
 ;;=3^Inhalant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,30524,1,4,0)
 ;;=4^F18.99
 ;;^UTILITY(U,$J,358.3,30524,2)
 ;;=^5133360
 ;;^UTILITY(U,$J,358.3,30525,0)
 ;;=F18.20^^113^1471^25
 ;;^UTILITY(U,$J,358.3,30525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30525,1,3,0)
 ;;=3^Inhalant Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,30525,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,30525,2)
 ;;=^5003392
