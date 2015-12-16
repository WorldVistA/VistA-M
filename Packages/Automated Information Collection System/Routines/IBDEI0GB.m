IBDEI0GB ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7563,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7563,1,4,0)
 ;;=4^396.3
 ;;^UTILITY(U,$J,358.3,7563,1,5,0)
 ;;=5^Aortic and Mitral Insufficiency
 ;;^UTILITY(U,$J,358.3,7563,2)
 ;;=Aortic and Mitral Insufficiency^269583
 ;;^UTILITY(U,$J,358.3,7564,0)
 ;;=429.9^^35^472^28
 ;;^UTILITY(U,$J,358.3,7564,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7564,1,4,0)
 ;;=4^429.9
 ;;^UTILITY(U,$J,358.3,7564,1,5,0)
 ;;=5^Diastolic Dysfunction
 ;;^UTILITY(U,$J,358.3,7564,2)
 ;;=^54741
 ;;^UTILITY(U,$J,358.3,7565,0)
 ;;=453.79^^35^472^27
 ;;^UTILITY(U,$J,358.3,7565,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7565,1,4,0)
 ;;=4^453.79
 ;;^UTILITY(U,$J,358.3,7565,1,5,0)
 ;;=5^Chr Venous Emblsm Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,7565,2)
 ;;=^338251
 ;;^UTILITY(U,$J,358.3,7566,0)
 ;;=453.89^^35^472^1
 ;;^UTILITY(U,$J,358.3,7566,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7566,1,4,0)
 ;;=4^453.89
 ;;^UTILITY(U,$J,358.3,7566,1,5,0)
 ;;=5^AC Venous Emblsm Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,7566,2)
 ;;=^338259
 ;;^UTILITY(U,$J,358.3,7567,0)
 ;;=454.2^^35^472^85
 ;;^UTILITY(U,$J,358.3,7567,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7567,1,4,0)
 ;;=4^454.2
 ;;^UTILITY(U,$J,358.3,7567,1,5,0)
 ;;=5^Varicose Veins w/Ulcer&Inflam
 ;;^UTILITY(U,$J,358.3,7567,2)
 ;;=^269821
 ;;^UTILITY(U,$J,358.3,7568,0)
 ;;=397.1^^35^472^74
 ;;^UTILITY(U,$J,358.3,7568,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7568,1,4,0)
 ;;=4^397.1
 ;;^UTILITY(U,$J,358.3,7568,1,5,0)
 ;;=5^Rheumatic Disease Pulmonary Valve
 ;;^UTILITY(U,$J,358.3,7568,2)
 ;;=^269587
 ;;^UTILITY(U,$J,358.3,7569,0)
 ;;=397.0^^35^472^75
 ;;^UTILITY(U,$J,358.3,7569,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7569,1,4,0)
 ;;=4^397.0
 ;;^UTILITY(U,$J,358.3,7569,1,5,0)
 ;;=5^Rheumatic Disease Tricuspid Valve
 ;;^UTILITY(U,$J,358.3,7569,2)
 ;;=^35528
 ;;^UTILITY(U,$J,358.3,7570,0)
 ;;=414.3^^35^472^17
 ;;^UTILITY(U,$J,358.3,7570,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7570,1,4,0)
 ;;=4^414.3
 ;;^UTILITY(U,$J,358.3,7570,1,5,0)
 ;;=5^CAD d/t Lipid Rich Plaque
 ;;^UTILITY(U,$J,358.3,7570,2)
 ;;=^336601
 ;;^UTILITY(U,$J,358.3,7571,0)
 ;;=414.4^^35^472^16
 ;;^UTILITY(U,$J,358.3,7571,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7571,1,4,0)
 ;;=4^414.4
 ;;^UTILITY(U,$J,358.3,7571,1,5,0)
 ;;=5^CAD d/t Calc Coronary Lesion
 ;;^UTILITY(U,$J,358.3,7571,2)
 ;;=^340518
 ;;^UTILITY(U,$J,358.3,7572,0)
 ;;=425.11^^35^472^60
 ;;^UTILITY(U,$J,358.3,7572,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7572,1,4,0)
 ;;=4^425.11
 ;;^UTILITY(U,$J,358.3,7572,1,5,0)
 ;;=5^Hypertrophic Subaortic Stenosis
 ;;^UTILITY(U,$J,358.3,7572,2)
 ;;=^340520
 ;;^UTILITY(U,$J,358.3,7573,0)
 ;;=425.18^^35^472^59
 ;;^UTILITY(U,$J,358.3,7573,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7573,1,4,0)
 ;;=4^425.18
 ;;^UTILITY(U,$J,358.3,7573,1,5,0)
 ;;=5^Hypertrophic Cardiomyopathy
 ;;^UTILITY(U,$J,358.3,7573,2)
 ;;=^340521
 ;;^UTILITY(U,$J,358.3,7574,0)
 ;;=V12.55^^35^472^54
 ;;^UTILITY(U,$J,358.3,7574,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7574,1,4,0)
 ;;=4^V12.55
 ;;^UTILITY(U,$J,358.3,7574,1,5,0)
 ;;=5^Hx of Pulmonary Embolism
 ;;^UTILITY(U,$J,358.3,7574,2)
 ;;=^340615
 ;;^UTILITY(U,$J,358.3,7575,0)
 ;;=454.9^^35^472^84
 ;;^UTILITY(U,$J,358.3,7575,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7575,1,4,0)
 ;;=4^454.9
 ;;^UTILITY(U,$J,358.3,7575,1,5,0)
 ;;=5^Varicose Veins
 ;;^UTILITY(U,$J,358.3,7575,2)
 ;;=^328758
 ;;^UTILITY(U,$J,358.3,7576,0)
 ;;=271.3^^35^473^11
 ;;^UTILITY(U,$J,358.3,7576,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7576,1,4,0)
 ;;=4^271.3
 ;;^UTILITY(U,$J,358.3,7576,1,5,0)
 ;;=5^Glucose Intolerance
