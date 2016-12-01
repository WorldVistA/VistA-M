IBDEI0KR ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26264,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,26264,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,26265,0)
 ;;=F18.921^^69^1090^18
 ;;^UTILITY(U,$J,358.3,26265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26265,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26265,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,26265,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,26266,0)
 ;;=F18.129^^69^1090^19
 ;;^UTILITY(U,$J,358.3,26266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26266,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26266,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,26266,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,26267,0)
 ;;=F18.229^^69^1090^20
 ;;^UTILITY(U,$J,358.3,26267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26267,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26267,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,26267,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,26268,0)
 ;;=F18.929^^69^1090^21
 ;;^UTILITY(U,$J,358.3,26268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26268,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26268,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,26268,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,26269,0)
 ;;=F18.180^^69^1090^1
 ;;^UTILITY(U,$J,358.3,26269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26269,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26269,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,26269,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,26270,0)
 ;;=F18.280^^69^1090^2
 ;;^UTILITY(U,$J,358.3,26270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26270,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26270,1,4,0)
 ;;=4^F18.280
 ;;^UTILITY(U,$J,358.3,26270,2)
 ;;=^5003402
 ;;^UTILITY(U,$J,358.3,26271,0)
 ;;=F18.980^^69^1090^3
 ;;^UTILITY(U,$J,358.3,26271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26271,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26271,1,4,0)
 ;;=4^F18.980
 ;;^UTILITY(U,$J,358.3,26271,2)
 ;;=^5003414
 ;;^UTILITY(U,$J,358.3,26272,0)
 ;;=F18.94^^69^1090^6
 ;;^UTILITY(U,$J,358.3,26272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26272,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26272,1,4,0)
 ;;=4^F18.94
 ;;^UTILITY(U,$J,358.3,26272,2)
 ;;=^5003409
 ;;^UTILITY(U,$J,358.3,26273,0)
 ;;=F18.17^^69^1090^7
 ;;^UTILITY(U,$J,358.3,26273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26273,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26273,1,4,0)
 ;;=4^F18.17
 ;;^UTILITY(U,$J,358.3,26273,2)
 ;;=^5003388
 ;;^UTILITY(U,$J,358.3,26274,0)
 ;;=F18.27^^69^1090^8
 ;;^UTILITY(U,$J,358.3,26274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26274,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26274,1,4,0)
 ;;=4^F18.27
 ;;^UTILITY(U,$J,358.3,26274,2)
 ;;=^5003401
 ;;^UTILITY(U,$J,358.3,26275,0)
 ;;=F18.97^^69^1090^9
 ;;^UTILITY(U,$J,358.3,26275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26275,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26275,1,4,0)
 ;;=4^F18.97
 ;;^UTILITY(U,$J,358.3,26275,2)
 ;;=^5003413
 ;;^UTILITY(U,$J,358.3,26276,0)
 ;;=F18.188^^69^1090^10
 ;;^UTILITY(U,$J,358.3,26276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26276,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26276,1,4,0)
 ;;=4^F18.188
 ;;^UTILITY(U,$J,358.3,26276,2)
 ;;=^5003390
 ;;^UTILITY(U,$J,358.3,26277,0)
 ;;=F18.288^^69^1090^11
 ;;^UTILITY(U,$J,358.3,26277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26277,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26277,1,4,0)
 ;;=4^F18.288
 ;;^UTILITY(U,$J,358.3,26277,2)
 ;;=^5003403
 ;;^UTILITY(U,$J,358.3,26278,0)
 ;;=F18.988^^69^1090^12
 ;;^UTILITY(U,$J,358.3,26278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26278,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26278,1,4,0)
 ;;=4^F18.988
 ;;^UTILITY(U,$J,358.3,26278,2)
 ;;=^5003415
 ;;^UTILITY(U,$J,358.3,26279,0)
 ;;=F18.159^^69^1090^13
 ;;^UTILITY(U,$J,358.3,26279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26279,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26279,1,4,0)
 ;;=4^F18.159
 ;;^UTILITY(U,$J,358.3,26279,2)
 ;;=^5003387
 ;;^UTILITY(U,$J,358.3,26280,0)
 ;;=F18.259^^69^1090^14
 ;;^UTILITY(U,$J,358.3,26280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26280,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26280,1,4,0)
 ;;=4^F18.259
 ;;^UTILITY(U,$J,358.3,26280,2)
 ;;=^5003400
 ;;^UTILITY(U,$J,358.3,26281,0)
 ;;=F18.959^^69^1090^15
 ;;^UTILITY(U,$J,358.3,26281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26281,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26281,1,4,0)
 ;;=4^F18.959
 ;;^UTILITY(U,$J,358.3,26281,2)
 ;;=^5003412
 ;;^UTILITY(U,$J,358.3,26282,0)
 ;;=F18.99^^69^1090^22
 ;;^UTILITY(U,$J,358.3,26282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26282,1,3,0)
 ;;=3^Inhalant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26282,1,4,0)
 ;;=4^F18.99
 ;;^UTILITY(U,$J,358.3,26282,2)
 ;;=^5133360
 ;;^UTILITY(U,$J,358.3,26283,0)
 ;;=F18.20^^69^1090^25
 ;;^UTILITY(U,$J,358.3,26283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26283,1,3,0)
 ;;=3^Inhalant Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,26283,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,26283,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,26284,0)
 ;;=Z00.6^^69^1091^1
 ;;^UTILITY(U,$J,358.3,26284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26284,1,3,0)
 ;;=3^Exam of Participant of Control in Clinical Research Program
 ;;^UTILITY(U,$J,358.3,26284,1,4,0)
 ;;=4^Z00.6
 ;;^UTILITY(U,$J,358.3,26284,2)
 ;;=^5062608
 ;;^UTILITY(U,$J,358.3,26285,0)
 ;;=F45.22^^69^1092^1
 ;;^UTILITY(U,$J,358.3,26285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26285,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,26285,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,26285,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,26286,0)
 ;;=F45.8^^69^1092^16
 ;;^UTILITY(U,$J,358.3,26286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26286,1,3,0)
 ;;=3^Somatoform Disorders,Other Specified
 ;;^UTILITY(U,$J,358.3,26286,1,4,0)
 ;;=4^F45.8
 ;;^UTILITY(U,$J,358.3,26286,2)
 ;;=^331915
 ;;^UTILITY(U,$J,358.3,26287,0)
 ;;=F45.0^^69^1092^14
 ;;^UTILITY(U,$J,358.3,26287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26287,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,26287,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,26287,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,26288,0)
 ;;=F45.9^^69^1092^15
 ;;^UTILITY(U,$J,358.3,26288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26288,1,3,0)
 ;;=3^Somatoform Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26288,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,26288,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,26289,0)
 ;;=F45.1^^69^1092^13
 ;;^UTILITY(U,$J,358.3,26289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26289,1,3,0)
 ;;=3^Somatic Symptom Disorder
 ;;^UTILITY(U,$J,358.3,26289,1,4,0)
 ;;=4^F45.1
 ;;^UTILITY(U,$J,358.3,26289,2)
 ;;=^5003585
 ;;^UTILITY(U,$J,358.3,26290,0)
 ;;=F44.4^^69^1092^2
 ;;^UTILITY(U,$J,358.3,26290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26290,1,3,0)
 ;;=3^Conversion Disorder w/ Abnormal Movement
 ;;^UTILITY(U,$J,358.3,26290,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,26290,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,26291,0)
 ;;=F44.6^^69^1092^3
 ;;^UTILITY(U,$J,358.3,26291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26291,1,3,0)
 ;;=3^Conversion Disorder w/ Anesthesia or Sensory Loss
 ;;^UTILITY(U,$J,358.3,26291,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,26291,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,26292,0)
 ;;=F44.5^^69^1092^4
 ;;^UTILITY(U,$J,358.3,26292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26292,1,3,0)
 ;;=3^Conversion Disorder w/ Attacks or Seizures
 ;;^UTILITY(U,$J,358.3,26292,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,26292,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,26293,0)
 ;;=F44.7^^69^1092^5
 ;;^UTILITY(U,$J,358.3,26293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26293,1,3,0)
 ;;=3^Conversion Disorder w/ Mixed Symptoms
 ;;^UTILITY(U,$J,358.3,26293,1,4,0)
 ;;=4^F44.7
 ;;^UTILITY(U,$J,358.3,26293,2)
 ;;=^5003582
 ;;^UTILITY(U,$J,358.3,26294,0)
 ;;=F68.10^^69^1092^10
 ;;^UTILITY(U,$J,358.3,26294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26294,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,26294,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,26294,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,26295,0)
 ;;=F54.^^69^1092^12
 ;;^UTILITY(U,$J,358.3,26295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26295,1,3,0)
 ;;=3^Psychological Factors Affecting Other Med Conditions
 ;;^UTILITY(U,$J,358.3,26295,1,4,0)
 ;;=4^F54.
 ;;^UTILITY(U,$J,358.3,26295,2)
 ;;=^5003627
 ;;^UTILITY(U,$J,358.3,26296,0)
 ;;=F44.6^^69^1092^6
 ;;^UTILITY(U,$J,358.3,26296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26296,1,3,0)
 ;;=3^Conversion Disorder w/ Special Sensory Symptom
 ;;^UTILITY(U,$J,358.3,26296,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,26296,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,26297,0)
 ;;=F44.4^^69^1092^7
 ;;^UTILITY(U,$J,358.3,26297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26297,1,3,0)
 ;;=3^Conversion Disorder w/ Speech Symptom
 ;;^UTILITY(U,$J,358.3,26297,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,26297,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,26298,0)
 ;;=F44.4^^69^1092^8
 ;;^UTILITY(U,$J,358.3,26298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26298,1,3,0)
 ;;=3^Conversion Disorder w/ Swallowing Symptom
