IBDEI0RN ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13651,2)
 ;;=Heart Failure, Systolic & Diastolic, Acute^328500
 ;;^UTILITY(U,$J,358.3,13652,0)
 ;;=428.42^^90^848^52
 ;;^UTILITY(U,$J,358.3,13652,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13652,1,4,0)
 ;;=4^428.42
 ;;^UTILITY(U,$J,358.3,13652,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic,Chronic
 ;;^UTILITY(U,$J,358.3,13652,2)
 ;;=^328501
 ;;^UTILITY(U,$J,358.3,13653,0)
 ;;=428.43^^90^848^51
 ;;^UTILITY(U,$J,358.3,13653,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13653,1,4,0)
 ;;=4^428.43
 ;;^UTILITY(U,$J,358.3,13653,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic
 ;;^UTILITY(U,$J,358.3,13653,2)
 ;;=^328502
 ;;^UTILITY(U,$J,358.3,13654,0)
 ;;=396.3^^90^848^10
 ;;^UTILITY(U,$J,358.3,13654,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13654,1,4,0)
 ;;=4^396.3
 ;;^UTILITY(U,$J,358.3,13654,1,5,0)
 ;;=5^Aortic and Mitral Insufficiency
 ;;^UTILITY(U,$J,358.3,13654,2)
 ;;=Aortic and Mitral Insufficiency^269583
 ;;^UTILITY(U,$J,358.3,13655,0)
 ;;=429.9^^90^848^28
 ;;^UTILITY(U,$J,358.3,13655,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13655,1,4,0)
 ;;=4^429.9
 ;;^UTILITY(U,$J,358.3,13655,1,5,0)
 ;;=5^Diastolic Dysfunction
 ;;^UTILITY(U,$J,358.3,13655,2)
 ;;=^54741
 ;;^UTILITY(U,$J,358.3,13656,0)
 ;;=453.79^^90^848^27
 ;;^UTILITY(U,$J,358.3,13656,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13656,1,4,0)
 ;;=4^453.79
 ;;^UTILITY(U,$J,358.3,13656,1,5,0)
 ;;=5^Chr Venous Emblsm Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,13656,2)
 ;;=^338251
 ;;^UTILITY(U,$J,358.3,13657,0)
 ;;=453.89^^90^848^1
 ;;^UTILITY(U,$J,358.3,13657,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13657,1,4,0)
 ;;=4^453.89
 ;;^UTILITY(U,$J,358.3,13657,1,5,0)
 ;;=5^AC Venous Emblsm Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,13657,2)
 ;;=^338259
 ;;^UTILITY(U,$J,358.3,13658,0)
 ;;=454.2^^90^848^85
 ;;^UTILITY(U,$J,358.3,13658,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13658,1,4,0)
 ;;=4^454.2
 ;;^UTILITY(U,$J,358.3,13658,1,5,0)
 ;;=5^Varicose Veins w/Ulcer&Inflam
 ;;^UTILITY(U,$J,358.3,13658,2)
 ;;=^269821
 ;;^UTILITY(U,$J,358.3,13659,0)
 ;;=397.1^^90^848^74
 ;;^UTILITY(U,$J,358.3,13659,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13659,1,4,0)
 ;;=4^397.1
 ;;^UTILITY(U,$J,358.3,13659,1,5,0)
 ;;=5^Rheumatic Disease Pulmonary Valve
 ;;^UTILITY(U,$J,358.3,13659,2)
 ;;=^269587
 ;;^UTILITY(U,$J,358.3,13660,0)
 ;;=397.0^^90^848^75
 ;;^UTILITY(U,$J,358.3,13660,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13660,1,4,0)
 ;;=4^397.0
 ;;^UTILITY(U,$J,358.3,13660,1,5,0)
 ;;=5^Rheumatic Disease Tricuspid Valve
 ;;^UTILITY(U,$J,358.3,13660,2)
 ;;=^35528
 ;;^UTILITY(U,$J,358.3,13661,0)
 ;;=414.3^^90^848^17
 ;;^UTILITY(U,$J,358.3,13661,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13661,1,4,0)
 ;;=4^414.3
 ;;^UTILITY(U,$J,358.3,13661,1,5,0)
 ;;=5^CAD d/t Lipid Rich Plaque
 ;;^UTILITY(U,$J,358.3,13661,2)
 ;;=^336601
 ;;^UTILITY(U,$J,358.3,13662,0)
 ;;=414.4^^90^848^16
 ;;^UTILITY(U,$J,358.3,13662,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13662,1,4,0)
 ;;=4^414.4
 ;;^UTILITY(U,$J,358.3,13662,1,5,0)
 ;;=5^CAD d/t Calc Coronary Lesion
 ;;^UTILITY(U,$J,358.3,13662,2)
 ;;=^340518
 ;;^UTILITY(U,$J,358.3,13663,0)
 ;;=425.11^^90^848^60
 ;;^UTILITY(U,$J,358.3,13663,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13663,1,4,0)
 ;;=4^425.11
 ;;^UTILITY(U,$J,358.3,13663,1,5,0)
 ;;=5^Hypertrophic Subaortic Stenosis
 ;;^UTILITY(U,$J,358.3,13663,2)
 ;;=^340520
 ;;^UTILITY(U,$J,358.3,13664,0)
 ;;=425.18^^90^848^59
 ;;^UTILITY(U,$J,358.3,13664,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13664,1,4,0)
 ;;=4^425.18
 ;;^UTILITY(U,$J,358.3,13664,1,5,0)
 ;;=5^Hypertrophic Cardiomyopathy
