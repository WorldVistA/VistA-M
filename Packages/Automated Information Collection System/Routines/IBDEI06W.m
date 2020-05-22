IBDEI06W ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16797,1,3,0)
 ;;=3^Screening,Diabetes
 ;;^UTILITY(U,$J,358.3,16797,1,4,0)
 ;;=4^Z13.1
 ;;^UTILITY(U,$J,358.3,16797,2)
 ;;=^5062700
 ;;^UTILITY(U,$J,358.3,16798,0)
 ;;=M48.061^^65^754^78
 ;;^UTILITY(U,$J,358.3,16798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16798,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/o Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,16798,1,4,0)
 ;;=4^M48.061
 ;;^UTILITY(U,$J,358.3,16798,2)
 ;;=^5151513
 ;;^UTILITY(U,$J,358.3,16799,0)
 ;;=M48.062^^65^754^77
 ;;^UTILITY(U,$J,358.3,16799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16799,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/ Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,16799,1,4,0)
 ;;=4^M48.062
 ;;^UTILITY(U,$J,358.3,16799,2)
 ;;=^5151514
 ;;^UTILITY(U,$J,358.3,16800,0)
 ;;=Z53.21^^65^754^58
 ;;^UTILITY(U,$J,358.3,16800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16800,1,3,0)
 ;;=3^PT left w/o being seen
 ;;^UTILITY(U,$J,358.3,16800,1,4,0)
 ;;=4^Z53.21
 ;;^UTILITY(U,$J,358.3,16800,2)
 ;;=^5063096
 ;;^UTILITY(U,$J,358.3,16801,0)
 ;;=Z78.9^^65^754^79
 ;;^UTILITY(U,$J,358.3,16801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16801,1,3,0)
 ;;=3^Triaged to Primary Care Clinic
 ;;^UTILITY(U,$J,358.3,16801,1,4,0)
 ;;=4^Z78.9
 ;;^UTILITY(U,$J,358.3,16801,2)
 ;;=^5063329
 ;;^UTILITY(U,$J,358.3,16802,0)
 ;;=I48.20^^65^754^8
 ;;^UTILITY(U,$J,358.3,16802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16802,1,3,0)
 ;;=3^Atrial Fibrillation,Chronic,Unspec
 ;;^UTILITY(U,$J,358.3,16802,1,4,0)
 ;;=4^I48.20
 ;;^UTILITY(U,$J,358.3,16802,2)
 ;;=^5158048
 ;;^UTILITY(U,$J,358.3,16803,0)
 ;;=M54.6^^65^754^61
 ;;^UTILITY(U,$J,358.3,16803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16803,1,3,0)
 ;;=3^Pain in Thoracic Spine
 ;;^UTILITY(U,$J,358.3,16803,1,4,0)
 ;;=4^M54.6
 ;;^UTILITY(U,$J,358.3,16803,2)
 ;;=^272507
 ;;^UTILITY(U,$J,358.3,16804,0)
 ;;=M54.12^^65^754^64
 ;;^UTILITY(U,$J,358.3,16804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16804,1,3,0)
 ;;=3^Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,16804,1,4,0)
 ;;=4^M54.12
 ;;^UTILITY(U,$J,358.3,16804,2)
 ;;=^5012297
 ;;^UTILITY(U,$J,358.3,16805,0)
 ;;=M54.17^^65^754^65
 ;;^UTILITY(U,$J,358.3,16805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16805,1,3,0)
 ;;=3^Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,16805,1,4,0)
 ;;=4^M54.17
 ;;^UTILITY(U,$J,358.3,16805,2)
 ;;=^5012302
 ;;^UTILITY(U,$J,358.3,16806,0)
 ;;=M54.30^^65^754^67
 ;;^UTILITY(U,$J,358.3,16806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16806,1,3,0)
 ;;=3^Sciatica
 ;;^UTILITY(U,$J,358.3,16806,1,4,0)
 ;;=4^M54.30
 ;;^UTILITY(U,$J,358.3,16806,2)
 ;;=^5012305
 ;;^UTILITY(U,$J,358.3,16807,0)
 ;;=M48.02^^65^754^76
 ;;^UTILITY(U,$J,358.3,16807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16807,1,3,0)
 ;;=3^Spinal Stenosis,Cervical Region
 ;;^UTILITY(U,$J,358.3,16807,1,4,0)
 ;;=4^M48.02
 ;;^UTILITY(U,$J,358.3,16807,2)
 ;;=^5012089
 ;;^UTILITY(U,$J,358.3,16808,0)
 ;;=Z51.81^^65^755^17
 ;;^UTILITY(U,$J,358.3,16808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16808,1,3,0)
 ;;=3^Therapeutic Drug Level Monitoring
 ;;^UTILITY(U,$J,358.3,16808,1,4,0)
 ;;=4^Z51.81
 ;;^UTILITY(U,$J,358.3,16808,2)
 ;;=^5063064
 ;;^UTILITY(U,$J,358.3,16809,0)
 ;;=Z02.79^^65^755^11
 ;;^UTILITY(U,$J,358.3,16809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16809,1,3,0)
 ;;=3^Issue of Medical Certificate NEC
 ;;^UTILITY(U,$J,358.3,16809,1,4,0)
 ;;=4^Z02.79
 ;;^UTILITY(U,$J,358.3,16809,2)
 ;;=^5062641
 ;;^UTILITY(U,$J,358.3,16810,0)
 ;;=Z76.0^^65^755^12
 ;;^UTILITY(U,$J,358.3,16810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16810,1,3,0)
 ;;=3^Issue of Repeat Prescription
 ;;^UTILITY(U,$J,358.3,16810,1,4,0)
 ;;=4^Z76.0
 ;;^UTILITY(U,$J,358.3,16810,2)
 ;;=^5063297
 ;;^UTILITY(U,$J,358.3,16811,0)
 ;;=Z04.9^^65^755^3
 ;;^UTILITY(U,$J,358.3,16811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16811,1,3,0)
 ;;=3^Exam & Observation for Unsp Reason
 ;;^UTILITY(U,$J,358.3,16811,1,4,0)
 ;;=4^Z04.9
 ;;^UTILITY(U,$J,358.3,16811,2)
 ;;=^5062666
 ;;^UTILITY(U,$J,358.3,16812,0)
 ;;=Z02.2^^65^755^4
 ;;^UTILITY(U,$J,358.3,16812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16812,1,3,0)
 ;;=3^Exam for Admission to Residential Institution
 ;;^UTILITY(U,$J,358.3,16812,1,4,0)
 ;;=4^Z02.2
 ;;^UTILITY(U,$J,358.3,16812,2)
 ;;=^5062635
 ;;^UTILITY(U,$J,358.3,16813,0)
 ;;=Z02.4^^65^755^5
 ;;^UTILITY(U,$J,358.3,16813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16813,1,3,0)
 ;;=3^Exam for Driving License
 ;;^UTILITY(U,$J,358.3,16813,1,4,0)
 ;;=4^Z02.4
 ;;^UTILITY(U,$J,358.3,16813,2)
 ;;=^5062637
 ;;^UTILITY(U,$J,358.3,16814,0)
 ;;=Z00.5^^65^755^7
 ;;^UTILITY(U,$J,358.3,16814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16814,1,3,0)
 ;;=3^Exam of Potential Donor of Organ/Tissue
 ;;^UTILITY(U,$J,358.3,16814,1,4,0)
 ;;=4^Z00.5
 ;;^UTILITY(U,$J,358.3,16814,2)
 ;;=^5062607
 ;;^UTILITY(U,$J,358.3,16815,0)
 ;;=Z02.3^^65^755^6
 ;;^UTILITY(U,$J,358.3,16815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16815,1,3,0)
 ;;=3^Exam for Recruitment to Armed Forces
 ;;^UTILITY(U,$J,358.3,16815,1,4,0)
 ;;=4^Z02.3
 ;;^UTILITY(U,$J,358.3,16815,2)
 ;;=^5062636
 ;;^UTILITY(U,$J,358.3,16816,0)
 ;;=Z02.89^^65^755^1
 ;;^UTILITY(U,$J,358.3,16816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16816,1,3,0)
 ;;=3^Admin Exam NEC
 ;;^UTILITY(U,$J,358.3,16816,1,4,0)
 ;;=4^Z02.89
 ;;^UTILITY(U,$J,358.3,16816,2)
 ;;=^5062645
 ;;^UTILITY(U,$J,358.3,16817,0)
 ;;=Z00.8^^65^755^8
 ;;^UTILITY(U,$J,358.3,16817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16817,1,3,0)
 ;;=3^General Exam NEC
 ;;^UTILITY(U,$J,358.3,16817,1,4,0)
 ;;=4^Z00.8
 ;;^UTILITY(U,$J,358.3,16817,2)
 ;;=^5062611
 ;;^UTILITY(U,$J,358.3,16818,0)
 ;;=Z02.1^^65^755^14
 ;;^UTILITY(U,$J,358.3,16818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16818,1,3,0)
 ;;=3^Pre-Employment Exam
 ;;^UTILITY(U,$J,358.3,16818,1,4,0)
 ;;=4^Z02.1
 ;;^UTILITY(U,$J,358.3,16818,2)
 ;;=^5062634
 ;;^UTILITY(U,$J,358.3,16819,0)
 ;;=Z01.810^^65^755^2
 ;;^UTILITY(U,$J,358.3,16819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16819,1,3,0)
 ;;=3^Cardiovascular Preprocedural Exam
 ;;^UTILITY(U,$J,358.3,16819,1,4,0)
 ;;=4^Z01.810
 ;;^UTILITY(U,$J,358.3,16819,2)
 ;;=^5062625
 ;;^UTILITY(U,$J,358.3,16820,0)
 ;;=Z01.811^^65^755^16
 ;;^UTILITY(U,$J,358.3,16820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16820,1,3,0)
 ;;=3^Respiratory Preprocedural Exam
 ;;^UTILITY(U,$J,358.3,16820,1,4,0)
 ;;=4^Z01.811
 ;;^UTILITY(U,$J,358.3,16820,2)
 ;;=^5062626
 ;;^UTILITY(U,$J,358.3,16821,0)
 ;;=Z01.812^^65^755^13
 ;;^UTILITY(U,$J,358.3,16821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16821,1,3,0)
 ;;=3^Lab Preprocedural Exam
 ;;^UTILITY(U,$J,358.3,16821,1,4,0)
 ;;=4^Z01.812
 ;;^UTILITY(U,$J,358.3,16821,2)
 ;;=^5062627
 ;;^UTILITY(U,$J,358.3,16822,0)
 ;;=Z01.818^^65^755^15
 ;;^UTILITY(U,$J,358.3,16822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16822,1,3,0)
 ;;=3^Preprocedural Exam NEC
 ;;^UTILITY(U,$J,358.3,16822,1,4,0)
 ;;=4^Z01.818
 ;;^UTILITY(U,$J,358.3,16822,2)
 ;;=^5062628
 ;;^UTILITY(U,$J,358.3,16823,0)
 ;;=Z71.0^^65^755^9
 ;;^UTILITY(U,$J,358.3,16823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16823,1,3,0)
 ;;=3^Hlth Service to Consult on Behalf of Another
 ;;^UTILITY(U,$J,358.3,16823,1,4,0)
 ;;=4^Z71.0
 ;;^UTILITY(U,$J,358.3,16823,2)
 ;;=^5063242
 ;;^UTILITY(U,$J,358.3,16824,0)
 ;;=Z59.8^^65^755^10
 ;;^UTILITY(U,$J,358.3,16824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16824,1,3,0)
 ;;=3^Housing/Economic Circumstance Problems
 ;;^UTILITY(U,$J,358.3,16824,1,4,0)
 ;;=4^Z59.8
 ;;^UTILITY(U,$J,358.3,16824,2)
 ;;=^5063137
 ;;^UTILITY(U,$J,358.3,16825,0)
 ;;=I20.0^^65^756^5
 ;;^UTILITY(U,$J,358.3,16825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16825,1,3,0)
 ;;=3^Unstable Angina
 ;;^UTILITY(U,$J,358.3,16825,1,4,0)
 ;;=4^I20.0
 ;;^UTILITY(U,$J,358.3,16825,2)
 ;;=^5007076
 ;;^UTILITY(U,$J,358.3,16826,0)
 ;;=I25.2^^65^756^4
 ;;^UTILITY(U,$J,358.3,16826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16826,1,3,0)
 ;;=3^Old Myocardial Infarction
 ;;^UTILITY(U,$J,358.3,16826,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,16826,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,16827,0)
 ;;=I20.8^^65^756^2
 ;;^UTILITY(U,$J,358.3,16827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16827,1,3,0)
 ;;=3^Angina Pectoris,Oth Forms
 ;;^UTILITY(U,$J,358.3,16827,1,4,0)
 ;;=4^I20.8
 ;;^UTILITY(U,$J,358.3,16827,2)
 ;;=^5007078
 ;;^UTILITY(U,$J,358.3,16828,0)
 ;;=I20.1^^65^756^1
 ;;^UTILITY(U,$J,358.3,16828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16828,1,3,0)
 ;;=3^Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,16828,1,4,0)
 ;;=4^I20.1
 ;;^UTILITY(U,$J,358.3,16828,2)
 ;;=^5007077
 ;;^UTILITY(U,$J,358.3,16829,0)
 ;;=I20.9^^65^756^3
 ;;^UTILITY(U,$J,358.3,16829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16829,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,16829,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,16829,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,16830,0)
 ;;=I65.29^^65^757^31
 ;;^UTILITY(U,$J,358.3,16830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16830,1,3,0)
 ;;=3^Occlusion & Stenosis Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,16830,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,16830,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,16831,0)
 ;;=I65.22^^65^757^29
 ;;^UTILITY(U,$J,358.3,16831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16831,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,16831,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,16831,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,16832,0)
 ;;=I65.23^^65^757^28
 ;;^UTILITY(U,$J,358.3,16832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16832,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,16832,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,16832,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,16833,0)
 ;;=I65.21^^65^757^30
 ;;^UTILITY(U,$J,358.3,16833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16833,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,16833,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,16833,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,16834,0)
 ;;=I70.219^^65^757^7
 ;;^UTILITY(U,$J,358.3,16834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16834,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Unspec Extrm
 ;;^UTILITY(U,$J,358.3,16834,1,4,0)
 ;;=4^I70.219
 ;;^UTILITY(U,$J,358.3,16834,2)
 ;;=^5007582
 ;;^UTILITY(U,$J,358.3,16835,0)
 ;;=I70.213^^65^757^8
 ;;^UTILITY(U,$J,358.3,16835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16835,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Bilat Legs
 ;;^UTILITY(U,$J,358.3,16835,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,16835,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,16836,0)
 ;;=I70.212^^65^757^9
 ;;^UTILITY(U,$J,358.3,16836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16836,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Left Leg
 ;;^UTILITY(U,$J,358.3,16836,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,16836,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,16837,0)
 ;;=I70.211^^65^757^10
 ;;^UTILITY(U,$J,358.3,16837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16837,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Right Leg
 ;;^UTILITY(U,$J,358.3,16837,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,16837,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,16838,0)
 ;;=I70.25^^65^757^6
 ;;^UTILITY(U,$J,358.3,16838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16838,1,3,0)
 ;;=3^Athscl Native Arteries of Extremitis w/ Ulceration
 ;;^UTILITY(U,$J,358.3,16838,1,4,0)
 ;;=4^I70.25
 ;;^UTILITY(U,$J,358.3,16838,2)
 ;;=^5007602
 ;;^UTILITY(U,$J,358.3,16839,0)
 ;;=I70.249^^65^757^11
 ;;^UTILITY(U,$J,358.3,16839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16839,1,3,0)
 ;;=3^Athscl Natv Art of Lt Leg w/ Ulceration of Unspec Site
 ;;^UTILITY(U,$J,358.3,16839,1,4,0)
 ;;=4^I70.249
 ;;^UTILITY(U,$J,358.3,16839,2)
 ;;=^5007601
 ;;^UTILITY(U,$J,358.3,16840,0)
 ;;=I70.239^^65^757^12
 ;;^UTILITY(U,$J,358.3,16840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16840,1,3,0)
 ;;=3^Athscl Natv Art of Rt Leg w/ Ulcer of Unspec Site
 ;;^UTILITY(U,$J,358.3,16840,1,4,0)
 ;;=4^I70.239
 ;;^UTILITY(U,$J,358.3,16840,2)
 ;;=^5007594
 ;;^UTILITY(U,$J,358.3,16841,0)
 ;;=I70.269^^65^757^13
 ;;^UTILITY(U,$J,358.3,16841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16841,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Unspec Extremity
 ;;^UTILITY(U,$J,358.3,16841,1,4,0)
 ;;=4^I70.269
 ;;^UTILITY(U,$J,358.3,16841,2)
 ;;=^5007607
 ;;^UTILITY(U,$J,358.3,16842,0)
 ;;=I70.263^^65^757^14
 ;;^UTILITY(U,$J,358.3,16842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16842,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Bilateral Legs
 ;;^UTILITY(U,$J,358.3,16842,1,4,0)
 ;;=4^I70.263
 ;;^UTILITY(U,$J,358.3,16842,2)
 ;;=^5007605
 ;;^UTILITY(U,$J,358.3,16843,0)
 ;;=I70.262^^65^757^15
 ;;^UTILITY(U,$J,358.3,16843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16843,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Left Leg
 ;;^UTILITY(U,$J,358.3,16843,1,4,0)
 ;;=4^I70.262
 ;;^UTILITY(U,$J,358.3,16843,2)
 ;;=^5007604
 ;;^UTILITY(U,$J,358.3,16844,0)
 ;;=I70.261^^65^757^16
 ;;^UTILITY(U,$J,358.3,16844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16844,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Right Leg
 ;;^UTILITY(U,$J,358.3,16844,1,4,0)
 ;;=4^I70.261
 ;;^UTILITY(U,$J,358.3,16844,2)
 ;;=^5007603
 ;;^UTILITY(U,$J,358.3,16845,0)
 ;;=I71.2^^65^757^34
 ;;^UTILITY(U,$J,358.3,16845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16845,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,16845,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,16845,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,16846,0)
 ;;=I71.4^^65^757^1
 ;;^UTILITY(U,$J,358.3,16846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16846,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,16846,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,16846,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,16847,0)
 ;;=I73.9^^65^757^32
 ;;^UTILITY(U,$J,358.3,16847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16847,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,16847,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,16847,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,16848,0)
 ;;=I82.891^^65^757^23
 ;;^UTILITY(U,$J,358.3,16848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16848,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Chronic
 ;;^UTILITY(U,$J,358.3,16848,1,4,0)
 ;;=4^I82.891
 ;;^UTILITY(U,$J,358.3,16848,2)
 ;;=^5007939
 ;;^UTILITY(U,$J,358.3,16849,0)
 ;;=I82.890^^65^757^22
 ;;^UTILITY(U,$J,358.3,16849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16849,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Acute
 ;;^UTILITY(U,$J,358.3,16849,1,4,0)
 ;;=4^I82.890
 ;;^UTILITY(U,$J,358.3,16849,2)
 ;;=^5007938
 ;;^UTILITY(U,$J,358.3,16850,0)
 ;;=I25.729^^65^757^2
 ;;^UTILITY(U,$J,358.3,16850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16850,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,16850,1,4,0)
 ;;=4^I25.729
 ;;^UTILITY(U,$J,358.3,16850,2)
 ;;=^5133561
 ;;^UTILITY(U,$J,358.3,16851,0)
 ;;=I25.119^^65^757^3
 ;;^UTILITY(U,$J,358.3,16851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16851,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/ Ang Pctrs,Unspec
 ;;^UTILITY(U,$J,358.3,16851,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,16851,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,16852,0)
 ;;=I25.10^^65^757^4
 ;;^UTILITY(U,$J,358.3,16852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16852,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,16852,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,16852,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,16853,0)
 ;;=I25.110^^65^757^5
 ;;^UTILITY(U,$J,358.3,16853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16853,1,3,0)
 ;;=3^Athscl Hrt Dis of Native Cor Art w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,16853,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,16853,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,16854,0)
 ;;=I25.810^^65^757^17
 ;;^UTILITY(U,$J,358.3,16854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16854,1,3,0)
 ;;=3^Athscl of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,16854,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,16854,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,16855,0)
 ;;=I25.701^^65^757^18
 ;;^UTILITY(U,$J,358.3,16855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16855,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,16855,1,4,0)
 ;;=4^I25.701
 ;;^UTILITY(U,$J,358.3,16855,2)
 ;;=^5007118
 ;;^UTILITY(U,$J,358.3,16856,0)
 ;;=I25.708^^65^757^19
 ;;^UTILITY(U,$J,358.3,16856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16856,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Oth Angina Pectoris
 ;;^UTILITY(U,$J,358.3,16856,1,4,0)
 ;;=4^I25.708
 ;;^UTILITY(U,$J,358.3,16856,2)
 ;;=^5007119
 ;;^UTILITY(U,$J,358.3,16857,0)
 ;;=I25.709^^65^757^20
 ;;^UTILITY(U,$J,358.3,16857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16857,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,16857,1,4,0)
 ;;=4^I25.709
 ;;^UTILITY(U,$J,358.3,16857,2)
 ;;=^5007120
 ;;^UTILITY(U,$J,358.3,16858,0)
 ;;=I25.700^^65^757^21
 ;;^UTILITY(U,$J,358.3,16858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16858,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unstable Angina Pectoris
 ;;^UTILITY(U,$J,358.3,16858,1,4,0)
 ;;=4^I25.700
 ;;^UTILITY(U,$J,358.3,16858,2)
 ;;=^5007117
 ;;^UTILITY(U,$J,358.3,16859,0)
 ;;=I82.469^^65^757^24
 ;;^UTILITY(U,$J,358.3,16859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16859,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Calf Muscle Vein,Acute
 ;;^UTILITY(U,$J,358.3,16859,1,4,0)
 ;;=4^I82.469
 ;;^UTILITY(U,$J,358.3,16859,2)
 ;;=^5158066
 ;;^UTILITY(U,$J,358.3,16860,0)
 ;;=I82.569^^65^757^25
 ;;^UTILITY(U,$J,358.3,16860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16860,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Calf Muscle Vein,Chronic
 ;;^UTILITY(U,$J,358.3,16860,1,4,0)
 ;;=4^I82.569
 ;;^UTILITY(U,$J,358.3,16860,2)
 ;;=^5158074
 ;;^UTILITY(U,$J,358.3,16861,0)
 ;;=I80.259^^65^757^33
 ;;^UTILITY(U,$J,358.3,16861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16861,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis,Unspec Calf Muscle Vein
 ;;^UTILITY(U,$J,358.3,16861,1,4,0)
 ;;=4^I80.259
 ;;^UTILITY(U,$J,358.3,16861,2)
 ;;=^5158058
 ;;^UTILITY(U,$J,358.3,16862,0)
 ;;=I82.409^^65^757^26
 ;;^UTILITY(U,$J,358.3,16862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16862,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Deep Vein,LE Unspec Acute
 ;;^UTILITY(U,$J,358.3,16862,1,4,0)
 ;;=4^I82.409
 ;;^UTILITY(U,$J,358.3,16862,2)
 ;;=^5133625
 ;;^UTILITY(U,$J,358.3,16863,0)
 ;;=I82.509^^65^757^27
 ;;^UTILITY(U,$J,358.3,16863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16863,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Deep Vein,LE Unspec Chronic
 ;;^UTILITY(U,$J,358.3,16863,1,4,0)
 ;;=4^I82.509
 ;;^UTILITY(U,$J,358.3,16863,2)
 ;;=^5133628
