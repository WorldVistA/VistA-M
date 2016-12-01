IBDEI0OR ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31384,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,31384,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,31384,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,31385,0)
 ;;=F43.10^^91^1363^9
 ;;^UTILITY(U,$J,358.3,31385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31385,1,3,0)
 ;;=3^Post-traumatic Stress Disorder
 ;;^UTILITY(U,$J,358.3,31385,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,31385,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,31386,0)
 ;;=F18.10^^91^1364^23
 ;;^UTILITY(U,$J,358.3,31386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31386,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,31386,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,31386,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,31387,0)
 ;;=F18.20^^91^1364^24
 ;;^UTILITY(U,$J,358.3,31387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31387,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,31387,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,31387,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,31388,0)
 ;;=F18.14^^91^1364^4
 ;;^UTILITY(U,$J,358.3,31388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31388,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31388,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,31388,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,31389,0)
 ;;=F18.24^^91^1364^5
 ;;^UTILITY(U,$J,358.3,31389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31389,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31389,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,31389,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,31390,0)
 ;;=F18.121^^91^1364^16
 ;;^UTILITY(U,$J,358.3,31390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31390,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31390,1,4,0)
 ;;=4^F18.121
 ;;^UTILITY(U,$J,358.3,31390,2)
 ;;=^5003382
 ;;^UTILITY(U,$J,358.3,31391,0)
 ;;=F18.221^^91^1364^17
 ;;^UTILITY(U,$J,358.3,31391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31391,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31391,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,31391,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,31392,0)
 ;;=F18.921^^91^1364^18
 ;;^UTILITY(U,$J,358.3,31392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31392,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31392,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,31392,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,31393,0)
 ;;=F18.129^^91^1364^19
 ;;^UTILITY(U,$J,358.3,31393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31393,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31393,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,31393,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,31394,0)
 ;;=F18.229^^91^1364^20
 ;;^UTILITY(U,$J,358.3,31394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31394,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31394,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,31394,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,31395,0)
 ;;=F18.929^^91^1364^21
 ;;^UTILITY(U,$J,358.3,31395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31395,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31395,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,31395,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,31396,0)
 ;;=F18.180^^91^1364^1
 ;;^UTILITY(U,$J,358.3,31396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31396,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31396,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,31396,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,31397,0)
 ;;=F18.280^^91^1364^2
 ;;^UTILITY(U,$J,358.3,31397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31397,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31397,1,4,0)
 ;;=4^F18.280
 ;;^UTILITY(U,$J,358.3,31397,2)
 ;;=^5003402
 ;;^UTILITY(U,$J,358.3,31398,0)
 ;;=F18.980^^91^1364^3
 ;;^UTILITY(U,$J,358.3,31398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31398,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31398,1,4,0)
 ;;=4^F18.980
 ;;^UTILITY(U,$J,358.3,31398,2)
 ;;=^5003414
 ;;^UTILITY(U,$J,358.3,31399,0)
 ;;=F18.94^^91^1364^6
 ;;^UTILITY(U,$J,358.3,31399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31399,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31399,1,4,0)
 ;;=4^F18.94
 ;;^UTILITY(U,$J,358.3,31399,2)
 ;;=^5003409
 ;;^UTILITY(U,$J,358.3,31400,0)
 ;;=F18.17^^91^1364^7
 ;;^UTILITY(U,$J,358.3,31400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31400,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31400,1,4,0)
 ;;=4^F18.17
 ;;^UTILITY(U,$J,358.3,31400,2)
 ;;=^5003388
 ;;^UTILITY(U,$J,358.3,31401,0)
 ;;=F18.27^^91^1364^8
 ;;^UTILITY(U,$J,358.3,31401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31401,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31401,1,4,0)
 ;;=4^F18.27
 ;;^UTILITY(U,$J,358.3,31401,2)
 ;;=^5003401
 ;;^UTILITY(U,$J,358.3,31402,0)
 ;;=F18.97^^91^1364^9
 ;;^UTILITY(U,$J,358.3,31402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31402,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31402,1,4,0)
 ;;=4^F18.97
 ;;^UTILITY(U,$J,358.3,31402,2)
 ;;=^5003413
 ;;^UTILITY(U,$J,358.3,31403,0)
 ;;=F18.188^^91^1364^10
 ;;^UTILITY(U,$J,358.3,31403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31403,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31403,1,4,0)
 ;;=4^F18.188
 ;;^UTILITY(U,$J,358.3,31403,2)
 ;;=^5003390
 ;;^UTILITY(U,$J,358.3,31404,0)
 ;;=F18.288^^91^1364^11
 ;;^UTILITY(U,$J,358.3,31404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31404,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31404,1,4,0)
 ;;=4^F18.288
 ;;^UTILITY(U,$J,358.3,31404,2)
 ;;=^5003403
 ;;^UTILITY(U,$J,358.3,31405,0)
 ;;=F18.988^^91^1364^12
 ;;^UTILITY(U,$J,358.3,31405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31405,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31405,1,4,0)
 ;;=4^F18.988
 ;;^UTILITY(U,$J,358.3,31405,2)
 ;;=^5003415
 ;;^UTILITY(U,$J,358.3,31406,0)
 ;;=F18.159^^91^1364^13
 ;;^UTILITY(U,$J,358.3,31406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31406,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31406,1,4,0)
 ;;=4^F18.159
 ;;^UTILITY(U,$J,358.3,31406,2)
 ;;=^5003387
 ;;^UTILITY(U,$J,358.3,31407,0)
 ;;=F18.259^^91^1364^14
 ;;^UTILITY(U,$J,358.3,31407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31407,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31407,1,4,0)
 ;;=4^F18.259
 ;;^UTILITY(U,$J,358.3,31407,2)
 ;;=^5003400
 ;;^UTILITY(U,$J,358.3,31408,0)
 ;;=F18.959^^91^1364^15
 ;;^UTILITY(U,$J,358.3,31408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31408,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31408,1,4,0)
 ;;=4^F18.959
 ;;^UTILITY(U,$J,358.3,31408,2)
 ;;=^5003412
 ;;^UTILITY(U,$J,358.3,31409,0)
 ;;=F18.99^^91^1364^22
 ;;^UTILITY(U,$J,358.3,31409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31409,1,3,0)
 ;;=3^Inhalant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,31409,1,4,0)
 ;;=4^F18.99
 ;;^UTILITY(U,$J,358.3,31409,2)
 ;;=^5133360
 ;;^UTILITY(U,$J,358.3,31410,0)
 ;;=F18.20^^91^1364^25
 ;;^UTILITY(U,$J,358.3,31410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31410,1,3,0)
 ;;=3^Inhalant Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,31410,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,31410,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,31411,0)
 ;;=Z00.6^^91^1365^1
 ;;^UTILITY(U,$J,358.3,31411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31411,1,3,0)
 ;;=3^Exam of Participant of Control in Clinical Research Program
 ;;^UTILITY(U,$J,358.3,31411,1,4,0)
 ;;=4^Z00.6
 ;;^UTILITY(U,$J,358.3,31411,2)
 ;;=^5062608
 ;;^UTILITY(U,$J,358.3,31412,0)
 ;;=F45.22^^91^1366^1
 ;;^UTILITY(U,$J,358.3,31412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31412,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,31412,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,31412,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,31413,0)
 ;;=F45.8^^91^1366^16
 ;;^UTILITY(U,$J,358.3,31413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31413,1,3,0)
 ;;=3^Somatoform Disorders,Other Specified
 ;;^UTILITY(U,$J,358.3,31413,1,4,0)
 ;;=4^F45.8
 ;;^UTILITY(U,$J,358.3,31413,2)
 ;;=^331915
 ;;^UTILITY(U,$J,358.3,31414,0)
 ;;=F45.0^^91^1366^14
 ;;^UTILITY(U,$J,358.3,31414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31414,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,31414,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,31414,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,31415,0)
 ;;=F45.9^^91^1366^15
 ;;^UTILITY(U,$J,358.3,31415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31415,1,3,0)
 ;;=3^Somatoform Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,31415,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,31415,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,31416,0)
 ;;=F45.1^^91^1366^13
 ;;^UTILITY(U,$J,358.3,31416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31416,1,3,0)
 ;;=3^Somatic Symptom Disorder
 ;;^UTILITY(U,$J,358.3,31416,1,4,0)
 ;;=4^F45.1
 ;;^UTILITY(U,$J,358.3,31416,2)
 ;;=^5003585
 ;;^UTILITY(U,$J,358.3,31417,0)
 ;;=F44.4^^91^1366^2
 ;;^UTILITY(U,$J,358.3,31417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31417,1,3,0)
 ;;=3^Conversion Disorder w/ Abnormal Movement
 ;;^UTILITY(U,$J,358.3,31417,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,31417,2)
 ;;=^5003579
