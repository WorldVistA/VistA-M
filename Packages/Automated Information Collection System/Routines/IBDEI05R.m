IBDEI05R ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13982,1,3,0)
 ;;=3^Screening,AAA
 ;;^UTILITY(U,$J,358.3,13982,1,4,0)
 ;;=4^Z13.6
 ;;^UTILITY(U,$J,358.3,13982,2)
 ;;=^5062707
 ;;^UTILITY(U,$J,358.3,13983,0)
 ;;=Z11.3^^62^683^73
 ;;^UTILITY(U,$J,358.3,13983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13983,1,3,0)
 ;;=3^Screening,STI
 ;;^UTILITY(U,$J,358.3,13983,1,4,0)
 ;;=4^Z11.3
 ;;^UTILITY(U,$J,358.3,13983,2)
 ;;=^5062672
 ;;^UTILITY(U,$J,358.3,13984,0)
 ;;=Z13.1^^62^683^72
 ;;^UTILITY(U,$J,358.3,13984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13984,1,3,0)
 ;;=3^Screening,Diabetes
 ;;^UTILITY(U,$J,358.3,13984,1,4,0)
 ;;=4^Z13.1
 ;;^UTILITY(U,$J,358.3,13984,2)
 ;;=^5062700
 ;;^UTILITY(U,$J,358.3,13985,0)
 ;;=M48.061^^62^683^78
 ;;^UTILITY(U,$J,358.3,13985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13985,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/o Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,13985,1,4,0)
 ;;=4^M48.061
 ;;^UTILITY(U,$J,358.3,13985,2)
 ;;=^5151513
 ;;^UTILITY(U,$J,358.3,13986,0)
 ;;=M48.062^^62^683^77
 ;;^UTILITY(U,$J,358.3,13986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13986,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/ Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,13986,1,4,0)
 ;;=4^M48.062
 ;;^UTILITY(U,$J,358.3,13986,2)
 ;;=^5151514
 ;;^UTILITY(U,$J,358.3,13987,0)
 ;;=Z53.21^^62^683^58
 ;;^UTILITY(U,$J,358.3,13987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13987,1,3,0)
 ;;=3^PT left w/o being seen
 ;;^UTILITY(U,$J,358.3,13987,1,4,0)
 ;;=4^Z53.21
 ;;^UTILITY(U,$J,358.3,13987,2)
 ;;=^5063096
 ;;^UTILITY(U,$J,358.3,13988,0)
 ;;=Z78.9^^62^683^79
 ;;^UTILITY(U,$J,358.3,13988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13988,1,3,0)
 ;;=3^Triaged to Primary Care Clinic
 ;;^UTILITY(U,$J,358.3,13988,1,4,0)
 ;;=4^Z78.9
 ;;^UTILITY(U,$J,358.3,13988,2)
 ;;=^5063329
 ;;^UTILITY(U,$J,358.3,13989,0)
 ;;=I48.20^^62^683^8
 ;;^UTILITY(U,$J,358.3,13989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13989,1,3,0)
 ;;=3^Atrial Fibrillation,Chronic,Unspec
 ;;^UTILITY(U,$J,358.3,13989,1,4,0)
 ;;=4^I48.20
 ;;^UTILITY(U,$J,358.3,13989,2)
 ;;=^5158048
 ;;^UTILITY(U,$J,358.3,13990,0)
 ;;=M54.6^^62^683^61
 ;;^UTILITY(U,$J,358.3,13990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13990,1,3,0)
 ;;=3^Pain in Thoracic Spine
 ;;^UTILITY(U,$J,358.3,13990,1,4,0)
 ;;=4^M54.6
 ;;^UTILITY(U,$J,358.3,13990,2)
 ;;=^272507
 ;;^UTILITY(U,$J,358.3,13991,0)
 ;;=M54.12^^62^683^64
 ;;^UTILITY(U,$J,358.3,13991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13991,1,3,0)
 ;;=3^Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,13991,1,4,0)
 ;;=4^M54.12
 ;;^UTILITY(U,$J,358.3,13991,2)
 ;;=^5012297
 ;;^UTILITY(U,$J,358.3,13992,0)
 ;;=M54.17^^62^683^65
 ;;^UTILITY(U,$J,358.3,13992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13992,1,3,0)
 ;;=3^Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,13992,1,4,0)
 ;;=4^M54.17
 ;;^UTILITY(U,$J,358.3,13992,2)
 ;;=^5012302
 ;;^UTILITY(U,$J,358.3,13993,0)
 ;;=M54.30^^62^683^67
 ;;^UTILITY(U,$J,358.3,13993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13993,1,3,0)
 ;;=3^Sciatica
 ;;^UTILITY(U,$J,358.3,13993,1,4,0)
 ;;=4^M54.30
 ;;^UTILITY(U,$J,358.3,13993,2)
 ;;=^5012305
 ;;^UTILITY(U,$J,358.3,13994,0)
 ;;=M48.02^^62^683^76
 ;;^UTILITY(U,$J,358.3,13994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13994,1,3,0)
 ;;=3^Spinal Stenosis,Cervical Region
 ;;^UTILITY(U,$J,358.3,13994,1,4,0)
 ;;=4^M48.02
 ;;^UTILITY(U,$J,358.3,13994,2)
 ;;=^5012089
 ;;^UTILITY(U,$J,358.3,13995,0)
 ;;=Z51.81^^62^684^17
 ;;^UTILITY(U,$J,358.3,13995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13995,1,3,0)
 ;;=3^Therapeutic Drug Level Monitoring
 ;;^UTILITY(U,$J,358.3,13995,1,4,0)
 ;;=4^Z51.81
 ;;^UTILITY(U,$J,358.3,13995,2)
 ;;=^5063064
 ;;^UTILITY(U,$J,358.3,13996,0)
 ;;=Z02.79^^62^684^11
 ;;^UTILITY(U,$J,358.3,13996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13996,1,3,0)
 ;;=3^Issue of Medical Certificate NEC
 ;;^UTILITY(U,$J,358.3,13996,1,4,0)
 ;;=4^Z02.79
 ;;^UTILITY(U,$J,358.3,13996,2)
 ;;=^5062641
 ;;^UTILITY(U,$J,358.3,13997,0)
 ;;=Z76.0^^62^684^12
 ;;^UTILITY(U,$J,358.3,13997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13997,1,3,0)
 ;;=3^Issue of Repeat Prescription
 ;;^UTILITY(U,$J,358.3,13997,1,4,0)
 ;;=4^Z76.0
 ;;^UTILITY(U,$J,358.3,13997,2)
 ;;=^5063297
 ;;^UTILITY(U,$J,358.3,13998,0)
 ;;=Z04.9^^62^684^3
 ;;^UTILITY(U,$J,358.3,13998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13998,1,3,0)
 ;;=3^Exam & Observation for Unsp Reason
 ;;^UTILITY(U,$J,358.3,13998,1,4,0)
 ;;=4^Z04.9
 ;;^UTILITY(U,$J,358.3,13998,2)
 ;;=^5062666
 ;;^UTILITY(U,$J,358.3,13999,0)
 ;;=Z02.2^^62^684^4
 ;;^UTILITY(U,$J,358.3,13999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13999,1,3,0)
 ;;=3^Exam for Admission to Residential Institution
 ;;^UTILITY(U,$J,358.3,13999,1,4,0)
 ;;=4^Z02.2
 ;;^UTILITY(U,$J,358.3,13999,2)
 ;;=^5062635
 ;;^UTILITY(U,$J,358.3,14000,0)
 ;;=Z02.4^^62^684^5
 ;;^UTILITY(U,$J,358.3,14000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14000,1,3,0)
 ;;=3^Exam for Driving License
 ;;^UTILITY(U,$J,358.3,14000,1,4,0)
 ;;=4^Z02.4
 ;;^UTILITY(U,$J,358.3,14000,2)
 ;;=^5062637
 ;;^UTILITY(U,$J,358.3,14001,0)
 ;;=Z00.5^^62^684^7
 ;;^UTILITY(U,$J,358.3,14001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14001,1,3,0)
 ;;=3^Exam of Potential Donor of Organ/Tissue
 ;;^UTILITY(U,$J,358.3,14001,1,4,0)
 ;;=4^Z00.5
 ;;^UTILITY(U,$J,358.3,14001,2)
 ;;=^5062607
 ;;^UTILITY(U,$J,358.3,14002,0)
 ;;=Z02.3^^62^684^6
 ;;^UTILITY(U,$J,358.3,14002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14002,1,3,0)
 ;;=3^Exam for Recruitment to Armed Forces
 ;;^UTILITY(U,$J,358.3,14002,1,4,0)
 ;;=4^Z02.3
 ;;^UTILITY(U,$J,358.3,14002,2)
 ;;=^5062636
 ;;^UTILITY(U,$J,358.3,14003,0)
 ;;=Z02.89^^62^684^1
 ;;^UTILITY(U,$J,358.3,14003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14003,1,3,0)
 ;;=3^Admin Exam NEC
 ;;^UTILITY(U,$J,358.3,14003,1,4,0)
 ;;=4^Z02.89
 ;;^UTILITY(U,$J,358.3,14003,2)
 ;;=^5062645
 ;;^UTILITY(U,$J,358.3,14004,0)
 ;;=Z00.8^^62^684^8
 ;;^UTILITY(U,$J,358.3,14004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14004,1,3,0)
 ;;=3^General Exam NEC
 ;;^UTILITY(U,$J,358.3,14004,1,4,0)
 ;;=4^Z00.8
 ;;^UTILITY(U,$J,358.3,14004,2)
 ;;=^5062611
 ;;^UTILITY(U,$J,358.3,14005,0)
 ;;=Z02.1^^62^684^14
 ;;^UTILITY(U,$J,358.3,14005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14005,1,3,0)
 ;;=3^Pre-Employment Exam
 ;;^UTILITY(U,$J,358.3,14005,1,4,0)
 ;;=4^Z02.1
 ;;^UTILITY(U,$J,358.3,14005,2)
 ;;=^5062634
 ;;^UTILITY(U,$J,358.3,14006,0)
 ;;=Z01.810^^62^684^2
 ;;^UTILITY(U,$J,358.3,14006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14006,1,3,0)
 ;;=3^Cardiovascular Preprocedural Exam
 ;;^UTILITY(U,$J,358.3,14006,1,4,0)
 ;;=4^Z01.810
 ;;^UTILITY(U,$J,358.3,14006,2)
 ;;=^5062625
 ;;^UTILITY(U,$J,358.3,14007,0)
 ;;=Z01.811^^62^684^16
 ;;^UTILITY(U,$J,358.3,14007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14007,1,3,0)
 ;;=3^Respiratory Preprocedural Exam
 ;;^UTILITY(U,$J,358.3,14007,1,4,0)
 ;;=4^Z01.811
 ;;^UTILITY(U,$J,358.3,14007,2)
 ;;=^5062626
 ;;^UTILITY(U,$J,358.3,14008,0)
 ;;=Z01.812^^62^684^13
 ;;^UTILITY(U,$J,358.3,14008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14008,1,3,0)
 ;;=3^Lab Preprocedural Exam
 ;;^UTILITY(U,$J,358.3,14008,1,4,0)
 ;;=4^Z01.812
 ;;^UTILITY(U,$J,358.3,14008,2)
 ;;=^5062627
 ;;^UTILITY(U,$J,358.3,14009,0)
 ;;=Z01.818^^62^684^15
 ;;^UTILITY(U,$J,358.3,14009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14009,1,3,0)
 ;;=3^Preprocedural Exam NEC
 ;;^UTILITY(U,$J,358.3,14009,1,4,0)
 ;;=4^Z01.818
 ;;^UTILITY(U,$J,358.3,14009,2)
 ;;=^5062628
 ;;^UTILITY(U,$J,358.3,14010,0)
 ;;=Z71.0^^62^684^9
 ;;^UTILITY(U,$J,358.3,14010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14010,1,3,0)
 ;;=3^Hlth Service to Consult on Behalf of Another
 ;;^UTILITY(U,$J,358.3,14010,1,4,0)
 ;;=4^Z71.0
 ;;^UTILITY(U,$J,358.3,14010,2)
 ;;=^5063242
 ;;^UTILITY(U,$J,358.3,14011,0)
 ;;=Z59.8^^62^684^10
 ;;^UTILITY(U,$J,358.3,14011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14011,1,3,0)
 ;;=3^Housing/Economic Circumstance Problems
 ;;^UTILITY(U,$J,358.3,14011,1,4,0)
 ;;=4^Z59.8
 ;;^UTILITY(U,$J,358.3,14011,2)
 ;;=^5063137
 ;;^UTILITY(U,$J,358.3,14012,0)
 ;;=I20.0^^62^685^5
 ;;^UTILITY(U,$J,358.3,14012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14012,1,3,0)
 ;;=3^Unstable Angina
 ;;^UTILITY(U,$J,358.3,14012,1,4,0)
 ;;=4^I20.0
 ;;^UTILITY(U,$J,358.3,14012,2)
 ;;=^5007076
 ;;^UTILITY(U,$J,358.3,14013,0)
 ;;=I25.2^^62^685^4
 ;;^UTILITY(U,$J,358.3,14013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14013,1,3,0)
 ;;=3^Old Myocardial Infarction
 ;;^UTILITY(U,$J,358.3,14013,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,14013,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,14014,0)
 ;;=I20.8^^62^685^2
 ;;^UTILITY(U,$J,358.3,14014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14014,1,3,0)
 ;;=3^Angina Pectoris,Oth Forms
 ;;^UTILITY(U,$J,358.3,14014,1,4,0)
 ;;=4^I20.8
 ;;^UTILITY(U,$J,358.3,14014,2)
 ;;=^5007078
 ;;^UTILITY(U,$J,358.3,14015,0)
 ;;=I20.1^^62^685^1
 ;;^UTILITY(U,$J,358.3,14015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14015,1,3,0)
 ;;=3^Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,14015,1,4,0)
 ;;=4^I20.1
 ;;^UTILITY(U,$J,358.3,14015,2)
 ;;=^5007077
 ;;^UTILITY(U,$J,358.3,14016,0)
 ;;=I20.9^^62^685^3
 ;;^UTILITY(U,$J,358.3,14016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14016,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,14016,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,14016,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,14017,0)
 ;;=I65.29^^62^686^31
 ;;^UTILITY(U,$J,358.3,14017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14017,1,3,0)
 ;;=3^Occlusion & Stenosis Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,14017,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,14017,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,14018,0)
 ;;=I65.22^^62^686^29
 ;;^UTILITY(U,$J,358.3,14018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14018,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,14018,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,14018,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,14019,0)
 ;;=I65.23^^62^686^28
 ;;^UTILITY(U,$J,358.3,14019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14019,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,14019,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,14019,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,14020,0)
 ;;=I65.21^^62^686^30
 ;;^UTILITY(U,$J,358.3,14020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14020,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,14020,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,14020,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,14021,0)
 ;;=I70.219^^62^686^7
 ;;^UTILITY(U,$J,358.3,14021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14021,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Unspec Extrm
 ;;^UTILITY(U,$J,358.3,14021,1,4,0)
 ;;=4^I70.219
 ;;^UTILITY(U,$J,358.3,14021,2)
 ;;=^5007582
 ;;^UTILITY(U,$J,358.3,14022,0)
 ;;=I70.213^^62^686^8
 ;;^UTILITY(U,$J,358.3,14022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14022,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Bilat Legs
 ;;^UTILITY(U,$J,358.3,14022,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,14022,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,14023,0)
 ;;=I70.212^^62^686^9
 ;;^UTILITY(U,$J,358.3,14023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14023,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Left Leg
 ;;^UTILITY(U,$J,358.3,14023,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,14023,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,14024,0)
 ;;=I70.211^^62^686^10
 ;;^UTILITY(U,$J,358.3,14024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14024,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Right Leg
 ;;^UTILITY(U,$J,358.3,14024,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,14024,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,14025,0)
 ;;=I70.25^^62^686^6
 ;;^UTILITY(U,$J,358.3,14025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14025,1,3,0)
 ;;=3^Athscl Native Arteries of Extremitis w/ Ulceration
 ;;^UTILITY(U,$J,358.3,14025,1,4,0)
 ;;=4^I70.25
 ;;^UTILITY(U,$J,358.3,14025,2)
 ;;=^5007602
 ;;^UTILITY(U,$J,358.3,14026,0)
 ;;=I70.249^^62^686^11
 ;;^UTILITY(U,$J,358.3,14026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14026,1,3,0)
 ;;=3^Athscl Natv Art of Lt Leg w/ Ulceration of Unspec Site
 ;;^UTILITY(U,$J,358.3,14026,1,4,0)
 ;;=4^I70.249
 ;;^UTILITY(U,$J,358.3,14026,2)
 ;;=^5007601
 ;;^UTILITY(U,$J,358.3,14027,0)
 ;;=I70.239^^62^686^12
 ;;^UTILITY(U,$J,358.3,14027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14027,1,3,0)
 ;;=3^Athscl Natv Art of Rt Leg w/ Ulcer of Unspec Site
 ;;^UTILITY(U,$J,358.3,14027,1,4,0)
 ;;=4^I70.239
 ;;^UTILITY(U,$J,358.3,14027,2)
 ;;=^5007594
 ;;^UTILITY(U,$J,358.3,14028,0)
 ;;=I70.269^^62^686^13
 ;;^UTILITY(U,$J,358.3,14028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14028,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Unspec Extremity
 ;;^UTILITY(U,$J,358.3,14028,1,4,0)
 ;;=4^I70.269
 ;;^UTILITY(U,$J,358.3,14028,2)
 ;;=^5007607
 ;;^UTILITY(U,$J,358.3,14029,0)
 ;;=I70.263^^62^686^14
 ;;^UTILITY(U,$J,358.3,14029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14029,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Bilateral Legs
 ;;^UTILITY(U,$J,358.3,14029,1,4,0)
 ;;=4^I70.263
 ;;^UTILITY(U,$J,358.3,14029,2)
 ;;=^5007605
 ;;^UTILITY(U,$J,358.3,14030,0)
 ;;=I70.262^^62^686^15
 ;;^UTILITY(U,$J,358.3,14030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14030,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Left Leg
 ;;^UTILITY(U,$J,358.3,14030,1,4,0)
 ;;=4^I70.262
 ;;^UTILITY(U,$J,358.3,14030,2)
 ;;=^5007604
 ;;^UTILITY(U,$J,358.3,14031,0)
 ;;=I70.261^^62^686^16
 ;;^UTILITY(U,$J,358.3,14031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14031,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Right Leg
 ;;^UTILITY(U,$J,358.3,14031,1,4,0)
 ;;=4^I70.261
 ;;^UTILITY(U,$J,358.3,14031,2)
 ;;=^5007603
 ;;^UTILITY(U,$J,358.3,14032,0)
 ;;=I71.2^^62^686^34
 ;;^UTILITY(U,$J,358.3,14032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14032,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,14032,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,14032,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,14033,0)
 ;;=I71.4^^62^686^1
 ;;^UTILITY(U,$J,358.3,14033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14033,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,14033,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,14033,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,14034,0)
 ;;=I73.9^^62^686^32
 ;;^UTILITY(U,$J,358.3,14034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14034,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,14034,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,14034,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,14035,0)
 ;;=I82.891^^62^686^23
 ;;^UTILITY(U,$J,358.3,14035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14035,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Chronic
 ;;^UTILITY(U,$J,358.3,14035,1,4,0)
 ;;=4^I82.891
 ;;^UTILITY(U,$J,358.3,14035,2)
 ;;=^5007939
 ;;^UTILITY(U,$J,358.3,14036,0)
 ;;=I82.890^^62^686^22
 ;;^UTILITY(U,$J,358.3,14036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14036,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Acute
 ;;^UTILITY(U,$J,358.3,14036,1,4,0)
 ;;=4^I82.890
 ;;^UTILITY(U,$J,358.3,14036,2)
 ;;=^5007938
 ;;^UTILITY(U,$J,358.3,14037,0)
 ;;=I25.729^^62^686^2
 ;;^UTILITY(U,$J,358.3,14037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14037,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,14037,1,4,0)
 ;;=4^I25.729
 ;;^UTILITY(U,$J,358.3,14037,2)
 ;;=^5133561
 ;;^UTILITY(U,$J,358.3,14038,0)
 ;;=I25.119^^62^686^3
 ;;^UTILITY(U,$J,358.3,14038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14038,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/ Ang Pctrs,Unspec
 ;;^UTILITY(U,$J,358.3,14038,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,14038,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,14039,0)
 ;;=I25.10^^62^686^4
 ;;^UTILITY(U,$J,358.3,14039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14039,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,14039,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,14039,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,14040,0)
 ;;=I25.110^^62^686^5
 ;;^UTILITY(U,$J,358.3,14040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14040,1,3,0)
 ;;=3^Athscl Hrt Dis of Native Cor Art w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,14040,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,14040,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,14041,0)
 ;;=I25.810^^62^686^17
 ;;^UTILITY(U,$J,358.3,14041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14041,1,3,0)
 ;;=3^Athscl of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,14041,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,14041,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,14042,0)
 ;;=I25.701^^62^686^18
 ;;^UTILITY(U,$J,358.3,14042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14042,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,14042,1,4,0)
 ;;=4^I25.701
 ;;^UTILITY(U,$J,358.3,14042,2)
 ;;=^5007118
 ;;^UTILITY(U,$J,358.3,14043,0)
 ;;=I25.708^^62^686^19
 ;;^UTILITY(U,$J,358.3,14043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14043,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Oth Angina Pectoris
 ;;^UTILITY(U,$J,358.3,14043,1,4,0)
 ;;=4^I25.708
 ;;^UTILITY(U,$J,358.3,14043,2)
 ;;=^5007119
 ;;^UTILITY(U,$J,358.3,14044,0)
 ;;=I25.709^^62^686^20
 ;;^UTILITY(U,$J,358.3,14044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14044,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,14044,1,4,0)
 ;;=4^I25.709
 ;;^UTILITY(U,$J,358.3,14044,2)
 ;;=^5007120
 ;;^UTILITY(U,$J,358.3,14045,0)
 ;;=I25.700^^62^686^21
 ;;^UTILITY(U,$J,358.3,14045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14045,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unstable Angina Pectoris
 ;;^UTILITY(U,$J,358.3,14045,1,4,0)
 ;;=4^I25.700
 ;;^UTILITY(U,$J,358.3,14045,2)
 ;;=^5007117
 ;;^UTILITY(U,$J,358.3,14046,0)
 ;;=I82.469^^62^686^24
 ;;^UTILITY(U,$J,358.3,14046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14046,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Calf Muscle Vein,Acute
 ;;^UTILITY(U,$J,358.3,14046,1,4,0)
 ;;=4^I82.469
 ;;^UTILITY(U,$J,358.3,14046,2)
 ;;=^5158066
 ;;^UTILITY(U,$J,358.3,14047,0)
 ;;=I82.569^^62^686^25
 ;;^UTILITY(U,$J,358.3,14047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14047,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Calf Muscle Vein,Chronic
 ;;^UTILITY(U,$J,358.3,14047,1,4,0)
 ;;=4^I82.569
 ;;^UTILITY(U,$J,358.3,14047,2)
 ;;=^5158074
 ;;^UTILITY(U,$J,358.3,14048,0)
 ;;=I80.259^^62^686^33
 ;;^UTILITY(U,$J,358.3,14048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14048,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis,Unspec Calf Muscle Vein
 ;;^UTILITY(U,$J,358.3,14048,1,4,0)
 ;;=4^I80.259
 ;;^UTILITY(U,$J,358.3,14048,2)
 ;;=^5158058
 ;;^UTILITY(U,$J,358.3,14049,0)
 ;;=I82.409^^62^686^26
 ;;^UTILITY(U,$J,358.3,14049,1,0)
 ;;=^358.31IA^4^2
