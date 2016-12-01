IBDEI0IQ ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23748,1,3,0)
 ;;=3^Reactive Attachment Disorder
 ;;^UTILITY(U,$J,358.3,23748,1,4,0)
 ;;=4^F94.1
 ;;^UTILITY(U,$J,358.3,23748,2)
 ;;=^5003705
 ;;^UTILITY(U,$J,358.3,23749,0)
 ;;=F94.2^^61^924^8
 ;;^UTILITY(U,$J,358.3,23749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23749,1,3,0)
 ;;=3^Disinhibited Social Engagement Disorder
 ;;^UTILITY(U,$J,358.3,23749,1,4,0)
 ;;=4^F94.2
 ;;^UTILITY(U,$J,358.3,23749,2)
 ;;=^5003706
 ;;^UTILITY(U,$J,358.3,23750,0)
 ;;=F43.8^^61^924^11
 ;;^UTILITY(U,$J,358.3,23750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23750,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,23750,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,23750,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,23751,0)
 ;;=F43.10^^61^924^9
 ;;^UTILITY(U,$J,358.3,23751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23751,1,3,0)
 ;;=3^Post-traumatic Stress Disorder
 ;;^UTILITY(U,$J,358.3,23751,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,23751,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,23752,0)
 ;;=F18.10^^61^925^23
 ;;^UTILITY(U,$J,358.3,23752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23752,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,23752,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,23752,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,23753,0)
 ;;=F18.20^^61^925^24
 ;;^UTILITY(U,$J,358.3,23753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23753,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,23753,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,23753,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,23754,0)
 ;;=F18.14^^61^925^4
 ;;^UTILITY(U,$J,358.3,23754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23754,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23754,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,23754,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,23755,0)
 ;;=F18.24^^61^925^5
 ;;^UTILITY(U,$J,358.3,23755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23755,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23755,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,23755,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,23756,0)
 ;;=F18.121^^61^925^16
 ;;^UTILITY(U,$J,358.3,23756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23756,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23756,1,4,0)
 ;;=4^F18.121
 ;;^UTILITY(U,$J,358.3,23756,2)
 ;;=^5003382
 ;;^UTILITY(U,$J,358.3,23757,0)
 ;;=F18.221^^61^925^17
 ;;^UTILITY(U,$J,358.3,23757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23757,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23757,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,23757,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,23758,0)
 ;;=F18.921^^61^925^18
 ;;^UTILITY(U,$J,358.3,23758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23758,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23758,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,23758,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,23759,0)
 ;;=F18.129^^61^925^19
 ;;^UTILITY(U,$J,358.3,23759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23759,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23759,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,23759,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,23760,0)
 ;;=F18.229^^61^925^20
 ;;^UTILITY(U,$J,358.3,23760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23760,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23760,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,23760,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,23761,0)
 ;;=F18.929^^61^925^21
 ;;^UTILITY(U,$J,358.3,23761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23761,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23761,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,23761,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,23762,0)
 ;;=F18.180^^61^925^1
 ;;^UTILITY(U,$J,358.3,23762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23762,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23762,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,23762,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,23763,0)
 ;;=F18.280^^61^925^2
 ;;^UTILITY(U,$J,358.3,23763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23763,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23763,1,4,0)
 ;;=4^F18.280
 ;;^UTILITY(U,$J,358.3,23763,2)
 ;;=^5003402
 ;;^UTILITY(U,$J,358.3,23764,0)
 ;;=F18.980^^61^925^3
 ;;^UTILITY(U,$J,358.3,23764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23764,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23764,1,4,0)
 ;;=4^F18.980
 ;;^UTILITY(U,$J,358.3,23764,2)
 ;;=^5003414
 ;;^UTILITY(U,$J,358.3,23765,0)
 ;;=F18.94^^61^925^6
 ;;^UTILITY(U,$J,358.3,23765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23765,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23765,1,4,0)
 ;;=4^F18.94
 ;;^UTILITY(U,$J,358.3,23765,2)
 ;;=^5003409
 ;;^UTILITY(U,$J,358.3,23766,0)
 ;;=F18.17^^61^925^7
 ;;^UTILITY(U,$J,358.3,23766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23766,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23766,1,4,0)
 ;;=4^F18.17
 ;;^UTILITY(U,$J,358.3,23766,2)
 ;;=^5003388
 ;;^UTILITY(U,$J,358.3,23767,0)
 ;;=F18.27^^61^925^8
 ;;^UTILITY(U,$J,358.3,23767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23767,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23767,1,4,0)
 ;;=4^F18.27
 ;;^UTILITY(U,$J,358.3,23767,2)
 ;;=^5003401
 ;;^UTILITY(U,$J,358.3,23768,0)
 ;;=F18.97^^61^925^9
 ;;^UTILITY(U,$J,358.3,23768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23768,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23768,1,4,0)
 ;;=4^F18.97
 ;;^UTILITY(U,$J,358.3,23768,2)
 ;;=^5003413
 ;;^UTILITY(U,$J,358.3,23769,0)
 ;;=F18.188^^61^925^10
 ;;^UTILITY(U,$J,358.3,23769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23769,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23769,1,4,0)
 ;;=4^F18.188
 ;;^UTILITY(U,$J,358.3,23769,2)
 ;;=^5003390
 ;;^UTILITY(U,$J,358.3,23770,0)
 ;;=F18.288^^61^925^11
 ;;^UTILITY(U,$J,358.3,23770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23770,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23770,1,4,0)
 ;;=4^F18.288
 ;;^UTILITY(U,$J,358.3,23770,2)
 ;;=^5003403
 ;;^UTILITY(U,$J,358.3,23771,0)
 ;;=F18.988^^61^925^12
 ;;^UTILITY(U,$J,358.3,23771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23771,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23771,1,4,0)
 ;;=4^F18.988
 ;;^UTILITY(U,$J,358.3,23771,2)
 ;;=^5003415
 ;;^UTILITY(U,$J,358.3,23772,0)
 ;;=F18.159^^61^925^13
 ;;^UTILITY(U,$J,358.3,23772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23772,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23772,1,4,0)
 ;;=4^F18.159
 ;;^UTILITY(U,$J,358.3,23772,2)
 ;;=^5003387
 ;;^UTILITY(U,$J,358.3,23773,0)
 ;;=F18.259^^61^925^14
 ;;^UTILITY(U,$J,358.3,23773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23773,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23773,1,4,0)
 ;;=4^F18.259
 ;;^UTILITY(U,$J,358.3,23773,2)
 ;;=^5003400
 ;;^UTILITY(U,$J,358.3,23774,0)
 ;;=F18.959^^61^925^15
 ;;^UTILITY(U,$J,358.3,23774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23774,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23774,1,4,0)
 ;;=4^F18.959
 ;;^UTILITY(U,$J,358.3,23774,2)
 ;;=^5003412
 ;;^UTILITY(U,$J,358.3,23775,0)
 ;;=F18.99^^61^925^22
 ;;^UTILITY(U,$J,358.3,23775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23775,1,3,0)
 ;;=3^Inhalant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,23775,1,4,0)
 ;;=4^F18.99
 ;;^UTILITY(U,$J,358.3,23775,2)
 ;;=^5133360
 ;;^UTILITY(U,$J,358.3,23776,0)
 ;;=F18.20^^61^925^25
 ;;^UTILITY(U,$J,358.3,23776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23776,1,3,0)
 ;;=3^Inhalant Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,23776,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,23776,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,23777,0)
 ;;=Z00.6^^61^926^1
 ;;^UTILITY(U,$J,358.3,23777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23777,1,3,0)
 ;;=3^Exam of Participant of Control in Clinical Research Program
 ;;^UTILITY(U,$J,358.3,23777,1,4,0)
 ;;=4^Z00.6
 ;;^UTILITY(U,$J,358.3,23777,2)
 ;;=^5062608
 ;;^UTILITY(U,$J,358.3,23778,0)
 ;;=F45.22^^61^927^1
 ;;^UTILITY(U,$J,358.3,23778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23778,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,23778,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,23778,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,23779,0)
 ;;=F45.8^^61^927^16
 ;;^UTILITY(U,$J,358.3,23779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23779,1,3,0)
 ;;=3^Somatoform Disorders,Other Specified
 ;;^UTILITY(U,$J,358.3,23779,1,4,0)
 ;;=4^F45.8
 ;;^UTILITY(U,$J,358.3,23779,2)
 ;;=^331915
 ;;^UTILITY(U,$J,358.3,23780,0)
 ;;=F45.0^^61^927^14
 ;;^UTILITY(U,$J,358.3,23780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23780,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,23780,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,23780,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,23781,0)
 ;;=F45.9^^61^927^15
 ;;^UTILITY(U,$J,358.3,23781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23781,1,3,0)
 ;;=3^Somatoform Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,23781,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,23781,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,23782,0)
 ;;=F45.1^^61^927^13
