IBDEI00E ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,302,1,3,0)
 ;;=3^95718
 ;;^UTILITY(U,$J,358.3,303,0)
 ;;=95719^^6^41^17^^^^1
 ;;^UTILITY(U,$J,358.3,303,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,303,1,2,0)
 ;;=2^EEG w/o Video,Cont Mntr,12-26 Hrs,Phys
 ;;^UTILITY(U,$J,358.3,303,1,3,0)
 ;;=3^95719
 ;;^UTILITY(U,$J,358.3,304,0)
 ;;=95720^^6^41^6^^^^1
 ;;^UTILITY(U,$J,358.3,304,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,304,1,2,0)
 ;;=2^EEG w/ Video,Cont Mntr,12-26 Hrs,Phys
 ;;^UTILITY(U,$J,358.3,304,1,3,0)
 ;;=3^95720
 ;;^UTILITY(U,$J,358.3,305,0)
 ;;=95721^^6^41^20^^^^1
 ;;^UTILITY(U,$J,358.3,305,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,305,1,2,0)
 ;;=2^EEG w/o Video,Cont Mntr,>36<60 Hrs,Phys
 ;;^UTILITY(U,$J,358.3,305,1,3,0)
 ;;=3^95721
 ;;^UTILITY(U,$J,358.3,306,0)
 ;;=95722^^6^41^9^^^^1
 ;;^UTILITY(U,$J,358.3,306,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,306,1,2,0)
 ;;=2^EEG w/ Video,Cont Mntr,>36<60 Hrs,Phys
 ;;^UTILITY(U,$J,358.3,306,1,3,0)
 ;;=3^95722
 ;;^UTILITY(U,$J,358.3,307,0)
 ;;=95723^^6^41^21^^^^1
 ;;^UTILITY(U,$J,358.3,307,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,307,1,2,0)
 ;;=2^EEG w/o Video,Cont Mntr,>60<84 Hrs,Phys
 ;;^UTILITY(U,$J,358.3,307,1,3,0)
 ;;=3^95723
 ;;^UTILITY(U,$J,358.3,308,0)
 ;;=95724^^6^41^10^^^^1
 ;;^UTILITY(U,$J,358.3,308,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,308,1,2,0)
 ;;=2^EEG w/ Video,Cont Mntr,>60<84 Hrs,Phys
 ;;^UTILITY(U,$J,358.3,308,1,3,0)
 ;;=3^95724
 ;;^UTILITY(U,$J,358.3,309,0)
 ;;=95725^^6^41^22^^^^1
 ;;^UTILITY(U,$J,358.3,309,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,309,1,2,0)
 ;;=2^EEG w/o Video,Cont Mntr,>84 Hrs,Phys
 ;;^UTILITY(U,$J,358.3,309,1,3,0)
 ;;=3^95725
 ;;^UTILITY(U,$J,358.3,310,0)
 ;;=95726^^6^41^11^^^^1
 ;;^UTILITY(U,$J,358.3,310,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,310,1,2,0)
 ;;=2^EEG w/ Video,Cont Mntr,>84 Hrs,Phys
 ;;^UTILITY(U,$J,358.3,310,1,3,0)
 ;;=3^95726
 ;;^UTILITY(U,$J,358.3,311,0)
 ;;=G40.A01^^7^42^3
 ;;^UTILITY(U,$J,358.3,311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,311,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,311,1,4,0)
 ;;=4^G40.A01
 ;;^UTILITY(U,$J,358.3,311,2)
 ;;=^5003868
 ;;^UTILITY(U,$J,358.3,312,0)
 ;;=G40.A09^^7^42^4
 ;;^UTILITY(U,$J,358.3,312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,312,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,312,1,4,0)
 ;;=4^G40.A09
 ;;^UTILITY(U,$J,358.3,312,2)
 ;;=^5003869
 ;;^UTILITY(U,$J,358.3,313,0)
 ;;=G40.A11^^7^42^1
 ;;^UTILITY(U,$J,358.3,313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,313,1,3,0)
 ;;=3^Absence Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,313,1,4,0)
 ;;=4^G40.A11
 ;;^UTILITY(U,$J,358.3,313,2)
 ;;=^5003870
 ;;^UTILITY(U,$J,358.3,314,0)
 ;;=G40.A19^^7^42^2
 ;;^UTILITY(U,$J,358.3,314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,314,1,3,0)
 ;;=3^Absence Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,314,1,4,0)
 ;;=4^G40.A19
 ;;^UTILITY(U,$J,358.3,314,2)
 ;;=^5003871
 ;;^UTILITY(U,$J,358.3,315,0)
 ;;=G40.309^^7^42^16
 ;;^UTILITY(U,$J,358.3,315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,315,1,3,0)
 ;;=3^Generalized Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,315,1,4,0)
 ;;=4^G40.309
 ;;^UTILITY(U,$J,358.3,315,2)
 ;;=^5003842
 ;;^UTILITY(U,$J,358.3,316,0)
 ;;=G40.311^^7^42^14
 ;;^UTILITY(U,$J,358.3,316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,316,1,3,0)
 ;;=3^Generalized Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,316,1,4,0)
 ;;=4^G40.311
 ;;^UTILITY(U,$J,358.3,316,2)
 ;;=^5003843
 ;;^UTILITY(U,$J,358.3,317,0)
 ;;=G40.319^^7^42^15
 ;;^UTILITY(U,$J,358.3,317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,317,1,3,0)
 ;;=3^Generalized Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,317,1,4,0)
 ;;=4^G40.319
 ;;^UTILITY(U,$J,358.3,317,2)
 ;;=^5003844
 ;;^UTILITY(U,$J,358.3,318,0)
 ;;=G40.409^^7^42^19
 ;;^UTILITY(U,$J,358.3,318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,318,1,3,0)
 ;;=3^Generalized Seizures,Other, Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,318,1,4,0)
 ;;=4^G40.409
 ;;^UTILITY(U,$J,358.3,318,2)
 ;;=^5003846
 ;;^UTILITY(U,$J,358.3,319,0)
 ;;=G40.411^^7^42^17
 ;;^UTILITY(U,$J,358.3,319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,319,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,319,1,4,0)
 ;;=4^G40.411
 ;;^UTILITY(U,$J,358.3,319,2)
 ;;=^5003847
 ;;^UTILITY(U,$J,358.3,320,0)
 ;;=G40.419^^7^42^18
 ;;^UTILITY(U,$J,358.3,320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,320,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,320,1,4,0)
 ;;=4^G40.419
 ;;^UTILITY(U,$J,358.3,320,2)
 ;;=^5003848
 ;;^UTILITY(U,$J,358.3,321,0)
 ;;=G40.209^^7^42^7
 ;;^UTILITY(U,$J,358.3,321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,321,1,3,0)
 ;;=3^Complex Partial Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,321,1,4,0)
 ;;=4^G40.209
 ;;^UTILITY(U,$J,358.3,321,2)
 ;;=^5003838
 ;;^UTILITY(U,$J,358.3,322,0)
 ;;=G40.211^^7^42^5
 ;;^UTILITY(U,$J,358.3,322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,322,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,322,1,4,0)
 ;;=4^G40.211
 ;;^UTILITY(U,$J,358.3,322,2)
 ;;=^5003839
 ;;^UTILITY(U,$J,358.3,323,0)
 ;;=G40.219^^7^42^6
 ;;^UTILITY(U,$J,358.3,323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,323,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,323,1,4,0)
 ;;=4^G40.219
 ;;^UTILITY(U,$J,358.3,323,2)
 ;;=^5003840
 ;;^UTILITY(U,$J,358.3,324,0)
 ;;=G40.109^^7^42^27
 ;;^UTILITY(U,$J,358.3,324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,324,1,3,0)
 ;;=3^Simple Partial Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,324,1,4,0)
 ;;=4^G40.109
 ;;^UTILITY(U,$J,358.3,324,2)
 ;;=^5003834
 ;;^UTILITY(U,$J,358.3,325,0)
 ;;=G40.111^^7^42^25
 ;;^UTILITY(U,$J,358.3,325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,325,1,3,0)
 ;;=3^Simple Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,325,1,4,0)
 ;;=4^G40.111
 ;;^UTILITY(U,$J,358.3,325,2)
 ;;=^5003835
 ;;^UTILITY(U,$J,358.3,326,0)
 ;;=G40.119^^7^42^26
 ;;^UTILITY(U,$J,358.3,326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,326,1,3,0)
 ;;=3^Simple Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,326,1,4,0)
 ;;=4^G40.119
 ;;^UTILITY(U,$J,358.3,326,2)
 ;;=^5003836
 ;;^UTILITY(U,$J,358.3,327,0)
 ;;=G40.B09^^7^42^22
 ;;^UTILITY(U,$J,358.3,327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,327,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,327,1,4,0)
 ;;=4^G40.B09
 ;;^UTILITY(U,$J,358.3,327,2)
 ;;=^5003873
 ;;^UTILITY(U,$J,358.3,328,0)
 ;;=G40.B11^^7^42^20
 ;;^UTILITY(U,$J,358.3,328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,328,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,328,1,4,0)
 ;;=4^G40.B11
 ;;^UTILITY(U,$J,358.3,328,2)
 ;;=^5003874
 ;;^UTILITY(U,$J,358.3,329,0)
 ;;=G40.B19^^7^42^21
 ;;^UTILITY(U,$J,358.3,329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,329,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,329,1,4,0)
 ;;=4^G40.B19
 ;;^UTILITY(U,$J,358.3,329,2)
 ;;=^5003875
 ;;^UTILITY(U,$J,358.3,330,0)
 ;;=G40.509^^7^42^13
 ;;^UTILITY(U,$J,358.3,330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,330,1,3,0)
 ;;=3^Epileptic Seizures d/t External Causes Not Intractalbe w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,330,1,4,0)
 ;;=4^G40.509
 ;;^UTILITY(U,$J,358.3,330,2)
 ;;=^5003850
 ;;^UTILITY(U,$J,358.3,331,0)
 ;;=G40.909^^7^42^12
 ;;^UTILITY(U,$J,358.3,331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,331,1,3,0)
 ;;=3^Epilepsy Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,331,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,331,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,332,0)
 ;;=G40.911^^7^42^10
 ;;^UTILITY(U,$J,358.3,332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,332,1,3,0)
 ;;=3^Epilepsy Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,332,1,4,0)
 ;;=4^G40.911
 ;;^UTILITY(U,$J,358.3,332,2)
 ;;=^5003866
 ;;^UTILITY(U,$J,358.3,333,0)
 ;;=G40.919^^7^42^11
 ;;^UTILITY(U,$J,358.3,333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,333,1,3,0)
 ;;=3^Epilepsy Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,333,1,4,0)
 ;;=4^G40.919
 ;;^UTILITY(U,$J,358.3,333,2)
 ;;=^5003867
 ;;^UTILITY(U,$J,358.3,334,0)
 ;;=G93.81^^7^42^23
 ;;^UTILITY(U,$J,358.3,334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,334,1,3,0)
 ;;=3^Mesial Temporal Sclerosis
 ;;^UTILITY(U,$J,358.3,334,1,4,0)
 ;;=4^G93.81
 ;;^UTILITY(U,$J,358.3,334,2)
 ;;=^338233
 ;;^UTILITY(U,$J,358.3,335,0)
 ;;=F44.5^^7^42^8
 ;;^UTILITY(U,$J,358.3,335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,335,1,3,0)
 ;;=3^Conversion Disorder w/ Seizures/Convulsions
 ;;^UTILITY(U,$J,358.3,335,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,335,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,336,0)
 ;;=R40.4^^7^42^30
 ;;^UTILITY(U,$J,358.3,336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,336,1,3,0)
 ;;=3^Transient Alteration of Awareness
 ;;^UTILITY(U,$J,358.3,336,1,4,0)
 ;;=4^R40.4
 ;;^UTILITY(U,$J,358.3,336,2)
 ;;=^5019435
 ;;^UTILITY(U,$J,358.3,337,0)
 ;;=R40.1^^7^42^29
 ;;^UTILITY(U,$J,358.3,337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,337,1,3,0)
 ;;=3^Stupor
 ;;^UTILITY(U,$J,358.3,337,1,4,0)
 ;;=4^R40.1
 ;;^UTILITY(U,$J,358.3,337,2)
 ;;=^5019353
 ;;^UTILITY(U,$J,358.3,338,0)
 ;;=R40.0^^7^42^28
 ;;^UTILITY(U,$J,358.3,338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,338,1,3,0)
 ;;=3^Somnolence
 ;;^UTILITY(U,$J,358.3,338,1,4,0)
 ;;=4^R40.0
 ;;^UTILITY(U,$J,358.3,338,2)
 ;;=^5019352
 ;;^UTILITY(U,$J,358.3,339,0)
 ;;=R56.9^^7^42^9
 ;;^UTILITY(U,$J,358.3,339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,339,1,3,0)
 ;;=3^Convulsions,Unspec
 ;;^UTILITY(U,$J,358.3,339,1,4,0)
 ;;=4^R56.9
 ;;^UTILITY(U,$J,358.3,339,2)
 ;;=^5019524
 ;;^UTILITY(U,$J,358.3,340,0)
 ;;=R56.1^^7^42^24
 ;;^UTILITY(U,$J,358.3,340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,340,1,3,0)
 ;;=3^Post Traumatic Seizures
 ;;^UTILITY(U,$J,358.3,340,1,4,0)
 ;;=4^R56.1
 ;;^UTILITY(U,$J,358.3,340,2)
 ;;=^5019523
 ;;^UTILITY(U,$J,358.3,341,0)
 ;;=G45.0^^7^43^15
 ;;^UTILITY(U,$J,358.3,341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,341,1,3,0)
 ;;=3^Vertebro-Basilar Artery Syndrome
 ;;^UTILITY(U,$J,358.3,341,1,4,0)
 ;;=4^G45.0
 ;;^UTILITY(U,$J,358.3,341,2)
 ;;=^5003955
 ;;^UTILITY(U,$J,358.3,342,0)
 ;;=G45.1^^7^43^4
 ;;^UTILITY(U,$J,358.3,342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,342,1,3,0)
 ;;=3^Carotid Artery Syndrome
 ;;^UTILITY(U,$J,358.3,342,1,4,0)
 ;;=4^G45.1
 ;;^UTILITY(U,$J,358.3,342,2)
 ;;=^5003956
 ;;^UTILITY(U,$J,358.3,343,0)
 ;;=G45.3^^7^43^1
 ;;^UTILITY(U,$J,358.3,343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,343,1,3,0)
 ;;=3^Amaurosis Fugax
 ;;^UTILITY(U,$J,358.3,343,1,4,0)
 ;;=4^G45.3
 ;;^UTILITY(U,$J,358.3,343,2)
 ;;=^304129
 ;;^UTILITY(U,$J,358.3,344,0)
 ;;=G45.4^^7^43^13
 ;;^UTILITY(U,$J,358.3,344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,344,1,3,0)
 ;;=3^Transient Global Amnesia
 ;;^UTILITY(U,$J,358.3,344,1,4,0)
 ;;=4^G45.4
 ;;^UTILITY(U,$J,358.3,344,2)
 ;;=^293883
 ;;^UTILITY(U,$J,358.3,345,0)
 ;;=G45.8^^7^43^11
 ;;^UTILITY(U,$J,358.3,345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,345,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attacks,Other
 ;;^UTILITY(U,$J,358.3,345,1,4,0)
 ;;=4^G45.8
 ;;^UTILITY(U,$J,358.3,345,2)
 ;;=^5003958
 ;;^UTILITY(U,$J,358.3,346,0)
 ;;=G45.9^^7^43^12
 ;;^UTILITY(U,$J,358.3,346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,346,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attacks,Unspec
 ;;^UTILITY(U,$J,358.3,346,1,4,0)
 ;;=4^G45.9
 ;;^UTILITY(U,$J,358.3,346,2)
 ;;=^5003959
 ;;^UTILITY(U,$J,358.3,347,0)
 ;;=G46.0^^7^43^8
 ;;^UTILITY(U,$J,358.3,347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,347,1,3,0)
 ;;=3^Middle Cerebral Artery Syndrome
 ;;^UTILITY(U,$J,358.3,347,1,4,0)
 ;;=4^G46.0
 ;;^UTILITY(U,$J,358.3,347,2)
 ;;=^5003960
 ;;^UTILITY(U,$J,358.3,348,0)
 ;;=G46.1^^7^43^2
 ;;^UTILITY(U,$J,358.3,348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,348,1,3,0)
 ;;=3^Anterior Cerebral Artery Syndrome
 ;;^UTILITY(U,$J,358.3,348,1,4,0)
 ;;=4^G46.1
 ;;^UTILITY(U,$J,358.3,348,2)
 ;;=^5003961
 ;;^UTILITY(U,$J,358.3,349,0)
 ;;=G46.2^^7^43^10
 ;;^UTILITY(U,$J,358.3,349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,349,1,3,0)
 ;;=3^Posterior Cerebral Artery Syndrome
 ;;^UTILITY(U,$J,358.3,349,1,4,0)
 ;;=4^G46.2
 ;;^UTILITY(U,$J,358.3,349,2)
 ;;=^5003962
 ;;^UTILITY(U,$J,358.3,350,0)
 ;;=G46.3^^7^43^3
 ;;^UTILITY(U,$J,358.3,350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,350,1,3,0)
 ;;=3^Brain Stem Stroke Syndrome
 ;;^UTILITY(U,$J,358.3,350,1,4,0)
 ;;=4^G46.3
 ;;^UTILITY(U,$J,358.3,350,2)
 ;;=^5003963
 ;;^UTILITY(U,$J,358.3,351,0)
 ;;=G46.7^^7^43^7
 ;;^UTILITY(U,$J,358.3,351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,351,1,3,0)
 ;;=3^Lacunar Syndromes,Other
 ;;^UTILITY(U,$J,358.3,351,1,4,0)
 ;;=4^G46.7
 ;;^UTILITY(U,$J,358.3,351,2)
 ;;=^5003967
 ;;^UTILITY(U,$J,358.3,352,0)
 ;;=G46.8^^7^43^14
 ;;^UTILITY(U,$J,358.3,352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,352,1,3,0)
 ;;=3^Vascular Syndromes of Brain in CVD,Other
 ;;^UTILITY(U,$J,358.3,352,1,4,0)
 ;;=4^G46.8
 ;;^UTILITY(U,$J,358.3,352,2)
 ;;=^5003968
 ;;^UTILITY(U,$J,358.3,353,0)
 ;;=I67.2^^7^43^5
 ;;^UTILITY(U,$J,358.3,353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,353,1,3,0)
 ;;=3^Cerebral Atherosclerosis
 ;;^UTILITY(U,$J,358.3,353,1,4,0)
 ;;=4^I67.2
 ;;^UTILITY(U,$J,358.3,353,2)
 ;;=^21571
 ;;^UTILITY(U,$J,358.3,354,0)
 ;;=I69.898^^7^43^6
 ;;^UTILITY(U,$J,358.3,354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,354,1,3,0)
 ;;=3^Cerebrovascular Disease Sequelae,Other
 ;;^UTILITY(U,$J,358.3,354,1,4,0)
 ;;=4^I69.898
 ;;^UTILITY(U,$J,358.3,354,2)
 ;;=^5007550
 ;;^UTILITY(U,$J,358.3,355,0)
 ;;=Z86.73^^7^43^9
 ;;^UTILITY(U,$J,358.3,355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,355,1,3,0)
 ;;=3^Personal Hx of TIA/Cerebral Inf w/o Resid Deficits
 ;;^UTILITY(U,$J,358.3,355,1,4,0)
 ;;=4^Z86.73
 ;;^UTILITY(U,$J,358.3,355,2)
 ;;=^5063477
 ;;^UTILITY(U,$J,358.3,356,0)
 ;;=H81.10^^7^44^1
 ;;^UTILITY(U,$J,358.3,356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,356,1,3,0)
 ;;=3^Benign Paroxysmal Vertigo
 ;;^UTILITY(U,$J,358.3,356,1,4,0)
 ;;=4^H81.10
 ;;^UTILITY(U,$J,358.3,356,2)
 ;;=^5006864
 ;;^UTILITY(U,$J,358.3,357,0)
 ;;=R55.^^7^44^3
 ;;^UTILITY(U,$J,358.3,357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,357,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,357,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,357,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,358,0)
 ;;=R42.^^7^44^2
 ;;^UTILITY(U,$J,358.3,358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,358,1,3,0)
 ;;=3^Dizziness and Giddiness
 ;;^UTILITY(U,$J,358.3,358,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,358,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,359,0)
 ;;=H81.4^^7^44^4
 ;;^UTILITY(U,$J,358.3,359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,359,1,3,0)
 ;;=3^Vertigo of Central Origin
 ;;^UTILITY(U,$J,358.3,359,1,4,0)
 ;;=4^H81.4
 ;;^UTILITY(U,$J,358.3,359,2)
 ;;=^269484
 ;;^UTILITY(U,$J,358.3,360,0)
 ;;=F10.27^^7^45^1
 ;;^UTILITY(U,$J,358.3,360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,360,1,3,0)
 ;;=3^Alcoholic Encephalopathy
 ;;^UTILITY(U,$J,358.3,360,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,360,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,361,0)
 ;;=G92.^^7^45^4
 ;;^UTILITY(U,$J,358.3,361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,361,1,3,0)
 ;;=3^Toxic Encephalopathy
 ;;^UTILITY(U,$J,358.3,361,1,4,0)
 ;;=4^G92.
 ;;^UTILITY(U,$J,358.3,361,2)
 ;;=^259061
 ;;^UTILITY(U,$J,358.3,362,0)
 ;;=G96.8^^7^45^2
 ;;^UTILITY(U,$J,358.3,362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,362,1,3,0)
 ;;=3^Disorder of Central Nervous System,Other Spec
 ;;^UTILITY(U,$J,358.3,362,1,4,0)
 ;;=4^G96.8
 ;;^UTILITY(U,$J,358.3,362,2)
 ;;=^5004199
 ;;^UTILITY(U,$J,358.3,363,0)
 ;;=G98.8^^7^45^3
 ;;^UTILITY(U,$J,358.3,363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,363,1,3,0)
 ;;=3^Disorder of Nervous System,Other
 ;;^UTILITY(U,$J,358.3,363,1,4,0)
 ;;=4^G98.8
 ;;^UTILITY(U,$J,358.3,363,2)
 ;;=^5004214
 ;;^UTILITY(U,$J,358.3,364,0)
 ;;=G43.009^^7^46^7
 ;;^UTILITY(U,$J,358.3,364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,364,1,3,0)
 ;;=3^Migraine w/o Aura Not Intractable 
 ;;^UTILITY(U,$J,358.3,364,1,4,0)
 ;;=4^G43.009
 ;;^UTILITY(U,$J,358.3,364,2)
 ;;=^5003877
 ;;^UTILITY(U,$J,358.3,365,0)
 ;;=G43.019^^7^46^6
 ;;^UTILITY(U,$J,358.3,365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,365,1,3,0)
 ;;=3^Migraine w/o Aura Intractable
 ;;^UTILITY(U,$J,358.3,365,1,4,0)
 ;;=4^G43.019
 ;;^UTILITY(U,$J,358.3,365,2)
 ;;=^5003879
 ;;^UTILITY(U,$J,358.3,366,0)
 ;;=G43.109^^7^46^5
 ;;^UTILITY(U,$J,358.3,366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,366,1,3,0)
 ;;=3^Migraine w/ Aura Not Intractable
 ;;^UTILITY(U,$J,358.3,366,1,4,0)
 ;;=4^G43.109
 ;;^UTILITY(U,$J,358.3,366,2)
 ;;=^5003881
 ;;^UTILITY(U,$J,358.3,367,0)
 ;;=G43.119^^7^46^4
 ;;^UTILITY(U,$J,358.3,367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,367,1,3,0)
 ;;=3^Migraine w/ Aura Intractable
 ;;^UTILITY(U,$J,358.3,367,1,4,0)
 ;;=4^G43.119
 ;;^UTILITY(U,$J,358.3,367,2)
 ;;=^5003883
 ;;^UTILITY(U,$J,358.3,368,0)
 ;;=G43.809^^7^46^2
 ;;^UTILITY(U,$J,358.3,368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,368,1,3,0)
 ;;=3^Migrain Not Intractable w/o Status Magrainosus,Other
 ;;^UTILITY(U,$J,358.3,368,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,368,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,369,0)
 ;;=G43.909^^7^46^3
 ;;^UTILITY(U,$J,358.3,369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,369,1,3,0)
 ;;=3^Migraine Not Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,369,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,369,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,370,0)
 ;;=G44.209^^7^46^8
 ;;^UTILITY(U,$J,358.3,370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,370,1,3,0)
 ;;=3^Tension-Type Headache Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,370,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,370,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,371,0)
 ;;=R51.^^7^46^1
 ;;^UTILITY(U,$J,358.3,371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,371,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,371,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,371,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,372,0)
 ;;=G20.^^7^47^9
 ;;^UTILITY(U,$J,358.3,372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,372,1,3,0)
 ;;=3^Parkinson's Disease
 ;;^UTILITY(U,$J,358.3,372,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,372,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,373,0)
 ;;=G21.8^^7^47^11
 ;;^UTILITY(U,$J,358.3,373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,373,1,3,0)
 ;;=3^Secondary Parkinsonism,Other
