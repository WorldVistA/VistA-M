IBDEI03D ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4210,1,3,0)
 ;;=3^Old Retinal Detachment, Partial
 ;;^UTILITY(U,$J,358.3,4210,1,4,0)
 ;;=4^361.06
 ;;^UTILITY(U,$J,358.3,4210,2)
 ;;=Old Retinal Detachment, Part^268591
 ;;^UTILITY(U,$J,358.3,4211,0)
 ;;=361.07^^39^298^38
 ;;^UTILITY(U,$J,358.3,4211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4211,1,3,0)
 ;;=3^Old Retinal Detacment, Total
 ;;^UTILITY(U,$J,358.3,4211,1,4,0)
 ;;=4^361.07
 ;;^UTILITY(U,$J,358.3,4211,2)
 ;;=Old Retinal Detacment, Total^268592
 ;;^UTILITY(U,$J,358.3,4212,0)
 ;;=362.57^^39^298^23
 ;;^UTILITY(U,$J,358.3,4212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4212,1,3,0)
 ;;=3^Drusen
 ;;^UTILITY(U,$J,358.3,4212,1,4,0)
 ;;=4^362.57
 ;;^UTILITY(U,$J,358.3,4212,2)
 ;;=Drusen^105561
 ;;^UTILITY(U,$J,358.3,4213,0)
 ;;=362.55^^39^298^55
 ;;^UTILITY(U,$J,358.3,4213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4213,1,3,0)
 ;;=3^Toxic Maculopathy
 ;;^UTILITY(U,$J,358.3,4213,1,4,0)
 ;;=4^362.55
 ;;^UTILITY(U,$J,358.3,4213,2)
 ;;=Toxic Maculopathy^268640
 ;;^UTILITY(U,$J,358.3,4214,0)
 ;;=363.31^^39^298^53
 ;;^UTILITY(U,$J,358.3,4214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4214,1,3,0)
 ;;=3^Solar Retinopathy
 ;;^UTILITY(U,$J,358.3,4214,1,4,0)
 ;;=4^363.31
 ;;^UTILITY(U,$J,358.3,4214,2)
 ;;=Solar Retinopathy^265207
 ;;^UTILITY(U,$J,358.3,4215,0)
 ;;=363.32^^39^298^32
 ;;^UTILITY(U,$J,358.3,4215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4215,1,3,0)
 ;;=3^Macular Scars
 ;;^UTILITY(U,$J,358.3,4215,1,4,0)
 ;;=4^363.32
 ;;^UTILITY(U,$J,358.3,4215,2)
 ;;=Macular Scars^268680
 ;;^UTILITY(U,$J,358.3,4216,0)
 ;;=362.83^^39^298^29
 ;;^UTILITY(U,$J,358.3,4216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4216,1,3,0)
 ;;=3^Macular Edema (Csme)
 ;;^UTILITY(U,$J,358.3,4216,1,4,0)
 ;;=4^362.83
 ;;^UTILITY(U,$J,358.3,4216,2)
 ;;=Macular Edema (CSME)^89576
 ;;^UTILITY(U,$J,358.3,4217,0)
 ;;=362.84^^39^298^46
 ;;^UTILITY(U,$J,358.3,4217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4217,1,3,0)
 ;;=3^Retinal Ischemia
 ;;^UTILITY(U,$J,358.3,4217,1,4,0)
 ;;=4^362.84
 ;;^UTILITY(U,$J,358.3,4217,2)
 ;;=Retinal Ischemia^276868
 ;;^UTILITY(U,$J,358.3,4218,0)
 ;;=363.20^^39^298^8
 ;;^UTILITY(U,$J,358.3,4218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4218,1,3,0)
 ;;=3^Chorioretinitis
 ;;^UTILITY(U,$J,358.3,4218,1,4,0)
 ;;=4^363.20
 ;;^UTILITY(U,$J,358.3,4218,2)
 ;;=Chorioretinitis^23913
 ;;^UTILITY(U,$J,358.3,4219,0)
 ;;=115.92^^39^298^24
 ;;^UTILITY(U,$J,358.3,4219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4219,1,3,0)
 ;;=3^Histoplamosis (Pohs)
 ;;^UTILITY(U,$J,358.3,4219,1,4,0)
 ;;=4^115.92
 ;;^UTILITY(U,$J,358.3,4219,2)
 ;;=Histoplamosis Retinitis^266905
 ;;^UTILITY(U,$J,358.3,4220,0)
 ;;=363.70^^39^298^9
 ;;^UTILITY(U,$J,358.3,4220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4220,1,3,0)
 ;;=3^Choroidal Detachment
 ;;^UTILITY(U,$J,358.3,4220,1,4,0)
 ;;=4^363.70
 ;;^UTILITY(U,$J,358.3,4220,2)
 ;;=Choroidal Detachment^276841
 ;;^UTILITY(U,$J,358.3,4221,0)
 ;;=363.63^^39^298^11
 ;;^UTILITY(U,$J,358.3,4221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4221,1,3,0)
 ;;=3^Choroidal Rupture
 ;;^UTILITY(U,$J,358.3,4221,1,4,0)
 ;;=4^363.63
 ;;^UTILITY(U,$J,358.3,4221,2)
 ;;=Choroidal Rupture^268698
 ;;^UTILITY(U,$J,358.3,4222,0)
 ;;=379.22^^39^298^3
 ;;^UTILITY(U,$J,358.3,4222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4222,1,3,0)
 ;;=3^Asteroid Hyalosis
 ;;^UTILITY(U,$J,358.3,4222,1,4,0)
 ;;=4^379.22
 ;;^UTILITY(U,$J,358.3,4222,2)
 ;;=Asteroid Hyalosis^269310
 ;;^UTILITY(U,$J,358.3,4223,0)
 ;;=379.21^^39^298^57
 ;;^UTILITY(U,$J,358.3,4223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4223,1,3,0)
 ;;=3^Vitreous Detachment/Degeneration (Pvd)
 ;;^UTILITY(U,$J,358.3,4223,1,4,0)
 ;;=4^379.21
 ;;^UTILITY(U,$J,358.3,4223,2)
 ;;=Vitreous Detachment/Degeneration^88242
 ;;^UTILITY(U,$J,358.3,4224,0)
 ;;=379.24^^39^298^58
 ;;^UTILITY(U,$J,358.3,4224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4224,1,3,0)
 ;;=3^Vitreous Floaters
 ;;^UTILITY(U,$J,358.3,4224,1,4,0)
 ;;=4^379.24
 ;;^UTILITY(U,$J,358.3,4224,2)
 ;;=Vitreous Floaters^88242
 ;;^UTILITY(U,$J,358.3,4225,0)
 ;;=379.26^^39^298^60
 ;;^UTILITY(U,$J,358.3,4225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4225,1,3,0)
 ;;=3^Vitreous Prolapse
 ;;^UTILITY(U,$J,358.3,4225,1,4,0)
 ;;=4^379.26
 ;;^UTILITY(U,$J,358.3,4225,2)
 ;;=Vitreous Prolapse^269312
 ;;^UTILITY(U,$J,358.3,4226,0)
 ;;=379.23^^39^298^59
 ;;^UTILITY(U,$J,358.3,4226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4226,1,3,0)
 ;;=3^Vitreous Hemorrhage
 ;;^UTILITY(U,$J,358.3,4226,1,4,0)
 ;;=4^379.23
 ;;^UTILITY(U,$J,358.3,4226,2)
 ;;=Vitreous Hemorrhage^127096
 ;;^UTILITY(U,$J,358.3,4227,0)
 ;;=362.18^^39^298^47
 ;;^UTILITY(U,$J,358.3,4227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4227,1,3,0)
 ;;=3^Retinal Vasculitis
 ;;^UTILITY(U,$J,358.3,4227,1,4,0)
 ;;=4^362.18
 ;;^UTILITY(U,$J,358.3,4227,2)
 ;;=Retinal Vasculitis^264463
 ;;^UTILITY(U,$J,358.3,4228,0)
 ;;=360.21^^39^298^19
 ;;^UTILITY(U,$J,358.3,4228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4228,1,3,0)
 ;;=3^Degenerative Myopia
 ;;^UTILITY(U,$J,358.3,4228,1,4,0)
 ;;=4^360.21
 ;;^UTILITY(U,$J,358.3,4228,2)
 ;;=Degenerative Myopia^268553
 ;;^UTILITY(U,$J,358.3,4229,0)
 ;;=362.64^^39^298^43
 ;;^UTILITY(U,$J,358.3,4229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4229,1,3,0)
 ;;=3^Reticular Degeneration
 ;;^UTILITY(U,$J,358.3,4229,1,4,0)
 ;;=4^362.64
 ;;^UTILITY(U,$J,358.3,4229,2)
 ;;=Reticular Degeneration^268645
 ;;^UTILITY(U,$J,358.3,4230,0)
 ;;=362.61^^39^298^17
 ;;^UTILITY(U,$J,358.3,4230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4230,1,3,0)
 ;;=3^Degeneration, Paving Stone
 ;;^UTILITY(U,$J,358.3,4230,1,4,0)
 ;;=4^362.61
 ;;^UTILITY(U,$J,358.3,4230,2)
 ;;=Paving Stone Degeneration^268642
 ;;^UTILITY(U,$J,358.3,4231,0)
 ;;=362.42^^39^298^51
 ;;^UTILITY(U,$J,358.3,4231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4231,1,3,0)
 ;;=3^Rpe Detachment, Serous
 ;;^UTILITY(U,$J,358.3,4231,1,4,0)
 ;;=4^362.42
 ;;^UTILITY(U,$J,358.3,4231,2)
 ;;=Serous RPE Detachment^268633
 ;;^UTILITY(U,$J,358.3,4232,0)
 ;;=362.43^^39^298^50
 ;;^UTILITY(U,$J,358.3,4232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4232,1,3,0)
 ;;=3^Rpe Detachment, Hemorrhagic
 ;;^UTILITY(U,$J,358.3,4232,1,4,0)
 ;;=4^362.43
 ;;^UTILITY(U,$J,358.3,4232,2)
 ;;=Hemorrhagic RPE Detachment^268634
 ;;^UTILITY(U,$J,358.3,4233,0)
 ;;=250.00^^39^298^22
 ;;^UTILITY(U,$J,358.3,4233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4233,1,3,0)
 ;;=3^Dm Type II, No Retinopathy
 ;;^UTILITY(U,$J,358.3,4233,1,4,0)
 ;;=4^250.00
 ;;^UTILITY(U,$J,358.3,4233,2)
 ;;=DM Type II, No Retinopathy^33605
 ;;^UTILITY(U,$J,358.3,4234,0)
 ;;=250.01^^39^298^21
 ;;^UTILITY(U,$J,358.3,4234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4234,1,3,0)
 ;;=3^Dm Type I, No Retinopathy
 ;;^UTILITY(U,$J,358.3,4234,1,4,0)
 ;;=4^250.01
 ;;^UTILITY(U,$J,358.3,4234,2)
 ;;=DM Type I, No Retinopathy^33586
 ;;^UTILITY(U,$J,358.3,4235,0)
 ;;=250.50^^39^298^15
 ;;^UTILITY(U,$J,358.3,4235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4235,1,3,0)
 ;;=3^Csme In DM Type II
 ;;^UTILITY(U,$J,358.3,4235,1,4,0)
 ;;=4^250.50
 ;;^UTILITY(U,$J,358.3,4235,2)
 ;;=CSME in DM type II^267839^362.83
 ;;^UTILITY(U,$J,358.3,4236,0)
 ;;=250.51^^39^298^14
 ;;^UTILITY(U,$J,358.3,4236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4236,1,3,0)
 ;;=3^Csme In Dm Type I
 ;;^UTILITY(U,$J,358.3,4236,1,4,0)
 ;;=4^250.51
 ;;^UTILITY(U,$J,358.3,4236,2)
 ;;=CSME in DM Type I^267840^362.83
 ;;^UTILITY(U,$J,358.3,4237,0)
 ;;=362.01^^39^298^20
 ;;^UTILITY(U,$J,358.3,4237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4237,1,3,0)
 ;;=3^Diabetic Retinopathy Nos
 ;;^UTILITY(U,$J,358.3,4237,1,4,0)
 ;;=4^362.01
 ;;^UTILITY(U,$J,358.3,4237,2)
 ;;=^12257
 ;;^UTILITY(U,$J,358.3,4238,0)
 ;;=362.02^^39^298^40
 ;;^UTILITY(U,$J,358.3,4238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4238,1,3,0)
 ;;=3^Prolif Diab Retinopathy
 ;;^UTILITY(U,$J,358.3,4238,1,4,0)
 ;;=4^362.02
 ;;^UTILITY(U,$J,358.3,4238,2)
 ;;=^268610
 ;;^UTILITY(U,$J,358.3,4239,0)
 ;;=362.03^^39^298^36
 ;;^UTILITY(U,$J,358.3,4239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4239,1,3,0)
 ;;=3^Nonprolf Db Retnoph Nos
 ;;^UTILITY(U,$J,358.3,4239,1,4,0)
 ;;=4^362.03
 ;;^UTILITY(U,$J,358.3,4239,2)
 ;;=^332786
 ;;^UTILITY(U,$J,358.3,4240,0)
 ;;=362.04^^39^298^33
 ;;^UTILITY(U,$J,358.3,4240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4240,1,3,0)
 ;;=3^Mild Nonprolf Db Retnoph
 ;;^UTILITY(U,$J,358.3,4240,1,4,0)
 ;;=4^362.04
 ;;^UTILITY(U,$J,358.3,4240,2)
 ;;=^332787
 ;;^UTILITY(U,$J,358.3,4241,0)
 ;;=362.05^^39^298^34
 ;;^UTILITY(U,$J,358.3,4241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4241,1,3,0)
 ;;=3^Mod Nonprolf Db Retinoph
 ;;^UTILITY(U,$J,358.3,4241,1,4,0)
 ;;=4^362.05
 ;;^UTILITY(U,$J,358.3,4241,2)
 ;;=^332788
 ;;^UTILITY(U,$J,358.3,4242,0)
 ;;=362.06^^39^298^52
 ;;^UTILITY(U,$J,358.3,4242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4242,1,3,0)
 ;;=3^Sev Nonprolf Db Retinoph
 ;;^UTILITY(U,$J,358.3,4242,1,4,0)
 ;;=4^362.06
 ;;^UTILITY(U,$J,358.3,4242,2)
 ;;=^332789
 ;;^UTILITY(U,$J,358.3,4243,0)
 ;;=379.27^^39^298^56
 ;;^UTILITY(U,$J,358.3,4243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4243,1,3,0)
 ;;=3^Vitreomacular Adhesion
 ;;^UTILITY(U,$J,358.3,4243,1,4,0)
 ;;=4^379.27
 ;;^UTILITY(U,$J,358.3,4243,2)
 ;;=^340517
 ;;^UTILITY(U,$J,358.3,4244,0)
 ;;=377.41^^39^299^23
 ;;^UTILITY(U,$J,358.3,4244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4244,1,3,0)
 ;;=3^Optic Neuropathy, Ischemic
 ;;^UTILITY(U,$J,358.3,4244,1,4,0)
 ;;=4^377.41
 ;;^UTILITY(U,$J,358.3,4244,2)
 ;;=Optic Neuropathy, Ischemic^269231
 ;;^UTILITY(U,$J,358.3,4245,0)
 ;;=377.21^^39^299^20
 ;;^UTILITY(U,$J,358.3,4245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4245,1,3,0)
 ;;=3^Drusen (ONH)
 ;;^UTILITY(U,$J,358.3,4245,1,4,0)
 ;;=4^377.21
 ;;^UTILITY(U,$J,358.3,4245,2)
 ;;=^269221
