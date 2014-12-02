IBDEI0VP ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15682,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15682,1,2,0)
 ;;=2^433.10
 ;;^UTILITY(U,$J,358.3,15682,1,3,0)
 ;;=3^Carotid Artery Sten
 ;;^UTILITY(U,$J,358.3,15682,2)
 ;;=Carotid Artery Stenosis^295801
 ;;^UTILITY(U,$J,358.3,15683,0)
 ;;=437.0^^98^961^2
 ;;^UTILITY(U,$J,358.3,15683,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15683,1,2,0)
 ;;=2^437.0
 ;;^UTILITY(U,$J,358.3,15683,1,3,0)
 ;;=3^Intracran Arter Sten
 ;;^UTILITY(U,$J,358.3,15683,2)
 ;;=Intercranial Arterial Stenosis^21571
 ;;^UTILITY(U,$J,358.3,15684,0)
 ;;=435.2^^98^961^6
 ;;^UTILITY(U,$J,358.3,15684,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15684,1,2,0)
 ;;=2^435.2
 ;;^UTILITY(U,$J,358.3,15684,1,3,0)
 ;;=3^Subclavian Stenosis
 ;;^UTILITY(U,$J,358.3,15684,2)
 ;;=Subclavian Stenosis^115012
 ;;^UTILITY(U,$J,358.3,15685,0)
 ;;=435.9^^98^961^7
 ;;^UTILITY(U,$J,358.3,15685,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15685,1,2,0)
 ;;=2^435.9
 ;;^UTILITY(U,$J,358.3,15685,1,3,0)
 ;;=3^Trans Ischemic Attack
 ;;^UTILITY(U,$J,358.3,15685,2)
 ;;=Trans Ischemic Attack^21635
 ;;^UTILITY(U,$J,358.3,15686,0)
 ;;=435.3^^98^961^8
 ;;^UTILITY(U,$J,358.3,15686,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15686,1,2,0)
 ;;=2^435.3
 ;;^UTILITY(U,$J,358.3,15686,1,3,0)
 ;;=3^Vertebral Basilar Insuff
 ;;^UTILITY(U,$J,358.3,15686,2)
 ;;=Vertebral Basilar Insuffiency^260000
 ;;^UTILITY(U,$J,358.3,15687,0)
 ;;=438.20^^98^961^4
 ;;^UTILITY(U,$J,358.3,15687,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15687,1,2,0)
 ;;=2^438.20
 ;;^UTILITY(U,$J,358.3,15687,1,3,0)
 ;;=3^Stroke w/Hemiplegia
 ;;^UTILITY(U,$J,358.3,15687,2)
 ;;=Stroke w/Hemiplegia^317910
 ;;^UTILITY(U,$J,358.3,15688,0)
 ;;=438.11^^98^961^3
 ;;^UTILITY(U,$J,358.3,15688,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15688,1,2,0)
 ;;=2^438.11
 ;;^UTILITY(U,$J,358.3,15688,1,3,0)
 ;;=3^Stroke w/Aphasia
 ;;^UTILITY(U,$J,358.3,15688,2)
 ;;=Stroke w/Aphasia^317907
 ;;^UTILITY(U,$J,358.3,15689,0)
 ;;=438.6^^98^961^5.1
 ;;^UTILITY(U,$J,358.3,15689,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15689,1,2,0)
 ;;=2^438.6
 ;;^UTILITY(U,$J,358.3,15689,1,3,0)
 ;;=3^Stroke w/Sensory Loss
 ;;^UTILITY(U,$J,358.3,15689,2)
 ;;=Stroke w/Sensory Loss^328503
 ;;^UTILITY(U,$J,358.3,15690,0)
 ;;=438.7^^98^961^5.2
 ;;^UTILITY(U,$J,358.3,15690,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15690,1,2,0)
 ;;=2^438.7
 ;;^UTILITY(U,$J,358.3,15690,1,3,0)
 ;;=3^Stroke w/Vision Loss
 ;;^UTILITY(U,$J,358.3,15690,2)
 ;;=Stroke w/Vision Loss^328504
 ;;^UTILITY(U,$J,358.3,15691,0)
 ;;=438.85^^98^961^5.3
 ;;^UTILITY(U,$J,358.3,15691,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15691,1,2,0)
 ;;=2^438.85
 ;;^UTILITY(U,$J,358.3,15691,1,3,0)
 ;;=3^Stroke w/Vertigo
 ;;^UTILITY(U,$J,358.3,15691,2)
 ;;=^328508
 ;;^UTILITY(U,$J,358.3,15692,0)
 ;;=438.82^^98^961^5.5
 ;;^UTILITY(U,$J,358.3,15692,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15692,1,2,0)
 ;;=2^438.82
 ;;^UTILITY(U,$J,358.3,15692,1,3,0)
 ;;=3^Stroke w/dysphagia
 ;;^UTILITY(U,$J,358.3,15692,2)
 ;;=Stroke w/dysphagia^317923
 ;;^UTILITY(U,$J,358.3,15693,0)
 ;;=438.89^^98^961^5
 ;;^UTILITY(U,$J,358.3,15693,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15693,1,2,0)
 ;;=2^438.89
 ;;^UTILITY(U,$J,358.3,15693,1,3,0)
 ;;=3^Stroke with Other Deficits
 ;;^UTILITY(U,$J,358.3,15693,2)
 ;;=^317924
 ;;^UTILITY(U,$J,358.3,15694,0)
 ;;=V12.54^^98^961^9
 ;;^UTILITY(U,$J,358.3,15694,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15694,1,2,0)
 ;;=2^V12.54
 ;;^UTILITY(U,$J,358.3,15694,1,3,0)
 ;;=3^Stroke F/U, No Residuals
 ;;^UTILITY(U,$J,358.3,15694,2)
 ;;=^335309
 ;;^UTILITY(U,$J,358.3,15695,0)
 ;;=345.10^^98^962^3
