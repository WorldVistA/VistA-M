IBDEI00Y ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,669,0)
 ;;=F94.2^^3^52^8
 ;;^UTILITY(U,$J,358.3,669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,669,1,3,0)
 ;;=3^Disinhibited Social Engagement Disorder
 ;;^UTILITY(U,$J,358.3,669,1,4,0)
 ;;=4^F94.2
 ;;^UTILITY(U,$J,358.3,669,2)
 ;;=^5003706
 ;;^UTILITY(U,$J,358.3,670,0)
 ;;=F43.8^^3^52^11
 ;;^UTILITY(U,$J,358.3,670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,670,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,670,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,670,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,671,0)
 ;;=F43.10^^3^52^9
 ;;^UTILITY(U,$J,358.3,671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,671,1,3,0)
 ;;=3^Post-traumatic Stress Disorder
 ;;^UTILITY(U,$J,358.3,671,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,671,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,672,0)
 ;;=F18.10^^3^53^23
 ;;^UTILITY(U,$J,358.3,672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,672,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,672,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,672,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,673,0)
 ;;=F18.20^^3^53^24
 ;;^UTILITY(U,$J,358.3,673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,673,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,673,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,673,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,674,0)
 ;;=F18.14^^3^53^4
 ;;^UTILITY(U,$J,358.3,674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,674,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,674,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,674,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,675,0)
 ;;=F18.24^^3^53^5
 ;;^UTILITY(U,$J,358.3,675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,675,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,675,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,675,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,676,0)
 ;;=F18.121^^3^53^16
 ;;^UTILITY(U,$J,358.3,676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,676,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,676,1,4,0)
 ;;=4^F18.121
 ;;^UTILITY(U,$J,358.3,676,2)
 ;;=^5003382
 ;;^UTILITY(U,$J,358.3,677,0)
 ;;=F18.221^^3^53^17
 ;;^UTILITY(U,$J,358.3,677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,677,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,677,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,677,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,678,0)
 ;;=F18.921^^3^53^18
 ;;^UTILITY(U,$J,358.3,678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,678,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,678,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,678,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,679,0)
 ;;=F18.129^^3^53^19
 ;;^UTILITY(U,$J,358.3,679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,679,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,679,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,679,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,680,0)
 ;;=F18.229^^3^53^20
 ;;^UTILITY(U,$J,358.3,680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,680,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,680,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,680,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,681,0)
 ;;=F18.929^^3^53^21
 ;;^UTILITY(U,$J,358.3,681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,681,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,681,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,681,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,682,0)
 ;;=F18.180^^3^53^1
 ;;^UTILITY(U,$J,358.3,682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,682,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,682,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,682,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,683,0)
 ;;=F18.280^^3^53^2
 ;;^UTILITY(U,$J,358.3,683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,683,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,683,1,4,0)
 ;;=4^F18.280
 ;;^UTILITY(U,$J,358.3,683,2)
 ;;=^5003402
 ;;^UTILITY(U,$J,358.3,684,0)
 ;;=F18.980^^3^53^3
 ;;^UTILITY(U,$J,358.3,684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,684,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,684,1,4,0)
 ;;=4^F18.980
 ;;^UTILITY(U,$J,358.3,684,2)
 ;;=^5003414
 ;;^UTILITY(U,$J,358.3,685,0)
 ;;=F18.94^^3^53^6
 ;;^UTILITY(U,$J,358.3,685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,685,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,685,1,4,0)
 ;;=4^F18.94
 ;;^UTILITY(U,$J,358.3,685,2)
 ;;=^5003409
 ;;^UTILITY(U,$J,358.3,686,0)
 ;;=F18.17^^3^53^7
 ;;^UTILITY(U,$J,358.3,686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,686,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,686,1,4,0)
 ;;=4^F18.17
 ;;^UTILITY(U,$J,358.3,686,2)
 ;;=^5003388
 ;;^UTILITY(U,$J,358.3,687,0)
 ;;=F18.27^^3^53^8
 ;;^UTILITY(U,$J,358.3,687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,687,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,687,1,4,0)
 ;;=4^F18.27
 ;;^UTILITY(U,$J,358.3,687,2)
 ;;=^5003401
 ;;^UTILITY(U,$J,358.3,688,0)
 ;;=F18.97^^3^53^9
 ;;^UTILITY(U,$J,358.3,688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,688,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,688,1,4,0)
 ;;=4^F18.97
 ;;^UTILITY(U,$J,358.3,688,2)
 ;;=^5003413
 ;;^UTILITY(U,$J,358.3,689,0)
 ;;=F18.188^^3^53^10
 ;;^UTILITY(U,$J,358.3,689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,689,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,689,1,4,0)
 ;;=4^F18.188
 ;;^UTILITY(U,$J,358.3,689,2)
 ;;=^5003390
 ;;^UTILITY(U,$J,358.3,690,0)
 ;;=F18.288^^3^53^11
 ;;^UTILITY(U,$J,358.3,690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,690,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,690,1,4,0)
 ;;=4^F18.288
 ;;^UTILITY(U,$J,358.3,690,2)
 ;;=^5003403
 ;;^UTILITY(U,$J,358.3,691,0)
 ;;=F18.988^^3^53^12
 ;;^UTILITY(U,$J,358.3,691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,691,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,691,1,4,0)
 ;;=4^F18.988
 ;;^UTILITY(U,$J,358.3,691,2)
 ;;=^5003415
 ;;^UTILITY(U,$J,358.3,692,0)
 ;;=F18.159^^3^53^13
 ;;^UTILITY(U,$J,358.3,692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,692,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,692,1,4,0)
 ;;=4^F18.159
 ;;^UTILITY(U,$J,358.3,692,2)
 ;;=^5003387
 ;;^UTILITY(U,$J,358.3,693,0)
 ;;=F18.259^^3^53^14
 ;;^UTILITY(U,$J,358.3,693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,693,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,693,1,4,0)
 ;;=4^F18.259
 ;;^UTILITY(U,$J,358.3,693,2)
 ;;=^5003400
 ;;^UTILITY(U,$J,358.3,694,0)
 ;;=F18.959^^3^53^15
 ;;^UTILITY(U,$J,358.3,694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,694,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,694,1,4,0)
 ;;=4^F18.959
 ;;^UTILITY(U,$J,358.3,694,2)
 ;;=^5003412
 ;;^UTILITY(U,$J,358.3,695,0)
 ;;=F18.99^^3^53^22
 ;;^UTILITY(U,$J,358.3,695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,695,1,3,0)
 ;;=3^Inhalant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,695,1,4,0)
 ;;=4^F18.99
 ;;^UTILITY(U,$J,358.3,695,2)
 ;;=^5133360
 ;;^UTILITY(U,$J,358.3,696,0)
 ;;=F18.20^^3^53^25
 ;;^UTILITY(U,$J,358.3,696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,696,1,3,0)
 ;;=3^Inhalant Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,696,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,696,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,697,0)
 ;;=Z00.6^^3^54^1
 ;;^UTILITY(U,$J,358.3,697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,697,1,3,0)
 ;;=3^Exam of Participant of Control in Clinical Research Program
 ;;^UTILITY(U,$J,358.3,697,1,4,0)
 ;;=4^Z00.6
 ;;^UTILITY(U,$J,358.3,697,2)
 ;;=^5062608
 ;;^UTILITY(U,$J,358.3,698,0)
 ;;=F45.22^^3^55^1
 ;;^UTILITY(U,$J,358.3,698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,698,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,698,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,698,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,699,0)
 ;;=F45.8^^3^55^16
 ;;^UTILITY(U,$J,358.3,699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,699,1,3,0)
 ;;=3^Somatoform Disorders,Other Specified
 ;;^UTILITY(U,$J,358.3,699,1,4,0)
 ;;=4^F45.8
 ;;^UTILITY(U,$J,358.3,699,2)
 ;;=^331915
 ;;^UTILITY(U,$J,358.3,700,0)
 ;;=F45.0^^3^55^14
 ;;^UTILITY(U,$J,358.3,700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,700,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,700,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,700,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,701,0)
 ;;=F45.9^^3^55^15
 ;;^UTILITY(U,$J,358.3,701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,701,1,3,0)
 ;;=3^Somatoform Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,701,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,701,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,702,0)
 ;;=F45.1^^3^55^13
 ;;^UTILITY(U,$J,358.3,702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,702,1,3,0)
 ;;=3^Somatic Symptom Disorder
 ;;^UTILITY(U,$J,358.3,702,1,4,0)
 ;;=4^F45.1
 ;;^UTILITY(U,$J,358.3,702,2)
 ;;=^5003585
 ;;^UTILITY(U,$J,358.3,703,0)
 ;;=F44.4^^3^55^2
 ;;^UTILITY(U,$J,358.3,703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,703,1,3,0)
 ;;=3^Conversion Disorder w/ Abnormal Movement
 ;;^UTILITY(U,$J,358.3,703,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,703,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,704,0)
 ;;=F44.6^^3^55^3
 ;;^UTILITY(U,$J,358.3,704,1,0)
 ;;=^358.31IA^4^2
