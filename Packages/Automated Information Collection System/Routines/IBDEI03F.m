IBDEI03F ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4282,1,3,0)
 ;;=3^Photophobia
 ;;^UTILITY(U,$J,358.3,4282,1,4,0)
 ;;=4^368.13
 ;;^UTILITY(U,$J,358.3,4282,2)
 ;;=^126851
 ;;^UTILITY(U,$J,358.3,4283,0)
 ;;=368.40^^39^300^23
 ;;^UTILITY(U,$J,358.3,4283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4283,1,3,0)
 ;;=3^Vis Field Defect
 ;;^UTILITY(U,$J,358.3,4283,1,4,0)
 ;;=4^368.40
 ;;^UTILITY(U,$J,358.3,4283,2)
 ;;=^126859
 ;;^UTILITY(U,$J,358.3,4284,0)
 ;;=369.4^^39^300^14
 ;;^UTILITY(U,$J,358.3,4284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4284,1,3,0)
 ;;=3^Legal Blindness
 ;;^UTILITY(U,$J,358.3,4284,1,4,0)
 ;;=4^369.4
 ;;^UTILITY(U,$J,358.3,4284,2)
 ;;=Legal Blindness^268887
 ;;^UTILITY(U,$J,358.3,4285,0)
 ;;=250.01^^39^300^5
 ;;^UTILITY(U,$J,358.3,4285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4285,1,3,0)
 ;;=3^DM Type I, w/o Eye Disease
 ;;^UTILITY(U,$J,358.3,4285,1,4,0)
 ;;=4^250.01
 ;;^UTILITY(U,$J,358.3,4285,2)
 ;;=Diabetes Mellitus Type I^33586
 ;;^UTILITY(U,$J,358.3,4286,0)
 ;;=V08.^^39^300^10
 ;;^UTILITY(U,$J,358.3,4286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4286,1,3,0)
 ;;=3^HIV Positive
 ;;^UTILITY(U,$J,358.3,4286,1,4,0)
 ;;=4^V08.
 ;;^UTILITY(U,$J,358.3,4286,2)
 ;;=Asymptomatic HIV Status^303392
 ;;^UTILITY(U,$J,358.3,4287,0)
 ;;=921.0^^39^300^4
 ;;^UTILITY(U,$J,358.3,4287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4287,1,3,0)
 ;;=3^Contusion of Eye
 ;;^UTILITY(U,$J,358.3,4287,1,4,0)
 ;;=4^921.0
 ;;^UTILITY(U,$J,358.3,4287,2)
 ;;=^15052
 ;;^UTILITY(U,$J,358.3,4288,0)
 ;;=379.91^^39^300^16
 ;;^UTILITY(U,$J,358.3,4288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4288,1,3,0)
 ;;=3^Pain in/around the Eye
 ;;^UTILITY(U,$J,358.3,4288,1,4,0)
 ;;=4^379.91
 ;;^UTILITY(U,$J,358.3,4288,2)
 ;;=Pain in or around eye^89093
 ;;^UTILITY(U,$J,358.3,4289,0)
 ;;=V58.69^^39^300^11
 ;;^UTILITY(U,$J,358.3,4289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4289,1,3,0)
 ;;=3^Hi-Risk med, L/T
 ;;^UTILITY(U,$J,358.3,4289,1,4,0)
 ;;=4^V58.69
 ;;^UTILITY(U,$J,358.3,4289,2)
 ;;=^303460
 ;;^UTILITY(U,$J,358.3,4290,0)
 ;;=871.4^^39^300^13
 ;;^UTILITY(U,$J,358.3,4290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4290,1,3,0)
 ;;=3^Laceration of Eyeball
 ;;^UTILITY(U,$J,358.3,4290,1,4,0)
 ;;=4^871.4
 ;;^UTILITY(U,$J,358.3,4290,2)
 ;;=Laceration of Eyeball^274889
 ;;^UTILITY(U,$J,358.3,4291,0)
 ;;=242.90^^39^300^22
 ;;^UTILITY(U,$J,358.3,4291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4291,1,3,0)
 ;;=3^Thyroid Eye Dis
 ;;^UTILITY(U,$J,358.3,4291,1,4,0)
 ;;=4^242.90
 ;;^UTILITY(U,$J,358.3,4291,2)
 ;;=Thyroid Eye Dis^267811^376.21
 ;;^UTILITY(U,$J,358.3,4292,0)
 ;;=135.^^39^300^20
 ;;^UTILITY(U,$J,358.3,4292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4292,1,3,0)
 ;;=3^Sarcoidosis
 ;;^UTILITY(U,$J,358.3,4292,1,4,0)
 ;;=4^135.
 ;;^UTILITY(U,$J,358.3,4292,2)
 ;;=Sarcoidosis^107916
 ;;^UTILITY(U,$J,358.3,4293,0)
 ;;=446.5^^39^300^21
 ;;^UTILITY(U,$J,358.3,4293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4293,1,3,0)
 ;;=3^Temporal Arteritis
 ;;^UTILITY(U,$J,358.3,4293,1,4,0)
 ;;=4^446.5
 ;;^UTILITY(U,$J,358.3,4293,2)
 ;;=Temporal Arteritis^117658
 ;;^UTILITY(U,$J,358.3,4294,0)
 ;;=401.9^^39^300^12
 ;;^UTILITY(U,$J,358.3,4294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4294,1,3,0)
 ;;=3^Hypertension
 ;;^UTILITY(U,$J,358.3,4294,1,4,0)
 ;;=4^401.9
 ;;^UTILITY(U,$J,358.3,4294,2)
 ;;=Hypertension^186630
 ;;^UTILITY(U,$J,358.3,4295,0)
 ;;=V72.0^^39^300^9
 ;;^UTILITY(U,$J,358.3,4295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4295,1,3,0)
 ;;=3^Eye Exam
 ;;^UTILITY(U,$J,358.3,4295,1,4,0)
 ;;=4^V72.0
 ;;^UTILITY(U,$J,358.3,4295,2)
 ;;=Eye Exam^43432
 ;;^UTILITY(U,$J,358.3,4296,0)
 ;;=V41.0^^39^300^19
 ;;^UTILITY(U,$J,358.3,4296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4296,1,3,0)
 ;;=3^Problems with Sight
 ;;^UTILITY(U,$J,358.3,4296,1,4,0)
 ;;=4^V41.0
 ;;^UTILITY(U,$J,358.3,4296,2)
 ;;=^295427
 ;;^UTILITY(U,$J,358.3,4297,0)
 ;;=998.59^^39^300^18
 ;;^UTILITY(U,$J,358.3,4297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4297,1,3,0)
 ;;=3^Post Op Infection
 ;;^UTILITY(U,$J,358.3,4297,1,4,0)
 ;;=4^998.59
 ;;^UTILITY(U,$J,358.3,4297,2)
 ;;=Post Op Infection^97081
 ;;^UTILITY(U,$J,358.3,4298,0)
 ;;=365.11^^39^301^15
 ;;^UTILITY(U,$J,358.3,4298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4298,1,3,0)
 ;;=3^Open Angle Glaucoma
 ;;^UTILITY(U,$J,358.3,4298,1,4,0)
 ;;=4^365.11
 ;;^UTILITY(U,$J,358.3,4298,2)
 ;;=Open Angle Glaucoma^51203
 ;;^UTILITY(U,$J,358.3,4299,0)
 ;;=365.12^^39^301^10
 ;;^UTILITY(U,$J,358.3,4299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4299,1,3,0)
 ;;=3^Low Tension Glaucoma
 ;;^UTILITY(U,$J,358.3,4299,1,4,0)
 ;;=4^365.12
 ;;^UTILITY(U,$J,358.3,4299,2)
 ;;=Low Tension Glaucoma^265223
 ;;^UTILITY(U,$J,358.3,4300,0)
 ;;=365.63^^39^301^13
 ;;^UTILITY(U,$J,358.3,4300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4300,1,3,0)
 ;;=3^Neovascular Glaucoma
 ;;^UTILITY(U,$J,358.3,4300,1,4,0)
 ;;=4^365.63
 ;;^UTILITY(U,$J,358.3,4300,2)
 ;;=Neovascular Glaucoma^268778
 ;;^UTILITY(U,$J,358.3,4301,0)
 ;;=365.10^^39^301^17
 ;;^UTILITY(U,$J,358.3,4301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4301,1,3,0)
 ;;=3^Open Angle, Glaucoma Unspec
 ;;^UTILITY(U,$J,358.3,4301,1,4,0)
 ;;=4^365.10
 ;;^UTILITY(U,$J,358.3,4301,2)
 ;;=^51206
 ;;^UTILITY(U,$J,358.3,4302,0)
 ;;=365.13^^39^301^21
 ;;^UTILITY(U,$J,358.3,4302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4302,1,3,0)
 ;;=3^Pigmentary Glaucoma
 ;;^UTILITY(U,$J,358.3,4302,1,4,0)
 ;;=4^365.13
 ;;^UTILITY(U,$J,358.3,4302,2)
 ;;=Pigmentary Glaucoma^51211
 ;;^UTILITY(U,$J,358.3,4303,0)
 ;;=365.20^^39^301^23
 ;;^UTILITY(U,$J,358.3,4303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4303,1,3,0)
 ;;=3^Prim Angle Closure Glaucoma
 ;;^UTILITY(U,$J,358.3,4303,1,4,0)
 ;;=4^365.20
 ;;^UTILITY(U,$J,358.3,4303,2)
 ;;=^51195
 ;;^UTILITY(U,$J,358.3,4304,0)
 ;;=365.52^^39^301^24
 ;;^UTILITY(U,$J,358.3,4304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4304,1,3,0)
 ;;=3^Pseudoexfoliation Glaucoma
 ;;^UTILITY(U,$J,358.3,4304,1,4,0)
 ;;=4^365.52
 ;;^UTILITY(U,$J,358.3,4304,2)
 ;;=Pseudoexfoliation Glaucoma^268771
 ;;^UTILITY(U,$J,358.3,4305,0)
 ;;=365.15^^39^301^27
 ;;^UTILITY(U,$J,358.3,4305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4305,1,3,0)
 ;;=3^Residual Open Angle Glaucoma
 ;;^UTILITY(U,$J,358.3,4305,1,4,0)
 ;;=4^365.15
 ;;^UTILITY(U,$J,358.3,4305,2)
 ;;=Residual Open Angle Glaucoma^268751
 ;;^UTILITY(U,$J,358.3,4306,0)
 ;;=365.31^^39^301^31
 ;;^UTILITY(U,$J,358.3,4306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4306,1,3,0)
 ;;=3^Steroid Induced Glaucoma
 ;;^UTILITY(U,$J,358.3,4306,1,4,0)
 ;;=4^365.31
 ;;^UTILITY(U,$J,358.3,4306,2)
 ;;=Steroid Induced Glaucoma^268761
 ;;^UTILITY(U,$J,358.3,4307,0)
 ;;=365.61^^39^301^8
 ;;^UTILITY(U,$J,358.3,4307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4307,1,3,0)
 ;;=3^Glaucoma W/Pupillary Block
 ;;^UTILITY(U,$J,358.3,4307,1,4,0)
 ;;=4^365.61
 ;;^UTILITY(U,$J,358.3,4307,2)
 ;;=Glaucoma W/Pupillary Block^268776
 ;;^UTILITY(U,$J,358.3,4308,0)
 ;;=365.23^^39^301^4
 ;;^UTILITY(U,$J,358.3,4308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4308,1,3,0)
 ;;=3^Chronic Angle Clos Glaucoma
 ;;^UTILITY(U,$J,358.3,4308,1,4,0)
 ;;=4^365.23
 ;;^UTILITY(U,$J,358.3,4308,2)
 ;;=^268756
 ;;^UTILITY(U,$J,358.3,4309,0)
 ;;=363.71^^39^301^29
 ;;^UTILITY(U,$J,358.3,4309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4309,1,3,0)
 ;;=3^Serous Choroidal Detachment
 ;;^UTILITY(U,$J,358.3,4309,1,4,0)
 ;;=4^363.71
 ;;^UTILITY(U,$J,358.3,4309,2)
 ;;=Choroidal Detachment^268699
 ;;^UTILITY(U,$J,358.3,4310,0)
 ;;=365.51^^39^301^19
 ;;^UTILITY(U,$J,358.3,4310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4310,1,3,0)
 ;;=3^Phacolytic Glaucoma
 ;;^UTILITY(U,$J,358.3,4310,1,4,0)
 ;;=4^365.51
 ;;^UTILITY(U,$J,358.3,4310,2)
 ;;=Phacolytic Glaucoma^265226
 ;;^UTILITY(U,$J,358.3,4311,0)
 ;;=365.01^^39^301^16
 ;;^UTILITY(U,$J,358.3,4311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4311,1,3,0)
 ;;=3^Open Angle Glaucoma Suspect
 ;;^UTILITY(U,$J,358.3,4311,1,4,0)
 ;;=4^365.01
 ;;^UTILITY(U,$J,358.3,4311,2)
 ;;=Open Angle Glaucoma Suspect^268747
 ;;^UTILITY(U,$J,358.3,4312,0)
 ;;=365.04^^39^301^14
 ;;^UTILITY(U,$J,358.3,4312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4312,1,3,0)
 ;;=3^Ocular Hypertension
 ;;^UTILITY(U,$J,358.3,4312,1,4,0)
 ;;=4^365.04
 ;;^UTILITY(U,$J,358.3,4312,2)
 ;;=Ocular Hypertension^85124
 ;;^UTILITY(U,$J,358.3,4313,0)
 ;;=365.03^^39^301^32
 ;;^UTILITY(U,$J,358.3,4313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4313,1,3,0)
 ;;=3^Steroid Responder
 ;;^UTILITY(U,$J,358.3,4313,1,4,0)
 ;;=4^365.03
 ;;^UTILITY(U,$J,358.3,4313,2)
 ;;=^268749
 ;;^UTILITY(U,$J,358.3,4314,0)
 ;;=366.11^^39^301^25
 ;;^UTILITY(U,$J,358.3,4314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4314,1,3,0)
 ;;=3^Pseudoexfoliation w/o Glaucoma
 ;;^UTILITY(U,$J,358.3,4314,1,4,0)
 ;;=4^366.11
 ;;^UTILITY(U,$J,358.3,4314,2)
 ;;=^265538
 ;;^UTILITY(U,$J,358.3,4315,0)
 ;;=365.02^^39^301^1
 ;;^UTILITY(U,$J,358.3,4315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4315,1,3,0)
 ;;=3^Anatomic Narrow Angle
 ;;^UTILITY(U,$J,358.3,4315,1,4,0)
 ;;=4^365.02
 ;;^UTILITY(U,$J,358.3,4315,2)
 ;;=Anatomic Narrow Angle^268748
 ;;^UTILITY(U,$J,358.3,4316,0)
 ;;=364.53^^39^301^20
 ;;^UTILITY(U,$J,358.3,4316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4316,1,3,0)
 ;;=3^Pigment Dispersion w/o Glauc
 ;;^UTILITY(U,$J,358.3,4316,1,4,0)
 ;;=4^364.53
 ;;^UTILITY(U,$J,358.3,4316,2)
 ;;=^268720
 ;;^UTILITY(U,$J,358.3,4317,0)
 ;;=364.42^^39^301^28
 ;;^UTILITY(U,$J,358.3,4317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4317,1,3,0)
 ;;=3^Rubeosis Iridis w/o Glaucoma
 ;;^UTILITY(U,$J,358.3,4317,1,4,0)
 ;;=4^364.42
 ;;^UTILITY(U,$J,358.3,4317,2)
 ;;=Rubeosis Iridis w/o Glaucoma^268716
 ;;^UTILITY(U,$J,358.3,4318,0)
 ;;=364.77^^39^301^2
 ;;^UTILITY(U,$J,358.3,4318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4318,1,3,0)
 ;;=3^Angle Recession w/o Glauc
