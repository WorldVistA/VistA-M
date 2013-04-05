IBDEI07C ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9648,1,3,0)
 ;;=3^Choroidal Detachment
 ;;^UTILITY(U,$J,358.3,9648,1,4,0)
 ;;=4^363.70
 ;;^UTILITY(U,$J,358.3,9648,2)
 ;;=Choroidal Detachment^276841
 ;;^UTILITY(U,$J,358.3,9649,0)
 ;;=363.63^^77^659^11
 ;;^UTILITY(U,$J,358.3,9649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9649,1,3,0)
 ;;=3^Choroidal Rupture
 ;;^UTILITY(U,$J,358.3,9649,1,4,0)
 ;;=4^363.63
 ;;^UTILITY(U,$J,358.3,9649,2)
 ;;=Choroidal Rupture^268698
 ;;^UTILITY(U,$J,358.3,9650,0)
 ;;=379.22^^77^659^3
 ;;^UTILITY(U,$J,358.3,9650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9650,1,3,0)
 ;;=3^Asteroid Hyalosis
 ;;^UTILITY(U,$J,358.3,9650,1,4,0)
 ;;=4^379.22
 ;;^UTILITY(U,$J,358.3,9650,2)
 ;;=Asteroid Hyalosis^269310
 ;;^UTILITY(U,$J,358.3,9651,0)
 ;;=379.21^^77^659^57
 ;;^UTILITY(U,$J,358.3,9651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9651,1,3,0)
 ;;=3^Vitreous Detachment/Degeneration (Pvd)
 ;;^UTILITY(U,$J,358.3,9651,1,4,0)
 ;;=4^379.21
 ;;^UTILITY(U,$J,358.3,9651,2)
 ;;=Vitreous Detachment/Degeneration^88242
 ;;^UTILITY(U,$J,358.3,9652,0)
 ;;=379.24^^77^659^58
 ;;^UTILITY(U,$J,358.3,9652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9652,1,3,0)
 ;;=3^Vitreous Floaters
 ;;^UTILITY(U,$J,358.3,9652,1,4,0)
 ;;=4^379.24
 ;;^UTILITY(U,$J,358.3,9652,2)
 ;;=Vitreous Floaters^88242
 ;;^UTILITY(U,$J,358.3,9653,0)
 ;;=379.26^^77^659^60
 ;;^UTILITY(U,$J,358.3,9653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9653,1,3,0)
 ;;=3^Vitreous Prolapse
 ;;^UTILITY(U,$J,358.3,9653,1,4,0)
 ;;=4^379.26
 ;;^UTILITY(U,$J,358.3,9653,2)
 ;;=Vitreous Prolapse^269312
 ;;^UTILITY(U,$J,358.3,9654,0)
 ;;=379.23^^77^659^59
 ;;^UTILITY(U,$J,358.3,9654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9654,1,3,0)
 ;;=3^Vitreous Hemorrhage
 ;;^UTILITY(U,$J,358.3,9654,1,4,0)
 ;;=4^379.23
 ;;^UTILITY(U,$J,358.3,9654,2)
 ;;=Vitreous Hemorrhage^127096
 ;;^UTILITY(U,$J,358.3,9655,0)
 ;;=362.18^^77^659^47
 ;;^UTILITY(U,$J,358.3,9655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9655,1,3,0)
 ;;=3^Retinal Vasculitis
 ;;^UTILITY(U,$J,358.3,9655,1,4,0)
 ;;=4^362.18
 ;;^UTILITY(U,$J,358.3,9655,2)
 ;;=Retinal Vasculitis^264463
 ;;^UTILITY(U,$J,358.3,9656,0)
 ;;=360.21^^77^659^19
 ;;^UTILITY(U,$J,358.3,9656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9656,1,3,0)
 ;;=3^Degenerative Myopia
 ;;^UTILITY(U,$J,358.3,9656,1,4,0)
 ;;=4^360.21
 ;;^UTILITY(U,$J,358.3,9656,2)
 ;;=Degenerative Myopia^268553
 ;;^UTILITY(U,$J,358.3,9657,0)
 ;;=362.64^^77^659^43
 ;;^UTILITY(U,$J,358.3,9657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9657,1,3,0)
 ;;=3^Reticular Degeneration
 ;;^UTILITY(U,$J,358.3,9657,1,4,0)
 ;;=4^362.64
 ;;^UTILITY(U,$J,358.3,9657,2)
 ;;=Reticular Degeneration^268645
 ;;^UTILITY(U,$J,358.3,9658,0)
 ;;=362.61^^77^659^17
 ;;^UTILITY(U,$J,358.3,9658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9658,1,3,0)
 ;;=3^Degeneration, Paving Stone
 ;;^UTILITY(U,$J,358.3,9658,1,4,0)
 ;;=4^362.61
 ;;^UTILITY(U,$J,358.3,9658,2)
 ;;=Paving Stone Degeneration^268642
 ;;^UTILITY(U,$J,358.3,9659,0)
 ;;=362.42^^77^659^51
 ;;^UTILITY(U,$J,358.3,9659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9659,1,3,0)
 ;;=3^Rpe Detachment, Serous
 ;;^UTILITY(U,$J,358.3,9659,1,4,0)
 ;;=4^362.42
 ;;^UTILITY(U,$J,358.3,9659,2)
 ;;=Serous RPE Detachment^268633
 ;;^UTILITY(U,$J,358.3,9660,0)
 ;;=362.43^^77^659^50
 ;;^UTILITY(U,$J,358.3,9660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9660,1,3,0)
 ;;=3^Rpe Detachment, Hemorrhagic
 ;;^UTILITY(U,$J,358.3,9660,1,4,0)
 ;;=4^362.43
 ;;^UTILITY(U,$J,358.3,9660,2)
 ;;=Hemorrhagic RPE Detachment^268634
 ;;^UTILITY(U,$J,358.3,9661,0)
 ;;=250.00^^77^659^22
 ;;^UTILITY(U,$J,358.3,9661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9661,1,3,0)
 ;;=3^Dm Type II, No Retinopathy
 ;;^UTILITY(U,$J,358.3,9661,1,4,0)
 ;;=4^250.00
 ;;^UTILITY(U,$J,358.3,9661,2)
 ;;=DM Type II, No Retinopathy^33605
 ;;^UTILITY(U,$J,358.3,9662,0)
 ;;=250.01^^77^659^21
 ;;^UTILITY(U,$J,358.3,9662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9662,1,3,0)
 ;;=3^Dm Type I, No Retinopathy
 ;;^UTILITY(U,$J,358.3,9662,1,4,0)
 ;;=4^250.01
 ;;^UTILITY(U,$J,358.3,9662,2)
 ;;=DM Type I, No Retinopathy^33586
 ;;^UTILITY(U,$J,358.3,9663,0)
 ;;=250.50^^77^659^15
 ;;^UTILITY(U,$J,358.3,9663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9663,1,3,0)
 ;;=3^Csme In DM Type II
 ;;^UTILITY(U,$J,358.3,9663,1,4,0)
 ;;=4^250.50
 ;;^UTILITY(U,$J,358.3,9663,2)
 ;;=CSME in DM type II^267839^362.83
 ;;^UTILITY(U,$J,358.3,9664,0)
 ;;=250.51^^77^659^14
 ;;^UTILITY(U,$J,358.3,9664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9664,1,3,0)
 ;;=3^Csme In Dm Type I
 ;;^UTILITY(U,$J,358.3,9664,1,4,0)
 ;;=4^250.51
 ;;^UTILITY(U,$J,358.3,9664,2)
 ;;=CSME in DM Type I^267840^362.83
 ;;^UTILITY(U,$J,358.3,9665,0)
 ;;=362.01^^77^659^20
 ;;^UTILITY(U,$J,358.3,9665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9665,1,3,0)
 ;;=3^Diabetic Retinopathy Nos
 ;;^UTILITY(U,$J,358.3,9665,1,4,0)
 ;;=4^362.01
 ;;^UTILITY(U,$J,358.3,9665,2)
 ;;=^12257
 ;;^UTILITY(U,$J,358.3,9666,0)
 ;;=362.02^^77^659^40
 ;;^UTILITY(U,$J,358.3,9666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9666,1,3,0)
 ;;=3^Prolif Diab Retinopathy
 ;;^UTILITY(U,$J,358.3,9666,1,4,0)
 ;;=4^362.02
 ;;^UTILITY(U,$J,358.3,9666,2)
 ;;=^268610
 ;;^UTILITY(U,$J,358.3,9667,0)
 ;;=362.03^^77^659^36
 ;;^UTILITY(U,$J,358.3,9667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9667,1,3,0)
 ;;=3^Nonprolf Db Retnoph Nos
 ;;^UTILITY(U,$J,358.3,9667,1,4,0)
 ;;=4^362.03
 ;;^UTILITY(U,$J,358.3,9667,2)
 ;;=^332786
 ;;^UTILITY(U,$J,358.3,9668,0)
 ;;=362.04^^77^659^33
 ;;^UTILITY(U,$J,358.3,9668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9668,1,3,0)
 ;;=3^Mild Nonprolf Db Retnoph
 ;;^UTILITY(U,$J,358.3,9668,1,4,0)
 ;;=4^362.04
 ;;^UTILITY(U,$J,358.3,9668,2)
 ;;=^332787
 ;;^UTILITY(U,$J,358.3,9669,0)
 ;;=362.05^^77^659^34
 ;;^UTILITY(U,$J,358.3,9669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9669,1,3,0)
 ;;=3^Mod Nonprolf Db Retinoph
 ;;^UTILITY(U,$J,358.3,9669,1,4,0)
 ;;=4^362.05
 ;;^UTILITY(U,$J,358.3,9669,2)
 ;;=^332788
 ;;^UTILITY(U,$J,358.3,9670,0)
 ;;=362.06^^77^659^52
 ;;^UTILITY(U,$J,358.3,9670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9670,1,3,0)
 ;;=3^Sev Nonprolf Db Retinoph
 ;;^UTILITY(U,$J,358.3,9670,1,4,0)
 ;;=4^362.06
 ;;^UTILITY(U,$J,358.3,9670,2)
 ;;=^332789
 ;;^UTILITY(U,$J,358.3,9671,0)
 ;;=379.27^^77^659^56
 ;;^UTILITY(U,$J,358.3,9671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9671,1,3,0)
 ;;=3^Vitreomacular Adhesion
 ;;^UTILITY(U,$J,358.3,9671,1,4,0)
 ;;=4^379.27
 ;;^UTILITY(U,$J,358.3,9671,2)
 ;;=^340517
 ;;^UTILITY(U,$J,358.3,9672,0)
 ;;=377.41^^77^660^23
 ;;^UTILITY(U,$J,358.3,9672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9672,1,3,0)
 ;;=3^Optic Neuropathy, Ischemic
 ;;^UTILITY(U,$J,358.3,9672,1,4,0)
 ;;=4^377.41
 ;;^UTILITY(U,$J,358.3,9672,2)
 ;;=Optic Neuropathy, Ischemic^269231
 ;;^UTILITY(U,$J,358.3,9673,0)
 ;;=377.21^^77^660^20
 ;;^UTILITY(U,$J,358.3,9673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9673,1,3,0)
 ;;=3^Drusen (ONH)
 ;;^UTILITY(U,$J,358.3,9673,1,4,0)
 ;;=4^377.21
 ;;^UTILITY(U,$J,358.3,9673,2)
 ;;=^269221
 ;;^UTILITY(U,$J,358.3,9674,0)
 ;;=377.10^^77^660^21
 ;;^UTILITY(U,$J,358.3,9674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9674,1,3,0)
 ;;=3^Optic Atrophy
 ;;^UTILITY(U,$J,358.3,9674,1,4,0)
 ;;=4^377.10
 ;;^UTILITY(U,$J,358.3,9674,2)
 ;;=^85926
 ;;^UTILITY(U,$J,358.3,9675,0)
 ;;=377.30^^77^660^22
 ;;^UTILITY(U,$J,358.3,9675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9675,1,3,0)
 ;;=3^Optic Neuritis
 ;;^UTILITY(U,$J,358.3,9675,1,4,0)
 ;;=4^377.30
 ;;^UTILITY(U,$J,358.3,9675,2)
 ;;=^86002
 ;;^UTILITY(U,$J,358.3,9676,0)
 ;;=377.01^^77^660^24
 ;;^UTILITY(U,$J,358.3,9676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9676,1,3,0)
 ;;=3^Papilledema
 ;;^UTILITY(U,$J,358.3,9676,1,4,0)
 ;;=4^377.01
 ;;^UTILITY(U,$J,358.3,9676,2)
 ;;=Papilledema Associated with Increased Intracranial Pressure^269212
 ;;^UTILITY(U,$J,358.3,9677,0)
 ;;=368.40^^77^660^18
 ;;^UTILITY(U,$J,358.3,9677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9677,1,3,0)
 ;;=3^Visual Field Defect
 ;;^UTILITY(U,$J,358.3,9677,1,4,0)
 ;;=4^368.40
 ;;^UTILITY(U,$J,358.3,9677,2)
 ;;=Visual Field Defect^126859
 ;;^UTILITY(U,$J,358.3,9678,0)
 ;;=379.40^^77^660^16
 ;;^UTILITY(U,$J,358.3,9678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9678,1,3,0)
 ;;=3^Pupil, Abnormal Function
 ;;^UTILITY(U,$J,358.3,9678,1,4,0)
 ;;=4^379.40
 ;;^UTILITY(U,$J,358.3,9678,2)
 ;;=Pupil, Abnormal Function^101288
 ;;^UTILITY(U,$J,358.3,9679,0)
 ;;=362.34^^77^660^1
 ;;^UTILITY(U,$J,358.3,9679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9679,1,3,0)
 ;;=3^Amaurosis Fugax
 ;;^UTILITY(U,$J,358.3,9679,1,4,0)
 ;;=4^362.34
 ;;^UTILITY(U,$J,358.3,9679,2)
 ;;=Amaurosis Fugax^268622
 ;;^UTILITY(U,$J,358.3,9680,0)
 ;;=351.0^^77^660^2
 ;;^UTILITY(U,$J,358.3,9680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9680,1,3,0)
 ;;=3^Bell's Palsy
 ;;^UTILITY(U,$J,358.3,9680,1,4,0)
 ;;=4^351.0
 ;;^UTILITY(U,$J,358.3,9680,2)
 ;;=Bell's Palsy^13238
 ;;^UTILITY(U,$J,358.3,9681,0)
 ;;=333.81^^77^660^3
 ;;^UTILITY(U,$J,358.3,9681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9681,1,3,0)
 ;;=3^Blepharospasm
 ;;^UTILITY(U,$J,358.3,9681,1,4,0)
 ;;=4^333.81
 ;;^UTILITY(U,$J,358.3,9681,2)
 ;;=Blepharospasm^15293
 ;;^UTILITY(U,$J,358.3,9682,0)
 ;;=437.9^^77^660^4
 ;;^UTILITY(U,$J,358.3,9682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9682,1,3,0)
 ;;=3^Cerebrovascular Dis
 ;;^UTILITY(U,$J,358.3,9682,1,4,0)
 ;;=4^437.9
 ;;^UTILITY(U,$J,358.3,9682,2)
 ;;=Cerebrovascular Dis^21803
 ;;^UTILITY(U,$J,358.3,9683,0)
 ;;=368.2^^77^660^5
 ;;^UTILITY(U,$J,358.3,9683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9683,1,3,0)
 ;;=3^Diplopia
 ;;^UTILITY(U,$J,358.3,9683,1,4,0)
 ;;=4^368.2
 ;;^UTILITY(U,$J,358.3,9683,2)
 ;;=Diplopia^35208
 ;;^UTILITY(U,$J,358.3,9684,0)
 ;;=378.53^^77^660^27
 ;;^UTILITY(U,$J,358.3,9684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9684,1,3,0)
 ;;=3^Fourth Nerve Paresis
