IBDEI03E ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8117,1,3,0)
 ;;=3^Screening,STI
 ;;^UTILITY(U,$J,358.3,8117,1,4,0)
 ;;=4^Z11.3
 ;;^UTILITY(U,$J,358.3,8117,2)
 ;;=^5062672
 ;;^UTILITY(U,$J,358.3,8118,0)
 ;;=Z13.1^^45^416^74
 ;;^UTILITY(U,$J,358.3,8118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8118,1,3,0)
 ;;=3^Screening,Diabetes
 ;;^UTILITY(U,$J,358.3,8118,1,4,0)
 ;;=4^Z13.1
 ;;^UTILITY(U,$J,358.3,8118,2)
 ;;=^5062700
 ;;^UTILITY(U,$J,358.3,8119,0)
 ;;=M48.061^^45^416^80
 ;;^UTILITY(U,$J,358.3,8119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8119,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/o Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,8119,1,4,0)
 ;;=4^M48.061
 ;;^UTILITY(U,$J,358.3,8119,2)
 ;;=^5151513
 ;;^UTILITY(U,$J,358.3,8120,0)
 ;;=M48.062^^45^416^79
 ;;^UTILITY(U,$J,358.3,8120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8120,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/ Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,8120,1,4,0)
 ;;=4^M48.062
 ;;^UTILITY(U,$J,358.3,8120,2)
 ;;=^5151514
 ;;^UTILITY(U,$J,358.3,8121,0)
 ;;=Z53.21^^45^416^60
 ;;^UTILITY(U,$J,358.3,8121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8121,1,3,0)
 ;;=3^PT left w/o being seen
 ;;^UTILITY(U,$J,358.3,8121,1,4,0)
 ;;=4^Z53.21
 ;;^UTILITY(U,$J,358.3,8121,2)
 ;;=^5063096
 ;;^UTILITY(U,$J,358.3,8122,0)
 ;;=Z78.9^^45^416^81
 ;;^UTILITY(U,$J,358.3,8122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8122,1,3,0)
 ;;=3^Triaged to Primary Care Clinic
 ;;^UTILITY(U,$J,358.3,8122,1,4,0)
 ;;=4^Z78.9
 ;;^UTILITY(U,$J,358.3,8122,2)
 ;;=^5063329
 ;;^UTILITY(U,$J,358.3,8123,0)
 ;;=I48.20^^45^416^8
 ;;^UTILITY(U,$J,358.3,8123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8123,1,3,0)
 ;;=3^Atrial Fibrillation,Chronic,Unspec
 ;;^UTILITY(U,$J,358.3,8123,1,4,0)
 ;;=4^I48.20
 ;;^UTILITY(U,$J,358.3,8123,2)
 ;;=^5158048
 ;;^UTILITY(U,$J,358.3,8124,0)
 ;;=M54.6^^45^416^63
 ;;^UTILITY(U,$J,358.3,8124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8124,1,3,0)
 ;;=3^Pain in Thoracic Spine
 ;;^UTILITY(U,$J,358.3,8124,1,4,0)
 ;;=4^M54.6
 ;;^UTILITY(U,$J,358.3,8124,2)
 ;;=^272507
 ;;^UTILITY(U,$J,358.3,8125,0)
 ;;=M54.12^^45^416^66
 ;;^UTILITY(U,$J,358.3,8125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8125,1,3,0)
 ;;=3^Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,8125,1,4,0)
 ;;=4^M54.12
 ;;^UTILITY(U,$J,358.3,8125,2)
 ;;=^5012297
 ;;^UTILITY(U,$J,358.3,8126,0)
 ;;=M54.17^^45^416^67
 ;;^UTILITY(U,$J,358.3,8126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8126,1,3,0)
 ;;=3^Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,8126,1,4,0)
 ;;=4^M54.17
 ;;^UTILITY(U,$J,358.3,8126,2)
 ;;=^5012302
 ;;^UTILITY(U,$J,358.3,8127,0)
 ;;=M54.30^^45^416^69
 ;;^UTILITY(U,$J,358.3,8127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8127,1,3,0)
 ;;=3^Sciatica
 ;;^UTILITY(U,$J,358.3,8127,1,4,0)
 ;;=4^M54.30
 ;;^UTILITY(U,$J,358.3,8127,2)
 ;;=^5012305
 ;;^UTILITY(U,$J,358.3,8128,0)
 ;;=M48.02^^45^416^78
 ;;^UTILITY(U,$J,358.3,8128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8128,1,3,0)
 ;;=3^Spinal Stenosis,Cervical Region
 ;;^UTILITY(U,$J,358.3,8128,1,4,0)
 ;;=4^M48.02
 ;;^UTILITY(U,$J,358.3,8128,2)
 ;;=^5012089
 ;;^UTILITY(U,$J,358.3,8129,0)
 ;;=N18.30^^45^416^11
 ;;^UTILITY(U,$J,358.3,8129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8129,1,3,0)
 ;;=3^CKD,Stage 3 Unspec
 ;;^UTILITY(U,$J,358.3,8129,1,4,0)
 ;;=4^N18.30
 ;;^UTILITY(U,$J,358.3,8129,2)
 ;;=^5159286
 ;;^UTILITY(U,$J,358.3,8130,0)
 ;;=N18.31^^45^416^12
 ;;^UTILITY(U,$J,358.3,8130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8130,1,3,0)
 ;;=3^CKD,Stage 3a
 ;;^UTILITY(U,$J,358.3,8130,1,4,0)
 ;;=4^N18.31
 ;;^UTILITY(U,$J,358.3,8130,2)
 ;;=^5159287
 ;;^UTILITY(U,$J,358.3,8131,0)
 ;;=N18.32^^45^416^13
 ;;^UTILITY(U,$J,358.3,8131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8131,1,3,0)
 ;;=3^CKD,Stage 3b
 ;;^UTILITY(U,$J,358.3,8131,1,4,0)
 ;;=4^N18.32
 ;;^UTILITY(U,$J,358.3,8131,2)
 ;;=^5159288
 ;;^UTILITY(U,$J,358.3,8132,0)
 ;;=M54.50^^45^416^48
 ;;^UTILITY(U,$J,358.3,8132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8132,1,3,0)
 ;;=3^Low Back Pain,Unspec
 ;;^UTILITY(U,$J,358.3,8132,1,4,0)
 ;;=4^M54.50
 ;;^UTILITY(U,$J,358.3,8132,2)
 ;;=^5161215
 ;;^UTILITY(U,$J,358.3,8133,0)
 ;;=Z51.81^^45^417^17
 ;;^UTILITY(U,$J,358.3,8133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8133,1,3,0)
 ;;=3^Therapeutic Drug Level Monitoring
 ;;^UTILITY(U,$J,358.3,8133,1,4,0)
 ;;=4^Z51.81
 ;;^UTILITY(U,$J,358.3,8133,2)
 ;;=^5063064
 ;;^UTILITY(U,$J,358.3,8134,0)
 ;;=Z02.79^^45^417^11
 ;;^UTILITY(U,$J,358.3,8134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8134,1,3,0)
 ;;=3^Issue of Medical Certificate NEC
 ;;^UTILITY(U,$J,358.3,8134,1,4,0)
 ;;=4^Z02.79
 ;;^UTILITY(U,$J,358.3,8134,2)
 ;;=^5062641
 ;;^UTILITY(U,$J,358.3,8135,0)
 ;;=Z76.0^^45^417^12
 ;;^UTILITY(U,$J,358.3,8135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8135,1,3,0)
 ;;=3^Issue of Repeat Prescription
 ;;^UTILITY(U,$J,358.3,8135,1,4,0)
 ;;=4^Z76.0
 ;;^UTILITY(U,$J,358.3,8135,2)
 ;;=^5063297
 ;;^UTILITY(U,$J,358.3,8136,0)
 ;;=Z04.9^^45^417^3
 ;;^UTILITY(U,$J,358.3,8136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8136,1,3,0)
 ;;=3^Exam & Observation for Unsp Reason
 ;;^UTILITY(U,$J,358.3,8136,1,4,0)
 ;;=4^Z04.9
 ;;^UTILITY(U,$J,358.3,8136,2)
 ;;=^5062666
 ;;^UTILITY(U,$J,358.3,8137,0)
 ;;=Z02.2^^45^417^4
 ;;^UTILITY(U,$J,358.3,8137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8137,1,3,0)
 ;;=3^Exam for Admission to Residential Institution
 ;;^UTILITY(U,$J,358.3,8137,1,4,0)
 ;;=4^Z02.2
 ;;^UTILITY(U,$J,358.3,8137,2)
 ;;=^5062635
 ;;^UTILITY(U,$J,358.3,8138,0)
 ;;=Z02.4^^45^417^5
 ;;^UTILITY(U,$J,358.3,8138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8138,1,3,0)
 ;;=3^Exam for Driving License
 ;;^UTILITY(U,$J,358.3,8138,1,4,0)
 ;;=4^Z02.4
 ;;^UTILITY(U,$J,358.3,8138,2)
 ;;=^5062637
 ;;^UTILITY(U,$J,358.3,8139,0)
 ;;=Z00.5^^45^417^7
 ;;^UTILITY(U,$J,358.3,8139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8139,1,3,0)
 ;;=3^Exam of Potential Donor of Organ/Tissue
 ;;^UTILITY(U,$J,358.3,8139,1,4,0)
 ;;=4^Z00.5
 ;;^UTILITY(U,$J,358.3,8139,2)
 ;;=^5062607
 ;;^UTILITY(U,$J,358.3,8140,0)
 ;;=Z02.3^^45^417^6
 ;;^UTILITY(U,$J,358.3,8140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8140,1,3,0)
 ;;=3^Exam for Recruitment to Armed Forces
 ;;^UTILITY(U,$J,358.3,8140,1,4,0)
 ;;=4^Z02.3
 ;;^UTILITY(U,$J,358.3,8140,2)
 ;;=^5062636
 ;;^UTILITY(U,$J,358.3,8141,0)
 ;;=Z02.89^^45^417^1
 ;;^UTILITY(U,$J,358.3,8141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8141,1,3,0)
 ;;=3^Admin Exam NEC
 ;;^UTILITY(U,$J,358.3,8141,1,4,0)
 ;;=4^Z02.89
 ;;^UTILITY(U,$J,358.3,8141,2)
 ;;=^5062645
 ;;^UTILITY(U,$J,358.3,8142,0)
 ;;=Z00.8^^45^417^8
 ;;^UTILITY(U,$J,358.3,8142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8142,1,3,0)
 ;;=3^General Exam NEC
 ;;^UTILITY(U,$J,358.3,8142,1,4,0)
 ;;=4^Z00.8
 ;;^UTILITY(U,$J,358.3,8142,2)
 ;;=^5062611
 ;;^UTILITY(U,$J,358.3,8143,0)
 ;;=Z02.1^^45^417^14
 ;;^UTILITY(U,$J,358.3,8143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8143,1,3,0)
 ;;=3^Pre-Employment Exam
 ;;^UTILITY(U,$J,358.3,8143,1,4,0)
 ;;=4^Z02.1
 ;;^UTILITY(U,$J,358.3,8143,2)
 ;;=^5062634
 ;;^UTILITY(U,$J,358.3,8144,0)
 ;;=Z01.810^^45^417^2
 ;;^UTILITY(U,$J,358.3,8144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8144,1,3,0)
 ;;=3^Cardiovascular Preprocedural Exam
 ;;^UTILITY(U,$J,358.3,8144,1,4,0)
 ;;=4^Z01.810
 ;;^UTILITY(U,$J,358.3,8144,2)
 ;;=^5062625
 ;;^UTILITY(U,$J,358.3,8145,0)
 ;;=Z01.811^^45^417^16
 ;;^UTILITY(U,$J,358.3,8145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8145,1,3,0)
 ;;=3^Respiratory Preprocedural Exam
 ;;^UTILITY(U,$J,358.3,8145,1,4,0)
 ;;=4^Z01.811
 ;;^UTILITY(U,$J,358.3,8145,2)
 ;;=^5062626
 ;;^UTILITY(U,$J,358.3,8146,0)
 ;;=Z01.812^^45^417^13
 ;;^UTILITY(U,$J,358.3,8146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8146,1,3,0)
 ;;=3^Lab Preprocedural Exam
 ;;^UTILITY(U,$J,358.3,8146,1,4,0)
 ;;=4^Z01.812
 ;;^UTILITY(U,$J,358.3,8146,2)
 ;;=^5062627
 ;;^UTILITY(U,$J,358.3,8147,0)
 ;;=Z01.818^^45^417^15
 ;;^UTILITY(U,$J,358.3,8147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8147,1,3,0)
 ;;=3^Preprocedural Exam NEC
 ;;^UTILITY(U,$J,358.3,8147,1,4,0)
 ;;=4^Z01.818
 ;;^UTILITY(U,$J,358.3,8147,2)
 ;;=^5062628
 ;;^UTILITY(U,$J,358.3,8148,0)
 ;;=Z71.0^^45^417^9
 ;;^UTILITY(U,$J,358.3,8148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8148,1,3,0)
 ;;=3^Hlth Service to Consult on Behalf of Another
 ;;^UTILITY(U,$J,358.3,8148,1,4,0)
 ;;=4^Z71.0
 ;;^UTILITY(U,$J,358.3,8148,2)
 ;;=^5063242
 ;;^UTILITY(U,$J,358.3,8149,0)
 ;;=Z59.89^^45^417^10
 ;;^UTILITY(U,$J,358.3,8149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8149,1,3,0)
 ;;=3^Housing/Economic Circumstance Problems,Other
 ;;^UTILITY(U,$J,358.3,8149,1,4,0)
 ;;=4^Z59.89
 ;;^UTILITY(U,$J,358.3,8149,2)
 ;;=^5161312
 ;;^UTILITY(U,$J,358.3,8150,0)
 ;;=I20.0^^45^418^5
 ;;^UTILITY(U,$J,358.3,8150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8150,1,3,0)
 ;;=3^Unstable Angina
 ;;^UTILITY(U,$J,358.3,8150,1,4,0)
 ;;=4^I20.0
 ;;^UTILITY(U,$J,358.3,8150,2)
 ;;=^5007076
 ;;^UTILITY(U,$J,358.3,8151,0)
 ;;=I25.2^^45^418^4
 ;;^UTILITY(U,$J,358.3,8151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8151,1,3,0)
 ;;=3^Old Myocardial Infarction
 ;;^UTILITY(U,$J,358.3,8151,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,8151,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,8152,0)
 ;;=I20.8^^45^418^2
 ;;^UTILITY(U,$J,358.3,8152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8152,1,3,0)
 ;;=3^Angina Pectoris,Oth Forms
 ;;^UTILITY(U,$J,358.3,8152,1,4,0)
 ;;=4^I20.8
 ;;^UTILITY(U,$J,358.3,8152,2)
 ;;=^5007078
 ;;^UTILITY(U,$J,358.3,8153,0)
 ;;=I20.1^^45^418^1
 ;;^UTILITY(U,$J,358.3,8153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8153,1,3,0)
 ;;=3^Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,8153,1,4,0)
 ;;=4^I20.1
 ;;^UTILITY(U,$J,358.3,8153,2)
 ;;=^5007077
 ;;^UTILITY(U,$J,358.3,8154,0)
 ;;=I20.9^^45^418^3
 ;;^UTILITY(U,$J,358.3,8154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8154,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,8154,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,8154,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,8155,0)
 ;;=I65.29^^45^419^31
 ;;^UTILITY(U,$J,358.3,8155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8155,1,3,0)
 ;;=3^Occlusion & Stenosis Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,8155,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,8155,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,8156,0)
 ;;=I65.22^^45^419^29
 ;;^UTILITY(U,$J,358.3,8156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8156,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,8156,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,8156,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,8157,0)
 ;;=I65.23^^45^419^28
 ;;^UTILITY(U,$J,358.3,8157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8157,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,8157,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,8157,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,8158,0)
 ;;=I65.21^^45^419^30
 ;;^UTILITY(U,$J,358.3,8158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8158,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,8158,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,8158,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,8159,0)
 ;;=I70.219^^45^419^7
 ;;^UTILITY(U,$J,358.3,8159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8159,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Unspec Extrm
 ;;^UTILITY(U,$J,358.3,8159,1,4,0)
 ;;=4^I70.219
 ;;^UTILITY(U,$J,358.3,8159,2)
 ;;=^5007582
 ;;^UTILITY(U,$J,358.3,8160,0)
 ;;=I70.213^^45^419^8
 ;;^UTILITY(U,$J,358.3,8160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8160,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Bilat Legs
 ;;^UTILITY(U,$J,358.3,8160,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,8160,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,8161,0)
 ;;=I70.212^^45^419^9
 ;;^UTILITY(U,$J,358.3,8161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8161,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Left Leg
 ;;^UTILITY(U,$J,358.3,8161,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,8161,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,8162,0)
 ;;=I70.211^^45^419^10
 ;;^UTILITY(U,$J,358.3,8162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8162,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Right Leg
 ;;^UTILITY(U,$J,358.3,8162,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,8162,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,8163,0)
 ;;=I70.25^^45^419^6
 ;;^UTILITY(U,$J,358.3,8163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8163,1,3,0)
 ;;=3^Athscl Native Arteries of Extremitis w/ Ulceration
 ;;^UTILITY(U,$J,358.3,8163,1,4,0)
 ;;=4^I70.25
 ;;^UTILITY(U,$J,358.3,8163,2)
 ;;=^5007602
 ;;^UTILITY(U,$J,358.3,8164,0)
 ;;=I70.249^^45^419^11
 ;;^UTILITY(U,$J,358.3,8164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8164,1,3,0)
 ;;=3^Athscl Natv Art of Lt Leg w/ Ulceration of Unspec Site
 ;;^UTILITY(U,$J,358.3,8164,1,4,0)
 ;;=4^I70.249
 ;;^UTILITY(U,$J,358.3,8164,2)
 ;;=^5007601
 ;;^UTILITY(U,$J,358.3,8165,0)
 ;;=I70.239^^45^419^12
 ;;^UTILITY(U,$J,358.3,8165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8165,1,3,0)
 ;;=3^Athscl Natv Art of Rt Leg w/ Ulcer of Unspec Site
 ;;^UTILITY(U,$J,358.3,8165,1,4,0)
 ;;=4^I70.239
 ;;^UTILITY(U,$J,358.3,8165,2)
 ;;=^5007594
 ;;^UTILITY(U,$J,358.3,8166,0)
 ;;=I70.269^^45^419^13
 ;;^UTILITY(U,$J,358.3,8166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8166,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Unspec Extremity
 ;;^UTILITY(U,$J,358.3,8166,1,4,0)
 ;;=4^I70.269
 ;;^UTILITY(U,$J,358.3,8166,2)
 ;;=^5007607
 ;;^UTILITY(U,$J,358.3,8167,0)
 ;;=I70.263^^45^419^14
 ;;^UTILITY(U,$J,358.3,8167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8167,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Bilateral Legs
 ;;^UTILITY(U,$J,358.3,8167,1,4,0)
 ;;=4^I70.263
 ;;^UTILITY(U,$J,358.3,8167,2)
 ;;=^5007605
 ;;^UTILITY(U,$J,358.3,8168,0)
 ;;=I70.262^^45^419^15
 ;;^UTILITY(U,$J,358.3,8168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8168,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Left Leg
 ;;^UTILITY(U,$J,358.3,8168,1,4,0)
 ;;=4^I70.262
 ;;^UTILITY(U,$J,358.3,8168,2)
 ;;=^5007604
 ;;^UTILITY(U,$J,358.3,8169,0)
 ;;=I70.261^^45^419^16
 ;;^UTILITY(U,$J,358.3,8169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8169,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Right Leg
 ;;^UTILITY(U,$J,358.3,8169,1,4,0)
 ;;=4^I70.261
 ;;^UTILITY(U,$J,358.3,8169,2)
 ;;=^5007603
 ;;^UTILITY(U,$J,358.3,8170,0)
 ;;=I71.2^^45^419^34
 ;;^UTILITY(U,$J,358.3,8170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8170,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,8170,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,8170,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,8171,0)
 ;;=I71.4^^45^419^1
 ;;^UTILITY(U,$J,358.3,8171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8171,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,8171,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,8171,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,8172,0)
 ;;=I73.9^^45^419^32
 ;;^UTILITY(U,$J,358.3,8172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8172,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,8172,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,8172,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,8173,0)
 ;;=I82.891^^45^419^23
 ;;^UTILITY(U,$J,358.3,8173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8173,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Chronic
 ;;^UTILITY(U,$J,358.3,8173,1,4,0)
 ;;=4^I82.891
 ;;^UTILITY(U,$J,358.3,8173,2)
 ;;=^5007939
 ;;^UTILITY(U,$J,358.3,8174,0)
 ;;=I82.890^^45^419^22
 ;;^UTILITY(U,$J,358.3,8174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8174,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Acute
 ;;^UTILITY(U,$J,358.3,8174,1,4,0)
 ;;=4^I82.890
 ;;^UTILITY(U,$J,358.3,8174,2)
 ;;=^5007938
 ;;^UTILITY(U,$J,358.3,8175,0)
 ;;=I25.729^^45^419^2
 ;;^UTILITY(U,$J,358.3,8175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8175,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,8175,1,4,0)
 ;;=4^I25.729
 ;;^UTILITY(U,$J,358.3,8175,2)
 ;;=^5133561
 ;;^UTILITY(U,$J,358.3,8176,0)
 ;;=I25.119^^45^419^3
 ;;^UTILITY(U,$J,358.3,8176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8176,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/ Ang Pctrs,Unspec
 ;;^UTILITY(U,$J,358.3,8176,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,8176,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,8177,0)
 ;;=I25.10^^45^419^4
 ;;^UTILITY(U,$J,358.3,8177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8177,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,8177,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,8177,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,8178,0)
 ;;=I25.110^^45^419^5
 ;;^UTILITY(U,$J,358.3,8178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8178,1,3,0)
 ;;=3^Athscl Hrt Dis of Native Cor Art w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,8178,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,8178,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,8179,0)
 ;;=I25.810^^45^419^17
 ;;^UTILITY(U,$J,358.3,8179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8179,1,3,0)
 ;;=3^Athscl of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,8179,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,8179,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,8180,0)
 ;;=I25.701^^45^419^18
 ;;^UTILITY(U,$J,358.3,8180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8180,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,8180,1,4,0)
 ;;=4^I25.701
 ;;^UTILITY(U,$J,358.3,8180,2)
 ;;=^5007118
 ;;^UTILITY(U,$J,358.3,8181,0)
 ;;=I25.708^^45^419^19
 ;;^UTILITY(U,$J,358.3,8181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8181,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Oth Angina Pectoris
 ;;^UTILITY(U,$J,358.3,8181,1,4,0)
 ;;=4^I25.708
 ;;^UTILITY(U,$J,358.3,8181,2)
 ;;=^5007119
 ;;^UTILITY(U,$J,358.3,8182,0)
 ;;=I25.709^^45^419^20
 ;;^UTILITY(U,$J,358.3,8182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8182,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,8182,1,4,0)
 ;;=4^I25.709
 ;;^UTILITY(U,$J,358.3,8182,2)
 ;;=^5007120
 ;;^UTILITY(U,$J,358.3,8183,0)
 ;;=I25.700^^45^419^21
 ;;^UTILITY(U,$J,358.3,8183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8183,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unstable Angina Pectoris
 ;;^UTILITY(U,$J,358.3,8183,1,4,0)
 ;;=4^I25.700
 ;;^UTILITY(U,$J,358.3,8183,2)
 ;;=^5007117
 ;;^UTILITY(U,$J,358.3,8184,0)
 ;;=I82.469^^45^419^24
 ;;^UTILITY(U,$J,358.3,8184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8184,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Calf Muscle Vein,Acute
 ;;^UTILITY(U,$J,358.3,8184,1,4,0)
 ;;=4^I82.469
 ;;^UTILITY(U,$J,358.3,8184,2)
 ;;=^5158066
 ;;^UTILITY(U,$J,358.3,8185,0)
 ;;=I82.569^^45^419^25
 ;;^UTILITY(U,$J,358.3,8185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8185,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Calf Muscle Vein,Chronic
 ;;^UTILITY(U,$J,358.3,8185,1,4,0)
 ;;=4^I82.569
