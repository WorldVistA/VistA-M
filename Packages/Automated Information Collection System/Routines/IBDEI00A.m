IBDEI00A ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3)
 ;;=^IBE(358.3,
 ;;^UTILITY(U,$J,358.3,0)
 ;;=IMP/EXP SELECTION^358.3I^28013^27898
 ;;^UTILITY(U,$J,358.3,1,0)
 ;;=99441^^1^1^1^^^^1
 ;;^UTILITY(U,$J,358.3,1,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1,1,1,0)
 ;;=1^99441
 ;;^UTILITY(U,$J,358.3,1,1,2,0)
 ;;=2^PHONE E/M BY PHYS 5-10 MIN
 ;;^UTILITY(U,$J,358.3,2,0)
 ;;=99443^^1^1^3^^^^1
 ;;^UTILITY(U,$J,358.3,2,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,2,1,1,0)
 ;;=1^99443
 ;;^UTILITY(U,$J,358.3,2,1,2,0)
 ;;=2^PHONE E/M BY PHYS 21-30 MIN
 ;;^UTILITY(U,$J,358.3,3,0)
 ;;=99442^^1^1^2^^^^1
 ;;^UTILITY(U,$J,358.3,3,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,3,1,1,0)
 ;;=1^99442
 ;;^UTILITY(U,$J,358.3,3,1,2,0)
 ;;=2^PHONE E/M BY PHYS 11-20 MIN
 ;;^UTILITY(U,$J,358.3,4,0)
 ;;=98966^^1^2^1^^^^1
 ;;^UTILITY(U,$J,358.3,4,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,4,1,1,0)
 ;;=1^98966
 ;;^UTILITY(U,$J,358.3,4,1,2,0)
 ;;=2^HC PRO PHONE CALL 5-10 MIN
 ;;^UTILITY(U,$J,358.3,5,0)
 ;;=98967^^1^2^2^^^^1
 ;;^UTILITY(U,$J,358.3,5,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,5,1,1,0)
 ;;=1^98967
 ;;^UTILITY(U,$J,358.3,5,1,2,0)
 ;;=2^HC PRO PHONE CALL 11-20 MIN
 ;;^UTILITY(U,$J,358.3,6,0)
 ;;=98968^^1^2^3^^^^1
 ;;^UTILITY(U,$J,358.3,6,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,6,1,1,0)
 ;;=1^98968
 ;;^UTILITY(U,$J,358.3,6,1,2,0)
 ;;=2^HC PRO PHONE CALL 21-30 MIN
 ;;^UTILITY(U,$J,358.3,7,0)
 ;;=G40.A01^^2^3^3
 ;;^UTILITY(U,$J,358.3,7,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,7,1,4,0)
 ;;=4^G40.A01
 ;;^UTILITY(U,$J,358.3,7,2)
 ;;=^5003868
 ;;^UTILITY(U,$J,358.3,8,0)
 ;;=G40.A09^^2^3^4
 ;;^UTILITY(U,$J,358.3,8,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,8,1,4,0)
 ;;=4^G40.A09
 ;;^UTILITY(U,$J,358.3,8,2)
 ;;=^5003869
 ;;^UTILITY(U,$J,358.3,9,0)
 ;;=G40.A11^^2^3^1
 ;;^UTILITY(U,$J,358.3,9,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9,1,3,0)
 ;;=3^Absence Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9,1,4,0)
 ;;=4^G40.A11
 ;;^UTILITY(U,$J,358.3,9,2)
 ;;=^5003870
 ;;^UTILITY(U,$J,358.3,10,0)
 ;;=G40.A19^^2^3^2
 ;;^UTILITY(U,$J,358.3,10,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10,1,3,0)
 ;;=3^Absence Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,10,1,4,0)
 ;;=4^G40.A19
 ;;^UTILITY(U,$J,358.3,10,2)
 ;;=^5003871
 ;;^UTILITY(U,$J,358.3,11,0)
 ;;=G40.309^^2^3^16
 ;;^UTILITY(U,$J,358.3,11,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11,1,3,0)
 ;;=3^Generalized Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,11,1,4,0)
 ;;=4^G40.309
 ;;^UTILITY(U,$J,358.3,11,2)
 ;;=^5003842
 ;;^UTILITY(U,$J,358.3,12,0)
 ;;=G40.311^^2^3^14
 ;;^UTILITY(U,$J,358.3,12,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12,1,3,0)
 ;;=3^Generalized Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,12,1,4,0)
 ;;=4^G40.311
 ;;^UTILITY(U,$J,358.3,12,2)
 ;;=^5003843
 ;;^UTILITY(U,$J,358.3,13,0)
 ;;=G40.319^^2^3^15
 ;;^UTILITY(U,$J,358.3,13,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13,1,3,0)
 ;;=3^Generalized Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,13,1,4,0)
 ;;=4^G40.319
 ;;^UTILITY(U,$J,358.3,13,2)
 ;;=^5003844
 ;;^UTILITY(U,$J,358.3,14,0)
 ;;=G40.409^^2^3^19
 ;;^UTILITY(U,$J,358.3,14,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14,1,3,0)
 ;;=3^Generalized Seizures,Other, Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,14,1,4,0)
 ;;=4^G40.409
 ;;^UTILITY(U,$J,358.3,14,2)
 ;;=^5003846
 ;;^UTILITY(U,$J,358.3,15,0)
 ;;=G40.411^^2^3^17
 ;;^UTILITY(U,$J,358.3,15,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,15,1,4,0)
 ;;=4^G40.411
 ;;^UTILITY(U,$J,358.3,15,2)
 ;;=^5003847
 ;;^UTILITY(U,$J,358.3,16,0)
 ;;=G40.419^^2^3^18
 ;;^UTILITY(U,$J,358.3,16,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,16,1,4,0)
 ;;=4^G40.419
 ;;^UTILITY(U,$J,358.3,16,2)
 ;;=^5003848
 ;;^UTILITY(U,$J,358.3,17,0)
 ;;=G40.209^^2^3^7
 ;;^UTILITY(U,$J,358.3,17,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17,1,3,0)
 ;;=3^Complex Partial Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,17,1,4,0)
 ;;=4^G40.209
 ;;^UTILITY(U,$J,358.3,17,2)
 ;;=^5003838
 ;;^UTILITY(U,$J,358.3,18,0)
 ;;=G40.211^^2^3^5
 ;;^UTILITY(U,$J,358.3,18,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,18,1,4,0)
 ;;=4^G40.211
 ;;^UTILITY(U,$J,358.3,18,2)
 ;;=^5003839
 ;;^UTILITY(U,$J,358.3,19,0)
 ;;=G40.219^^2^3^6
 ;;^UTILITY(U,$J,358.3,19,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,19,1,4,0)
 ;;=4^G40.219
 ;;^UTILITY(U,$J,358.3,19,2)
 ;;=^5003840
 ;;^UTILITY(U,$J,358.3,20,0)
 ;;=G40.109^^2^3^27
 ;;^UTILITY(U,$J,358.3,20,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20,1,3,0)
 ;;=3^Simple Partial Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,20,1,4,0)
 ;;=4^G40.109
 ;;^UTILITY(U,$J,358.3,20,2)
 ;;=^5003834
 ;;^UTILITY(U,$J,358.3,21,0)
 ;;=G40.111^^2^3^25
 ;;^UTILITY(U,$J,358.3,21,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21,1,3,0)
 ;;=3^Simple Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,21,1,4,0)
 ;;=4^G40.111
 ;;^UTILITY(U,$J,358.3,21,2)
 ;;=^5003835
 ;;^UTILITY(U,$J,358.3,22,0)
 ;;=G40.119^^2^3^26
 ;;^UTILITY(U,$J,358.3,22,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22,1,3,0)
 ;;=3^Simple Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,22,1,4,0)
 ;;=4^G40.119
 ;;^UTILITY(U,$J,358.3,22,2)
 ;;=^5003836
 ;;^UTILITY(U,$J,358.3,23,0)
 ;;=G40.B09^^2^3^22
 ;;^UTILITY(U,$J,358.3,23,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,23,1,4,0)
 ;;=4^G40.B09
 ;;^UTILITY(U,$J,358.3,23,2)
 ;;=^5003873
 ;;^UTILITY(U,$J,358.3,24,0)
 ;;=G40.B11^^2^3^20
 ;;^UTILITY(U,$J,358.3,24,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,24,1,4,0)
 ;;=4^G40.B11
 ;;^UTILITY(U,$J,358.3,24,2)
 ;;=^5003874
 ;;^UTILITY(U,$J,358.3,25,0)
 ;;=G40.B19^^2^3^21
 ;;^UTILITY(U,$J,358.3,25,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,25,1,4,0)
 ;;=4^G40.B19
 ;;^UTILITY(U,$J,358.3,25,2)
 ;;=^5003875
 ;;^UTILITY(U,$J,358.3,26,0)
 ;;=G40.509^^2^3^13
 ;;^UTILITY(U,$J,358.3,26,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26,1,3,0)
 ;;=3^Epileptic Seizures d/t External Causes Not Intractalbe w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,26,1,4,0)
 ;;=4^G40.509
 ;;^UTILITY(U,$J,358.3,26,2)
 ;;=^5003850
 ;;^UTILITY(U,$J,358.3,27,0)
 ;;=G40.909^^2^3^12
 ;;^UTILITY(U,$J,358.3,27,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27,1,3,0)
 ;;=3^Epilepsy Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,27,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,27,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,28,0)
 ;;=G40.911^^2^3^10
 ;;^UTILITY(U,$J,358.3,28,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28,1,3,0)
 ;;=3^Epilepsy Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,28,1,4,0)
 ;;=4^G40.911
 ;;^UTILITY(U,$J,358.3,28,2)
 ;;=^5003866
 ;;^UTILITY(U,$J,358.3,29,0)
 ;;=G40.919^^2^3^11
 ;;^UTILITY(U,$J,358.3,29,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29,1,3,0)
 ;;=3^Epilepsy Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,29,1,4,0)
 ;;=4^G40.919
 ;;^UTILITY(U,$J,358.3,29,2)
 ;;=^5003867
 ;;^UTILITY(U,$J,358.3,30,0)
 ;;=G93.81^^2^3^23
 ;;^UTILITY(U,$J,358.3,30,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30,1,3,0)
 ;;=3^Mesial Temporal Sclerosis
 ;;^UTILITY(U,$J,358.3,30,1,4,0)
 ;;=4^G93.81
 ;;^UTILITY(U,$J,358.3,30,2)
 ;;=^338233
 ;;^UTILITY(U,$J,358.3,31,0)
 ;;=F44.5^^2^3^8
 ;;^UTILITY(U,$J,358.3,31,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31,1,3,0)
 ;;=3^Conversion Disorder w/ Seizures/Convulsions
 ;;^UTILITY(U,$J,358.3,31,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,31,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,32,0)
 ;;=R40.4^^2^3^30
 ;;^UTILITY(U,$J,358.3,32,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32,1,3,0)
 ;;=3^Transient Alteration of Awareness
 ;;^UTILITY(U,$J,358.3,32,1,4,0)
 ;;=4^R40.4
 ;;^UTILITY(U,$J,358.3,32,2)
 ;;=^5019435
 ;;^UTILITY(U,$J,358.3,33,0)
 ;;=R40.1^^2^3^29
 ;;^UTILITY(U,$J,358.3,33,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33,1,3,0)
 ;;=3^Stupor
 ;;^UTILITY(U,$J,358.3,33,1,4,0)
 ;;=4^R40.1
 ;;^UTILITY(U,$J,358.3,33,2)
 ;;=^5019353
 ;;^UTILITY(U,$J,358.3,34,0)
 ;;=R40.0^^2^3^28
 ;;^UTILITY(U,$J,358.3,34,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34,1,3,0)
 ;;=3^Somnolence
 ;;^UTILITY(U,$J,358.3,34,1,4,0)
 ;;=4^R40.0
 ;;^UTILITY(U,$J,358.3,34,2)
 ;;=^5019352
 ;;^UTILITY(U,$J,358.3,35,0)
 ;;=R56.9^^2^3^9
 ;;^UTILITY(U,$J,358.3,35,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35,1,3,0)
 ;;=3^Convulsions,Unspec
 ;;^UTILITY(U,$J,358.3,35,1,4,0)
 ;;=4^R56.9
 ;;^UTILITY(U,$J,358.3,35,2)
 ;;=^5019524
 ;;^UTILITY(U,$J,358.3,36,0)
 ;;=R56.1^^2^3^24
 ;;^UTILITY(U,$J,358.3,36,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36,1,3,0)
 ;;=3^Post Traumatic Seizures
 ;;^UTILITY(U,$J,358.3,36,1,4,0)
 ;;=4^R56.1
 ;;^UTILITY(U,$J,358.3,36,2)
 ;;=^5019523
 ;;^UTILITY(U,$J,358.3,37,0)
 ;;=G45.0^^2^4^15
 ;;^UTILITY(U,$J,358.3,37,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37,1,3,0)
 ;;=3^Vertebro-Basilar Artery Syndrome
 ;;^UTILITY(U,$J,358.3,37,1,4,0)
 ;;=4^G45.0
 ;;^UTILITY(U,$J,358.3,37,2)
 ;;=^5003955
 ;;^UTILITY(U,$J,358.3,38,0)
 ;;=G45.1^^2^4^4
 ;;^UTILITY(U,$J,358.3,38,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38,1,3,0)
 ;;=3^Carotid Artery Syndrome
 ;;^UTILITY(U,$J,358.3,38,1,4,0)
 ;;=4^G45.1
 ;;^UTILITY(U,$J,358.3,38,2)
 ;;=^5003956
 ;;^UTILITY(U,$J,358.3,39,0)
 ;;=G45.3^^2^4^1
 ;;^UTILITY(U,$J,358.3,39,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39,1,3,0)
 ;;=3^Amaurosis Fugax
 ;;^UTILITY(U,$J,358.3,39,1,4,0)
 ;;=4^G45.3
 ;;^UTILITY(U,$J,358.3,39,2)
 ;;=^304129
 ;;^UTILITY(U,$J,358.3,40,0)
 ;;=G45.4^^2^4^13
 ;;^UTILITY(U,$J,358.3,40,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40,1,3,0)
 ;;=3^Transient Global Amnesia
 ;;^UTILITY(U,$J,358.3,40,1,4,0)
 ;;=4^G45.4
 ;;^UTILITY(U,$J,358.3,40,2)
 ;;=^293883
 ;;^UTILITY(U,$J,358.3,41,0)
 ;;=G45.8^^2^4^11
 ;;^UTILITY(U,$J,358.3,41,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attacks,Other
 ;;^UTILITY(U,$J,358.3,41,1,4,0)
 ;;=4^G45.8
 ;;^UTILITY(U,$J,358.3,41,2)
 ;;=^5003958
 ;;^UTILITY(U,$J,358.3,42,0)
 ;;=G45.9^^2^4^12
 ;;^UTILITY(U,$J,358.3,42,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attacks,Unspec
 ;;^UTILITY(U,$J,358.3,42,1,4,0)
 ;;=4^G45.9
 ;;^UTILITY(U,$J,358.3,42,2)
 ;;=^5003959
 ;;^UTILITY(U,$J,358.3,43,0)
 ;;=G46.0^^2^4^8
 ;;^UTILITY(U,$J,358.3,43,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43,1,3,0)
 ;;=3^Middle Cerebral Artery Syndrome
 ;;^UTILITY(U,$J,358.3,43,1,4,0)
 ;;=4^G46.0
 ;;^UTILITY(U,$J,358.3,43,2)
 ;;=^5003960
 ;;^UTILITY(U,$J,358.3,44,0)
 ;;=G46.1^^2^4^2
 ;;^UTILITY(U,$J,358.3,44,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44,1,3,0)
 ;;=3^Anterior Cerebral Artery Syndrome
 ;;^UTILITY(U,$J,358.3,44,1,4,0)
 ;;=4^G46.1
 ;;^UTILITY(U,$J,358.3,44,2)
 ;;=^5003961
 ;;^UTILITY(U,$J,358.3,45,0)
 ;;=G46.2^^2^4^10
 ;;^UTILITY(U,$J,358.3,45,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45,1,3,0)
 ;;=3^Posterior Cerebral Artery Syndrome
 ;;^UTILITY(U,$J,358.3,45,1,4,0)
 ;;=4^G46.2
 ;;^UTILITY(U,$J,358.3,45,2)
 ;;=^5003962
 ;;^UTILITY(U,$J,358.3,46,0)
 ;;=G46.3^^2^4^3
 ;;^UTILITY(U,$J,358.3,46,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46,1,3,0)
 ;;=3^Brain Stem Stroke Syndrome
 ;;^UTILITY(U,$J,358.3,46,1,4,0)
 ;;=4^G46.3
 ;;^UTILITY(U,$J,358.3,46,2)
 ;;=^5003963
 ;;^UTILITY(U,$J,358.3,47,0)
 ;;=G46.7^^2^4^7
 ;;^UTILITY(U,$J,358.3,47,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47,1,3,0)
 ;;=3^Lacunar Syndromes,Other
 ;;^UTILITY(U,$J,358.3,47,1,4,0)
 ;;=4^G46.7
 ;;^UTILITY(U,$J,358.3,47,2)
 ;;=^5003967
 ;;^UTILITY(U,$J,358.3,48,0)
 ;;=G46.8^^2^4^14
 ;;^UTILITY(U,$J,358.3,48,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48,1,3,0)
 ;;=3^Vascular Syndromes of Brain in CVD,Other
 ;;^UTILITY(U,$J,358.3,48,1,4,0)
 ;;=4^G46.8
 ;;^UTILITY(U,$J,358.3,48,2)
 ;;=^5003968
 ;;^UTILITY(U,$J,358.3,49,0)
 ;;=I67.2^^2^4^5
 ;;^UTILITY(U,$J,358.3,49,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49,1,3,0)
 ;;=3^Cerebral Atherosclerosis
 ;;^UTILITY(U,$J,358.3,49,1,4,0)
 ;;=4^I67.2
 ;;^UTILITY(U,$J,358.3,49,2)
 ;;=^21571
 ;;^UTILITY(U,$J,358.3,50,0)
 ;;=I69.898^^2^4^6
 ;;^UTILITY(U,$J,358.3,50,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50,1,3,0)
 ;;=3^Cerebrovascular Disease Sequelae,Other
 ;;^UTILITY(U,$J,358.3,50,1,4,0)
 ;;=4^I69.898
 ;;^UTILITY(U,$J,358.3,50,2)
 ;;=^5007550
 ;;^UTILITY(U,$J,358.3,51,0)
 ;;=Z86.73^^2^4^9
 ;;^UTILITY(U,$J,358.3,51,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51,1,3,0)
 ;;=3^Personal Hx of TIA/Cerebral Inf w/o Resid Deficits
 ;;^UTILITY(U,$J,358.3,51,1,4,0)
 ;;=4^Z86.73
 ;;^UTILITY(U,$J,358.3,51,2)
 ;;=^5063477
 ;;^UTILITY(U,$J,358.3,52,0)
 ;;=H81.10^^2^5^1
 ;;^UTILITY(U,$J,358.3,52,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52,1,3,0)
 ;;=3^Benign Paroxysmal Vertigo
 ;;^UTILITY(U,$J,358.3,52,1,4,0)
 ;;=4^H81.10
 ;;^UTILITY(U,$J,358.3,52,2)
 ;;=^5006864
 ;;^UTILITY(U,$J,358.3,53,0)
 ;;=R55.^^2^5^3
 ;;^UTILITY(U,$J,358.3,53,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,53,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,53,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,54,0)
 ;;=R42.^^2^5^2
 ;;^UTILITY(U,$J,358.3,54,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54,1,3,0)
 ;;=3^Dizziness and Giddiness
 ;;^UTILITY(U,$J,358.3,54,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,54,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,55,0)
 ;;=H81.4^^2^5^4
 ;;^UTILITY(U,$J,358.3,55,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55,1,3,0)
 ;;=3^Vertigo of Central Origin
 ;;^UTILITY(U,$J,358.3,55,1,4,0)
 ;;=4^H81.4
 ;;^UTILITY(U,$J,358.3,55,2)
 ;;=^269484
 ;;^UTILITY(U,$J,358.3,56,0)
 ;;=F10.27^^2^6^1
 ;;^UTILITY(U,$J,358.3,56,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56,1,3,0)
 ;;=3^Alcoholic Encephalopathy
 ;;^UTILITY(U,$J,358.3,56,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,56,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,57,0)
 ;;=G98.8^^2^6^3
 ;;^UTILITY(U,$J,358.3,57,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,57,1,3,0)
 ;;=3^Disorder of Nervous System,Other
 ;;^UTILITY(U,$J,358.3,57,1,4,0)
 ;;=4^G98.8
 ;;^UTILITY(U,$J,358.3,57,2)
 ;;=^5004214
 ;;^UTILITY(U,$J,358.3,58,0)
 ;;=G96.89^^2^6^2
 ;;^UTILITY(U,$J,358.3,58,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,58,1,3,0)
 ;;=3^Disorder of Central Nervous System,Other Spec
 ;;^UTILITY(U,$J,358.3,58,1,4,0)
 ;;=4^G96.89
 ;;^UTILITY(U,$J,358.3,58,2)
 ;;=^5159172
 ;;^UTILITY(U,$J,358.3,59,0)
 ;;=G92.9^^2^6^4
 ;;^UTILITY(U,$J,358.3,59,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,59,1,3,0)
 ;;=3^Toxic Encephalopathy,Unspec
 ;;^UTILITY(U,$J,358.3,59,1,4,0)
 ;;=4^G92.9
 ;;^UTILITY(U,$J,358.3,59,2)
 ;;=^5161166
 ;;^UTILITY(U,$J,358.3,60,0)
 ;;=G43.009^^2^7^8
 ;;^UTILITY(U,$J,358.3,60,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,60,1,3,0)
 ;;=3^Migraine w/o Aura Not Intractable 
 ;;^UTILITY(U,$J,358.3,60,1,4,0)
 ;;=4^G43.009
 ;;^UTILITY(U,$J,358.3,60,2)
 ;;=^5003877
 ;;^UTILITY(U,$J,358.3,61,0)
 ;;=G43.019^^2^7^7
 ;;^UTILITY(U,$J,358.3,61,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,61,1,3,0)
 ;;=3^Migraine w/o Aura Intractable
 ;;^UTILITY(U,$J,358.3,61,1,4,0)
 ;;=4^G43.019
 ;;^UTILITY(U,$J,358.3,61,2)
 ;;=^5003879
 ;;^UTILITY(U,$J,358.3,62,0)
 ;;=G43.109^^2^7^6
 ;;^UTILITY(U,$J,358.3,62,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,62,1,3,0)
 ;;=3^Migraine w/ Aura Not Intractable
 ;;^UTILITY(U,$J,358.3,62,1,4,0)
 ;;=4^G43.109
 ;;^UTILITY(U,$J,358.3,62,2)
 ;;=^5003881
 ;;^UTILITY(U,$J,358.3,63,0)
 ;;=G43.119^^2^7^5
 ;;^UTILITY(U,$J,358.3,63,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,63,1,3,0)
 ;;=3^Migraine w/ Aura Intractable
 ;;^UTILITY(U,$J,358.3,63,1,4,0)
 ;;=4^G43.119
 ;;^UTILITY(U,$J,358.3,63,2)
 ;;=^5003883
 ;;^UTILITY(U,$J,358.3,64,0)
 ;;=G43.809^^2^7^3
 ;;^UTILITY(U,$J,358.3,64,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,64,1,3,0)
 ;;=3^Migrain Not Intractable w/o Status Magrainosus,Other
 ;;^UTILITY(U,$J,358.3,64,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,64,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,65,0)
 ;;=G43.909^^2^7^4
 ;;^UTILITY(U,$J,358.3,65,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,65,1,3,0)
 ;;=3^Migraine Not Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,65,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,65,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,66,0)
 ;;=G44.209^^2^7^9
 ;;^UTILITY(U,$J,358.3,66,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,66,1,3,0)
 ;;=3^Tension-Type Headache Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,66,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,66,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,67,0)
 ;;=R51.0^^2^7^1
 ;;^UTILITY(U,$J,358.3,67,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,67,1,3,0)
 ;;=3^Headache w/ Orthostatic Component,NEC
 ;;^UTILITY(U,$J,358.3,67,1,4,0)
 ;;=4^R51.0
 ;;^UTILITY(U,$J,358.3,67,2)
 ;;=^5159305
 ;;^UTILITY(U,$J,358.3,68,0)
 ;;=R51.9^^2^7^2
 ;;^UTILITY(U,$J,358.3,68,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,68,1,3,0)
 ;;=3^Headache,Unspecified
 ;;^UTILITY(U,$J,358.3,68,1,4,0)
 ;;=4^R51.9
 ;;^UTILITY(U,$J,358.3,68,2)
 ;;=^5159306
 ;;^UTILITY(U,$J,358.3,69,0)
 ;;=G20.^^2^8^9
 ;;^UTILITY(U,$J,358.3,69,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,69,1,3,0)
 ;;=3^Parkinson's Disease
 ;;^UTILITY(U,$J,358.3,69,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,69,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,70,0)
 ;;=G21.8^^2^8^11
 ;;^UTILITY(U,$J,358.3,70,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,70,1,3,0)
 ;;=3^Secondary Parkinsonism,Other
 ;;^UTILITY(U,$J,358.3,70,1,4,0)
 ;;=4^G21.8
 ;;^UTILITY(U,$J,358.3,70,2)
 ;;=^5003777
 ;;^UTILITY(U,$J,358.3,71,0)
 ;;=G25.0^^2^8^6
 ;;^UTILITY(U,$J,358.3,71,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,71,1,3,0)
 ;;=3^Essential Tremor
 ;;^UTILITY(U,$J,358.3,71,1,4,0)
 ;;=4^G25.0
 ;;^UTILITY(U,$J,358.3,71,2)
 ;;=^5003791
 ;;^UTILITY(U,$J,358.3,72,0)
 ;;=G25.1^^2^8^5
 ;;^UTILITY(U,$J,358.3,72,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,72,1,3,0)
 ;;=3^Drug-Induced Tremor
 ;;^UTILITY(U,$J,358.3,72,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,72,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,73,0)
 ;;=G25.2^^2^8^14
