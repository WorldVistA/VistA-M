IBDEI0FS ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7602,0)
 ;;=365.61^^49^559^11
 ;;^UTILITY(U,$J,358.3,7602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7602,1,3,0)
 ;;=3^Glaucoma W/Pupillary Block
 ;;^UTILITY(U,$J,358.3,7602,1,4,0)
 ;;=4^365.61
 ;;^UTILITY(U,$J,358.3,7602,2)
 ;;=Glaucoma W/Pupillary Block^268776
 ;;^UTILITY(U,$J,358.3,7603,0)
 ;;=365.23^^49^559^13
 ;;^UTILITY(U,$J,358.3,7603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7603,1,3,0)
 ;;=3^Glaucoma,Chr Angle Closure
 ;;^UTILITY(U,$J,358.3,7603,1,4,0)
 ;;=4^365.23
 ;;^UTILITY(U,$J,358.3,7603,2)
 ;;=^268756
 ;;^UTILITY(U,$J,358.3,7604,0)
 ;;=363.71^^49^559^43
 ;;^UTILITY(U,$J,358.3,7604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7604,1,3,0)
 ;;=3^Serous Choroidal Detachment
 ;;^UTILITY(U,$J,358.3,7604,1,4,0)
 ;;=4^363.71
 ;;^UTILITY(U,$J,358.3,7604,2)
 ;;=Choroidal Detachment^268699
 ;;^UTILITY(U,$J,358.3,7605,0)
 ;;=365.51^^49^559^24
 ;;^UTILITY(U,$J,358.3,7605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7605,1,3,0)
 ;;=3^Glaucoma,Phacolytic
 ;;^UTILITY(U,$J,358.3,7605,1,4,0)
 ;;=4^365.51
 ;;^UTILITY(U,$J,358.3,7605,2)
 ;;=Phacolytic Glaucoma^265226
 ;;^UTILITY(U,$J,358.3,7606,0)
 ;;=365.01^^49^559^21
 ;;^UTILITY(U,$J,358.3,7606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7606,1,3,0)
 ;;=3^Glaucoma,Open Angle Suspect
 ;;^UTILITY(U,$J,358.3,7606,1,4,0)
 ;;=4^365.01
 ;;^UTILITY(U,$J,358.3,7606,2)
 ;;=Open Angle Glaucoma Suspect^268747
 ;;^UTILITY(U,$J,358.3,7607,0)
 ;;=365.04^^49^559^37
 ;;^UTILITY(U,$J,358.3,7607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7607,1,3,0)
 ;;=3^Ocular Hypertension
 ;;^UTILITY(U,$J,358.3,7607,1,4,0)
 ;;=4^365.04
 ;;^UTILITY(U,$J,358.3,7607,2)
 ;;=Ocular Hypertension^85124
 ;;^UTILITY(U,$J,358.3,7608,0)
 ;;=365.03^^49^559^44
 ;;^UTILITY(U,$J,358.3,7608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7608,1,3,0)
 ;;=3^Steroid Responder
 ;;^UTILITY(U,$J,358.3,7608,1,4,0)
 ;;=4^365.03
 ;;^UTILITY(U,$J,358.3,7608,2)
 ;;=^268749
 ;;^UTILITY(U,$J,358.3,7609,0)
 ;;=366.11^^49^559^41
 ;;^UTILITY(U,$J,358.3,7609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7609,1,3,0)
 ;;=3^Pseudoexfoliation w/o Glaucoma
 ;;^UTILITY(U,$J,358.3,7609,1,4,0)
 ;;=4^366.11
 ;;^UTILITY(U,$J,358.3,7609,2)
 ;;=^265538
 ;;^UTILITY(U,$J,358.3,7610,0)
 ;;=365.02^^49^559^1
 ;;^UTILITY(U,$J,358.3,7610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7610,1,3,0)
 ;;=3^Anatomic Narrow Angle
 ;;^UTILITY(U,$J,358.3,7610,1,4,0)
 ;;=4^365.02
 ;;^UTILITY(U,$J,358.3,7610,2)
 ;;=Anatomic Narrow Angle^268748
 ;;^UTILITY(U,$J,358.3,7611,0)
 ;;=364.53^^49^559^39
 ;;^UTILITY(U,$J,358.3,7611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7611,1,3,0)
 ;;=3^Pigment Dispersion w/o Glauc
 ;;^UTILITY(U,$J,358.3,7611,1,4,0)
 ;;=4^364.53
 ;;^UTILITY(U,$J,358.3,7611,2)
 ;;=^268720
 ;;^UTILITY(U,$J,358.3,7612,0)
 ;;=364.42^^49^559^42
 ;;^UTILITY(U,$J,358.3,7612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7612,1,3,0)
 ;;=3^Rubeosis Iridis w/o Glaucoma
 ;;^UTILITY(U,$J,358.3,7612,1,4,0)
 ;;=4^364.42
 ;;^UTILITY(U,$J,358.3,7612,2)
 ;;=Rubeosis Iridis w/o Glaucoma^268716
 ;;^UTILITY(U,$J,358.3,7613,0)
 ;;=364.77^^49^559^2
 ;;^UTILITY(U,$J,358.3,7613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7613,1,3,0)
 ;;=3^Angle Recession w/o Glauc
 ;;^UTILITY(U,$J,358.3,7613,1,4,0)
 ;;=4^364.77
 ;;^UTILITY(U,$J,358.3,7613,2)
 ;;=Angle Recession w/o Glauc^268743
 ;;^UTILITY(U,$J,358.3,7614,0)
 ;;=368.40^^49^559^45
 ;;^UTILITY(U,$J,358.3,7614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7614,1,3,0)
 ;;=3^Visual Field Defect
 ;;^UTILITY(U,$J,358.3,7614,1,4,0)
 ;;=4^368.40
 ;;^UTILITY(U,$J,358.3,7614,2)
 ;;=Visual Field Defect^126859
