IBDEI05J ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13363,1,4,0)
 ;;=4^N99.820
 ;;^UTILITY(U,$J,358.3,13363,2)
 ;;=^5015968
 ;;^UTILITY(U,$J,358.3,13364,0)
 ;;=N99.821^^53^582^195
 ;;^UTILITY(U,$J,358.3,13364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13364,1,3,0)
 ;;=3^Postproc Hemor/Hematom,GU Sys After Oth Proc
 ;;^UTILITY(U,$J,358.3,13364,1,4,0)
 ;;=4^N99.821
 ;;^UTILITY(U,$J,358.3,13364,2)
 ;;=^5015969
 ;;^UTILITY(U,$J,358.3,13365,0)
 ;;=T88.8XXA^^53^582^26
 ;;^UTILITY(U,$J,358.3,13365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13365,1,3,0)
 ;;=3^Complic,Surgical/Medical Care NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,13365,1,4,0)
 ;;=4^T88.8XXA
 ;;^UTILITY(U,$J,358.3,13365,2)
 ;;=^5055814
 ;;^UTILITY(U,$J,358.3,13366,0)
 ;;=T81.83XA^^53^582^173
 ;;^UTILITY(U,$J,358.3,13366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13366,1,3,0)
 ;;=3^Persistent Postprocedural Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,13366,1,4,0)
 ;;=4^T81.83XA
 ;;^UTILITY(U,$J,358.3,13366,2)
 ;;=^5054659
 ;;^UTILITY(U,$J,358.3,13367,0)
 ;;=T81.89XA^^53^582^25
 ;;^UTILITY(U,$J,358.3,13367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13367,1,3,0)
 ;;=3^Complic,Procedures NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,13367,1,4,0)
 ;;=4^T81.89XA
 ;;^UTILITY(U,$J,358.3,13367,2)
 ;;=^5054662
 ;;^UTILITY(U,$J,358.3,13368,0)
 ;;=T81.9XXA^^53^582^24
 ;;^UTILITY(U,$J,358.3,13368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13368,1,3,0)
 ;;=3^Complic,Procedure Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,13368,1,4,0)
 ;;=4^T81.9XXA
 ;;^UTILITY(U,$J,358.3,13368,2)
 ;;=^5054665
 ;;^UTILITY(U,$J,358.3,13369,0)
 ;;=T85.810A^^53^582^48
 ;;^UTILITY(U,$J,358.3,13369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13369,1,3,0)
 ;;=3^Embol d/t Nervous System Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,13369,1,4,0)
 ;;=4^T85.810A
 ;;^UTILITY(U,$J,358.3,13369,2)
 ;;=^5140309
 ;;^UTILITY(U,$J,358.3,13370,0)
 ;;=T85.818A^^53^582^49
 ;;^UTILITY(U,$J,358.3,13370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13370,1,3,0)
 ;;=3^Embol d/t Oth Internal Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,13370,1,4,0)
 ;;=4^T85.818A
 ;;^UTILITY(U,$J,358.3,13370,2)
 ;;=^5140312
 ;;^UTILITY(U,$J,358.3,13371,0)
 ;;=T85.820A^^53^582^55
 ;;^UTILITY(U,$J,358.3,13371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13371,1,3,0)
 ;;=3^Fibrosis d/t Nervous System Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,13371,1,4,0)
 ;;=4^T85.820A
 ;;^UTILITY(U,$J,358.3,13371,2)
 ;;=^5140315
 ;;^UTILITY(U,$J,358.3,13372,0)
 ;;=T85.828A^^53^582^56
 ;;^UTILITY(U,$J,358.3,13372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13372,1,3,0)
 ;;=3^Fibrosis d/t Other Internal Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,13372,1,4,0)
 ;;=4^T85.828A
 ;;^UTILITY(U,$J,358.3,13372,2)
 ;;=^5140318
 ;;^UTILITY(U,$J,358.3,13373,0)
 ;;=T85.830A^^53^582^61
 ;;^UTILITY(U,$J,358.3,13373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13373,1,3,0)
 ;;=3^Hemorrh d/t Nervous System Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,13373,1,4,0)
 ;;=4^T85.830A
 ;;^UTILITY(U,$J,358.3,13373,2)
 ;;=^5140321
 ;;^UTILITY(U,$J,358.3,13374,0)
 ;;=T85.838A^^53^582^62
 ;;^UTILITY(U,$J,358.3,13374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13374,1,3,0)
 ;;=3^Hemorrh d/t Other Internal Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,13374,1,4,0)
 ;;=4^T85.838A
 ;;^UTILITY(U,$J,358.3,13374,2)
 ;;=^5140324
 ;;^UTILITY(U,$J,358.3,13375,0)
 ;;=T83.61XA^^53^582^77
 ;;^UTILITY(U,$J,358.3,13375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13375,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Implanted Penile Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,13375,1,4,0)
 ;;=4^T83.61XA
 ;;^UTILITY(U,$J,358.3,13375,2)
 ;;=^5140162
 ;;^UTILITY(U,$J,358.3,13376,0)
 ;;=T83.62XA^^53^582^78
 ;;^UTILITY(U,$J,358.3,13376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13376,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Implanted Testicular Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,13376,1,4,0)
 ;;=4^T83.62XA
 ;;^UTILITY(U,$J,358.3,13376,2)
 ;;=^5140165
 ;;^UTILITY(U,$J,358.3,13377,0)
 ;;=T83.69XA^^53^582^100
 ;;^UTILITY(U,$J,358.3,13377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13377,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Oth Prosthetic Device/Implant/Graft in Genital Tract,Init Encntr
 ;;^UTILITY(U,$J,358.3,13377,1,4,0)
 ;;=4^T83.69XA
 ;;^UTILITY(U,$J,358.3,13377,2)
 ;;=^5140168
 ;;^UTILITY(U,$J,358.3,13378,0)
 ;;=T83.510A^^53^582^67
 ;;^UTILITY(U,$J,358.3,13378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13378,1,3,0)
 ;;=3^Infect d/t Cystostomy Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,13378,1,4,0)
 ;;=4^T83.510A
 ;;^UTILITY(U,$J,358.3,13378,2)
 ;;=^5140135
 ;;^UTILITY(U,$J,358.3,13379,0)
 ;;=T83.510S^^53^582^68
 ;;^UTILITY(U,$J,358.3,13379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13379,1,3,0)
 ;;=3^Infect d/t Cystostomy Catheter,Sequela
 ;;^UTILITY(U,$J,358.3,13379,1,4,0)
 ;;=4^T83.510S
 ;;^UTILITY(U,$J,358.3,13379,2)
 ;;=^5140137
 ;;^UTILITY(U,$J,358.3,13380,0)
 ;;=T83.510D^^53^582^66
 ;;^UTILITY(U,$J,358.3,13380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13380,1,3,0)
 ;;=3^Infect d/t Cystostomy Catheter,Healing/Subs
 ;;^UTILITY(U,$J,358.3,13380,1,4,0)
 ;;=4^T83.510D
 ;;^UTILITY(U,$J,358.3,13380,2)
 ;;=^5140136
 ;;^UTILITY(U,$J,358.3,13381,0)
 ;;=T83.511A^^53^582^69
 ;;^UTILITY(U,$J,358.3,13381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13381,1,3,0)
 ;;=3^Infect d/t Indwelling Urethral Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,13381,1,4,0)
 ;;=4^T83.511A
 ;;^UTILITY(U,$J,358.3,13381,2)
 ;;=^5140138
 ;;^UTILITY(U,$J,358.3,13382,0)
 ;;=T83.511D^^53^582^70
 ;;^UTILITY(U,$J,358.3,13382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13382,1,3,0)
 ;;=3^Infect d/t Indwelling Urethral Catheter,Healing/Subs
 ;;^UTILITY(U,$J,358.3,13382,1,4,0)
 ;;=4^T83.511D
 ;;^UTILITY(U,$J,358.3,13382,2)
 ;;=^5140139
 ;;^UTILITY(U,$J,358.3,13383,0)
 ;;=T83.511S^^53^582^71
 ;;^UTILITY(U,$J,358.3,13383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13383,1,3,0)
 ;;=3^Infect d/t Indwelling Urethral Catheter,Sequela
 ;;^UTILITY(U,$J,358.3,13383,1,4,0)
 ;;=4^T83.511S
 ;;^UTILITY(U,$J,358.3,13383,2)
 ;;=^5140140
 ;;^UTILITY(U,$J,358.3,13384,0)
 ;;=T83.512A^^53^582^73
 ;;^UTILITY(U,$J,358.3,13384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13384,1,3,0)
 ;;=3^Infect d/t Nephrostomy Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,13384,1,4,0)
 ;;=4^T83.512A
 ;;^UTILITY(U,$J,358.3,13384,2)
 ;;=^5140141
 ;;^UTILITY(U,$J,358.3,13385,0)
 ;;=T83.512D^^53^582^72
 ;;^UTILITY(U,$J,358.3,13385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13385,1,3,0)
 ;;=3^Infect d/t Nephrostomy Catheter,Healing/Subs
 ;;^UTILITY(U,$J,358.3,13385,1,4,0)
 ;;=4^T83.512D
 ;;^UTILITY(U,$J,358.3,13385,2)
 ;;=^5140142
 ;;^UTILITY(U,$J,358.3,13386,0)
 ;;=T83.512S^^53^582^74
 ;;^UTILITY(U,$J,358.3,13386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13386,1,3,0)
 ;;=3^Infect d/t Nephrostomy Catheter,Sequela
 ;;^UTILITY(U,$J,358.3,13386,1,4,0)
 ;;=4^T83.512S
 ;;^UTILITY(U,$J,358.3,13386,2)
 ;;=^5140143
 ;;^UTILITY(U,$J,358.3,13387,0)
 ;;=T85.840A^^53^582^168
 ;;^UTILITY(U,$J,358.3,13387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13387,1,3,0)
 ;;=3^Pain d/t Nervous System Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,13387,1,4,0)
 ;;=4^T85.840A
 ;;^UTILITY(U,$J,358.3,13387,2)
 ;;=^5140327
 ;;^UTILITY(U,$J,358.3,13388,0)
 ;;=T85.848A^^53^582^169
 ;;^UTILITY(U,$J,358.3,13388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13388,1,3,0)
 ;;=3^Pain d/t Oth Internal Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,13388,1,4,0)
 ;;=4^T85.848A
 ;;^UTILITY(U,$J,358.3,13388,2)
 ;;=^5140330
 ;;^UTILITY(U,$J,358.3,13389,0)
 ;;=I97.620^^53^582^210
 ;;^UTILITY(U,$J,358.3,13389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13389,1,3,0)
 ;;=3^Postproc Hemorrhage of Circ Sys Organ 
 ;;^UTILITY(U,$J,358.3,13389,1,4,0)
 ;;=4^I97.620
 ;;^UTILITY(U,$J,358.3,13389,2)
 ;;=^5138677
 ;;^UTILITY(U,$J,358.3,13390,0)
 ;;=I97.621^^53^582^184
 ;;^UTILITY(U,$J,358.3,13390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13390,1,3,0)
 ;;=3^Postproc Hematoma of Circ System/Structure
 ;;^UTILITY(U,$J,358.3,13390,1,4,0)
 ;;=4^I97.621
 ;;^UTILITY(U,$J,358.3,13390,2)
 ;;=^5138678
 ;;^UTILITY(U,$J,358.3,13391,0)
 ;;=I97.622^^53^582^219
 ;;^UTILITY(U,$J,358.3,13391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13391,1,3,0)
 ;;=3^Postproc Seroma of Circ System/Structure
 ;;^UTILITY(U,$J,358.3,13391,1,4,0)
 ;;=4^I97.622
 ;;^UTILITY(U,$J,358.3,13391,2)
 ;;=^5138679
 ;;^UTILITY(U,$J,358.3,13392,0)
 ;;=T85.850A^^53^582^221
 ;;^UTILITY(U,$J,358.3,13392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13392,1,3,0)
 ;;=3^Sten d/t Nerv Sys Prosth Dvc/Implnt/Grft,Init Enc
 ;;^UTILITY(U,$J,358.3,13392,1,4,0)
 ;;=4^T85.850A
 ;;^UTILITY(U,$J,358.3,13392,2)
 ;;=^5140333
 ;;^UTILITY(U,$J,358.3,13393,0)
 ;;=T85.858A^^53^582^222
 ;;^UTILITY(U,$J,358.3,13393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13393,1,3,0)
 ;;=3^Sten d/t Oth Int Prosth Dvc/Implnt/Grft,Init Enc
 ;;^UTILITY(U,$J,358.3,13393,1,4,0)
 ;;=4^T85.858A
 ;;^UTILITY(U,$J,358.3,13393,2)
 ;;=^5140336
 ;;^UTILITY(U,$J,358.3,13394,0)
 ;;=T85.868A^^53^582^228
 ;;^UTILITY(U,$J,358.3,13394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13394,1,3,0)
 ;;=3^Thromb d/t Oth Int Prosth Dvc/Implnt/Grft,Init Enc
 ;;^UTILITY(U,$J,358.3,13394,1,4,0)
 ;;=4^T85.868A
 ;;^UTILITY(U,$J,358.3,13394,2)
 ;;=^5140342
 ;;^UTILITY(U,$J,358.3,13395,0)
 ;;=T85.860A^^53^582^227
 ;;^UTILITY(U,$J,358.3,13395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13395,1,3,0)
 ;;=3^Thromb d/t Nerv Sys Prosth Dvc/Implnt/Grft,Init Enc
 ;;^UTILITY(U,$J,358.3,13395,1,4,0)
 ;;=4^T85.860A
 ;;^UTILITY(U,$J,358.3,13395,2)
 ;;=^5140339
 ;;^UTILITY(U,$J,358.3,13396,0)
 ;;=K91.30^^53^582^215
 ;;^UTILITY(U,$J,358.3,13396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13396,1,3,0)
 ;;=3^Postproc Intestinal Obstruction
 ;;^UTILITY(U,$J,358.3,13396,1,4,0)
 ;;=4^K91.30
 ;;^UTILITY(U,$J,358.3,13396,2)
 ;;=^5151427
 ;;^UTILITY(U,$J,358.3,13397,0)
 ;;=K91.31^^53^582^217
 ;;^UTILITY(U,$J,358.3,13397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13397,1,3,0)
 ;;=3^Postproc Intestinal Obstruction,Partial/Incompl
 ;;^UTILITY(U,$J,358.3,13397,1,4,0)
 ;;=4^K91.31
 ;;^UTILITY(U,$J,358.3,13397,2)
 ;;=^5151428
 ;;^UTILITY(U,$J,358.3,13398,0)
 ;;=K91.32^^53^582^216
 ;;^UTILITY(U,$J,358.3,13398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13398,1,3,0)
 ;;=3^Postproc Intestinal Obstruction,Complete
 ;;^UTILITY(U,$J,358.3,13398,1,4,0)
 ;;=4^K91.32
 ;;^UTILITY(U,$J,358.3,13398,2)
 ;;=^5151429
 ;;^UTILITY(U,$J,358.3,13399,0)
 ;;=H59.323^^53^582^185
 ;;^UTILITY(U,$J,358.3,13399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13399,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Bil Eye/Adnexa After Oth Proc
 ;;^UTILITY(U,$J,358.3,13399,1,4,0)
 ;;=4^H59.323
 ;;^UTILITY(U,$J,358.3,13399,2)
 ;;=^5006423
 ;;^UTILITY(U,$J,358.3,13400,0)
 ;;=N99.85^^53^582^174
 ;;^UTILITY(U,$J,358.3,13400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13400,1,3,0)
 ;;=3^Post Endometrial Ablation Syndrome
 ;;^UTILITY(U,$J,358.3,13400,1,4,0)
 ;;=4^N99.85
 ;;^UTILITY(U,$J,358.3,13400,2)
 ;;=^5158110
 ;;^UTILITY(U,$J,358.3,13401,0)
 ;;=I05.0^^53^583^49
 ;;^UTILITY(U,$J,358.3,13401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13401,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,13401,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,13401,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,13402,0)
 ;;=I08.0^^53^583^50
 ;;^UTILITY(U,$J,358.3,13402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13402,1,3,0)
 ;;=3^Rheumatic Mitral/Aortic Valve Disorders
 ;;^UTILITY(U,$J,358.3,13402,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,13402,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,13403,0)
 ;;=I25.10^^53^583^7
 ;;^UTILITY(U,$J,358.3,13403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13403,1,3,0)
 ;;=3^Athscl Hrt Dis,Nat Cor Art w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,13403,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,13403,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,13404,0)
 ;;=I31.9^^53^583^43
 ;;^UTILITY(U,$J,358.3,13404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13404,1,3,0)
 ;;=3^Pericardium Disease,Unspec
 ;;^UTILITY(U,$J,358.3,13404,1,4,0)
 ;;=4^I31.9
 ;;^UTILITY(U,$J,358.3,13404,2)
 ;;=^5007165
 ;;^UTILITY(U,$J,358.3,13405,0)
 ;;=I34.1^^53^583^37
 ;;^UTILITY(U,$J,358.3,13405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13405,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,13405,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,13405,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,13406,0)
 ;;=I35.0^^53^583^36
 ;;^UTILITY(U,$J,358.3,13406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13406,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,13406,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,13406,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,13407,0)
 ;;=I35.1^^53^583^35
 ;;^UTILITY(U,$J,358.3,13407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13407,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,13407,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,13407,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,13408,0)
 ;;=I42.1^^53^583^38
 ;;^UTILITY(U,$J,358.3,13408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13408,1,3,0)
 ;;=3^Obstructive Hypertrophic Cardiomyopathy
 ;;^UTILITY(U,$J,358.3,13408,1,4,0)
 ;;=4^I42.1
 ;;^UTILITY(U,$J,358.3,13408,2)
 ;;=^340520
 ;;^UTILITY(U,$J,358.3,13409,0)
 ;;=I42.5^^53^583^48
 ;;^UTILITY(U,$J,358.3,13409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13409,1,3,0)
 ;;=3^Restrictive Cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,13409,1,4,0)
 ;;=4^I42.5
 ;;^UTILITY(U,$J,358.3,13409,2)
 ;;=^5007196
 ;;^UTILITY(U,$J,358.3,13410,0)
 ;;=I42.8^^53^583^14
 ;;^UTILITY(U,$J,358.3,13410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13410,1,3,0)
 ;;=3^Cardiomyopathies NEC
 ;;^UTILITY(U,$J,358.3,13410,1,4,0)
 ;;=4^I42.8
 ;;^UTILITY(U,$J,358.3,13410,2)
 ;;=^5007199
 ;;^UTILITY(U,$J,358.3,13411,0)
 ;;=I49.5^^53^583^59
 ;;^UTILITY(U,$J,358.3,13411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13411,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,13411,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,13411,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,13412,0)
 ;;=I50.9^^53^583^30
 ;;^UTILITY(U,$J,358.3,13412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13412,1,3,0)
 ;;=3^Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,13412,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,13412,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,13413,0)
 ;;=I51.7^^53^583^13
 ;;^UTILITY(U,$J,358.3,13413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13413,1,3,0)
 ;;=3^Cardiomegaly
 ;;^UTILITY(U,$J,358.3,13413,1,4,0)
 ;;=4^I51.7
 ;;^UTILITY(U,$J,358.3,13413,2)
 ;;=^5007257
 ;;^UTILITY(U,$J,358.3,13414,0)
 ;;=I65.21^^53^583^41
 ;;^UTILITY(U,$J,358.3,13414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13414,1,3,0)
 ;;=3^Occlusion/Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,13414,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,13414,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,13415,0)
 ;;=I65.22^^53^583^40
 ;;^UTILITY(U,$J,358.3,13415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13415,1,3,0)
 ;;=3^Occlusion/Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,13415,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,13415,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,13416,0)
 ;;=I65.23^^53^583^39
 ;;^UTILITY(U,$J,358.3,13416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13416,1,3,0)
 ;;=3^Occlusion/Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,13416,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,13416,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,13417,0)
 ;;=I71.2^^53^583^66
 ;;^UTILITY(U,$J,358.3,13417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13417,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,13417,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,13417,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,13418,0)
 ;;=I71.4^^53^583^2
 ;;^UTILITY(U,$J,358.3,13418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13418,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,13418,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,13418,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,13419,0)
 ;;=I73.9^^53^583^42
 ;;^UTILITY(U,$J,358.3,13419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13419,1,3,0)
 ;;=3^PVD,Unspec
 ;;^UTILITY(U,$J,358.3,13419,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,13419,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,13420,0)
 ;;=I82.91^^53^583^18
 ;;^UTILITY(U,$J,358.3,13420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13420,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Vein,Chronic
 ;;^UTILITY(U,$J,358.3,13420,1,4,0)
 ;;=4^I82.91
 ;;^UTILITY(U,$J,358.3,13420,2)
 ;;=^5007941
 ;;^UTILITY(U,$J,358.3,13421,0)
 ;;=I83.019^^53^583^68
 ;;^UTILITY(U,$J,358.3,13421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13421,1,3,0)
 ;;=3^Varicose Veins RLE w/ Ulcer
 ;;^UTILITY(U,$J,358.3,13421,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,13421,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,13422,0)
 ;;=I83.029^^53^583^67
 ;;^UTILITY(U,$J,358.3,13422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13422,1,3,0)
 ;;=3^Varicose Veins LLE w/ Ulcer
 ;;^UTILITY(U,$J,358.3,13422,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,13422,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,13423,0)
 ;;=I87.2^^53^583^69
 ;;^UTILITY(U,$J,358.3,13423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13423,1,3,0)
 ;;=3^Venous Insufficiency
 ;;^UTILITY(U,$J,358.3,13423,1,4,0)
 ;;=4^I87.2
 ;;^UTILITY(U,$J,358.3,13423,2)
 ;;=^5008047
 ;;^UTILITY(U,$J,358.3,13424,0)
 ;;=R07.9^^53^583^16
 ;;^UTILITY(U,$J,358.3,13424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13424,1,3,0)
 ;;=3^Chest Pain,Unspec
 ;;^UTILITY(U,$J,358.3,13424,1,4,0)
 ;;=4^R07.9
 ;;^UTILITY(U,$J,358.3,13424,2)
 ;;=^5019201
 ;;^UTILITY(U,$J,358.3,13425,0)
 ;;=Z95.2^^53^583^47
 ;;^UTILITY(U,$J,358.3,13425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13425,1,3,0)
 ;;=3^Presence of Prosthetic Heart Valve
 ;;^UTILITY(U,$J,358.3,13425,1,4,0)
 ;;=4^Z95.2
 ;;^UTILITY(U,$J,358.3,13425,2)
 ;;=^5063670
 ;;^UTILITY(U,$J,358.3,13426,0)
 ;;=Z95.0^^53^583^46
 ;;^UTILITY(U,$J,358.3,13426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13426,1,3,0)
 ;;=3^Presence of Cardiac Pacemaker
 ;;^UTILITY(U,$J,358.3,13426,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,13426,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,13427,0)
 ;;=Z95.810^^53^583^45
 ;;^UTILITY(U,$J,358.3,13427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13427,1,3,0)
 ;;=3^Presence of Automatic Cardiac Defibrillator
 ;;^UTILITY(U,$J,358.3,13427,1,4,0)
 ;;=4^Z95.810
 ;;^UTILITY(U,$J,358.3,13427,2)
 ;;=^5063674
 ;;^UTILITY(U,$J,358.3,13428,0)
 ;;=Z95.1^^53^583^44
 ;;^UTILITY(U,$J,358.3,13428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13428,1,3,0)
 ;;=3^Presence of Aortocoronary Bypass Graft
 ;;^UTILITY(U,$J,358.3,13428,1,4,0)
 ;;=4^Z95.1
 ;;^UTILITY(U,$J,358.3,13428,2)
 ;;=^5063669
 ;;^UTILITY(U,$J,358.3,13429,0)
 ;;=I71.3^^53^583^1
 ;;^UTILITY(U,$J,358.3,13429,1,0)
 ;;=^358.31IA^4^2
