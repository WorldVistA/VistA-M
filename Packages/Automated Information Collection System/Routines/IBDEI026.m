IBDEI026 ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4880,1,4,0)
 ;;=4^S32.2XXA
 ;;^UTILITY(U,$J,358.3,4880,2)
 ;;=^5024629
 ;;^UTILITY(U,$J,358.3,4881,0)
 ;;=S83.201A^^34^300^11
 ;;^UTILITY(U,$J,358.3,4881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4881,1,3,0)
 ;;=3^Bucket-hndl tear of unsp mensc, current injury, l knee, init
 ;;^UTILITY(U,$J,358.3,4881,1,4,0)
 ;;=4^S83.201A
 ;;^UTILITY(U,$J,358.3,4881,2)
 ;;=^5043028
 ;;^UTILITY(U,$J,358.3,4882,0)
 ;;=S43.421A^^34^300^108
 ;;^UTILITY(U,$J,358.3,4882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4882,1,3,0)
 ;;=3^Sprain of right rotator cuff capsule, initial encounter
 ;;^UTILITY(U,$J,358.3,4882,1,4,0)
 ;;=4^S43.421A
 ;;^UTILITY(U,$J,358.3,4882,2)
 ;;=^5027879
 ;;^UTILITY(U,$J,358.3,4883,0)
 ;;=S43.422A^^34^300^104
 ;;^UTILITY(U,$J,358.3,4883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4883,1,3,0)
 ;;=3^Sprain of left rotator cuff capsule, initial encounter
 ;;^UTILITY(U,$J,358.3,4883,1,4,0)
 ;;=4^S43.422A
 ;;^UTILITY(U,$J,358.3,4883,2)
 ;;=^5027882
 ;;^UTILITY(U,$J,358.3,4884,0)
 ;;=S63.501A^^34^300^103
 ;;^UTILITY(U,$J,358.3,4884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4884,1,3,0)
 ;;=3^Sprain of Right Wrist,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,4884,1,4,0)
 ;;=4^S63.501A
 ;;^UTILITY(U,$J,358.3,4884,2)
 ;;=^5035583
 ;;^UTILITY(U,$J,358.3,4885,0)
 ;;=S63.502A^^34^300^102
 ;;^UTILITY(U,$J,358.3,4885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4885,1,3,0)
 ;;=3^Sprain of Left Wrist,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,4885,1,4,0)
 ;;=4^S63.502A
 ;;^UTILITY(U,$J,358.3,4885,2)
 ;;=^5035586
 ;;^UTILITY(U,$J,358.3,4886,0)
 ;;=S93.401A^^34^300^110
 ;;^UTILITY(U,$J,358.3,4886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4886,1,3,0)
 ;;=3^Sprain of unspecified ligament of right ankle, init encntr
 ;;^UTILITY(U,$J,358.3,4886,1,4,0)
 ;;=4^S93.401A
 ;;^UTILITY(U,$J,358.3,4886,2)
 ;;=^5045774
 ;;^UTILITY(U,$J,358.3,4887,0)
 ;;=S93.402A^^34^300^109
 ;;^UTILITY(U,$J,358.3,4887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4887,1,3,0)
 ;;=3^Sprain of unspecified ligament of left ankle, init encntr
 ;;^UTILITY(U,$J,358.3,4887,1,4,0)
 ;;=4^S93.402A
 ;;^UTILITY(U,$J,358.3,4887,2)
 ;;=^5045777
 ;;^UTILITY(U,$J,358.3,4888,0)
 ;;=S13.4XXA^^34^300^105
 ;;^UTILITY(U,$J,358.3,4888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4888,1,3,0)
 ;;=3^Sprain of ligaments of cervical spine, initial encounter
 ;;^UTILITY(U,$J,358.3,4888,1,4,0)
 ;;=4^S13.4XXA
 ;;^UTILITY(U,$J,358.3,4888,2)
 ;;=^5022028
 ;;^UTILITY(U,$J,358.3,4889,0)
 ;;=S23.3XXA^^34^300^107
 ;;^UTILITY(U,$J,358.3,4889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4889,1,3,0)
 ;;=3^Sprain of ligaments of thoracic spine, initial encounter
 ;;^UTILITY(U,$J,358.3,4889,1,4,0)
 ;;=4^S23.3XXA
 ;;^UTILITY(U,$J,358.3,4889,2)
 ;;=^5023246
 ;;^UTILITY(U,$J,358.3,4890,0)
 ;;=S33.5XXA^^34^300^106
 ;;^UTILITY(U,$J,358.3,4890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4890,1,3,0)
 ;;=3^Sprain of ligaments of lumbar spine, initial encounter
 ;;^UTILITY(U,$J,358.3,4890,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,4890,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,4891,0)
 ;;=Z96.60^^34^300^75
 ;;^UTILITY(U,$J,358.3,4891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4891,1,3,0)
 ;;=3^Presence of unspecified orthopedic joint implant
 ;;^UTILITY(U,$J,358.3,4891,1,4,0)
 ;;=4^Z96.60
 ;;^UTILITY(U,$J,358.3,4891,2)
 ;;=^5063691
 ;;^UTILITY(U,$J,358.3,4892,0)
 ;;=Z89.511^^34^300^4
 ;;^UTILITY(U,$J,358.3,4892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4892,1,3,0)
 ;;=3^Acquired absence of right leg below knee
 ;;^UTILITY(U,$J,358.3,4892,1,4,0)
 ;;=4^Z89.511
 ;;^UTILITY(U,$J,358.3,4892,2)
 ;;=^5063566
 ;;^UTILITY(U,$J,358.3,4893,0)
 ;;=Z89.512^^34^300^2
 ;;^UTILITY(U,$J,358.3,4893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4893,1,3,0)
 ;;=3^Acquired absence of left leg below knee
 ;;^UTILITY(U,$J,358.3,4893,1,4,0)
 ;;=4^Z89.512
 ;;^UTILITY(U,$J,358.3,4893,2)
 ;;=^5063567
 ;;^UTILITY(U,$J,358.3,4894,0)
 ;;=Z89.611^^34^300^3
 ;;^UTILITY(U,$J,358.3,4894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4894,1,3,0)
 ;;=3^Acquired absence of right leg above knee
 ;;^UTILITY(U,$J,358.3,4894,1,4,0)
 ;;=4^Z89.611
 ;;^UTILITY(U,$J,358.3,4894,2)
 ;;=^5063572
 ;;^UTILITY(U,$J,358.3,4895,0)
 ;;=Z89.612^^34^300^1
 ;;^UTILITY(U,$J,358.3,4895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4895,1,3,0)
 ;;=3^Acquired absence of left leg above knee
 ;;^UTILITY(U,$J,358.3,4895,1,4,0)
 ;;=4^Z89.612
 ;;^UTILITY(U,$J,358.3,4895,2)
 ;;=^5063573
 ;;^UTILITY(U,$J,358.3,4896,0)
 ;;=S83.200A^^34^300^12
 ;;^UTILITY(U,$J,358.3,4896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4896,1,3,0)
 ;;=3^Bucket-hndl tear of unsp mensc, current injury, r knee, init
 ;;^UTILITY(U,$J,358.3,4896,1,4,0)
 ;;=4^S83.200A
 ;;^UTILITY(U,$J,358.3,4896,2)
 ;;=^5043025
 ;;^UTILITY(U,$J,358.3,4897,0)
 ;;=M26.601^^34^300^114
 ;;^UTILITY(U,$J,358.3,4897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4897,1,3,0)
 ;;=3^Temporomandibular Joint Disorder,Right
 ;;^UTILITY(U,$J,358.3,4897,1,4,0)
 ;;=4^M26.601
 ;;^UTILITY(U,$J,358.3,4897,2)
 ;;=^5138792
 ;;^UTILITY(U,$J,358.3,4898,0)
 ;;=M26.602^^34^300^113
 ;;^UTILITY(U,$J,358.3,4898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4898,1,3,0)
 ;;=3^Temporomandibular Joint Disorder,Left
 ;;^UTILITY(U,$J,358.3,4898,1,4,0)
 ;;=4^M26.602
 ;;^UTILITY(U,$J,358.3,4898,2)
 ;;=^5138793
 ;;^UTILITY(U,$J,358.3,4899,0)
 ;;=M26.603^^34^300^112
 ;;^UTILITY(U,$J,358.3,4899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4899,1,3,0)
 ;;=3^Temporomandibular Joint Disorder,Bilateral
 ;;^UTILITY(U,$J,358.3,4899,1,4,0)
 ;;=4^M26.603
 ;;^UTILITY(U,$J,358.3,4899,2)
 ;;=^5138794
 ;;^UTILITY(U,$J,358.3,4900,0)
 ;;=T14.90XA^^34^300^41
 ;;^UTILITY(U,$J,358.3,4900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4900,1,3,0)
 ;;=3^Injury,Unspec,Initial Encntr
 ;;^UTILITY(U,$J,358.3,4900,1,4,0)
 ;;=4^T14.90XA
 ;;^UTILITY(U,$J,358.3,4900,2)
 ;;=^5151776
 ;;^UTILITY(U,$J,358.3,4901,0)
 ;;=T14.90XD^^34^300^42
 ;;^UTILITY(U,$J,358.3,4901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4901,1,3,0)
 ;;=3^Injury,Unspec,Subsequent Encntr
 ;;^UTILITY(U,$J,358.3,4901,1,4,0)
 ;;=4^T14.90XD
 ;;^UTILITY(U,$J,358.3,4901,2)
 ;;=^5151777
 ;;^UTILITY(U,$J,358.3,4902,0)
 ;;=T14.90XS^^34^300^43
 ;;^UTILITY(U,$J,358.3,4902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4902,1,3,0)
 ;;=3^Injury,Unspec,Sequela
 ;;^UTILITY(U,$J,358.3,4902,1,4,0)
 ;;=4^T14.90XS
 ;;^UTILITY(U,$J,358.3,4902,2)
 ;;=^5151778
 ;;^UTILITY(U,$J,358.3,4903,0)
 ;;=E11.40^^34^301^27
 ;;^UTILITY(U,$J,358.3,4903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4903,1,3,0)
 ;;=3^DM Type 2 w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,4903,1,4,0)
 ;;=4^E11.40
 ;;^UTILITY(U,$J,358.3,4903,2)
 ;;=^5002644
 ;;^UTILITY(U,$J,358.3,4904,0)
 ;;=F01.50^^34^301^72
 ;;^UTILITY(U,$J,358.3,4904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4904,1,3,0)
 ;;=3^Vascular dementia without behavioral disturbance
 ;;^UTILITY(U,$J,358.3,4904,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,4904,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,4905,0)
 ;;=F10.27^^34^301^6
 ;;^UTILITY(U,$J,358.3,4905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4905,1,3,0)
 ;;=3^Alcohol dependence with alcohol-induced persisting dementia
 ;;^UTILITY(U,$J,358.3,4905,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,4905,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,4906,0)
 ;;=G44.209^^34^301^68
 ;;^UTILITY(U,$J,358.3,4906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4906,1,3,0)
 ;;=3^Tension-type headache, unspecified, not intractable
 ;;^UTILITY(U,$J,358.3,4906,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,4906,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,4907,0)
 ;;=G30.9^^34^301^7
 ;;^UTILITY(U,$J,358.3,4907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4907,1,3,0)
 ;;=3^Alzheimer's disease, unspecified
 ;;^UTILITY(U,$J,358.3,4907,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,4907,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,4908,0)
 ;;=G20.^^34^301^57
 ;;^UTILITY(U,$J,358.3,4908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4908,1,3,0)
 ;;=3^Parkinson's disease
 ;;^UTILITY(U,$J,358.3,4908,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,4908,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,4909,0)
 ;;=G25.0^^34^301^33
 ;;^UTILITY(U,$J,358.3,4909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4909,1,3,0)
 ;;=3^Essential tremor
 ;;^UTILITY(U,$J,358.3,4909,1,4,0)
 ;;=4^G25.0
 ;;^UTILITY(U,$J,358.3,4909,2)
 ;;=^5003791
 ;;^UTILITY(U,$J,358.3,4910,0)
 ;;=G25.1^^34^301^29
 ;;^UTILITY(U,$J,358.3,4910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4910,1,3,0)
 ;;=3^Drug-induced tremor
 ;;^UTILITY(U,$J,358.3,4910,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,4910,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,4911,0)
 ;;=G25.2^^34^301^70
 ;;^UTILITY(U,$J,358.3,4911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4911,1,3,0)
 ;;=3^Tremor NEC
 ;;^UTILITY(U,$J,358.3,4911,1,4,0)
 ;;=4^G25.2
 ;;^UTILITY(U,$J,358.3,4911,2)
 ;;=^5003793
 ;;^UTILITY(U,$J,358.3,4912,0)
 ;;=G25.81^^34^301^63
 ;;^UTILITY(U,$J,358.3,4912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4912,1,3,0)
 ;;=3^Restless legs syndrome
 ;;^UTILITY(U,$J,358.3,4912,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,4912,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,4913,0)
 ;;=G90.59^^34^301^22
 ;;^UTILITY(U,$J,358.3,4913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4913,1,3,0)
 ;;=3^Complex regional pain syndrome I of other specified site
 ;;^UTILITY(U,$J,358.3,4913,1,4,0)
 ;;=4^G90.59
 ;;^UTILITY(U,$J,358.3,4913,2)
 ;;=^5004171
 ;;^UTILITY(U,$J,358.3,4914,0)
 ;;=G35.^^34^301^48
 ;;^UTILITY(U,$J,358.3,4914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4914,1,3,0)
 ;;=3^Multiple sclerosis
 ;;^UTILITY(U,$J,358.3,4914,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,4914,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,4915,0)
 ;;=G82.20^^34^301^55
 ;;^UTILITY(U,$J,358.3,4915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4915,1,3,0)
 ;;=3^Paraplegia, unspecified
 ;;^UTILITY(U,$J,358.3,4915,1,4,0)
 ;;=4^G82.20
 ;;^UTILITY(U,$J,358.3,4915,2)
 ;;=^5004125
 ;;^UTILITY(U,$J,358.3,4916,0)
 ;;=G40.909^^34^301^32
 ;;^UTILITY(U,$J,358.3,4916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4916,1,3,0)
 ;;=3^Epilepsy, unsp, not intractable, without status epilepticus
 ;;^UTILITY(U,$J,358.3,4916,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,4916,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,4917,0)
 ;;=G40.901^^34^301^31
 ;;^UTILITY(U,$J,358.3,4917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4917,1,3,0)
 ;;=3^Epilepsy, unsp, not intractable, with status epilepticus
 ;;^UTILITY(U,$J,358.3,4917,1,4,0)
 ;;=4^G40.901
 ;;^UTILITY(U,$J,358.3,4917,2)
 ;;=^5003864
 ;;^UTILITY(U,$J,358.3,4918,0)
 ;;=G43.809^^34^301^53
 ;;^UTILITY(U,$J,358.3,4918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4918,1,3,0)
 ;;=3^Other migraine, not intractable, without status migrainosus
 ;;^UTILITY(U,$J,358.3,4918,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,4918,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,4919,0)
 ;;=G43.A0^^34^301^26
 ;;^UTILITY(U,$J,358.3,4919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4919,1,3,0)
 ;;=3^Cyclical vomiting, not intractable
 ;;^UTILITY(U,$J,358.3,4919,1,4,0)
 ;;=4^G43.A0
 ;;^UTILITY(U,$J,358.3,4919,2)
 ;;=^5003912
 ;;^UTILITY(U,$J,358.3,4920,0)
 ;;=G43.B0^^34^301^51
 ;;^UTILITY(U,$J,358.3,4920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4920,1,3,0)
 ;;=3^Ophthalmoplegic migraine, not intractable
 ;;^UTILITY(U,$J,358.3,4920,1,4,0)
 ;;=4^G43.B0
 ;;^UTILITY(U,$J,358.3,4920,2)
 ;;=^5003914
 ;;^UTILITY(U,$J,358.3,4921,0)
 ;;=G43.C0^^34^301^59
 ;;^UTILITY(U,$J,358.3,4921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4921,1,3,0)
 ;;=3^Periodic Headache Syndromes,Not Intractable
 ;;^UTILITY(U,$J,358.3,4921,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,4921,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,4922,0)
 ;;=G43.D0^^34^301^2
 ;;^UTILITY(U,$J,358.3,4922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4922,1,3,0)
 ;;=3^Abdominal migraine, not intractable
 ;;^UTILITY(U,$J,358.3,4922,1,4,0)
 ;;=4^G43.D0
 ;;^UTILITY(U,$J,358.3,4922,2)
 ;;=^5003918
 ;;^UTILITY(U,$J,358.3,4923,0)
 ;;=G43.A1^^34^301^25
 ;;^UTILITY(U,$J,358.3,4923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4923,1,3,0)
 ;;=3^Cyclical vomiting, intractable
 ;;^UTILITY(U,$J,358.3,4923,1,4,0)
 ;;=4^G43.A1
 ;;^UTILITY(U,$J,358.3,4923,2)
 ;;=^5003913
 ;;^UTILITY(U,$J,358.3,4924,0)
 ;;=G43.B1^^34^301^50
 ;;^UTILITY(U,$J,358.3,4924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4924,1,3,0)
 ;;=3^Ophthalmoplegic migraine, intractable
 ;;^UTILITY(U,$J,358.3,4924,1,4,0)
 ;;=4^G43.B1
 ;;^UTILITY(U,$J,358.3,4924,2)
 ;;=^5003915
 ;;^UTILITY(U,$J,358.3,4925,0)
 ;;=G43.C1^^34^301^58
 ;;^UTILITY(U,$J,358.3,4925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4925,1,3,0)
 ;;=3^Periodic Headache Syndromes,Intractable
 ;;^UTILITY(U,$J,358.3,4925,1,4,0)
 ;;=4^G43.C1
 ;;^UTILITY(U,$J,358.3,4925,2)
 ;;=^5003917
 ;;^UTILITY(U,$J,358.3,4926,0)
 ;;=G43.D1^^34^301^1
 ;;^UTILITY(U,$J,358.3,4926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4926,1,3,0)
 ;;=3^Abdominal migraine, intractable
 ;;^UTILITY(U,$J,358.3,4926,1,4,0)
 ;;=4^G43.D1
 ;;^UTILITY(U,$J,358.3,4926,2)
 ;;=^5003919
 ;;^UTILITY(U,$J,358.3,4927,0)
 ;;=G43.909^^34^301^47
 ;;^UTILITY(U,$J,358.3,4927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4927,1,3,0)
 ;;=3^Migraine, unsp, not intractable, without status migrainosus
 ;;^UTILITY(U,$J,358.3,4927,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,4927,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,4928,0)
 ;;=G43.919^^34^301^46
 ;;^UTILITY(U,$J,358.3,4928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4928,1,3,0)
 ;;=3^Migraine, unsp, intractable, without status migrainosus
 ;;^UTILITY(U,$J,358.3,4928,1,4,0)
 ;;=4^G43.919
 ;;^UTILITY(U,$J,358.3,4928,2)
 ;;=^5003911
 ;;^UTILITY(U,$J,358.3,4929,0)
 ;;=G51.0^^34^301^13
 ;;^UTILITY(U,$J,358.3,4929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4929,1,3,0)
 ;;=3^Bell's palsy
 ;;^UTILITY(U,$J,358.3,4929,1,4,0)
 ;;=4^G51.0
 ;;^UTILITY(U,$J,358.3,4929,2)
 ;;=^13238
 ;;^UTILITY(U,$J,358.3,4930,0)
 ;;=G57.11^^34^301^45
 ;;^UTILITY(U,$J,358.3,4930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4930,1,3,0)
 ;;=3^Meralgia paresthetica, right lower limb
 ;;^UTILITY(U,$J,358.3,4930,1,4,0)
 ;;=4^G57.11
 ;;^UTILITY(U,$J,358.3,4930,2)
 ;;=^5004042
 ;;^UTILITY(U,$J,358.3,4931,0)
 ;;=G57.12^^34^301^44
 ;;^UTILITY(U,$J,358.3,4931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4931,1,3,0)
 ;;=3^Meralgia paresthetica, left lower limb
 ;;^UTILITY(U,$J,358.3,4931,1,4,0)
 ;;=4^G57.12
 ;;^UTILITY(U,$J,358.3,4931,2)
 ;;=^5004043
 ;;^UTILITY(U,$J,358.3,4932,0)
 ;;=G60.8^^34^301^52
 ;;^UTILITY(U,$J,358.3,4932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4932,1,3,0)
 ;;=3^Other hereditary and idiopathic neuropathies
 ;;^UTILITY(U,$J,358.3,4932,1,4,0)
 ;;=4^G60.8
 ;;^UTILITY(U,$J,358.3,4932,2)
 ;;=^5004070
 ;;^UTILITY(U,$J,358.3,4933,0)
 ;;=G60.9^^34^301^41
 ;;^UTILITY(U,$J,358.3,4933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4933,1,3,0)
 ;;=3^Hereditary and idiopathic neuropathy, unspecified
 ;;^UTILITY(U,$J,358.3,4933,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,4933,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,4934,0)
 ;;=H81.13^^34^301^14
 ;;^UTILITY(U,$J,358.3,4934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4934,1,3,0)
 ;;=3^Benign paroxysmal vertigo, bilateral
 ;;^UTILITY(U,$J,358.3,4934,1,4,0)
 ;;=4^H81.13
 ;;^UTILITY(U,$J,358.3,4934,2)
 ;;=^5006867
 ;;^UTILITY(U,$J,358.3,4935,0)
 ;;=H81.11^^34^301^16
 ;;^UTILITY(U,$J,358.3,4935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4935,1,3,0)
 ;;=3^Benign paroxysmal vertigo, right ear
 ;;^UTILITY(U,$J,358.3,4935,1,4,0)
 ;;=4^H81.11
 ;;^UTILITY(U,$J,358.3,4935,2)
 ;;=^5006865
 ;;^UTILITY(U,$J,358.3,4936,0)
 ;;=H81.12^^34^301^15
 ;;^UTILITY(U,$J,358.3,4936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4936,1,3,0)
 ;;=3^Benign paroxysmal vertigo, left ear
 ;;^UTILITY(U,$J,358.3,4936,1,4,0)
 ;;=4^H81.12
 ;;^UTILITY(U,$J,358.3,4936,2)
 ;;=^5006866
 ;;^UTILITY(U,$J,358.3,4937,0)
 ;;=I63.50^^34^301^17
 ;;^UTILITY(U,$J,358.3,4937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4937,1,3,0)
 ;;=3^Cereb infrc due to unsp occls or stenos of unsp cereb artery
 ;;^UTILITY(U,$J,358.3,4937,1,4,0)
 ;;=4^I63.50
 ;;^UTILITY(U,$J,358.3,4937,2)
 ;;=^5007343
 ;;^UTILITY(U,$J,358.3,4938,0)
 ;;=G45.9^^34^301^69
 ;;^UTILITY(U,$J,358.3,4938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4938,1,3,0)
 ;;=3^Transient cerebral ischemic attack, unspecified
 ;;^UTILITY(U,$J,358.3,4938,1,4,0)
 ;;=4^G45.9
 ;;^UTILITY(U,$J,358.3,4938,2)
 ;;=^5003959
 ;;^UTILITY(U,$J,358.3,4939,0)
 ;;=I67.9^^34^301^18
 ;;^UTILITY(U,$J,358.3,4939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4939,1,3,0)
 ;;=3^Cerebrovascular disease, unspecified
 ;;^UTILITY(U,$J,358.3,4939,1,4,0)
 ;;=4^I67.9
 ;;^UTILITY(U,$J,358.3,4939,2)
 ;;=^5007389
 ;;^UTILITY(U,$J,358.3,4940,0)
 ;;=I69.920^^34^301^9
 ;;^UTILITY(U,$J,358.3,4940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4940,1,3,0)
 ;;=3^Aphasia following unspecified cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,4940,1,4,0)
 ;;=4^I69.920
 ;;^UTILITY(U,$J,358.3,4940,2)
 ;;=^5007553
 ;;^UTILITY(U,$J,358.3,4941,0)
 ;;=I69.921^^34^301^30
 ;;^UTILITY(U,$J,358.3,4941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4941,1,3,0)
 ;;=3^Dysphasia following unspecified cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,4941,1,4,0)
 ;;=4^I69.921
 ;;^UTILITY(U,$J,358.3,4941,2)
 ;;=^5007554
 ;;^UTILITY(U,$J,358.3,4942,0)
 ;;=I69.951^^34^301^37
 ;;^UTILITY(U,$J,358.3,4942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4942,1,3,0)
 ;;=3^Hemiplga fol unsp cerebvasc disease aff right dominant side
 ;;^UTILITY(U,$J,358.3,4942,1,4,0)
 ;;=4^I69.951
 ;;^UTILITY(U,$J,358.3,4942,2)
 ;;=^5007561
 ;;^UTILITY(U,$J,358.3,4943,0)
 ;;=I69.952^^34^301^38
 ;;^UTILITY(U,$J,358.3,4943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4943,1,3,0)
 ;;=3^Hemiplga fol unsp cerebvasc disease aff left dominant side
 ;;^UTILITY(U,$J,358.3,4943,1,4,0)
 ;;=4^I69.952
 ;;^UTILITY(U,$J,358.3,4943,2)
 ;;=^5133586
 ;;^UTILITY(U,$J,358.3,4944,0)
 ;;=I69.953^^34^301^39
 ;;^UTILITY(U,$J,358.3,4944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4944,1,3,0)
 ;;=3^Hemiplga fol unsp cerebvasc disease aff right nondom side
 ;;^UTILITY(U,$J,358.3,4944,1,4,0)
 ;;=4^I69.953
 ;;^UTILITY(U,$J,358.3,4944,2)
 ;;=^5007562
 ;;^UTILITY(U,$J,358.3,4945,0)
 ;;=I69.954^^34^301^40
 ;;^UTILITY(U,$J,358.3,4945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4945,1,3,0)
 ;;=3^Hemiplga fol unsp cerebvasc disease aff left nondom side
 ;;^UTILITY(U,$J,358.3,4945,1,4,0)
 ;;=4^I69.954
 ;;^UTILITY(U,$J,358.3,4945,2)
 ;;=^5133587
 ;;^UTILITY(U,$J,358.3,4946,0)
 ;;=I69.993^^34^301^10
 ;;^UTILITY(U,$J,358.3,4946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4946,1,3,0)
 ;;=3^Ataxia following unspecified cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,4946,1,4,0)
 ;;=4^I69.993
 ;;^UTILITY(U,$J,358.3,4946,2)
 ;;=^5007571
 ;;^UTILITY(U,$J,358.3,4947,0)
 ;;=M79.2^^34^301^49
 ;;^UTILITY(U,$J,358.3,4947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4947,1,3,0)
 ;;=3^Neuralgia and neuritis, unspecified
