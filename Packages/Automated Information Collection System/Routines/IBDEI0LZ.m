IBDEI0LZ ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27815,1,4,0)
 ;;=4^Q28.2
 ;;^UTILITY(U,$J,358.3,27815,2)
 ;;=^5018595
 ;;^UTILITY(U,$J,358.3,27816,0)
 ;;=G93.0^^77^1192^5
 ;;^UTILITY(U,$J,358.3,27816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27816,1,3,0)
 ;;=3^Cerebral cysts
 ;;^UTILITY(U,$J,358.3,27816,1,4,0)
 ;;=4^G93.0
 ;;^UTILITY(U,$J,358.3,27816,2)
 ;;=^268481
 ;;^UTILITY(U,$J,358.3,27817,0)
 ;;=G04.90^^77^1192^10
 ;;^UTILITY(U,$J,358.3,27817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27817,1,3,0)
 ;;=3^Encephalitis and encephalomyelitis, unspecified
 ;;^UTILITY(U,$J,358.3,27817,1,4,0)
 ;;=4^G04.90
 ;;^UTILITY(U,$J,358.3,27817,2)
 ;;=^5003741
 ;;^UTILITY(U,$J,358.3,27818,0)
 ;;=G04.91^^77^1192^19
 ;;^UTILITY(U,$J,358.3,27818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27818,1,3,0)
 ;;=3^Myelitis, unspecified
 ;;^UTILITY(U,$J,358.3,27818,1,4,0)
 ;;=4^G04.91
 ;;^UTILITY(U,$J,358.3,27818,2)
 ;;=^5003742
 ;;^UTILITY(U,$J,358.3,27819,0)
 ;;=G93.40^^77^1192^11
 ;;^UTILITY(U,$J,358.3,27819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27819,1,3,0)
 ;;=3^Encephalopathy, unspecified
 ;;^UTILITY(U,$J,358.3,27819,1,4,0)
 ;;=4^G93.40
 ;;^UTILITY(U,$J,358.3,27819,2)
 ;;=^329917
 ;;^UTILITY(U,$J,358.3,27820,0)
 ;;=G91.0^^77^1192^9
 ;;^UTILITY(U,$J,358.3,27820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27820,1,3,0)
 ;;=3^Communicating hydrocephalus
 ;;^UTILITY(U,$J,358.3,27820,1,4,0)
 ;;=4^G91.0
 ;;^UTILITY(U,$J,358.3,27820,2)
 ;;=^26586
 ;;^UTILITY(U,$J,358.3,27821,0)
 ;;=G91.1^^77^1192^27
 ;;^UTILITY(U,$J,358.3,27821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27821,1,3,0)
 ;;=3^Obstructive hydrocephalus
 ;;^UTILITY(U,$J,358.3,27821,1,4,0)
 ;;=4^G91.1
 ;;^UTILITY(U,$J,358.3,27821,2)
 ;;=^84947
 ;;^UTILITY(U,$J,358.3,27822,0)
 ;;=I61.9^^77^1192^20
 ;;^UTILITY(U,$J,358.3,27822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27822,1,3,0)
 ;;=3^Nontraumatic intracerebral hemorrhage, unspecified
 ;;^UTILITY(U,$J,358.3,27822,1,4,0)
 ;;=4^I61.9
 ;;^UTILITY(U,$J,358.3,27822,2)
 ;;=^5007288
 ;;^UTILITY(U,$J,358.3,27823,0)
 ;;=I61.3^^77^1192^21
 ;;^UTILITY(U,$J,358.3,27823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27823,1,3,0)
 ;;=3^Nontraumatic intracerebral hemorrhage, brainstem
 ;;^UTILITY(U,$J,358.3,27823,1,4,0)
 ;;=4^I61.3
 ;;^UTILITY(U,$J,358.3,27823,2)
 ;;=^5007283
 ;;^UTILITY(U,$J,358.3,27824,0)
 ;;=I61.4^^77^1192^22
 ;;^UTILITY(U,$J,358.3,27824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27824,1,3,0)
 ;;=3^Nontraumatic intracerebral hemorrhage, cerebellum
 ;;^UTILITY(U,$J,358.3,27824,1,4,0)
 ;;=4^I61.4
 ;;^UTILITY(U,$J,358.3,27824,2)
 ;;=^5007284
 ;;^UTILITY(U,$J,358.3,27825,0)
 ;;=I61.5^^77^1192^23
 ;;^UTILITY(U,$J,358.3,27825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27825,1,3,0)
 ;;=3^Nontraumatic intracerebral hemorrhage, intraventricular
 ;;^UTILITY(U,$J,358.3,27825,1,4,0)
 ;;=4^I61.5
 ;;^UTILITY(U,$J,358.3,27825,2)
 ;;=^5007285
 ;;^UTILITY(U,$J,358.3,27826,0)
 ;;=I61.6^^77^1192^24
 ;;^UTILITY(U,$J,358.3,27826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27826,1,3,0)
 ;;=3^Nontraumatic intracerebral hemorrhage, multiple localized
 ;;^UTILITY(U,$J,358.3,27826,1,4,0)
 ;;=4^I61.6
 ;;^UTILITY(U,$J,358.3,27826,2)
 ;;=^5007286
 ;;^UTILITY(U,$J,358.3,27827,0)
 ;;=G44.1^^77^1192^69
 ;;^UTILITY(U,$J,358.3,27827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27827,1,3,0)
 ;;=3^Vascular headache, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,27827,1,4,0)
 ;;=4^G44.1
 ;;^UTILITY(U,$J,358.3,27827,2)
 ;;=^5003934
 ;;^UTILITY(U,$J,358.3,27828,0)
 ;;=R51.^^77^1192^12
 ;;^UTILITY(U,$J,358.3,27828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27828,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,27828,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,27828,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,27829,0)
 ;;=G03.9^^77^1192^18
 ;;^UTILITY(U,$J,358.3,27829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27829,1,3,0)
 ;;=3^Meningitis, unspecified
 ;;^UTILITY(U,$J,358.3,27829,1,4,0)
 ;;=4^G03.9
 ;;^UTILITY(U,$J,358.3,27829,2)
 ;;=^5003729
 ;;^UTILITY(U,$J,358.3,27830,0)
 ;;=G03.1^^77^1192^8
 ;;^UTILITY(U,$J,358.3,27830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27830,1,3,0)
 ;;=3^Chronic meningitis
 ;;^UTILITY(U,$J,358.3,27830,1,4,0)
 ;;=4^G03.1
 ;;^UTILITY(U,$J,358.3,27830,2)
 ;;=^268382
 ;;^UTILITY(U,$J,358.3,27831,0)
 ;;=G00.9^^77^1192^2
 ;;^UTILITY(U,$J,358.3,27831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27831,1,3,0)
 ;;=3^Bacterial meningitis, unspecified
 ;;^UTILITY(U,$J,358.3,27831,1,4,0)
 ;;=4^G00.9
 ;;^UTILITY(U,$J,358.3,27831,2)
 ;;=^5003724
 ;;^UTILITY(U,$J,358.3,27832,0)
 ;;=A87.9^^77^1192^71
 ;;^UTILITY(U,$J,358.3,27832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27832,1,3,0)
 ;;=3^Viral meningitis, unspecified
 ;;^UTILITY(U,$J,358.3,27832,1,4,0)
 ;;=4^A87.9
 ;;^UTILITY(U,$J,358.3,27832,2)
 ;;=^5000435
 ;;^UTILITY(U,$J,358.3,27833,0)
 ;;=G96.0^^77^1192^7
 ;;^UTILITY(U,$J,358.3,27833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27833,1,3,0)
 ;;=3^Cerebrospinal fluid leak
 ;;^UTILITY(U,$J,358.3,27833,1,4,0)
 ;;=4^G96.0
 ;;^UTILITY(U,$J,358.3,27833,2)
 ;;=^5004195
 ;;^UTILITY(U,$J,358.3,27834,0)
 ;;=G20.^^77^1192^34
 ;;^UTILITY(U,$J,358.3,27834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27834,1,3,0)
 ;;=3^Parkinson's disease
 ;;^UTILITY(U,$J,358.3,27834,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,27834,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,27835,0)
 ;;=I62.00^^77^1192^26
 ;;^UTILITY(U,$J,358.3,27835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27835,1,3,0)
 ;;=3^Nontraumatic subdural hemorrhage, unspecified
 ;;^UTILITY(U,$J,358.3,27835,1,4,0)
 ;;=4^I62.00
 ;;^UTILITY(U,$J,358.3,27835,2)
 ;;=^5007289
 ;;^UTILITY(U,$J,358.3,27836,0)
 ;;=I60.9^^77^1192^25
 ;;^UTILITY(U,$J,358.3,27836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27836,1,3,0)
 ;;=3^Nontraumatic subarachnoid hemorrhage, unspecified
 ;;^UTILITY(U,$J,358.3,27836,1,4,0)
 ;;=4^I60.9
 ;;^UTILITY(U,$J,358.3,27836,2)
 ;;=^5007279
 ;;^UTILITY(U,$J,358.3,27837,0)
 ;;=G45.9^^77^1192^37
 ;;^UTILITY(U,$J,358.3,27837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27837,1,3,0)
 ;;=3^Transient cerebral ischemic attack, unspecified
 ;;^UTILITY(U,$J,358.3,27837,1,4,0)
 ;;=4^G45.9
 ;;^UTILITY(U,$J,358.3,27837,2)
 ;;=^5003959
 ;;^UTILITY(U,$J,358.3,27838,0)
 ;;=G50.0^^77^1192^68
 ;;^UTILITY(U,$J,358.3,27838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27838,1,3,0)
 ;;=3^Trigeminal neuralgia
 ;;^UTILITY(U,$J,358.3,27838,1,4,0)
 ;;=4^G50.0
 ;;^UTILITY(U,$J,358.3,27838,2)
 ;;=^121978
 ;;^UTILITY(U,$J,358.3,27839,0)
 ;;=G45.0^^77^1192^70
 ;;^UTILITY(U,$J,358.3,27839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27839,1,3,0)
 ;;=3^Vertebro-basilar artery syndrome
 ;;^UTILITY(U,$J,358.3,27839,1,4,0)
 ;;=4^G45.0
 ;;^UTILITY(U,$J,358.3,27839,2)
 ;;=^5003955
 ;;^UTILITY(U,$J,358.3,27840,0)
 ;;=G91.9^^77^1192^13
 ;;^UTILITY(U,$J,358.3,27840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27840,1,3,0)
 ;;=3^Hydrocephalus, unspecified
 ;;^UTILITY(U,$J,358.3,27840,1,4,0)
 ;;=4^G91.9
 ;;^UTILITY(U,$J,358.3,27840,2)
 ;;=^5004178
 ;;^UTILITY(U,$J,358.3,27841,0)
 ;;=G93.6^^77^1192^6
 ;;^UTILITY(U,$J,358.3,27841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27841,1,3,0)
 ;;=3^Cerebral edema
 ;;^UTILITY(U,$J,358.3,27841,1,4,0)
 ;;=4^G93.6
 ;;^UTILITY(U,$J,358.3,27841,2)
 ;;=^5004183
 ;;^UTILITY(U,$J,358.3,27842,0)
 ;;=I97.810^^77^1192^17
 ;;^UTILITY(U,$J,358.3,27842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27842,1,3,0)
 ;;=3^Intraoperative cerebvasc infarction during cardiac surgery
 ;;^UTILITY(U,$J,358.3,27842,1,4,0)
 ;;=4^I97.810
 ;;^UTILITY(U,$J,358.3,27842,2)
 ;;=^5008107
 ;;^UTILITY(U,$J,358.3,27843,0)
 ;;=I97.811^^77^1192^16
 ;;^UTILITY(U,$J,358.3,27843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27843,1,3,0)
 ;;=3^Intraoperative cerebrovascular infarction during oth surgery
 ;;^UTILITY(U,$J,358.3,27843,1,4,0)
 ;;=4^I97.811
 ;;^UTILITY(U,$J,358.3,27843,2)
 ;;=^5008108
 ;;^UTILITY(U,$J,358.3,27844,0)
 ;;=I97.820^^77^1192^36
 ;;^UTILITY(U,$J,358.3,27844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27844,1,3,0)
 ;;=3^Postprocedural cerebvasc infarction during cardiac surgery
 ;;^UTILITY(U,$J,358.3,27844,1,4,0)
 ;;=4^I97.820
 ;;^UTILITY(U,$J,358.3,27844,2)
 ;;=^5008109
 ;;^UTILITY(U,$J,358.3,27845,0)
 ;;=I97.821^^77^1192^35
 ;;^UTILITY(U,$J,358.3,27845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27845,1,3,0)
 ;;=3^Postprocedural cerebrovascular infarction during oth surgery
 ;;^UTILITY(U,$J,358.3,27845,1,4,0)
 ;;=4^I97.821
 ;;^UTILITY(U,$J,358.3,27845,2)
 ;;=^5008110
 ;;^UTILITY(U,$J,358.3,27846,0)
 ;;=G97.2^^77^1192^15
 ;;^UTILITY(U,$J,358.3,27846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27846,1,3,0)
 ;;=3^Intracranial hypotension following ventricular shunting
 ;;^UTILITY(U,$J,358.3,27846,1,4,0)
 ;;=4^G97.2
 ;;^UTILITY(U,$J,358.3,27846,2)
 ;;=^5004203
 ;;^UTILITY(U,$J,358.3,27847,0)
 ;;=G93.82^^77^1192^3
 ;;^UTILITY(U,$J,358.3,27847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27847,1,3,0)
 ;;=3^Brain death
 ;;^UTILITY(U,$J,358.3,27847,1,4,0)
 ;;=4^G93.82
 ;;^UTILITY(U,$J,358.3,27847,2)
 ;;=^5004184
 ;;^UTILITY(U,$J,358.3,27848,0)
 ;;=S06.1X0A^^77^1192^65
 ;;^UTILITY(U,$J,358.3,27848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27848,1,3,0)
 ;;=3^Traum cereb edema w/o LOC, init
 ;;^UTILITY(U,$J,358.3,27848,1,4,0)
 ;;=4^S06.1X0A
 ;;^UTILITY(U,$J,358.3,27848,2)
 ;;=^5020696
 ;;^UTILITY(U,$J,358.3,27849,0)
 ;;=S06.1X0D^^77^1192^67
 ;;^UTILITY(U,$J,358.3,27849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27849,1,3,0)
 ;;=3^Traum cereb edema w/o LOC, subs
 ;;^UTILITY(U,$J,358.3,27849,1,4,0)
 ;;=4^S06.1X0D
 ;;^UTILITY(U,$J,358.3,27849,2)
 ;;=^5020697
 ;;^UTILITY(U,$J,358.3,27850,0)
 ;;=S06.1X0S^^77^1192^66
 ;;^UTILITY(U,$J,358.3,27850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27850,1,3,0)
 ;;=3^Traum cereb edema w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,27850,1,4,0)
 ;;=4^S06.1X0S
