IBDEI0LP ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27451,1,3,0)
 ;;=3^Self-Mgmt Ed/Train,5-8 Pts
 ;;^UTILITY(U,$J,358.3,27452,0)
 ;;=95971^^73^1168^2^^^^1
 ;;^UTILITY(U,$J,358.3,27452,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27452,1,2,0)
 ;;=2^95971
 ;;^UTILITY(U,$J,358.3,27452,1,3,0)
 ;;=3^Analyze Neurostim,Simple
 ;;^UTILITY(U,$J,358.3,27453,0)
 ;;=95972^^73^1168^1^^^^1
 ;;^UTILITY(U,$J,358.3,27453,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27453,1,2,0)
 ;;=2^95972
 ;;^UTILITY(U,$J,358.3,27453,1,3,0)
 ;;=3^Analyze Neurostim,Complex,up to 1hr
 ;;^UTILITY(U,$J,358.3,27454,0)
 ;;=95974^^73^1168^3^^^^1
 ;;^UTILITY(U,$J,358.3,27454,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27454,1,2,0)
 ;;=2^95974
 ;;^UTILITY(U,$J,358.3,27454,1,3,0)
 ;;=3^Cranial Neurostim,Complex,1st Hr
 ;;^UTILITY(U,$J,358.3,27455,0)
 ;;=95975^^73^1168^4^^^^1
 ;;^UTILITY(U,$J,358.3,27455,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27455,1,2,0)
 ;;=2^95975
 ;;^UTILITY(U,$J,358.3,27455,1,3,0)
 ;;=3^Cranial Neurostim,Complex,Ea Addl 30 Min
 ;;^UTILITY(U,$J,358.3,27456,0)
 ;;=G40.A01^^74^1169^3
 ;;^UTILITY(U,$J,358.3,27456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27456,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27456,1,4,0)
 ;;=4^G40.A01
 ;;^UTILITY(U,$J,358.3,27456,2)
 ;;=^5003868
 ;;^UTILITY(U,$J,358.3,27457,0)
 ;;=G40.A09^^74^1169^4
 ;;^UTILITY(U,$J,358.3,27457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27457,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27457,1,4,0)
 ;;=4^G40.A09
 ;;^UTILITY(U,$J,358.3,27457,2)
 ;;=^5003869
 ;;^UTILITY(U,$J,358.3,27458,0)
 ;;=G40.A11^^74^1169^1
 ;;^UTILITY(U,$J,358.3,27458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27458,1,3,0)
 ;;=3^Absence Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27458,1,4,0)
 ;;=4^G40.A11
 ;;^UTILITY(U,$J,358.3,27458,2)
 ;;=^5003870
 ;;^UTILITY(U,$J,358.3,27459,0)
 ;;=G40.A19^^74^1169^2
 ;;^UTILITY(U,$J,358.3,27459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27459,1,3,0)
 ;;=3^Absence Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27459,1,4,0)
 ;;=4^G40.A19
 ;;^UTILITY(U,$J,358.3,27459,2)
 ;;=^5003871
 ;;^UTILITY(U,$J,358.3,27460,0)
 ;;=G40.309^^74^1169^17
 ;;^UTILITY(U,$J,358.3,27460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27460,1,3,0)
 ;;=3^Generalized Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27460,1,4,0)
 ;;=4^G40.309
 ;;^UTILITY(U,$J,358.3,27460,2)
 ;;=^5003842
 ;;^UTILITY(U,$J,358.3,27461,0)
 ;;=G40.311^^74^1169^15
 ;;^UTILITY(U,$J,358.3,27461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27461,1,3,0)
 ;;=3^Generalized Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27461,1,4,0)
 ;;=4^G40.311
 ;;^UTILITY(U,$J,358.3,27461,2)
 ;;=^5003843
 ;;^UTILITY(U,$J,358.3,27462,0)
 ;;=G40.319^^74^1169^16
 ;;^UTILITY(U,$J,358.3,27462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27462,1,3,0)
 ;;=3^Generalized Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27462,1,4,0)
 ;;=4^G40.319
 ;;^UTILITY(U,$J,358.3,27462,2)
 ;;=^5003844
 ;;^UTILITY(U,$J,358.3,27463,0)
 ;;=G40.409^^74^1169^20
 ;;^UTILITY(U,$J,358.3,27463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27463,1,3,0)
 ;;=3^Generalized Seizures,Other, Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27463,1,4,0)
 ;;=4^G40.409
 ;;^UTILITY(U,$J,358.3,27463,2)
 ;;=^5003846
 ;;^UTILITY(U,$J,358.3,27464,0)
 ;;=G40.411^^74^1169^18
 ;;^UTILITY(U,$J,358.3,27464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27464,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27464,1,4,0)
 ;;=4^G40.411
 ;;^UTILITY(U,$J,358.3,27464,2)
 ;;=^5003847
 ;;^UTILITY(U,$J,358.3,27465,0)
 ;;=G40.419^^74^1169^19
 ;;^UTILITY(U,$J,358.3,27465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27465,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27465,1,4,0)
 ;;=4^G40.419
 ;;^UTILITY(U,$J,358.3,27465,2)
 ;;=^5003848
 ;;^UTILITY(U,$J,358.3,27466,0)
 ;;=G40.209^^74^1169^7
 ;;^UTILITY(U,$J,358.3,27466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27466,1,3,0)
 ;;=3^Complex Partial Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27466,1,4,0)
 ;;=4^G40.209
 ;;^UTILITY(U,$J,358.3,27466,2)
 ;;=^5003838
 ;;^UTILITY(U,$J,358.3,27467,0)
 ;;=G40.211^^74^1169^5
 ;;^UTILITY(U,$J,358.3,27467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27467,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27467,1,4,0)
 ;;=4^G40.211
 ;;^UTILITY(U,$J,358.3,27467,2)
 ;;=^5003839
 ;;^UTILITY(U,$J,358.3,27468,0)
 ;;=G40.219^^74^1169^6
 ;;^UTILITY(U,$J,358.3,27468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27468,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27468,1,4,0)
 ;;=4^G40.219
 ;;^UTILITY(U,$J,358.3,27468,2)
 ;;=^5003840
 ;;^UTILITY(U,$J,358.3,27469,0)
 ;;=G40.109^^74^1169^28
 ;;^UTILITY(U,$J,358.3,27469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27469,1,3,0)
 ;;=3^Simple Partial Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27469,1,4,0)
 ;;=4^G40.109
 ;;^UTILITY(U,$J,358.3,27469,2)
 ;;=^5003834
 ;;^UTILITY(U,$J,358.3,27470,0)
 ;;=G40.111^^74^1169^26
 ;;^UTILITY(U,$J,358.3,27470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27470,1,3,0)
 ;;=3^Simple Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27470,1,4,0)
 ;;=4^G40.111
 ;;^UTILITY(U,$J,358.3,27470,2)
 ;;=^5003835
 ;;^UTILITY(U,$J,358.3,27471,0)
 ;;=G40.119^^74^1169^27
 ;;^UTILITY(U,$J,358.3,27471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27471,1,3,0)
 ;;=3^Simple Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27471,1,4,0)
 ;;=4^G40.119
 ;;^UTILITY(U,$J,358.3,27471,2)
 ;;=^5003836
 ;;^UTILITY(U,$J,358.3,27472,0)
 ;;=G40.B09^^74^1169^23
 ;;^UTILITY(U,$J,358.3,27472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27472,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27472,1,4,0)
 ;;=4^G40.B09
 ;;^UTILITY(U,$J,358.3,27472,2)
 ;;=^5003873
 ;;^UTILITY(U,$J,358.3,27473,0)
 ;;=G40.B11^^74^1169^21
 ;;^UTILITY(U,$J,358.3,27473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27473,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27473,1,4,0)
 ;;=4^G40.B11
 ;;^UTILITY(U,$J,358.3,27473,2)
 ;;=^5003874
 ;;^UTILITY(U,$J,358.3,27474,0)
 ;;=G40.B19^^74^1169^22
 ;;^UTILITY(U,$J,358.3,27474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27474,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27474,1,4,0)
 ;;=4^G40.B19
 ;;^UTILITY(U,$J,358.3,27474,2)
 ;;=^5003875
 ;;^UTILITY(U,$J,358.3,27475,0)
 ;;=G40.509^^74^1169^14
 ;;^UTILITY(U,$J,358.3,27475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27475,1,3,0)
 ;;=3^Epileptic Seizures d/t External Causes Not Intractalbe w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27475,1,4,0)
 ;;=4^G40.509
 ;;^UTILITY(U,$J,358.3,27475,2)
 ;;=^5003850
 ;;^UTILITY(U,$J,358.3,27476,0)
 ;;=G40.909^^74^1169^13
 ;;^UTILITY(U,$J,358.3,27476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27476,1,3,0)
 ;;=3^Epilepsy Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,27476,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,27476,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,27477,0)
 ;;=G40.911^^74^1169^10
 ;;^UTILITY(U,$J,358.3,27477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27477,1,3,0)
 ;;=3^Epilepsy Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,27477,1,4,0)
 ;;=4^G40.911
 ;;^UTILITY(U,$J,358.3,27477,2)
 ;;=^5003866
 ;;^UTILITY(U,$J,358.3,27478,0)
 ;;=G40.919^^74^1169^11
 ;;^UTILITY(U,$J,358.3,27478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27478,1,3,0)
 ;;=3^Epilepsy Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,27478,1,4,0)
 ;;=4^G40.919
 ;;^UTILITY(U,$J,358.3,27478,2)
 ;;=^5003867
 ;;^UTILITY(U,$J,358.3,27479,0)
 ;;=G93.81^^74^1169^24
 ;;^UTILITY(U,$J,358.3,27479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27479,1,3,0)
 ;;=3^Mesial Temporal Sclerosis
 ;;^UTILITY(U,$J,358.3,27479,1,4,0)
 ;;=4^G93.81
 ;;^UTILITY(U,$J,358.3,27479,2)
 ;;=^338233
 ;;^UTILITY(U,$J,358.3,27480,0)
 ;;=F44.5^^74^1169^8
 ;;^UTILITY(U,$J,358.3,27480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27480,1,3,0)
 ;;=3^Conversion Disorder w/ Seizures/Convulsions
 ;;^UTILITY(U,$J,358.3,27480,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,27480,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,27481,0)
 ;;=R40.4^^74^1169^31
 ;;^UTILITY(U,$J,358.3,27481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27481,1,3,0)
 ;;=3^Transient Alteration of Awareness
 ;;^UTILITY(U,$J,358.3,27481,1,4,0)
 ;;=4^R40.4
 ;;^UTILITY(U,$J,358.3,27481,2)
 ;;=^5019435
 ;;^UTILITY(U,$J,358.3,27482,0)
 ;;=R40.1^^74^1169^30
 ;;^UTILITY(U,$J,358.3,27482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27482,1,3,0)
 ;;=3^Stupor
 ;;^UTILITY(U,$J,358.3,27482,1,4,0)
 ;;=4^R40.1
 ;;^UTILITY(U,$J,358.3,27482,2)
 ;;=^5019353
 ;;^UTILITY(U,$J,358.3,27483,0)
 ;;=R40.0^^74^1169^29
 ;;^UTILITY(U,$J,358.3,27483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27483,1,3,0)
 ;;=3^Somnolence
 ;;^UTILITY(U,$J,358.3,27483,1,4,0)
 ;;=4^R40.0
 ;;^UTILITY(U,$J,358.3,27483,2)
 ;;=^5019352
 ;;^UTILITY(U,$J,358.3,27484,0)
 ;;=R56.9^^74^1169^9
 ;;^UTILITY(U,$J,358.3,27484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27484,1,3,0)
 ;;=3^Convulsions,Unspec
 ;;^UTILITY(U,$J,358.3,27484,1,4,0)
 ;;=4^R56.9
 ;;^UTILITY(U,$J,358.3,27484,2)
 ;;=^5019524
 ;;^UTILITY(U,$J,358.3,27485,0)
 ;;=R56.1^^74^1169^25
 ;;^UTILITY(U,$J,358.3,27485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27485,1,3,0)
 ;;=3^Post Traumatic Seizures
 ;;^UTILITY(U,$J,358.3,27485,1,4,0)
 ;;=4^R56.1
