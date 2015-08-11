IBDEI0HR ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8594,0)
 ;;=365.61^^52^583^11
 ;;^UTILITY(U,$J,358.3,8594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8594,1,3,0)
 ;;=3^Glaucoma W/Pupillary Block
 ;;^UTILITY(U,$J,358.3,8594,1,4,0)
 ;;=4^365.61
 ;;^UTILITY(U,$J,358.3,8594,2)
 ;;=Glaucoma W/Pupillary Block^268776
 ;;^UTILITY(U,$J,358.3,8595,0)
 ;;=365.23^^52^583^13
 ;;^UTILITY(U,$J,358.3,8595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8595,1,3,0)
 ;;=3^Glaucoma,Chr Angle Closure
 ;;^UTILITY(U,$J,358.3,8595,1,4,0)
 ;;=4^365.23
 ;;^UTILITY(U,$J,358.3,8595,2)
 ;;=^268756
 ;;^UTILITY(U,$J,358.3,8596,0)
 ;;=363.71^^52^583^43
 ;;^UTILITY(U,$J,358.3,8596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8596,1,3,0)
 ;;=3^Serous Choroidal Detachment
 ;;^UTILITY(U,$J,358.3,8596,1,4,0)
 ;;=4^363.71
 ;;^UTILITY(U,$J,358.3,8596,2)
 ;;=Choroidal Detachment^268699
 ;;^UTILITY(U,$J,358.3,8597,0)
 ;;=365.51^^52^583^24
 ;;^UTILITY(U,$J,358.3,8597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8597,1,3,0)
 ;;=3^Glaucoma,Phacolytic
 ;;^UTILITY(U,$J,358.3,8597,1,4,0)
 ;;=4^365.51
 ;;^UTILITY(U,$J,358.3,8597,2)
 ;;=Phacolytic Glaucoma^265226
 ;;^UTILITY(U,$J,358.3,8598,0)
 ;;=365.01^^52^583^21
 ;;^UTILITY(U,$J,358.3,8598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8598,1,3,0)
 ;;=3^Glaucoma,Open Angle Suspect
 ;;^UTILITY(U,$J,358.3,8598,1,4,0)
 ;;=4^365.01
 ;;^UTILITY(U,$J,358.3,8598,2)
 ;;=Open Angle Glaucoma Suspect^268747
 ;;^UTILITY(U,$J,358.3,8599,0)
 ;;=365.04^^52^583^37
 ;;^UTILITY(U,$J,358.3,8599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8599,1,3,0)
 ;;=3^Ocular Hypertension
 ;;^UTILITY(U,$J,358.3,8599,1,4,0)
 ;;=4^365.04
 ;;^UTILITY(U,$J,358.3,8599,2)
 ;;=Ocular Hypertension^85124
 ;;^UTILITY(U,$J,358.3,8600,0)
 ;;=365.03^^52^583^44
 ;;^UTILITY(U,$J,358.3,8600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8600,1,3,0)
 ;;=3^Steroid Responder
 ;;^UTILITY(U,$J,358.3,8600,1,4,0)
 ;;=4^365.03
 ;;^UTILITY(U,$J,358.3,8600,2)
 ;;=^268749
 ;;^UTILITY(U,$J,358.3,8601,0)
 ;;=366.11^^52^583^41
 ;;^UTILITY(U,$J,358.3,8601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8601,1,3,0)
 ;;=3^Pseudoexfoliation w/o Glaucoma
 ;;^UTILITY(U,$J,358.3,8601,1,4,0)
 ;;=4^366.11
 ;;^UTILITY(U,$J,358.3,8601,2)
 ;;=^265538
 ;;^UTILITY(U,$J,358.3,8602,0)
 ;;=365.02^^52^583^1
 ;;^UTILITY(U,$J,358.3,8602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8602,1,3,0)
 ;;=3^Anatomic Narrow Angle
 ;;^UTILITY(U,$J,358.3,8602,1,4,0)
 ;;=4^365.02
 ;;^UTILITY(U,$J,358.3,8602,2)
 ;;=Anatomic Narrow Angle^268748
 ;;^UTILITY(U,$J,358.3,8603,0)
 ;;=364.53^^52^583^39
 ;;^UTILITY(U,$J,358.3,8603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8603,1,3,0)
 ;;=3^Pigment Dispersion w/o Glauc
 ;;^UTILITY(U,$J,358.3,8603,1,4,0)
 ;;=4^364.53
 ;;^UTILITY(U,$J,358.3,8603,2)
 ;;=^268720
 ;;^UTILITY(U,$J,358.3,8604,0)
 ;;=364.42^^52^583^42
 ;;^UTILITY(U,$J,358.3,8604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8604,1,3,0)
 ;;=3^Rubeosis Iridis w/o Glaucoma
 ;;^UTILITY(U,$J,358.3,8604,1,4,0)
 ;;=4^364.42
 ;;^UTILITY(U,$J,358.3,8604,2)
 ;;=Rubeosis Iridis w/o Glaucoma^268716
 ;;^UTILITY(U,$J,358.3,8605,0)
 ;;=364.77^^52^583^2
 ;;^UTILITY(U,$J,358.3,8605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8605,1,3,0)
 ;;=3^Angle Recession w/o Glauc
 ;;^UTILITY(U,$J,358.3,8605,1,4,0)
 ;;=4^364.77
 ;;^UTILITY(U,$J,358.3,8605,2)
 ;;=Angle Recession w/o Glauc^268743
 ;;^UTILITY(U,$J,358.3,8606,0)
 ;;=368.40^^52^583^45
 ;;^UTILITY(U,$J,358.3,8606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8606,1,3,0)
 ;;=3^Visual Field Defect
 ;;^UTILITY(U,$J,358.3,8606,1,4,0)
 ;;=4^368.40
 ;;^UTILITY(U,$J,358.3,8606,2)
 ;;=Visual Field Defect^126859
