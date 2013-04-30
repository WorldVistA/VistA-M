IBDEI07M ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10015,2)
 ;;=Central Retinal Vein Occlusion^268624
 ;;^UTILITY(U,$J,358.3,10016,0)
 ;;=362.41^^79^675^6
 ;;^UTILITY(U,$J,358.3,10016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10016,1,3,0)
 ;;=3^Central Serous Retinopathy (Csr)
 ;;^UTILITY(U,$J,358.3,10016,1,4,0)
 ;;=4^362.41
 ;;^UTILITY(U,$J,358.3,10016,2)
 ;;=Central Serous Retinopathy^265870
 ;;^UTILITY(U,$J,358.3,10017,0)
 ;;=224.6^^79^675^10
 ;;^UTILITY(U,$J,358.3,10017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10017,1,3,0)
 ;;=3^Choroidal Nevus
 ;;^UTILITY(U,$J,358.3,10017,1,4,0)
 ;;=4^224.6
 ;;^UTILITY(U,$J,358.3,10017,2)
 ;;=Choroidal Nevus^267676
 ;;^UTILITY(U,$J,358.3,10018,0)
 ;;=362.53^^79^675^16
 ;;^UTILITY(U,$J,358.3,10018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10018,1,3,0)
 ;;=3^Cystoid Macular Degeneration/Edema (Cme)
 ;;^UTILITY(U,$J,358.3,10018,1,4,0)
 ;;=4^362.53
 ;;^UTILITY(U,$J,358.3,10018,2)
 ;;=Cystoid Macular Degeneration/Edema^268638
 ;;^UTILITY(U,$J,358.3,10019,0)
 ;;=361.32^^79^675^26
 ;;^UTILITY(U,$J,358.3,10019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10019,1,3,0)
 ;;=3^Horseshoe Tear
 ;;^UTILITY(U,$J,358.3,10019,1,4,0)
 ;;=4^361.32
 ;;^UTILITY(U,$J,358.3,10019,2)
 ;;=^268606
 ;;^UTILITY(U,$J,358.3,10020,0)
 ;;=362.63^^79^675^28
 ;;^UTILITY(U,$J,358.3,10020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10020,1,3,0)
 ;;=3^Lattice Degeneration
 ;;^UTILITY(U,$J,358.3,10020,1,4,0)
 ;;=4^362.63
 ;;^UTILITY(U,$J,358.3,10020,2)
 ;;=^268644
 ;;^UTILITY(U,$J,358.3,10021,0)
 ;;=362.54^^79^675^30
 ;;^UTILITY(U,$J,358.3,10021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10021,1,3,0)
 ;;=3^Macular Hole
 ;;^UTILITY(U,$J,358.3,10021,1,4,0)
 ;;=4^362.54
 ;;^UTILITY(U,$J,358.3,10021,2)
 ;;=^268639
 ;;^UTILITY(U,$J,358.3,10022,0)
 ;;=362.56^^79^675^31
 ;;^UTILITY(U,$J,358.3,10022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10022,1,3,0)
 ;;=3^Macular Pucker/Epiretinal Membrane (Erm)
 ;;^UTILITY(U,$J,358.3,10022,1,4,0)
 ;;=4^362.56
 ;;^UTILITY(U,$J,358.3,10022,2)
 ;;=Macular Puckering^268641
 ;;^UTILITY(U,$J,358.3,10023,0)
 ;;=361.10^^79^675^49
 ;;^UTILITY(U,$J,358.3,10023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10023,1,3,0)
 ;;=3^Retinoschisis
 ;;^UTILITY(U,$J,358.3,10023,1,4,0)
 ;;=4^361.10
 ;;^UTILITY(U,$J,358.3,10023,2)
 ;;=^265856
 ;;^UTILITY(U,$J,358.3,10024,0)
 ;;=362.16^^79^675^48
 ;;^UTILITY(U,$J,358.3,10024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10024,1,3,0)
 ;;=3^Retinal/Subretinal Neovascularization
 ;;^UTILITY(U,$J,358.3,10024,1,4,0)
 ;;=4^362.16
 ;;^UTILITY(U,$J,358.3,10024,2)
 ;;=Subretinal Neovascularization^105601
 ;;^UTILITY(U,$J,358.3,10025,0)
 ;;=362.11^^79^675^27
 ;;^UTILITY(U,$J,358.3,10025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10025,1,3,0)
 ;;=3^Hypertensive Retinopathy
 ;;^UTILITY(U,$J,358.3,10025,1,4,0)
 ;;=4^362.11
 ;;^UTILITY(U,$J,358.3,10025,2)
 ;;=Hypertensive Retinopathy^265209
 ;;^UTILITY(U,$J,358.3,10026,0)
 ;;=363.30^^79^675^7
 ;;^UTILITY(U,$J,358.3,10026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10026,1,3,0)
 ;;=3^Chorioretinal Scar
 ;;^UTILITY(U,$J,358.3,10026,1,4,0)
 ;;=4^363.30
 ;;^UTILITY(U,$J,358.3,10026,2)
 ;;=Chorioretinal Scar^23910
 ;;^UTILITY(U,$J,358.3,10027,0)
 ;;=361.31^^79^675^39
 ;;^UTILITY(U,$J,358.3,10027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10027,1,3,0)
 ;;=3^Peripheral Retinal Hole
 ;;^UTILITY(U,$J,358.3,10027,1,4,0)
 ;;=4^361.31
 ;;^UTILITY(U,$J,358.3,10027,2)
 ;;=Peripheral Retinal Hole^268605
 ;;^UTILITY(U,$J,358.3,10028,0)
 ;;=362.51^^79^675^1
 ;;^UTILITY(U,$J,358.3,10028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10028,1,3,0)
 ;;=3^Age Macular Degeneration, Dry (Armd)
 ;;^UTILITY(U,$J,358.3,10028,1,4,0)
 ;;=4^362.51
 ;;^UTILITY(U,$J,358.3,10028,2)
 ;;=^268636
 ;;^UTILITY(U,$J,358.3,10029,0)
 ;;=362.52^^79^675^2
 ;;^UTILITY(U,$J,358.3,10029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10029,1,3,0)
 ;;=3^Age Macular Degeneration, Wet (Armd)
 ;;^UTILITY(U,$J,358.3,10029,1,4,0)
 ;;=4^362.52
 ;;^UTILITY(U,$J,358.3,10029,2)
 ;;=Macular Degeneration, Wet^268637
 ;;^UTILITY(U,$J,358.3,10030,0)
 ;;=362.32^^79^675^4
 ;;^UTILITY(U,$J,358.3,10030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10030,1,3,0)
 ;;=3^Brao/Branch Retinal Artery Occlusion
 ;;^UTILITY(U,$J,358.3,10030,1,4,0)
 ;;=4^362.32
 ;;^UTILITY(U,$J,358.3,10030,2)
 ;;=ARTERIAL BRANCH OCCLUSION^16756
 ;;^UTILITY(U,$J,358.3,10031,0)
 ;;=362.15^^79^675^54
 ;;^UTILITY(U,$J,358.3,10031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10031,1,3,0)
 ;;=3^Telangiectasia
 ;;^UTILITY(U,$J,358.3,10031,1,4,0)
 ;;=4^362.15
 ;;^UTILITY(U,$J,358.3,10031,2)
 ;;=Retinal Telangiectasia^268616
 ;;^UTILITY(U,$J,358.3,10032,0)
 ;;=362.60^^79^675^18
 ;;^UTILITY(U,$J,358.3,10032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10032,1,3,0)
 ;;=3^Degeneration, Periph, Retina
 ;;^UTILITY(U,$J,358.3,10032,1,4,0)
 ;;=4^362.60
 ;;^UTILITY(U,$J,358.3,10032,2)
 ;;=Peripheral Retinal Degeneration^92193
 ;;^UTILITY(U,$J,358.3,10033,0)
 ;;=362.81^^79^675^45
 ;;^UTILITY(U,$J,358.3,10033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10033,1,3,0)
 ;;=3^Retinal Hemorrhage
 ;;^UTILITY(U,$J,358.3,10033,1,4,0)
 ;;=4^362.81
 ;;^UTILITY(U,$J,358.3,10033,2)
 ;;=Retinal Hemorrhage^105587
 ;;^UTILITY(U,$J,358.3,10034,0)
 ;;=190.6^^79^675^35
 ;;^UTILITY(U,$J,358.3,10034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10034,1,3,0)
 ;;=3^Neoplams, Benign Of Choroid
 ;;^UTILITY(U,$J,358.3,10034,1,4,0)
 ;;=4^190.6
 ;;^UTILITY(U,$J,358.3,10034,2)
 ;;=Malig Neoplasm of Choroid (Primary)^267276
 ;;^UTILITY(U,$J,358.3,10035,0)
 ;;=362.33^^79^675^25
 ;;^UTILITY(U,$J,358.3,10035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10035,1,3,0)
 ;;=3^Hollenhorst Plaque
 ;;^UTILITY(U,$J,358.3,10035,1,4,0)
 ;;=4^362.33
 ;;^UTILITY(U,$J,358.3,10035,2)
 ;;=Hollenhorst Plaque^268620
 ;;^UTILITY(U,$J,358.3,10036,0)
 ;;=361.00^^79^675^44
 ;;^UTILITY(U,$J,358.3,10036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10036,1,3,0)
 ;;=3^Retinal Detachment, Unspecified
 ;;^UTILITY(U,$J,358.3,10036,1,4,0)
 ;;=4^361.00
 ;;^UTILITY(U,$J,358.3,10036,2)
 ;;=Retinal Detachment, Unspecified^268585
 ;;^UTILITY(U,$J,358.3,10037,0)
 ;;=361.01^^79^675^41
 ;;^UTILITY(U,$J,358.3,10037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10037,1,3,0)
 ;;=3^Recent Retinal Detachment, Partial
 ;;^UTILITY(U,$J,358.3,10037,1,4,0)
 ;;=4^361.01
 ;;^UTILITY(U,$J,358.3,10037,2)
 ;;=Recent Retinal Detachment, Partial^268586
 ;;^UTILITY(U,$J,358.3,10038,0)
 ;;=361.05^^79^675^42
 ;;^UTILITY(U,$J,358.3,10038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10038,1,3,0)
 ;;=3^Recent Retinal Detachment, Total
 ;;^UTILITY(U,$J,358.3,10038,1,4,0)
 ;;=4^361.05
 ;;^UTILITY(U,$J,358.3,10038,2)
 ;;=Recent Retinal Detachment, Total^268590
 ;;^UTILITY(U,$J,358.3,10039,0)
 ;;=361.06^^79^675^37
 ;;^UTILITY(U,$J,358.3,10039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10039,1,3,0)
 ;;=3^Old Retinal Detachment, Partial
 ;;^UTILITY(U,$J,358.3,10039,1,4,0)
 ;;=4^361.06
 ;;^UTILITY(U,$J,358.3,10039,2)
 ;;=Old Retinal Detachment, Part^268591
 ;;^UTILITY(U,$J,358.3,10040,0)
 ;;=361.07^^79^675^38
 ;;^UTILITY(U,$J,358.3,10040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10040,1,3,0)
 ;;=3^Old Retinal Detacment, Total
 ;;^UTILITY(U,$J,358.3,10040,1,4,0)
 ;;=4^361.07
 ;;^UTILITY(U,$J,358.3,10040,2)
 ;;=Old Retinal Detacment, Total^268592
 ;;^UTILITY(U,$J,358.3,10041,0)
 ;;=362.57^^79^675^23
 ;;^UTILITY(U,$J,358.3,10041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10041,1,3,0)
 ;;=3^Drusen
 ;;^UTILITY(U,$J,358.3,10041,1,4,0)
 ;;=4^362.57
 ;;^UTILITY(U,$J,358.3,10041,2)
 ;;=Drusen^105561
 ;;^UTILITY(U,$J,358.3,10042,0)
 ;;=362.55^^79^675^55
 ;;^UTILITY(U,$J,358.3,10042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10042,1,3,0)
 ;;=3^Toxic Maculopathy
 ;;^UTILITY(U,$J,358.3,10042,1,4,0)
 ;;=4^362.55
 ;;^UTILITY(U,$J,358.3,10042,2)
 ;;=Toxic Maculopathy^268640
 ;;^UTILITY(U,$J,358.3,10043,0)
 ;;=363.31^^79^675^53
 ;;^UTILITY(U,$J,358.3,10043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10043,1,3,0)
 ;;=3^Solar Retinopathy
 ;;^UTILITY(U,$J,358.3,10043,1,4,0)
 ;;=4^363.31
 ;;^UTILITY(U,$J,358.3,10043,2)
 ;;=Solar Retinopathy^265207
 ;;^UTILITY(U,$J,358.3,10044,0)
 ;;=363.32^^79^675^32
 ;;^UTILITY(U,$J,358.3,10044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10044,1,3,0)
 ;;=3^Macular Scars
 ;;^UTILITY(U,$J,358.3,10044,1,4,0)
 ;;=4^363.32
 ;;^UTILITY(U,$J,358.3,10044,2)
 ;;=Macular Scars^268680
 ;;^UTILITY(U,$J,358.3,10045,0)
 ;;=362.83^^79^675^29
 ;;^UTILITY(U,$J,358.3,10045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10045,1,3,0)
 ;;=3^Macular Edema (Csme)
 ;;^UTILITY(U,$J,358.3,10045,1,4,0)
 ;;=4^362.83
 ;;^UTILITY(U,$J,358.3,10045,2)
 ;;=Macular Edema (CSME)^89576
 ;;^UTILITY(U,$J,358.3,10046,0)
 ;;=362.84^^79^675^46
 ;;^UTILITY(U,$J,358.3,10046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10046,1,3,0)
 ;;=3^Retinal Ischemia
 ;;^UTILITY(U,$J,358.3,10046,1,4,0)
 ;;=4^362.84
 ;;^UTILITY(U,$J,358.3,10046,2)
 ;;=Retinal Ischemia^276868
 ;;^UTILITY(U,$J,358.3,10047,0)
 ;;=363.20^^79^675^8
 ;;^UTILITY(U,$J,358.3,10047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10047,1,3,0)
 ;;=3^Chorioretinitis
 ;;^UTILITY(U,$J,358.3,10047,1,4,0)
 ;;=4^363.20
 ;;^UTILITY(U,$J,358.3,10047,2)
 ;;=Chorioretinitis^23913
 ;;^UTILITY(U,$J,358.3,10048,0)
 ;;=115.92^^79^675^24
 ;;^UTILITY(U,$J,358.3,10048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10048,1,3,0)
 ;;=3^Histoplamosis (Pohs)
 ;;^UTILITY(U,$J,358.3,10048,1,4,0)
 ;;=4^115.92
 ;;^UTILITY(U,$J,358.3,10048,2)
 ;;=Histoplamosis Retinitis^266905
 ;;^UTILITY(U,$J,358.3,10049,0)
 ;;=363.70^^79^675^9
 ;;^UTILITY(U,$J,358.3,10049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10049,1,3,0)
 ;;=3^Choroidal Detachment
 ;;^UTILITY(U,$J,358.3,10049,1,4,0)
 ;;=4^363.70
 ;;^UTILITY(U,$J,358.3,10049,2)
 ;;=Choroidal Detachment^276841
 ;;^UTILITY(U,$J,358.3,10050,0)
 ;;=363.63^^79^675^11
