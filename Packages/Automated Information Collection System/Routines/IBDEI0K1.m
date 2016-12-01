IBDEI0K1 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25356,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25356,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,25356,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,25357,0)
 ;;=F18.180^^66^1023^1
 ;;^UTILITY(U,$J,358.3,25357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25357,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25357,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,25357,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,25358,0)
 ;;=F18.280^^66^1023^2
 ;;^UTILITY(U,$J,358.3,25358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25358,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25358,1,4,0)
 ;;=4^F18.280
 ;;^UTILITY(U,$J,358.3,25358,2)
 ;;=^5003402
 ;;^UTILITY(U,$J,358.3,25359,0)
 ;;=F18.980^^66^1023^3
 ;;^UTILITY(U,$J,358.3,25359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25359,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25359,1,4,0)
 ;;=4^F18.980
 ;;^UTILITY(U,$J,358.3,25359,2)
 ;;=^5003414
 ;;^UTILITY(U,$J,358.3,25360,0)
 ;;=F18.94^^66^1023^6
 ;;^UTILITY(U,$J,358.3,25360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25360,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25360,1,4,0)
 ;;=4^F18.94
 ;;^UTILITY(U,$J,358.3,25360,2)
 ;;=^5003409
 ;;^UTILITY(U,$J,358.3,25361,0)
 ;;=F18.17^^66^1023^7
 ;;^UTILITY(U,$J,358.3,25361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25361,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25361,1,4,0)
 ;;=4^F18.17
 ;;^UTILITY(U,$J,358.3,25361,2)
 ;;=^5003388
 ;;^UTILITY(U,$J,358.3,25362,0)
 ;;=F18.27^^66^1023^8
 ;;^UTILITY(U,$J,358.3,25362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25362,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25362,1,4,0)
 ;;=4^F18.27
 ;;^UTILITY(U,$J,358.3,25362,2)
 ;;=^5003401
 ;;^UTILITY(U,$J,358.3,25363,0)
 ;;=F18.97^^66^1023^9
 ;;^UTILITY(U,$J,358.3,25363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25363,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25363,1,4,0)
 ;;=4^F18.97
 ;;^UTILITY(U,$J,358.3,25363,2)
 ;;=^5003413
 ;;^UTILITY(U,$J,358.3,25364,0)
 ;;=F18.188^^66^1023^10
 ;;^UTILITY(U,$J,358.3,25364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25364,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25364,1,4,0)
 ;;=4^F18.188
 ;;^UTILITY(U,$J,358.3,25364,2)
 ;;=^5003390
 ;;^UTILITY(U,$J,358.3,25365,0)
 ;;=F18.288^^66^1023^11
 ;;^UTILITY(U,$J,358.3,25365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25365,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25365,1,4,0)
 ;;=4^F18.288
 ;;^UTILITY(U,$J,358.3,25365,2)
 ;;=^5003403
 ;;^UTILITY(U,$J,358.3,25366,0)
 ;;=F18.988^^66^1023^12
 ;;^UTILITY(U,$J,358.3,25366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25366,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25366,1,4,0)
 ;;=4^F18.988
 ;;^UTILITY(U,$J,358.3,25366,2)
 ;;=^5003415
 ;;^UTILITY(U,$J,358.3,25367,0)
 ;;=F18.159^^66^1023^13
 ;;^UTILITY(U,$J,358.3,25367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25367,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25367,1,4,0)
 ;;=4^F18.159
 ;;^UTILITY(U,$J,358.3,25367,2)
 ;;=^5003387
 ;;^UTILITY(U,$J,358.3,25368,0)
 ;;=F18.259^^66^1023^14
 ;;^UTILITY(U,$J,358.3,25368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25368,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25368,1,4,0)
 ;;=4^F18.259
 ;;^UTILITY(U,$J,358.3,25368,2)
 ;;=^5003400
 ;;^UTILITY(U,$J,358.3,25369,0)
 ;;=F18.959^^66^1023^15
 ;;^UTILITY(U,$J,358.3,25369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25369,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25369,1,4,0)
 ;;=4^F18.959
 ;;^UTILITY(U,$J,358.3,25369,2)
 ;;=^5003412
 ;;^UTILITY(U,$J,358.3,25370,0)
 ;;=F18.99^^66^1023^22
 ;;^UTILITY(U,$J,358.3,25370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25370,1,3,0)
 ;;=3^Inhalant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25370,1,4,0)
 ;;=4^F18.99
 ;;^UTILITY(U,$J,358.3,25370,2)
 ;;=^5133360
 ;;^UTILITY(U,$J,358.3,25371,0)
 ;;=F18.20^^66^1023^25
 ;;^UTILITY(U,$J,358.3,25371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25371,1,3,0)
 ;;=3^Inhalant Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,25371,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,25371,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,25372,0)
 ;;=Z00.6^^66^1024^1
 ;;^UTILITY(U,$J,358.3,25372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25372,1,3,0)
 ;;=3^Exam of Participant of Control in Clinical Research Program
 ;;^UTILITY(U,$J,358.3,25372,1,4,0)
 ;;=4^Z00.6
 ;;^UTILITY(U,$J,358.3,25372,2)
 ;;=^5062608
 ;;^UTILITY(U,$J,358.3,25373,0)
 ;;=F45.22^^66^1025^1
 ;;^UTILITY(U,$J,358.3,25373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25373,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,25373,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,25373,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,25374,0)
 ;;=F45.8^^66^1025^16
 ;;^UTILITY(U,$J,358.3,25374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25374,1,3,0)
 ;;=3^Somatoform Disorders,Other Specified
 ;;^UTILITY(U,$J,358.3,25374,1,4,0)
 ;;=4^F45.8
 ;;^UTILITY(U,$J,358.3,25374,2)
 ;;=^331915
 ;;^UTILITY(U,$J,358.3,25375,0)
 ;;=F45.0^^66^1025^14
 ;;^UTILITY(U,$J,358.3,25375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25375,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,25375,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,25375,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,25376,0)
 ;;=F45.9^^66^1025^15
 ;;^UTILITY(U,$J,358.3,25376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25376,1,3,0)
 ;;=3^Somatoform Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25376,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,25376,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,25377,0)
 ;;=F45.1^^66^1025^13
 ;;^UTILITY(U,$J,358.3,25377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25377,1,3,0)
 ;;=3^Somatic Symptom Disorder
 ;;^UTILITY(U,$J,358.3,25377,1,4,0)
 ;;=4^F45.1
 ;;^UTILITY(U,$J,358.3,25377,2)
 ;;=^5003585
 ;;^UTILITY(U,$J,358.3,25378,0)
 ;;=F44.4^^66^1025^2
 ;;^UTILITY(U,$J,358.3,25378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25378,1,3,0)
 ;;=3^Conversion Disorder w/ Abnormal Movement
 ;;^UTILITY(U,$J,358.3,25378,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,25378,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,25379,0)
 ;;=F44.6^^66^1025^3
 ;;^UTILITY(U,$J,358.3,25379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25379,1,3,0)
 ;;=3^Conversion Disorder w/ Anesthesia or Sensory Loss
 ;;^UTILITY(U,$J,358.3,25379,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,25379,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,25380,0)
 ;;=F44.5^^66^1025^4
 ;;^UTILITY(U,$J,358.3,25380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25380,1,3,0)
 ;;=3^Conversion Disorder w/ Attacks or Seizures
 ;;^UTILITY(U,$J,358.3,25380,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,25380,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,25381,0)
 ;;=F44.7^^66^1025^5
 ;;^UTILITY(U,$J,358.3,25381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25381,1,3,0)
 ;;=3^Conversion Disorder w/ Mixed Symptoms
 ;;^UTILITY(U,$J,358.3,25381,1,4,0)
 ;;=4^F44.7
 ;;^UTILITY(U,$J,358.3,25381,2)
 ;;=^5003582
 ;;^UTILITY(U,$J,358.3,25382,0)
 ;;=F68.10^^66^1025^10
 ;;^UTILITY(U,$J,358.3,25382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25382,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,25382,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,25382,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,25383,0)
 ;;=F54.^^66^1025^12
 ;;^UTILITY(U,$J,358.3,25383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25383,1,3,0)
 ;;=3^Psychological Factors Affecting Other Med Conditions
 ;;^UTILITY(U,$J,358.3,25383,1,4,0)
 ;;=4^F54.
 ;;^UTILITY(U,$J,358.3,25383,2)
 ;;=^5003627
 ;;^UTILITY(U,$J,358.3,25384,0)
 ;;=F44.6^^66^1025^6
 ;;^UTILITY(U,$J,358.3,25384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25384,1,3,0)
 ;;=3^Conversion Disorder w/ Special Sensory Symptom
 ;;^UTILITY(U,$J,358.3,25384,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,25384,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,25385,0)
 ;;=F44.4^^66^1025^7
 ;;^UTILITY(U,$J,358.3,25385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25385,1,3,0)
 ;;=3^Conversion Disorder w/ Speech Symptom
 ;;^UTILITY(U,$J,358.3,25385,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,25385,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,25386,0)
 ;;=F44.4^^66^1025^8
 ;;^UTILITY(U,$J,358.3,25386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25386,1,3,0)
 ;;=3^Conversion Disorder w/ Swallowing Symptom
 ;;^UTILITY(U,$J,358.3,25386,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,25386,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,25387,0)
 ;;=F44.4^^66^1025^9
 ;;^UTILITY(U,$J,358.3,25387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25387,1,3,0)
 ;;=3^Conversion Disorder w/ Weakness or Paralysis
 ;;^UTILITY(U,$J,358.3,25387,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,25387,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,25388,0)
 ;;=F45.21^^66^1025^11
 ;;^UTILITY(U,$J,358.3,25388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25388,1,3,0)
 ;;=3^Illness Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,25388,1,4,0)
 ;;=4^F45.21
 ;;^UTILITY(U,$J,358.3,25388,2)
 ;;=^5003587
 ;;^UTILITY(U,$J,358.3,25389,0)
 ;;=F91.2^^66^1026^1
 ;;^UTILITY(U,$J,358.3,25389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25389,1,3,0)
 ;;=3^Conduct Disorder,Adolescent-Onset Type
 ;;^UTILITY(U,$J,358.3,25389,1,4,0)
 ;;=4^F91.2
 ;;^UTILITY(U,$J,358.3,25389,2)
 ;;=^5003699
 ;;^UTILITY(U,$J,358.3,25390,0)
 ;;=F91.1^^66^1026^2
 ;;^UTILITY(U,$J,358.3,25390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25390,1,3,0)
 ;;=3^Conduct Disorder,Childhood-Onset Type
