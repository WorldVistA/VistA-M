IBDEI00C ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,154,1,2,0)
 ;;=2^Non-Phys EHR Asmnt,11-20 min
 ;;^UTILITY(U,$J,358.3,154,1,3,0)
 ;;=3^98971
 ;;^UTILITY(U,$J,358.3,155,0)
 ;;=98972^^4^24^3^^^^1
 ;;^UTILITY(U,$J,358.3,155,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,155,1,2,0)
 ;;=2^Non-Phys EHR Asmnt,21+ min
 ;;^UTILITY(U,$J,358.3,155,1,3,0)
 ;;=3^98972
 ;;^UTILITY(U,$J,358.3,156,0)
 ;;=G40.A01^^5^25^3
 ;;^UTILITY(U,$J,358.3,156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,156,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,156,1,4,0)
 ;;=4^G40.A01
 ;;^UTILITY(U,$J,358.3,156,2)
 ;;=^5003868
 ;;^UTILITY(U,$J,358.3,157,0)
 ;;=G40.A09^^5^25^4
 ;;^UTILITY(U,$J,358.3,157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,157,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,157,1,4,0)
 ;;=4^G40.A09
 ;;^UTILITY(U,$J,358.3,157,2)
 ;;=^5003869
 ;;^UTILITY(U,$J,358.3,158,0)
 ;;=G40.A11^^5^25^1
 ;;^UTILITY(U,$J,358.3,158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,158,1,3,0)
 ;;=3^Absence Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,158,1,4,0)
 ;;=4^G40.A11
 ;;^UTILITY(U,$J,358.3,158,2)
 ;;=^5003870
 ;;^UTILITY(U,$J,358.3,159,0)
 ;;=G40.A19^^5^25^2
 ;;^UTILITY(U,$J,358.3,159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,159,1,3,0)
 ;;=3^Absence Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,159,1,4,0)
 ;;=4^G40.A19
 ;;^UTILITY(U,$J,358.3,159,2)
 ;;=^5003871
 ;;^UTILITY(U,$J,358.3,160,0)
 ;;=G40.309^^5^25^16
 ;;^UTILITY(U,$J,358.3,160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,160,1,3,0)
 ;;=3^Generalized Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,160,1,4,0)
 ;;=4^G40.309
 ;;^UTILITY(U,$J,358.3,160,2)
 ;;=^5003842
 ;;^UTILITY(U,$J,358.3,161,0)
 ;;=G40.311^^5^25^14
 ;;^UTILITY(U,$J,358.3,161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,161,1,3,0)
 ;;=3^Generalized Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,161,1,4,0)
 ;;=4^G40.311
 ;;^UTILITY(U,$J,358.3,161,2)
 ;;=^5003843
 ;;^UTILITY(U,$J,358.3,162,0)
 ;;=G40.319^^5^25^15
 ;;^UTILITY(U,$J,358.3,162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,162,1,3,0)
 ;;=3^Generalized Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,162,1,4,0)
 ;;=4^G40.319
 ;;^UTILITY(U,$J,358.3,162,2)
 ;;=^5003844
 ;;^UTILITY(U,$J,358.3,163,0)
 ;;=G40.409^^5^25^19
 ;;^UTILITY(U,$J,358.3,163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,163,1,3,0)
 ;;=3^Generalized Seizures,Other, Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,163,1,4,0)
 ;;=4^G40.409
 ;;^UTILITY(U,$J,358.3,163,2)
 ;;=^5003846
 ;;^UTILITY(U,$J,358.3,164,0)
 ;;=G40.411^^5^25^17
 ;;^UTILITY(U,$J,358.3,164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,164,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,164,1,4,0)
 ;;=4^G40.411
 ;;^UTILITY(U,$J,358.3,164,2)
 ;;=^5003847
 ;;^UTILITY(U,$J,358.3,165,0)
 ;;=G40.419^^5^25^18
 ;;^UTILITY(U,$J,358.3,165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,165,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,165,1,4,0)
 ;;=4^G40.419
 ;;^UTILITY(U,$J,358.3,165,2)
 ;;=^5003848
 ;;^UTILITY(U,$J,358.3,166,0)
 ;;=G40.209^^5^25^7
 ;;^UTILITY(U,$J,358.3,166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,166,1,3,0)
 ;;=3^Complex Partial Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,166,1,4,0)
 ;;=4^G40.209
 ;;^UTILITY(U,$J,358.3,166,2)
 ;;=^5003838
 ;;^UTILITY(U,$J,358.3,167,0)
 ;;=G40.211^^5^25^5
 ;;^UTILITY(U,$J,358.3,167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,167,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,167,1,4,0)
 ;;=4^G40.211
 ;;^UTILITY(U,$J,358.3,167,2)
 ;;=^5003839
 ;;^UTILITY(U,$J,358.3,168,0)
 ;;=G40.219^^5^25^6
 ;;^UTILITY(U,$J,358.3,168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,168,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,168,1,4,0)
 ;;=4^G40.219
 ;;^UTILITY(U,$J,358.3,168,2)
 ;;=^5003840
 ;;^UTILITY(U,$J,358.3,169,0)
 ;;=G40.109^^5^25^27
 ;;^UTILITY(U,$J,358.3,169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,169,1,3,0)
 ;;=3^Simple Partial Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,169,1,4,0)
 ;;=4^G40.109
 ;;^UTILITY(U,$J,358.3,169,2)
 ;;=^5003834
 ;;^UTILITY(U,$J,358.3,170,0)
 ;;=G40.111^^5^25^25
 ;;^UTILITY(U,$J,358.3,170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,170,1,3,0)
 ;;=3^Simple Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,170,1,4,0)
 ;;=4^G40.111
 ;;^UTILITY(U,$J,358.3,170,2)
 ;;=^5003835
 ;;^UTILITY(U,$J,358.3,171,0)
 ;;=G40.119^^5^25^26
 ;;^UTILITY(U,$J,358.3,171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,171,1,3,0)
 ;;=3^Simple Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,171,1,4,0)
 ;;=4^G40.119
 ;;^UTILITY(U,$J,358.3,171,2)
 ;;=^5003836
 ;;^UTILITY(U,$J,358.3,172,0)
 ;;=G40.B09^^5^25^22
 ;;^UTILITY(U,$J,358.3,172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,172,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,172,1,4,0)
 ;;=4^G40.B09
 ;;^UTILITY(U,$J,358.3,172,2)
 ;;=^5003873
 ;;^UTILITY(U,$J,358.3,173,0)
 ;;=G40.B11^^5^25^20
 ;;^UTILITY(U,$J,358.3,173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,173,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,173,1,4,0)
 ;;=4^G40.B11
 ;;^UTILITY(U,$J,358.3,173,2)
 ;;=^5003874
 ;;^UTILITY(U,$J,358.3,174,0)
 ;;=G40.B19^^5^25^21
 ;;^UTILITY(U,$J,358.3,174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,174,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,174,1,4,0)
 ;;=4^G40.B19
 ;;^UTILITY(U,$J,358.3,174,2)
 ;;=^5003875
 ;;^UTILITY(U,$J,358.3,175,0)
 ;;=G40.509^^5^25^13
 ;;^UTILITY(U,$J,358.3,175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,175,1,3,0)
 ;;=3^Epileptic Seizures d/t External Causes Not Intractalbe w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,175,1,4,0)
 ;;=4^G40.509
 ;;^UTILITY(U,$J,358.3,175,2)
 ;;=^5003850
 ;;^UTILITY(U,$J,358.3,176,0)
 ;;=G40.909^^5^25^12
 ;;^UTILITY(U,$J,358.3,176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,176,1,3,0)
 ;;=3^Epilepsy Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,176,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,176,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,177,0)
 ;;=G40.911^^5^25^10
 ;;^UTILITY(U,$J,358.3,177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,177,1,3,0)
 ;;=3^Epilepsy Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,177,1,4,0)
 ;;=4^G40.911
 ;;^UTILITY(U,$J,358.3,177,2)
 ;;=^5003866
 ;;^UTILITY(U,$J,358.3,178,0)
 ;;=G40.919^^5^25^11
 ;;^UTILITY(U,$J,358.3,178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,178,1,3,0)
 ;;=3^Epilepsy Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,178,1,4,0)
 ;;=4^G40.919
 ;;^UTILITY(U,$J,358.3,178,2)
 ;;=^5003867
 ;;^UTILITY(U,$J,358.3,179,0)
 ;;=G93.81^^5^25^23
 ;;^UTILITY(U,$J,358.3,179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,179,1,3,0)
 ;;=3^Mesial Temporal Sclerosis
 ;;^UTILITY(U,$J,358.3,179,1,4,0)
 ;;=4^G93.81
 ;;^UTILITY(U,$J,358.3,179,2)
 ;;=^338233
 ;;^UTILITY(U,$J,358.3,180,0)
 ;;=F44.5^^5^25^8
 ;;^UTILITY(U,$J,358.3,180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,180,1,3,0)
 ;;=3^Conversion Disorder w/ Seizures/Convulsions
 ;;^UTILITY(U,$J,358.3,180,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,180,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,181,0)
 ;;=R40.4^^5^25^30
 ;;^UTILITY(U,$J,358.3,181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,181,1,3,0)
 ;;=3^Transient Alteration of Awareness
 ;;^UTILITY(U,$J,358.3,181,1,4,0)
 ;;=4^R40.4
 ;;^UTILITY(U,$J,358.3,181,2)
 ;;=^5019435
 ;;^UTILITY(U,$J,358.3,182,0)
 ;;=R40.1^^5^25^29
 ;;^UTILITY(U,$J,358.3,182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,182,1,3,0)
 ;;=3^Stupor
 ;;^UTILITY(U,$J,358.3,182,1,4,0)
 ;;=4^R40.1
 ;;^UTILITY(U,$J,358.3,182,2)
 ;;=^5019353
 ;;^UTILITY(U,$J,358.3,183,0)
 ;;=R40.0^^5^25^28
 ;;^UTILITY(U,$J,358.3,183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,183,1,3,0)
 ;;=3^Somnolence
 ;;^UTILITY(U,$J,358.3,183,1,4,0)
 ;;=4^R40.0
 ;;^UTILITY(U,$J,358.3,183,2)
 ;;=^5019352
 ;;^UTILITY(U,$J,358.3,184,0)
 ;;=R56.9^^5^25^9
 ;;^UTILITY(U,$J,358.3,184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,184,1,3,0)
 ;;=3^Convulsions,Unspec
 ;;^UTILITY(U,$J,358.3,184,1,4,0)
 ;;=4^R56.9
 ;;^UTILITY(U,$J,358.3,184,2)
 ;;=^5019524
 ;;^UTILITY(U,$J,358.3,185,0)
 ;;=R56.1^^5^25^24
 ;;^UTILITY(U,$J,358.3,185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,185,1,3,0)
 ;;=3^Post Traumatic Seizures
 ;;^UTILITY(U,$J,358.3,185,1,4,0)
 ;;=4^R56.1
 ;;^UTILITY(U,$J,358.3,185,2)
 ;;=^5019523
 ;;^UTILITY(U,$J,358.3,186,0)
 ;;=G45.0^^5^26^15
 ;;^UTILITY(U,$J,358.3,186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,186,1,3,0)
 ;;=3^Vertebro-Basilar Artery Syndrome
 ;;^UTILITY(U,$J,358.3,186,1,4,0)
 ;;=4^G45.0
 ;;^UTILITY(U,$J,358.3,186,2)
 ;;=^5003955
 ;;^UTILITY(U,$J,358.3,187,0)
 ;;=G45.1^^5^26^4
 ;;^UTILITY(U,$J,358.3,187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,187,1,3,0)
 ;;=3^Carotid Artery Syndrome
 ;;^UTILITY(U,$J,358.3,187,1,4,0)
 ;;=4^G45.1
 ;;^UTILITY(U,$J,358.3,187,2)
 ;;=^5003956
 ;;^UTILITY(U,$J,358.3,188,0)
 ;;=G45.3^^5^26^1
 ;;^UTILITY(U,$J,358.3,188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,188,1,3,0)
 ;;=3^Amaurosis Fugax
 ;;^UTILITY(U,$J,358.3,188,1,4,0)
 ;;=4^G45.3
 ;;^UTILITY(U,$J,358.3,188,2)
 ;;=^304129
 ;;^UTILITY(U,$J,358.3,189,0)
 ;;=G45.4^^5^26^13
 ;;^UTILITY(U,$J,358.3,189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,189,1,3,0)
 ;;=3^Transient Global Amnesia
 ;;^UTILITY(U,$J,358.3,189,1,4,0)
 ;;=4^G45.4
 ;;^UTILITY(U,$J,358.3,189,2)
 ;;=^293883
 ;;^UTILITY(U,$J,358.3,190,0)
 ;;=G45.8^^5^26^11
 ;;^UTILITY(U,$J,358.3,190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,190,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attacks,Other
 ;;^UTILITY(U,$J,358.3,190,1,4,0)
 ;;=4^G45.8
 ;;^UTILITY(U,$J,358.3,190,2)
 ;;=^5003958
 ;;^UTILITY(U,$J,358.3,191,0)
 ;;=G45.9^^5^26^12
 ;;^UTILITY(U,$J,358.3,191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,191,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attacks,Unspec
 ;;^UTILITY(U,$J,358.3,191,1,4,0)
 ;;=4^G45.9
 ;;^UTILITY(U,$J,358.3,191,2)
 ;;=^5003959
 ;;^UTILITY(U,$J,358.3,192,0)
 ;;=G46.0^^5^26^8
 ;;^UTILITY(U,$J,358.3,192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,192,1,3,0)
 ;;=3^Middle Cerebral Artery Syndrome
 ;;^UTILITY(U,$J,358.3,192,1,4,0)
 ;;=4^G46.0
 ;;^UTILITY(U,$J,358.3,192,2)
 ;;=^5003960
 ;;^UTILITY(U,$J,358.3,193,0)
 ;;=G46.1^^5^26^2
 ;;^UTILITY(U,$J,358.3,193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,193,1,3,0)
 ;;=3^Anterior Cerebral Artery Syndrome
 ;;^UTILITY(U,$J,358.3,193,1,4,0)
 ;;=4^G46.1
 ;;^UTILITY(U,$J,358.3,193,2)
 ;;=^5003961
 ;;^UTILITY(U,$J,358.3,194,0)
 ;;=G46.2^^5^26^10
 ;;^UTILITY(U,$J,358.3,194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,194,1,3,0)
 ;;=3^Posterior Cerebral Artery Syndrome
 ;;^UTILITY(U,$J,358.3,194,1,4,0)
 ;;=4^G46.2
 ;;^UTILITY(U,$J,358.3,194,2)
 ;;=^5003962
 ;;^UTILITY(U,$J,358.3,195,0)
 ;;=G46.3^^5^26^3
 ;;^UTILITY(U,$J,358.3,195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,195,1,3,0)
 ;;=3^Brain Stem Stroke Syndrome
 ;;^UTILITY(U,$J,358.3,195,1,4,0)
 ;;=4^G46.3
 ;;^UTILITY(U,$J,358.3,195,2)
 ;;=^5003963
 ;;^UTILITY(U,$J,358.3,196,0)
 ;;=G46.7^^5^26^7
 ;;^UTILITY(U,$J,358.3,196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,196,1,3,0)
 ;;=3^Lacunar Syndromes,Other
 ;;^UTILITY(U,$J,358.3,196,1,4,0)
 ;;=4^G46.7
 ;;^UTILITY(U,$J,358.3,196,2)
 ;;=^5003967
 ;;^UTILITY(U,$J,358.3,197,0)
 ;;=G46.8^^5^26^14
 ;;^UTILITY(U,$J,358.3,197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,197,1,3,0)
 ;;=3^Vascular Syndromes of Brain in CVD,Other
 ;;^UTILITY(U,$J,358.3,197,1,4,0)
 ;;=4^G46.8
 ;;^UTILITY(U,$J,358.3,197,2)
 ;;=^5003968
 ;;^UTILITY(U,$J,358.3,198,0)
 ;;=I67.2^^5^26^5
 ;;^UTILITY(U,$J,358.3,198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,198,1,3,0)
 ;;=3^Cerebral Atherosclerosis
 ;;^UTILITY(U,$J,358.3,198,1,4,0)
 ;;=4^I67.2
 ;;^UTILITY(U,$J,358.3,198,2)
 ;;=^21571
 ;;^UTILITY(U,$J,358.3,199,0)
 ;;=I69.898^^5^26^6
 ;;^UTILITY(U,$J,358.3,199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,199,1,3,0)
 ;;=3^Cerebrovascular Disease Sequelae,Other
 ;;^UTILITY(U,$J,358.3,199,1,4,0)
 ;;=4^I69.898
 ;;^UTILITY(U,$J,358.3,199,2)
 ;;=^5007550
 ;;^UTILITY(U,$J,358.3,200,0)
 ;;=Z86.73^^5^26^9
 ;;^UTILITY(U,$J,358.3,200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,200,1,3,0)
 ;;=3^Personal Hx of TIA/Cerebral Inf w/o Resid Deficits
 ;;^UTILITY(U,$J,358.3,200,1,4,0)
 ;;=4^Z86.73
 ;;^UTILITY(U,$J,358.3,200,2)
 ;;=^5063477
 ;;^UTILITY(U,$J,358.3,201,0)
 ;;=H81.10^^5^27^1
 ;;^UTILITY(U,$J,358.3,201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,201,1,3,0)
 ;;=3^Benign Paroxysmal Vertigo
 ;;^UTILITY(U,$J,358.3,201,1,4,0)
 ;;=4^H81.10
 ;;^UTILITY(U,$J,358.3,201,2)
 ;;=^5006864
 ;;^UTILITY(U,$J,358.3,202,0)
 ;;=R55.^^5^27^3
 ;;^UTILITY(U,$J,358.3,202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,202,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,202,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,202,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,203,0)
 ;;=R42.^^5^27^2
 ;;^UTILITY(U,$J,358.3,203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,203,1,3,0)
 ;;=3^Dizziness and Giddiness
 ;;^UTILITY(U,$J,358.3,203,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,203,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,204,0)
 ;;=H81.4^^5^27^4
 ;;^UTILITY(U,$J,358.3,204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,204,1,3,0)
 ;;=3^Vertigo of Central Origin
 ;;^UTILITY(U,$J,358.3,204,1,4,0)
 ;;=4^H81.4
 ;;^UTILITY(U,$J,358.3,204,2)
 ;;=^269484
 ;;^UTILITY(U,$J,358.3,205,0)
 ;;=F10.27^^5^28^1
 ;;^UTILITY(U,$J,358.3,205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,205,1,3,0)
 ;;=3^Alcoholic Encephalopathy
 ;;^UTILITY(U,$J,358.3,205,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,205,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,206,0)
 ;;=G92.^^5^28^4
 ;;^UTILITY(U,$J,358.3,206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,206,1,3,0)
 ;;=3^Toxic Encephalopathy
 ;;^UTILITY(U,$J,358.3,206,1,4,0)
 ;;=4^G92.
 ;;^UTILITY(U,$J,358.3,206,2)
 ;;=^259061
 ;;^UTILITY(U,$J,358.3,207,0)
 ;;=G96.8^^5^28^2
 ;;^UTILITY(U,$J,358.3,207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,207,1,3,0)
 ;;=3^Disorder of Central Nervous System,Other Spec
 ;;^UTILITY(U,$J,358.3,207,1,4,0)
 ;;=4^G96.8
 ;;^UTILITY(U,$J,358.3,207,2)
 ;;=^5004199
 ;;^UTILITY(U,$J,358.3,208,0)
 ;;=G98.8^^5^28^3
 ;;^UTILITY(U,$J,358.3,208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,208,1,3,0)
 ;;=3^Disorder of Nervous System,Other
 ;;^UTILITY(U,$J,358.3,208,1,4,0)
 ;;=4^G98.8
 ;;^UTILITY(U,$J,358.3,208,2)
 ;;=^5004214
 ;;^UTILITY(U,$J,358.3,209,0)
 ;;=G43.009^^5^29^7
 ;;^UTILITY(U,$J,358.3,209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,209,1,3,0)
 ;;=3^Migraine w/o Aura Not Intractable 
 ;;^UTILITY(U,$J,358.3,209,1,4,0)
 ;;=4^G43.009
 ;;^UTILITY(U,$J,358.3,209,2)
 ;;=^5003877
 ;;^UTILITY(U,$J,358.3,210,0)
 ;;=G43.019^^5^29^6
 ;;^UTILITY(U,$J,358.3,210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,210,1,3,0)
 ;;=3^Migraine w/o Aura Intractable
 ;;^UTILITY(U,$J,358.3,210,1,4,0)
 ;;=4^G43.019
 ;;^UTILITY(U,$J,358.3,210,2)
 ;;=^5003879
 ;;^UTILITY(U,$J,358.3,211,0)
 ;;=G43.109^^5^29^5
 ;;^UTILITY(U,$J,358.3,211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,211,1,3,0)
 ;;=3^Migraine w/ Aura Not Intractable
 ;;^UTILITY(U,$J,358.3,211,1,4,0)
 ;;=4^G43.109
 ;;^UTILITY(U,$J,358.3,211,2)
 ;;=^5003881
 ;;^UTILITY(U,$J,358.3,212,0)
 ;;=G43.119^^5^29^4
 ;;^UTILITY(U,$J,358.3,212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,212,1,3,0)
 ;;=3^Migraine w/ Aura Intractable
 ;;^UTILITY(U,$J,358.3,212,1,4,0)
 ;;=4^G43.119
 ;;^UTILITY(U,$J,358.3,212,2)
 ;;=^5003883
 ;;^UTILITY(U,$J,358.3,213,0)
 ;;=G43.809^^5^29^2
 ;;^UTILITY(U,$J,358.3,213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,213,1,3,0)
 ;;=3^Migrain Not Intractable w/o Status Magrainosus,Other
 ;;^UTILITY(U,$J,358.3,213,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,213,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,214,0)
 ;;=G43.909^^5^29^3
 ;;^UTILITY(U,$J,358.3,214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,214,1,3,0)
 ;;=3^Migraine Not Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,214,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,214,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,215,0)
 ;;=G44.209^^5^29^8
 ;;^UTILITY(U,$J,358.3,215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,215,1,3,0)
 ;;=3^Tension-Type Headache Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,215,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,215,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,216,0)
 ;;=R51.^^5^29^1
 ;;^UTILITY(U,$J,358.3,216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,216,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,216,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,216,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,217,0)
 ;;=G20.^^5^30^9
 ;;^UTILITY(U,$J,358.3,217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,217,1,3,0)
 ;;=3^Parkinson's Disease
 ;;^UTILITY(U,$J,358.3,217,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,217,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,218,0)
 ;;=G21.8^^5^30^11
 ;;^UTILITY(U,$J,358.3,218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,218,1,3,0)
 ;;=3^Secondary Parkinsonism,Other
 ;;^UTILITY(U,$J,358.3,218,1,4,0)
 ;;=4^G21.8
 ;;^UTILITY(U,$J,358.3,218,2)
 ;;=^5003777
 ;;^UTILITY(U,$J,358.3,219,0)
 ;;=G25.0^^5^30^6
 ;;^UTILITY(U,$J,358.3,219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,219,1,3,0)
 ;;=3^Essential Tremor
 ;;^UTILITY(U,$J,358.3,219,1,4,0)
 ;;=4^G25.0
 ;;^UTILITY(U,$J,358.3,219,2)
 ;;=^5003791
 ;;^UTILITY(U,$J,358.3,220,0)
 ;;=G25.1^^5^30^5
 ;;^UTILITY(U,$J,358.3,220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,220,1,3,0)
 ;;=3^Drug-Induced Tremor
 ;;^UTILITY(U,$J,358.3,220,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,220,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,221,0)
 ;;=G25.2^^5^30^14
 ;;^UTILITY(U,$J,358.3,221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,221,1,3,0)
 ;;=3^Tremor,Other Spec Forms
 ;;^UTILITY(U,$J,358.3,221,1,4,0)
 ;;=4^G25.2
 ;;^UTILITY(U,$J,358.3,221,2)
 ;;=^5003793
 ;;^UTILITY(U,$J,358.3,222,0)
 ;;=G25.3^^5^30^8
 ;;^UTILITY(U,$J,358.3,222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,222,1,3,0)
 ;;=3^Myoclonus
 ;;^UTILITY(U,$J,358.3,222,1,4,0)
 ;;=4^G25.3
 ;;^UTILITY(U,$J,358.3,222,2)
 ;;=^80620
 ;;^UTILITY(U,$J,358.3,223,0)
 ;;=G25.69^^5^30^13
 ;;^UTILITY(U,$J,358.3,223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,223,1,3,0)
 ;;=3^Tics,Organic Origin,Other
 ;;^UTILITY(U,$J,358.3,223,1,4,0)
 ;;=4^G25.69
 ;;^UTILITY(U,$J,358.3,223,2)
 ;;=^5003797
 ;;^UTILITY(U,$J,358.3,224,0)
 ;;=G25.61^^5^30^4
 ;;^UTILITY(U,$J,358.3,224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,224,1,3,0)
 ;;=3^Drug-Induced Tics
 ;;^UTILITY(U,$J,358.3,224,1,4,0)
 ;;=4^G25.61
