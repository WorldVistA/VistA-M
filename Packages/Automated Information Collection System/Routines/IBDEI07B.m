IBDEI07B ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9613,1,3,0)
 ;;=3^Crao/Central Retinal Artery Occlusion
 ;;^UTILITY(U,$J,358.3,9613,1,4,0)
 ;;=4^362.31
 ;;^UTILITY(U,$J,358.3,9613,2)
 ;;=Central Retinal Artery Occulusion^21255
 ;;^UTILITY(U,$J,358.3,9614,0)
 ;;=362.35^^77^659^13
 ;;^UTILITY(U,$J,358.3,9614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9614,1,3,0)
 ;;=3^Crvo/Central Retinal Vein Occlusion
 ;;^UTILITY(U,$J,358.3,9614,1,4,0)
 ;;=4^362.35
 ;;^UTILITY(U,$J,358.3,9614,2)
 ;;=Central Retinal Vein Occlusion^268624
 ;;^UTILITY(U,$J,358.3,9615,0)
 ;;=362.41^^77^659^6
 ;;^UTILITY(U,$J,358.3,9615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9615,1,3,0)
 ;;=3^Central Serous Retinopathy (Csr)
 ;;^UTILITY(U,$J,358.3,9615,1,4,0)
 ;;=4^362.41
 ;;^UTILITY(U,$J,358.3,9615,2)
 ;;=Central Serous Retinopathy^265870
 ;;^UTILITY(U,$J,358.3,9616,0)
 ;;=224.6^^77^659^10
 ;;^UTILITY(U,$J,358.3,9616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9616,1,3,0)
 ;;=3^Choroidal Nevus
 ;;^UTILITY(U,$J,358.3,9616,1,4,0)
 ;;=4^224.6
 ;;^UTILITY(U,$J,358.3,9616,2)
 ;;=Choroidal Nevus^267676
 ;;^UTILITY(U,$J,358.3,9617,0)
 ;;=362.53^^77^659^16
 ;;^UTILITY(U,$J,358.3,9617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9617,1,3,0)
 ;;=3^Cystoid Macular Degeneration/Edema (Cme)
 ;;^UTILITY(U,$J,358.3,9617,1,4,0)
 ;;=4^362.53
 ;;^UTILITY(U,$J,358.3,9617,2)
 ;;=Cystoid Macular Degeneration/Edema^268638
 ;;^UTILITY(U,$J,358.3,9618,0)
 ;;=361.32^^77^659^26
 ;;^UTILITY(U,$J,358.3,9618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9618,1,3,0)
 ;;=3^Horseshoe Tear
 ;;^UTILITY(U,$J,358.3,9618,1,4,0)
 ;;=4^361.32
 ;;^UTILITY(U,$J,358.3,9618,2)
 ;;=^268606
 ;;^UTILITY(U,$J,358.3,9619,0)
 ;;=362.63^^77^659^28
 ;;^UTILITY(U,$J,358.3,9619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9619,1,3,0)
 ;;=3^Lattice Degeneration
 ;;^UTILITY(U,$J,358.3,9619,1,4,0)
 ;;=4^362.63
 ;;^UTILITY(U,$J,358.3,9619,2)
 ;;=^268644
 ;;^UTILITY(U,$J,358.3,9620,0)
 ;;=362.54^^77^659^30
 ;;^UTILITY(U,$J,358.3,9620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9620,1,3,0)
 ;;=3^Macular Hole
 ;;^UTILITY(U,$J,358.3,9620,1,4,0)
 ;;=4^362.54
 ;;^UTILITY(U,$J,358.3,9620,2)
 ;;=^268639
 ;;^UTILITY(U,$J,358.3,9621,0)
 ;;=362.56^^77^659^31
 ;;^UTILITY(U,$J,358.3,9621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9621,1,3,0)
 ;;=3^Macular Pucker/Epiretinal Membrane (Erm)
 ;;^UTILITY(U,$J,358.3,9621,1,4,0)
 ;;=4^362.56
 ;;^UTILITY(U,$J,358.3,9621,2)
 ;;=Macular Puckering^268641
 ;;^UTILITY(U,$J,358.3,9622,0)
 ;;=361.10^^77^659^49
 ;;^UTILITY(U,$J,358.3,9622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9622,1,3,0)
 ;;=3^Retinoschisis
 ;;^UTILITY(U,$J,358.3,9622,1,4,0)
 ;;=4^361.10
 ;;^UTILITY(U,$J,358.3,9622,2)
 ;;=^265856
 ;;^UTILITY(U,$J,358.3,9623,0)
 ;;=362.16^^77^659^48
 ;;^UTILITY(U,$J,358.3,9623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9623,1,3,0)
 ;;=3^Retinal/Subretinal Neovascularization
 ;;^UTILITY(U,$J,358.3,9623,1,4,0)
 ;;=4^362.16
 ;;^UTILITY(U,$J,358.3,9623,2)
 ;;=Subretinal Neovascularization^105601
 ;;^UTILITY(U,$J,358.3,9624,0)
 ;;=362.11^^77^659^27
 ;;^UTILITY(U,$J,358.3,9624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9624,1,3,0)
 ;;=3^Hypertensive Retinopathy
 ;;^UTILITY(U,$J,358.3,9624,1,4,0)
 ;;=4^362.11
 ;;^UTILITY(U,$J,358.3,9624,2)
 ;;=Hypertensive Retinopathy^265209
 ;;^UTILITY(U,$J,358.3,9625,0)
 ;;=363.30^^77^659^7
 ;;^UTILITY(U,$J,358.3,9625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9625,1,3,0)
 ;;=3^Chorioretinal Scar
 ;;^UTILITY(U,$J,358.3,9625,1,4,0)
 ;;=4^363.30
 ;;^UTILITY(U,$J,358.3,9625,2)
 ;;=Chorioretinal Scar^23910
 ;;^UTILITY(U,$J,358.3,9626,0)
 ;;=361.31^^77^659^39
 ;;^UTILITY(U,$J,358.3,9626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9626,1,3,0)
 ;;=3^Peripheral Retinal Hole
 ;;^UTILITY(U,$J,358.3,9626,1,4,0)
 ;;=4^361.31
 ;;^UTILITY(U,$J,358.3,9626,2)
 ;;=Peripheral Retinal Hole^268605
 ;;^UTILITY(U,$J,358.3,9627,0)
 ;;=362.51^^77^659^1
 ;;^UTILITY(U,$J,358.3,9627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9627,1,3,0)
 ;;=3^Age Macular Degeneration, Dry (Armd)
 ;;^UTILITY(U,$J,358.3,9627,1,4,0)
 ;;=4^362.51
 ;;^UTILITY(U,$J,358.3,9627,2)
 ;;=^268636
 ;;^UTILITY(U,$J,358.3,9628,0)
 ;;=362.52^^77^659^2
 ;;^UTILITY(U,$J,358.3,9628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9628,1,3,0)
 ;;=3^Age Macular Degeneration, Wet (Armd)
 ;;^UTILITY(U,$J,358.3,9628,1,4,0)
 ;;=4^362.52
 ;;^UTILITY(U,$J,358.3,9628,2)
 ;;=Macular Degeneration, Wet^268637
 ;;^UTILITY(U,$J,358.3,9629,0)
 ;;=362.32^^77^659^4
 ;;^UTILITY(U,$J,358.3,9629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9629,1,3,0)
 ;;=3^Brao/Branch Retinal Artery Occlusion
 ;;^UTILITY(U,$J,358.3,9629,1,4,0)
 ;;=4^362.32
 ;;^UTILITY(U,$J,358.3,9629,2)
 ;;=ARTERIAL BRANCH OCCLUSION^16756
 ;;^UTILITY(U,$J,358.3,9630,0)
 ;;=362.15^^77^659^54
 ;;^UTILITY(U,$J,358.3,9630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9630,1,3,0)
 ;;=3^Telangiectasia
 ;;^UTILITY(U,$J,358.3,9630,1,4,0)
 ;;=4^362.15
 ;;^UTILITY(U,$J,358.3,9630,2)
 ;;=Retinal Telangiectasia^268616
 ;;^UTILITY(U,$J,358.3,9631,0)
 ;;=362.60^^77^659^18
 ;;^UTILITY(U,$J,358.3,9631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9631,1,3,0)
 ;;=3^Degeneration, Periph, Retina
 ;;^UTILITY(U,$J,358.3,9631,1,4,0)
 ;;=4^362.60
 ;;^UTILITY(U,$J,358.3,9631,2)
 ;;=Peripheral Retinal Degeneration^92193
 ;;^UTILITY(U,$J,358.3,9632,0)
 ;;=362.81^^77^659^45
 ;;^UTILITY(U,$J,358.3,9632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9632,1,3,0)
 ;;=3^Retinal Hemorrhage
 ;;^UTILITY(U,$J,358.3,9632,1,4,0)
 ;;=4^362.81
 ;;^UTILITY(U,$J,358.3,9632,2)
 ;;=Retinal Hemorrhage^105587
 ;;^UTILITY(U,$J,358.3,9633,0)
 ;;=190.6^^77^659^35
 ;;^UTILITY(U,$J,358.3,9633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9633,1,3,0)
 ;;=3^Neoplams, Benign Of Choroid
 ;;^UTILITY(U,$J,358.3,9633,1,4,0)
 ;;=4^190.6
 ;;^UTILITY(U,$J,358.3,9633,2)
 ;;=Malig Neoplasm of Choroid (Primary)^267276
 ;;^UTILITY(U,$J,358.3,9634,0)
 ;;=362.33^^77^659^25
 ;;^UTILITY(U,$J,358.3,9634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9634,1,3,0)
 ;;=3^Hollenhorst Plaque
 ;;^UTILITY(U,$J,358.3,9634,1,4,0)
 ;;=4^362.33
 ;;^UTILITY(U,$J,358.3,9634,2)
 ;;=Hollenhorst Plaque^268620
 ;;^UTILITY(U,$J,358.3,9635,0)
 ;;=361.00^^77^659^44
 ;;^UTILITY(U,$J,358.3,9635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9635,1,3,0)
 ;;=3^Retinal Detachment, Unspecified
 ;;^UTILITY(U,$J,358.3,9635,1,4,0)
 ;;=4^361.00
 ;;^UTILITY(U,$J,358.3,9635,2)
 ;;=Retinal Detachment, Unspecified^268585
 ;;^UTILITY(U,$J,358.3,9636,0)
 ;;=361.01^^77^659^41
 ;;^UTILITY(U,$J,358.3,9636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9636,1,3,0)
 ;;=3^Recent Retinal Detachment, Partial
 ;;^UTILITY(U,$J,358.3,9636,1,4,0)
 ;;=4^361.01
 ;;^UTILITY(U,$J,358.3,9636,2)
 ;;=Recent Retinal Detachment, Partial^268586
 ;;^UTILITY(U,$J,358.3,9637,0)
 ;;=361.05^^77^659^42
 ;;^UTILITY(U,$J,358.3,9637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9637,1,3,0)
 ;;=3^Recent Retinal Detachment, Total
 ;;^UTILITY(U,$J,358.3,9637,1,4,0)
 ;;=4^361.05
 ;;^UTILITY(U,$J,358.3,9637,2)
 ;;=Recent Retinal Detachment, Total^268590
 ;;^UTILITY(U,$J,358.3,9638,0)
 ;;=361.06^^77^659^37
 ;;^UTILITY(U,$J,358.3,9638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9638,1,3,0)
 ;;=3^Old Retinal Detachment, Partial
 ;;^UTILITY(U,$J,358.3,9638,1,4,0)
 ;;=4^361.06
 ;;^UTILITY(U,$J,358.3,9638,2)
 ;;=Old Retinal Detachment, Part^268591
 ;;^UTILITY(U,$J,358.3,9639,0)
 ;;=361.07^^77^659^38
 ;;^UTILITY(U,$J,358.3,9639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9639,1,3,0)
 ;;=3^Old Retinal Detacment, Total
 ;;^UTILITY(U,$J,358.3,9639,1,4,0)
 ;;=4^361.07
 ;;^UTILITY(U,$J,358.3,9639,2)
 ;;=Old Retinal Detacment, Total^268592
 ;;^UTILITY(U,$J,358.3,9640,0)
 ;;=362.57^^77^659^23
 ;;^UTILITY(U,$J,358.3,9640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9640,1,3,0)
 ;;=3^Drusen
 ;;^UTILITY(U,$J,358.3,9640,1,4,0)
 ;;=4^362.57
 ;;^UTILITY(U,$J,358.3,9640,2)
 ;;=Drusen^105561
 ;;^UTILITY(U,$J,358.3,9641,0)
 ;;=362.55^^77^659^55
 ;;^UTILITY(U,$J,358.3,9641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9641,1,3,0)
 ;;=3^Toxic Maculopathy
 ;;^UTILITY(U,$J,358.3,9641,1,4,0)
 ;;=4^362.55
 ;;^UTILITY(U,$J,358.3,9641,2)
 ;;=Toxic Maculopathy^268640
 ;;^UTILITY(U,$J,358.3,9642,0)
 ;;=363.31^^77^659^53
 ;;^UTILITY(U,$J,358.3,9642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9642,1,3,0)
 ;;=3^Solar Retinopathy
 ;;^UTILITY(U,$J,358.3,9642,1,4,0)
 ;;=4^363.31
 ;;^UTILITY(U,$J,358.3,9642,2)
 ;;=Solar Retinopathy^265207
 ;;^UTILITY(U,$J,358.3,9643,0)
 ;;=363.32^^77^659^32
 ;;^UTILITY(U,$J,358.3,9643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9643,1,3,0)
 ;;=3^Macular Scars
 ;;^UTILITY(U,$J,358.3,9643,1,4,0)
 ;;=4^363.32
 ;;^UTILITY(U,$J,358.3,9643,2)
 ;;=Macular Scars^268680
 ;;^UTILITY(U,$J,358.3,9644,0)
 ;;=362.83^^77^659^29
 ;;^UTILITY(U,$J,358.3,9644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9644,1,3,0)
 ;;=3^Macular Edema (Csme)
 ;;^UTILITY(U,$J,358.3,9644,1,4,0)
 ;;=4^362.83
 ;;^UTILITY(U,$J,358.3,9644,2)
 ;;=Macular Edema (CSME)^89576
 ;;^UTILITY(U,$J,358.3,9645,0)
 ;;=362.84^^77^659^46
 ;;^UTILITY(U,$J,358.3,9645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9645,1,3,0)
 ;;=3^Retinal Ischemia
 ;;^UTILITY(U,$J,358.3,9645,1,4,0)
 ;;=4^362.84
 ;;^UTILITY(U,$J,358.3,9645,2)
 ;;=Retinal Ischemia^276868
 ;;^UTILITY(U,$J,358.3,9646,0)
 ;;=363.20^^77^659^8
 ;;^UTILITY(U,$J,358.3,9646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9646,1,3,0)
 ;;=3^Chorioretinitis
 ;;^UTILITY(U,$J,358.3,9646,1,4,0)
 ;;=4^363.20
 ;;^UTILITY(U,$J,358.3,9646,2)
 ;;=Chorioretinitis^23913
 ;;^UTILITY(U,$J,358.3,9647,0)
 ;;=115.92^^77^659^24
 ;;^UTILITY(U,$J,358.3,9647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9647,1,3,0)
 ;;=3^Histoplamosis (Pohs)
 ;;^UTILITY(U,$J,358.3,9647,1,4,0)
 ;;=4^115.92
 ;;^UTILITY(U,$J,358.3,9647,2)
 ;;=Histoplamosis Retinitis^266905
 ;;^UTILITY(U,$J,358.3,9648,0)
 ;;=363.70^^77^659^9
 ;;^UTILITY(U,$J,358.3,9648,1,0)
 ;;=^358.31IA^4^2
