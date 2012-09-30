IBDEI03C ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4175,1,4,0)
 ;;=4^366.53
 ;;^UTILITY(U,$J,358.3,4175,2)
 ;;=Post Capsular Fibrosis, Obscuring Vision^268823
 ;;^UTILITY(U,$J,358.3,4176,0)
 ;;=366.11^^39^297^9
 ;;^UTILITY(U,$J,358.3,4176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4176,1,3,0)
 ;;=3^Cataract, Pseudoexfoliation
 ;;^UTILITY(U,$J,358.3,4176,1,4,0)
 ;;=4^366.11
 ;;^UTILITY(U,$J,358.3,4176,2)
 ;;=Pseudoexfoliation^265538
 ;;^UTILITY(U,$J,358.3,4177,0)
 ;;=366.17^^39^297^4
 ;;^UTILITY(U,$J,358.3,4177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4177,1,3,0)
 ;;=3^Cataract, Mature
 ;;^UTILITY(U,$J,358.3,4177,1,4,0)
 ;;=4^366.17
 ;;^UTILITY(U,$J,358.3,4177,2)
 ;;=Mature Cataract^265530
 ;;^UTILITY(U,$J,358.3,4178,0)
 ;;=366.45^^39^297^10
 ;;^UTILITY(U,$J,358.3,4178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4178,1,3,0)
 ;;=3^Cataract, Toxic
 ;;^UTILITY(U,$J,358.3,4178,1,4,0)
 ;;=4^366.45
 ;;^UTILITY(U,$J,358.3,4178,2)
 ;;=Toxic Cataract^268819
 ;;^UTILITY(U,$J,358.3,4179,0)
 ;;=362.53^^39^297^14
 ;;^UTILITY(U,$J,358.3,4179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4179,1,3,0)
 ;;=3^Cystoid Macular Edema (CME)
 ;;^UTILITY(U,$J,358.3,4179,1,4,0)
 ;;=4^362.53
 ;;^UTILITY(U,$J,358.3,4179,2)
 ;;=^268638^996.79
 ;;^UTILITY(U,$J,358.3,4180,0)
 ;;=743.30^^39^297^2
 ;;^UTILITY(U,$J,358.3,4180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4180,1,3,0)
 ;;=3^Cataract, Congenital
 ;;^UTILITY(U,$J,358.3,4180,1,4,0)
 ;;=4^743.30
 ;;^UTILITY(U,$J,358.3,4180,2)
 ;;=Congenital Cataract^27422
 ;;^UTILITY(U,$J,358.3,4181,0)
 ;;=996.53^^39^297^13
 ;;^UTILITY(U,$J,358.3,4181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4181,1,3,0)
 ;;=3^Complication of Lens Implant 
 ;;^UTILITY(U,$J,358.3,4181,1,4,0)
 ;;=4^996.53
 ;;^UTILITY(U,$J,358.3,4181,2)
 ;;=Complication of Lens Implant (dislocation)^276279
 ;;^UTILITY(U,$J,358.3,4182,0)
 ;;=366.9^^39^297^12
 ;;^UTILITY(U,$J,358.3,4182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4182,1,3,0)
 ;;=3^Cataract, Unspecified
 ;;^UTILITY(U,$J,358.3,4182,1,4,0)
 ;;=4^366.9
 ;;^UTILITY(U,$J,358.3,4182,2)
 ;;=^20266
 ;;^UTILITY(U,$J,358.3,4183,0)
 ;;=996.69^^39^297^15
 ;;^UTILITY(U,$J,358.3,4183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4183,1,3,0)
 ;;=3^Post Op Endophthalmitis
 ;;^UTILITY(U,$J,358.3,4183,1,4,0)
 ;;=4^996.69
 ;;^UTILITY(U,$J,358.3,4183,2)
 ;;=Post Op Endophthalmitis^276291
 ;;^UTILITY(U,$J,358.3,4184,0)
 ;;=362.36^^39^298^5
 ;;^UTILITY(U,$J,358.3,4184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4184,1,3,0)
 ;;=3^Brvo/Branch Retinal Vein Occlusion
 ;;^UTILITY(U,$J,358.3,4184,1,4,0)
 ;;=4^362.36
 ;;^UTILITY(U,$J,358.3,4184,2)
 ;;=Branch Retina Vein Occlusion^268626
 ;;^UTILITY(U,$J,358.3,4185,0)
 ;;=362.31^^39^298^12
 ;;^UTILITY(U,$J,358.3,4185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4185,1,3,0)
 ;;=3^Crao/Central Retinal Artery Occlusion
 ;;^UTILITY(U,$J,358.3,4185,1,4,0)
 ;;=4^362.31
 ;;^UTILITY(U,$J,358.3,4185,2)
 ;;=Central Retinal Artery Occulusion^21255
 ;;^UTILITY(U,$J,358.3,4186,0)
 ;;=362.35^^39^298^13
 ;;^UTILITY(U,$J,358.3,4186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4186,1,3,0)
 ;;=3^Crvo/Central Retinal Vein Occlusion
 ;;^UTILITY(U,$J,358.3,4186,1,4,0)
 ;;=4^362.35
 ;;^UTILITY(U,$J,358.3,4186,2)
 ;;=Central Retinal Vein Occlusion^268624
 ;;^UTILITY(U,$J,358.3,4187,0)
 ;;=362.41^^39^298^6
 ;;^UTILITY(U,$J,358.3,4187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4187,1,3,0)
 ;;=3^Central Serous Retinopathy (Csr)
 ;;^UTILITY(U,$J,358.3,4187,1,4,0)
 ;;=4^362.41
 ;;^UTILITY(U,$J,358.3,4187,2)
 ;;=Central Serous Retinopathy^265870
 ;;^UTILITY(U,$J,358.3,4188,0)
 ;;=224.6^^39^298^10
 ;;^UTILITY(U,$J,358.3,4188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4188,1,3,0)
 ;;=3^Choroidal Nevus
 ;;^UTILITY(U,$J,358.3,4188,1,4,0)
 ;;=4^224.6
 ;;^UTILITY(U,$J,358.3,4188,2)
 ;;=Choroidal Nevus^267676
 ;;^UTILITY(U,$J,358.3,4189,0)
 ;;=362.53^^39^298^16
 ;;^UTILITY(U,$J,358.3,4189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4189,1,3,0)
 ;;=3^Cystoid Macular Degeneration/Edema (Cme)
 ;;^UTILITY(U,$J,358.3,4189,1,4,0)
 ;;=4^362.53
 ;;^UTILITY(U,$J,358.3,4189,2)
 ;;=Cystoid Macular Degeneration/Edema^268638
 ;;^UTILITY(U,$J,358.3,4190,0)
 ;;=361.32^^39^298^26
 ;;^UTILITY(U,$J,358.3,4190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4190,1,3,0)
 ;;=3^Horseshoe Tear
 ;;^UTILITY(U,$J,358.3,4190,1,4,0)
 ;;=4^361.32
 ;;^UTILITY(U,$J,358.3,4190,2)
 ;;=^268606
 ;;^UTILITY(U,$J,358.3,4191,0)
 ;;=362.63^^39^298^28
 ;;^UTILITY(U,$J,358.3,4191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4191,1,3,0)
 ;;=3^Lattice Degeneration
 ;;^UTILITY(U,$J,358.3,4191,1,4,0)
 ;;=4^362.63
 ;;^UTILITY(U,$J,358.3,4191,2)
 ;;=^268644
 ;;^UTILITY(U,$J,358.3,4192,0)
 ;;=362.54^^39^298^30
 ;;^UTILITY(U,$J,358.3,4192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4192,1,3,0)
 ;;=3^Macular Hole
 ;;^UTILITY(U,$J,358.3,4192,1,4,0)
 ;;=4^362.54
 ;;^UTILITY(U,$J,358.3,4192,2)
 ;;=^268639
 ;;^UTILITY(U,$J,358.3,4193,0)
 ;;=362.56^^39^298^31
 ;;^UTILITY(U,$J,358.3,4193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4193,1,3,0)
 ;;=3^Macular Pucker/Epiretinal Membrane (Erm)
 ;;^UTILITY(U,$J,358.3,4193,1,4,0)
 ;;=4^362.56
 ;;^UTILITY(U,$J,358.3,4193,2)
 ;;=Macular Puckering^268641
 ;;^UTILITY(U,$J,358.3,4194,0)
 ;;=361.10^^39^298^49
 ;;^UTILITY(U,$J,358.3,4194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4194,1,3,0)
 ;;=3^Retinoschisis
 ;;^UTILITY(U,$J,358.3,4194,1,4,0)
 ;;=4^361.10
 ;;^UTILITY(U,$J,358.3,4194,2)
 ;;=^265856
 ;;^UTILITY(U,$J,358.3,4195,0)
 ;;=362.16^^39^298^48
 ;;^UTILITY(U,$J,358.3,4195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4195,1,3,0)
 ;;=3^Retinal/Subretinal Neovascularization
 ;;^UTILITY(U,$J,358.3,4195,1,4,0)
 ;;=4^362.16
 ;;^UTILITY(U,$J,358.3,4195,2)
 ;;=Subretinal Neovascularization^105601
 ;;^UTILITY(U,$J,358.3,4196,0)
 ;;=362.11^^39^298^27
 ;;^UTILITY(U,$J,358.3,4196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4196,1,3,0)
 ;;=3^Hypertensive Retinopathy
 ;;^UTILITY(U,$J,358.3,4196,1,4,0)
 ;;=4^362.11
 ;;^UTILITY(U,$J,358.3,4196,2)
 ;;=Hypertensive Retinopathy^265209
 ;;^UTILITY(U,$J,358.3,4197,0)
 ;;=363.30^^39^298^7
 ;;^UTILITY(U,$J,358.3,4197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4197,1,3,0)
 ;;=3^Chorioretinal Scar
 ;;^UTILITY(U,$J,358.3,4197,1,4,0)
 ;;=4^363.30
 ;;^UTILITY(U,$J,358.3,4197,2)
 ;;=Chorioretinal Scar^23910
 ;;^UTILITY(U,$J,358.3,4198,0)
 ;;=361.31^^39^298^39
 ;;^UTILITY(U,$J,358.3,4198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4198,1,3,0)
 ;;=3^Peripheral Retinal Hole
 ;;^UTILITY(U,$J,358.3,4198,1,4,0)
 ;;=4^361.31
 ;;^UTILITY(U,$J,358.3,4198,2)
 ;;=Peripheral Retinal Hole^268605
 ;;^UTILITY(U,$J,358.3,4199,0)
 ;;=362.51^^39^298^1
 ;;^UTILITY(U,$J,358.3,4199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4199,1,3,0)
 ;;=3^Age Macular Degeneration, Dry (Armd)
 ;;^UTILITY(U,$J,358.3,4199,1,4,0)
 ;;=4^362.51
 ;;^UTILITY(U,$J,358.3,4199,2)
 ;;=^268636
 ;;^UTILITY(U,$J,358.3,4200,0)
 ;;=362.52^^39^298^2
 ;;^UTILITY(U,$J,358.3,4200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4200,1,3,0)
 ;;=3^Age Macular Degeneration, Wet (Armd)
 ;;^UTILITY(U,$J,358.3,4200,1,4,0)
 ;;=4^362.52
 ;;^UTILITY(U,$J,358.3,4200,2)
 ;;=Macular Degeneration, Wet^268637
 ;;^UTILITY(U,$J,358.3,4201,0)
 ;;=362.32^^39^298^4
 ;;^UTILITY(U,$J,358.3,4201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4201,1,3,0)
 ;;=3^Brao/Branch Retinal Artery Occlusion
 ;;^UTILITY(U,$J,358.3,4201,1,4,0)
 ;;=4^362.32
 ;;^UTILITY(U,$J,358.3,4201,2)
 ;;=ARTERIAL BRANCH OCCLUSION^16756
 ;;^UTILITY(U,$J,358.3,4202,0)
 ;;=362.15^^39^298^54
 ;;^UTILITY(U,$J,358.3,4202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4202,1,3,0)
 ;;=3^Telangiectasia
 ;;^UTILITY(U,$J,358.3,4202,1,4,0)
 ;;=4^362.15
 ;;^UTILITY(U,$J,358.3,4202,2)
 ;;=Retinal Telangiectasia^268616
 ;;^UTILITY(U,$J,358.3,4203,0)
 ;;=362.60^^39^298^18
 ;;^UTILITY(U,$J,358.3,4203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4203,1,3,0)
 ;;=3^Degeneration, Periph, Retina
 ;;^UTILITY(U,$J,358.3,4203,1,4,0)
 ;;=4^362.60
 ;;^UTILITY(U,$J,358.3,4203,2)
 ;;=Peripheral Retinal Degeneration^92193
 ;;^UTILITY(U,$J,358.3,4204,0)
 ;;=362.81^^39^298^45
 ;;^UTILITY(U,$J,358.3,4204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4204,1,3,0)
 ;;=3^Retinal Hemorrhage
 ;;^UTILITY(U,$J,358.3,4204,1,4,0)
 ;;=4^362.81
 ;;^UTILITY(U,$J,358.3,4204,2)
 ;;=Retinal Hemorrhage^105587
 ;;^UTILITY(U,$J,358.3,4205,0)
 ;;=190.6^^39^298^35
 ;;^UTILITY(U,$J,358.3,4205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4205,1,3,0)
 ;;=3^Neoplams, Benign Of Choroid
 ;;^UTILITY(U,$J,358.3,4205,1,4,0)
 ;;=4^190.6
 ;;^UTILITY(U,$J,358.3,4205,2)
 ;;=Malig Neoplasm of Choroid (Primary)^267276
 ;;^UTILITY(U,$J,358.3,4206,0)
 ;;=362.33^^39^298^25
 ;;^UTILITY(U,$J,358.3,4206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4206,1,3,0)
 ;;=3^Hollenhorst Plaque
 ;;^UTILITY(U,$J,358.3,4206,1,4,0)
 ;;=4^362.33
 ;;^UTILITY(U,$J,358.3,4206,2)
 ;;=Hollenhorst Plaque^268620
 ;;^UTILITY(U,$J,358.3,4207,0)
 ;;=361.00^^39^298^44
 ;;^UTILITY(U,$J,358.3,4207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4207,1,3,0)
 ;;=3^Retinal Detachment, Unspecified
 ;;^UTILITY(U,$J,358.3,4207,1,4,0)
 ;;=4^361.00
 ;;^UTILITY(U,$J,358.3,4207,2)
 ;;=Retinal Detachment, Unspecified^268585
 ;;^UTILITY(U,$J,358.3,4208,0)
 ;;=361.01^^39^298^41
 ;;^UTILITY(U,$J,358.3,4208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4208,1,3,0)
 ;;=3^Recent Retinal Detachment, Partial
 ;;^UTILITY(U,$J,358.3,4208,1,4,0)
 ;;=4^361.01
 ;;^UTILITY(U,$J,358.3,4208,2)
 ;;=Recent Retinal Detachment, Partial^268586
 ;;^UTILITY(U,$J,358.3,4209,0)
 ;;=361.05^^39^298^42
 ;;^UTILITY(U,$J,358.3,4209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4209,1,3,0)
 ;;=3^Recent Retinal Detachment, Total
 ;;^UTILITY(U,$J,358.3,4209,1,4,0)
 ;;=4^361.05
 ;;^UTILITY(U,$J,358.3,4209,2)
 ;;=Recent Retinal Detachment, Total^268590
 ;;^UTILITY(U,$J,358.3,4210,0)
 ;;=361.06^^39^298^37
