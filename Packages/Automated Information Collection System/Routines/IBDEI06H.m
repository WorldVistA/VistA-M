IBDEI06H ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8660,1,3,0)
 ;;=3^Glaucoma,Prim Angle Closure
 ;;^UTILITY(U,$J,358.3,8660,1,4,0)
 ;;=4^365.20
 ;;^UTILITY(U,$J,358.3,8660,2)
 ;;=^51195
 ;;^UTILITY(U,$J,358.3,8661,0)
 ;;=365.52^^53^576^27
 ;;^UTILITY(U,$J,358.3,8661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8661,1,3,0)
 ;;=3^Glaucoma,Pseudoexfoliation
 ;;^UTILITY(U,$J,358.3,8661,1,4,0)
 ;;=4^365.52
 ;;^UTILITY(U,$J,358.3,8661,2)
 ;;=Pseudoexfoliation Glaucoma^268771
 ;;^UTILITY(U,$J,358.3,8662,0)
 ;;=365.15^^53^576^29
 ;;^UTILITY(U,$J,358.3,8662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8662,1,3,0)
 ;;=3^Glaucoma,Residual Open Angle
 ;;^UTILITY(U,$J,358.3,8662,1,4,0)
 ;;=4^365.15
 ;;^UTILITY(U,$J,358.3,8662,2)
 ;;=Residual Open Angle Glaucoma^268751
 ;;^UTILITY(U,$J,358.3,8663,0)
 ;;=365.31^^53^576^32
 ;;^UTILITY(U,$J,358.3,8663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8663,1,3,0)
 ;;=3^Glaucoma,Steroid Induced
 ;;^UTILITY(U,$J,358.3,8663,1,4,0)
 ;;=4^365.31
 ;;^UTILITY(U,$J,358.3,8663,2)
 ;;=Steroid Induced Glaucoma^268761
 ;;^UTILITY(U,$J,358.3,8664,0)
 ;;=365.61^^53^576^11
 ;;^UTILITY(U,$J,358.3,8664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8664,1,3,0)
 ;;=3^Glaucoma W/Pupillary Block
 ;;^UTILITY(U,$J,358.3,8664,1,4,0)
 ;;=4^365.61
 ;;^UTILITY(U,$J,358.3,8664,2)
 ;;=Glaucoma W/Pupillary Block^268776
 ;;^UTILITY(U,$J,358.3,8665,0)
 ;;=365.23^^53^576^13
 ;;^UTILITY(U,$J,358.3,8665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8665,1,3,0)
 ;;=3^Glaucoma,Chr Angle Closure
 ;;^UTILITY(U,$J,358.3,8665,1,4,0)
 ;;=4^365.23
 ;;^UTILITY(U,$J,358.3,8665,2)
 ;;=^268756
 ;;^UTILITY(U,$J,358.3,8666,0)
 ;;=363.71^^53^576^43
 ;;^UTILITY(U,$J,358.3,8666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8666,1,3,0)
 ;;=3^Serous Choroidal Detachment
 ;;^UTILITY(U,$J,358.3,8666,1,4,0)
 ;;=4^363.71
 ;;^UTILITY(U,$J,358.3,8666,2)
 ;;=Choroidal Detachment^268699
 ;;^UTILITY(U,$J,358.3,8667,0)
 ;;=365.51^^53^576^24
 ;;^UTILITY(U,$J,358.3,8667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8667,1,3,0)
 ;;=3^Glaucoma,Phacolytic
 ;;^UTILITY(U,$J,358.3,8667,1,4,0)
 ;;=4^365.51
 ;;^UTILITY(U,$J,358.3,8667,2)
 ;;=Phacolytic Glaucoma^265226
 ;;^UTILITY(U,$J,358.3,8668,0)
 ;;=365.01^^53^576^21
 ;;^UTILITY(U,$J,358.3,8668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8668,1,3,0)
 ;;=3^Glaucoma,Open Angle Suspect
 ;;^UTILITY(U,$J,358.3,8668,1,4,0)
 ;;=4^365.01
 ;;^UTILITY(U,$J,358.3,8668,2)
 ;;=Open Angle Glaucoma Suspect^268747
 ;;^UTILITY(U,$J,358.3,8669,0)
 ;;=365.04^^53^576^37
 ;;^UTILITY(U,$J,358.3,8669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8669,1,3,0)
 ;;=3^Ocular Hypertension
 ;;^UTILITY(U,$J,358.3,8669,1,4,0)
 ;;=4^365.04
 ;;^UTILITY(U,$J,358.3,8669,2)
 ;;=Ocular Hypertension^85124
 ;;^UTILITY(U,$J,358.3,8670,0)
 ;;=365.03^^53^576^44
 ;;^UTILITY(U,$J,358.3,8670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8670,1,3,0)
 ;;=3^Steroid Responder
 ;;^UTILITY(U,$J,358.3,8670,1,4,0)
 ;;=4^365.03
 ;;^UTILITY(U,$J,358.3,8670,2)
 ;;=^268749
 ;;^UTILITY(U,$J,358.3,8671,0)
 ;;=366.11^^53^576^41
 ;;^UTILITY(U,$J,358.3,8671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8671,1,3,0)
 ;;=3^Pseudoexfoliation w/o Glaucoma
 ;;^UTILITY(U,$J,358.3,8671,1,4,0)
 ;;=4^366.11
 ;;^UTILITY(U,$J,358.3,8671,2)
 ;;=^265538
 ;;^UTILITY(U,$J,358.3,8672,0)
 ;;=365.02^^53^576^1
 ;;^UTILITY(U,$J,358.3,8672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8672,1,3,0)
 ;;=3^Anatomic Narrow Angle
 ;;^UTILITY(U,$J,358.3,8672,1,4,0)
 ;;=4^365.02
 ;;^UTILITY(U,$J,358.3,8672,2)
 ;;=Anatomic Narrow Angle^268748
 ;;^UTILITY(U,$J,358.3,8673,0)
 ;;=364.53^^53^576^39
 ;;^UTILITY(U,$J,358.3,8673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8673,1,3,0)
 ;;=3^Pigment Dispersion w/o Glauc
 ;;^UTILITY(U,$J,358.3,8673,1,4,0)
 ;;=4^364.53
 ;;^UTILITY(U,$J,358.3,8673,2)
 ;;=^268720
 ;;^UTILITY(U,$J,358.3,8674,0)
 ;;=364.42^^53^576^42
 ;;^UTILITY(U,$J,358.3,8674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8674,1,3,0)
 ;;=3^Rubeosis Iridis w/o Glaucoma
 ;;^UTILITY(U,$J,358.3,8674,1,4,0)
 ;;=4^364.42
 ;;^UTILITY(U,$J,358.3,8674,2)
 ;;=Rubeosis Iridis w/o Glaucoma^268716
 ;;^UTILITY(U,$J,358.3,8675,0)
 ;;=364.77^^53^576^2
 ;;^UTILITY(U,$J,358.3,8675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8675,1,3,0)
 ;;=3^Angle Recession w/o Glauc
 ;;^UTILITY(U,$J,358.3,8675,1,4,0)
 ;;=4^364.77
 ;;^UTILITY(U,$J,358.3,8675,2)
 ;;=Angle Recession w/o Glauc^268743
 ;;^UTILITY(U,$J,358.3,8676,0)
 ;;=368.40^^53^576^45
 ;;^UTILITY(U,$J,358.3,8676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8676,1,3,0)
 ;;=3^Visual Field Defect
 ;;^UTILITY(U,$J,358.3,8676,1,4,0)
 ;;=4^368.40
 ;;^UTILITY(U,$J,358.3,8676,2)
 ;;=Visual Field Defect^126859
 ;;^UTILITY(U,$J,358.3,8677,0)
 ;;=363.70^^53^576^4
 ;;^UTILITY(U,$J,358.3,8677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8677,1,3,0)
 ;;=3^Choroidal Detachment NOS
 ;;^UTILITY(U,$J,358.3,8677,1,4,0)
 ;;=4^363.70
 ;;^UTILITY(U,$J,358.3,8677,2)
 ;;=^276841
 ;;^UTILITY(U,$J,358.3,8678,0)
 ;;=365.24^^53^576^28
 ;;^UTILITY(U,$J,358.3,8678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8678,1,3,0)
 ;;=3^Glaucoma,Residual Angle Closure
 ;;^UTILITY(U,$J,358.3,8678,1,4,0)
 ;;=4^365.24
 ;;^UTILITY(U,$J,358.3,8678,2)
 ;;=^268758
 ;;^UTILITY(U,$J,358.3,8679,0)
 ;;=365.65^^53^576^34
 ;;^UTILITY(U,$J,358.3,8679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8679,1,3,0)
 ;;=3^Glaucoma,Traumatic
 ;;^UTILITY(U,$J,358.3,8679,1,4,0)
 ;;=4^365.65
 ;;^UTILITY(U,$J,358.3,8679,2)
 ;;=^268780
 ;;^UTILITY(U,$J,358.3,8680,0)
 ;;=365.89^^53^576^23
 ;;^UTILITY(U,$J,358.3,8680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8680,1,3,0)
 ;;=3^Glaucoma,Oth Specified
 ;;^UTILITY(U,$J,358.3,8680,1,4,0)
 ;;=4^365.89
 ;;^UTILITY(U,$J,358.3,8680,2)
 ;;=^88069
 ;;^UTILITY(U,$J,358.3,8681,0)
 ;;=365.05^^53^576^38
 ;;^UTILITY(U,$J,358.3,8681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8681,1,3,0)
 ;;=3^Opn Ang w/ brdrlne fnd-Hi Risk
 ;;^UTILITY(U,$J,358.3,8681,1,4,0)
 ;;=4^365.05
 ;;^UTILITY(U,$J,358.3,8681,2)
 ;;=^340511
 ;;^UTILITY(U,$J,358.3,8682,0)
 ;;=365.06^^53^576^40
 ;;^UTILITY(U,$J,358.3,8682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8682,1,3,0)
 ;;=3^Prim Ang Clos w/o Glauc Dmg
 ;;^UTILITY(U,$J,358.3,8682,1,4,0)
 ;;=4^365.06
 ;;^UTILITY(U,$J,358.3,8682,2)
 ;;=^340512
 ;;^UTILITY(U,$J,358.3,8683,0)
 ;;=365.70^^53^576^31
 ;;^UTILITY(U,$J,358.3,8683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8683,1,3,0)
 ;;=3^Glaucoma,Stage NOS
 ;;^UTILITY(U,$J,358.3,8683,1,4,0)
 ;;=4^365.70
 ;;^UTILITY(U,$J,358.3,8683,2)
 ;;=^340609
 ;;^UTILITY(U,$J,358.3,8684,0)
 ;;=365.71^^53^576^17
 ;;^UTILITY(U,$J,358.3,8684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8684,1,3,0)
 ;;=3^Glaucoma,Mild Stage
 ;;^UTILITY(U,$J,358.3,8684,1,4,0)
 ;;=4^365.71
 ;;^UTILITY(U,$J,358.3,8684,2)
 ;;=^340513
 ;;^UTILITY(U,$J,358.3,8685,0)
 ;;=365.72^^53^576^18
 ;;^UTILITY(U,$J,358.3,8685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8685,1,3,0)
 ;;=3^Glaucoma,Moderate Stage
 ;;^UTILITY(U,$J,358.3,8685,1,4,0)
 ;;=4^365.72
 ;;^UTILITY(U,$J,358.3,8685,2)
 ;;=^340514
 ;;^UTILITY(U,$J,358.3,8686,0)
 ;;=365.73^^53^576^30
 ;;^UTILITY(U,$J,358.3,8686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8686,1,3,0)
 ;;=3^Glaucoma,Severe Stage
 ;;^UTILITY(U,$J,358.3,8686,1,4,0)
 ;;=4^365.73
 ;;^UTILITY(U,$J,358.3,8686,2)
 ;;=^340515
 ;;^UTILITY(U,$J,358.3,8687,0)
 ;;=365.74^^53^576^14
 ;;^UTILITY(U,$J,358.3,8687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8687,1,3,0)
 ;;=3^Glaucoma,Indeterm Stage
 ;;^UTILITY(U,$J,358.3,8687,1,4,0)
 ;;=4^365.74
 ;;^UTILITY(U,$J,358.3,8687,2)
 ;;=^340516
 ;;^UTILITY(U,$J,358.3,8688,0)
 ;;=V19.11^^53^576^5
 ;;^UTILITY(U,$J,358.3,8688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8688,1,3,0)
 ;;=3^Family Hx Glaucoma
 ;;^UTILITY(U,$J,358.3,8688,1,4,0)
 ;;=4^V19.11
 ;;^UTILITY(U,$J,358.3,8688,2)
 ;;=^340617
 ;;^UTILITY(U,$J,358.3,8689,0)
 ;;=V19.19^^53^576^6
 ;;^UTILITY(U,$J,358.3,8689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8689,1,3,0)
 ;;=3^Family Hx Oth Spec Eye Disord
 ;;^UTILITY(U,$J,358.3,8689,1,4,0)
 ;;=4^V19.19
 ;;^UTILITY(U,$J,358.3,8689,2)
 ;;=^340618
 ;;^UTILITY(U,$J,358.3,8690,0)
 ;;=365.62^^53^576^8
 ;;^UTILITY(U,$J,358.3,8690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8690,1,3,0)
 ;;=3^Glauc Assoc w/ Ocular Inflamm
 ;;^UTILITY(U,$J,358.3,8690,1,4,0)
 ;;=4^365.62
 ;;^UTILITY(U,$J,358.3,8690,2)
 ;;=^268777
 ;;^UTILITY(U,$J,358.3,8691,0)
 ;;=365.00^^53^576^33
 ;;^UTILITY(U,$J,358.3,8691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8691,1,3,0)
 ;;=3^Glaucoma,Suspects
 ;;^UTILITY(U,$J,358.3,8691,1,4,0)
 ;;=4^365.00
 ;;^UTILITY(U,$J,358.3,8691,2)
 ;;=^97584
 ;;^UTILITY(U,$J,358.3,8692,0)
 ;;=365.60^^53^576^10
 ;;^UTILITY(U,$J,358.3,8692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8692,1,3,0)
 ;;=3^Glauc w/ Unspec Ocular D/O
 ;;^UTILITY(U,$J,358.3,8692,1,4,0)
 ;;=4^365.60
 ;;^UTILITY(U,$J,358.3,8692,2)
 ;;=^268775
 ;;^UTILITY(U,$J,358.3,8693,0)
 ;;=365.9^^53^576^35
 ;;^UTILITY(U,$J,358.3,8693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8693,1,3,0)
 ;;=3^Glaucoma,Unspec
 ;;^UTILITY(U,$J,358.3,8693,1,4,0)
 ;;=4^365.9
 ;;^UTILITY(U,$J,358.3,8693,2)
 ;;=^51160
 ;;^UTILITY(U,$J,358.3,8694,0)
 ;;=365.22^^53^576^12
 ;;^UTILITY(U,$J,358.3,8694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8694,1,3,0)
 ;;=3^Glaucoma,Acute Angle Closure
 ;;^UTILITY(U,$J,358.3,8694,1,4,0)
 ;;=4^365.22
 ;;^UTILITY(U,$J,358.3,8694,2)
 ;;=^268754
 ;;^UTILITY(U,$J,358.3,8695,0)
 ;;=365.59^^53^576^7
 ;;^UTILITY(U,$J,358.3,8695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8695,1,3,0)
 ;;=3^Glauc Assoc w/ Lens D/O
 ;;^UTILITY(U,$J,358.3,8695,1,4,0)
 ;;=4^365.59
 ;;^UTILITY(U,$J,358.3,8695,2)
 ;;=^268773
 ;;^UTILITY(U,$J,358.3,8696,0)
 ;;=365.44^^53^576^9
 ;;^UTILITY(U,$J,358.3,8696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8696,1,3,0)
 ;;=3^Glauc Assoc w/ Systemic Syndromes
 ;;^UTILITY(U,$J,358.3,8696,1,4,0)
 ;;=4^365.44
