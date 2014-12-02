IBDEI0HI ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8507,1,3,0)
 ;;=3^Glaucoma,Steroid Induced
 ;;^UTILITY(U,$J,358.3,8507,1,4,0)
 ;;=4^365.31
 ;;^UTILITY(U,$J,358.3,8507,2)
 ;;=Steroid Induced Glaucoma^268761
 ;;^UTILITY(U,$J,358.3,8508,0)
 ;;=365.61^^58^610^11
 ;;^UTILITY(U,$J,358.3,8508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8508,1,3,0)
 ;;=3^Glaucoma W/Pupillary Block
 ;;^UTILITY(U,$J,358.3,8508,1,4,0)
 ;;=4^365.61
 ;;^UTILITY(U,$J,358.3,8508,2)
 ;;=Glaucoma W/Pupillary Block^268776
 ;;^UTILITY(U,$J,358.3,8509,0)
 ;;=365.23^^58^610^13
 ;;^UTILITY(U,$J,358.3,8509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8509,1,3,0)
 ;;=3^Glaucoma,Chr Angle Closure
 ;;^UTILITY(U,$J,358.3,8509,1,4,0)
 ;;=4^365.23
 ;;^UTILITY(U,$J,358.3,8509,2)
 ;;=^268756
 ;;^UTILITY(U,$J,358.3,8510,0)
 ;;=363.71^^58^610^43
 ;;^UTILITY(U,$J,358.3,8510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8510,1,3,0)
 ;;=3^Serous Choroidal Detachment
 ;;^UTILITY(U,$J,358.3,8510,1,4,0)
 ;;=4^363.71
 ;;^UTILITY(U,$J,358.3,8510,2)
 ;;=Choroidal Detachment^268699
 ;;^UTILITY(U,$J,358.3,8511,0)
 ;;=365.51^^58^610^24
 ;;^UTILITY(U,$J,358.3,8511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8511,1,3,0)
 ;;=3^Glaucoma,Phacolytic
 ;;^UTILITY(U,$J,358.3,8511,1,4,0)
 ;;=4^365.51
 ;;^UTILITY(U,$J,358.3,8511,2)
 ;;=Phacolytic Glaucoma^265226
 ;;^UTILITY(U,$J,358.3,8512,0)
 ;;=365.01^^58^610^21
 ;;^UTILITY(U,$J,358.3,8512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8512,1,3,0)
 ;;=3^Glaucoma,Open Angle Suspect
 ;;^UTILITY(U,$J,358.3,8512,1,4,0)
 ;;=4^365.01
 ;;^UTILITY(U,$J,358.3,8512,2)
 ;;=Open Angle Glaucoma Suspect^268747
 ;;^UTILITY(U,$J,358.3,8513,0)
 ;;=365.04^^58^610^37
 ;;^UTILITY(U,$J,358.3,8513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8513,1,3,0)
 ;;=3^Ocular Hypertension
 ;;^UTILITY(U,$J,358.3,8513,1,4,0)
 ;;=4^365.04
 ;;^UTILITY(U,$J,358.3,8513,2)
 ;;=Ocular Hypertension^85124
 ;;^UTILITY(U,$J,358.3,8514,0)
 ;;=365.03^^58^610^44
 ;;^UTILITY(U,$J,358.3,8514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8514,1,3,0)
 ;;=3^Steroid Responder
 ;;^UTILITY(U,$J,358.3,8514,1,4,0)
 ;;=4^365.03
 ;;^UTILITY(U,$J,358.3,8514,2)
 ;;=^268749
 ;;^UTILITY(U,$J,358.3,8515,0)
 ;;=366.11^^58^610^41
 ;;^UTILITY(U,$J,358.3,8515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8515,1,3,0)
 ;;=3^Pseudoexfoliation w/o Glaucoma
 ;;^UTILITY(U,$J,358.3,8515,1,4,0)
 ;;=4^366.11
 ;;^UTILITY(U,$J,358.3,8515,2)
 ;;=^265538
 ;;^UTILITY(U,$J,358.3,8516,0)
 ;;=365.02^^58^610^1
 ;;^UTILITY(U,$J,358.3,8516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8516,1,3,0)
 ;;=3^Anatomic Narrow Angle
 ;;^UTILITY(U,$J,358.3,8516,1,4,0)
 ;;=4^365.02
 ;;^UTILITY(U,$J,358.3,8516,2)
 ;;=Anatomic Narrow Angle^268748
 ;;^UTILITY(U,$J,358.3,8517,0)
 ;;=364.53^^58^610^39
 ;;^UTILITY(U,$J,358.3,8517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8517,1,3,0)
 ;;=3^Pigment Dispersion w/o Glauc
 ;;^UTILITY(U,$J,358.3,8517,1,4,0)
 ;;=4^364.53
 ;;^UTILITY(U,$J,358.3,8517,2)
 ;;=^268720
 ;;^UTILITY(U,$J,358.3,8518,0)
 ;;=364.42^^58^610^42
 ;;^UTILITY(U,$J,358.3,8518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8518,1,3,0)
 ;;=3^Rubeosis Iridis w/o Glaucoma
 ;;^UTILITY(U,$J,358.3,8518,1,4,0)
 ;;=4^364.42
 ;;^UTILITY(U,$J,358.3,8518,2)
 ;;=Rubeosis Iridis w/o Glaucoma^268716
 ;;^UTILITY(U,$J,358.3,8519,0)
 ;;=364.77^^58^610^2
 ;;^UTILITY(U,$J,358.3,8519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8519,1,3,0)
 ;;=3^Angle Recession w/o Glauc
 ;;^UTILITY(U,$J,358.3,8519,1,4,0)
 ;;=4^364.77
 ;;^UTILITY(U,$J,358.3,8519,2)
 ;;=Angle Recession w/o Glauc^268743
 ;;^UTILITY(U,$J,358.3,8520,0)
 ;;=368.40^^58^610^45
 ;;^UTILITY(U,$J,358.3,8520,1,0)
 ;;=^358.31IA^4^2
