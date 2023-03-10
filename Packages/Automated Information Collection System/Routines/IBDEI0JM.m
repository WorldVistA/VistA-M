IBDEI0JM ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8826,1,3,0)
 ;;=3^Presence of Left Artificial Leg
 ;;^UTILITY(U,$J,358.3,8826,1,4,0)
 ;;=4^Z97.14
 ;;^UTILITY(U,$J,358.3,8826,2)
 ;;=^5063725
 ;;^UTILITY(U,$J,358.3,8827,0)
 ;;=Z97.15^^39^402^116
 ;;^UTILITY(U,$J,358.3,8827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8827,1,3,0)
 ;;=3^Presence of Artificial Arms,Bilateral
 ;;^UTILITY(U,$J,358.3,8827,1,4,0)
 ;;=4^Z97.15
 ;;^UTILITY(U,$J,358.3,8827,2)
 ;;=^5063726
 ;;^UTILITY(U,$J,358.3,8828,0)
 ;;=Z97.16^^39^402^121
 ;;^UTILITY(U,$J,358.3,8828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8828,1,3,0)
 ;;=3^Presence of Artificial Legs,Bilateral
 ;;^UTILITY(U,$J,358.3,8828,1,4,0)
 ;;=4^Z97.16
 ;;^UTILITY(U,$J,358.3,8828,2)
 ;;=^5063727
 ;;^UTILITY(U,$J,358.3,8829,0)
 ;;=Z98.61^^39^402^9
 ;;^UTILITY(U,$J,358.3,8829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8829,1,3,0)
 ;;=3^Coronary Angioplasty Status
 ;;^UTILITY(U,$J,358.3,8829,1,4,0)
 ;;=4^Z98.61
 ;;^UTILITY(U,$J,358.3,8829,2)
 ;;=^5063742
 ;;^UTILITY(U,$J,358.3,8830,0)
 ;;=Z98.62^^39^402^66
 ;;^UTILITY(U,$J,358.3,8830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8830,1,3,0)
 ;;=3^Peripheral Vascular Angioplasty Status w/o Graft
 ;;^UTILITY(U,$J,358.3,8830,1,4,0)
 ;;=4^Z98.62
 ;;^UTILITY(U,$J,358.3,8830,2)
 ;;=^5063743
 ;;^UTILITY(U,$J,358.3,8831,0)
 ;;=Z98.84^^39^402^4
 ;;^UTILITY(U,$J,358.3,8831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8831,1,3,0)
 ;;=3^Bariatric Surgery Status
 ;;^UTILITY(U,$J,358.3,8831,1,4,0)
 ;;=4^Z98.84
 ;;^UTILITY(U,$J,358.3,8831,2)
 ;;=^5063749
 ;;^UTILITY(U,$J,358.3,8832,0)
 ;;=Z99.2^^39^402^147
 ;;^UTILITY(U,$J,358.3,8832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8832,1,3,0)
 ;;=3^Renal Dialysis Dependence
 ;;^UTILITY(U,$J,358.3,8832,1,4,0)
 ;;=4^Z99.2
 ;;^UTILITY(U,$J,358.3,8832,2)
 ;;=^5063758
 ;;^UTILITY(U,$J,358.3,8833,0)
 ;;=Z99.81^^39^402^150
 ;;^UTILITY(U,$J,358.3,8833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8833,1,3,0)
 ;;=3^Supplemental Oxygen Dependence
 ;;^UTILITY(U,$J,358.3,8833,1,4,0)
 ;;=4^Z99.81
 ;;^UTILITY(U,$J,358.3,8833,2)
 ;;=^5063760
 ;;^UTILITY(U,$J,358.3,8834,0)
 ;;=Z98.1^^39^402^2
 ;;^UTILITY(U,$J,358.3,8834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8834,1,3,0)
 ;;=3^Arthrodesis Status
 ;;^UTILITY(U,$J,358.3,8834,1,4,0)
 ;;=4^Z98.1
 ;;^UTILITY(U,$J,358.3,8834,2)
 ;;=^5063734
 ;;^UTILITY(U,$J,358.3,8835,0)
 ;;=Z94.7^^39^402^8
 ;;^UTILITY(U,$J,358.3,8835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8835,1,3,0)
 ;;=3^Corneal Transplant Status
 ;;^UTILITY(U,$J,358.3,8835,1,4,0)
 ;;=4^Z94.7
 ;;^UTILITY(U,$J,358.3,8835,2)
 ;;=^5063661
 ;;^UTILITY(U,$J,358.3,8836,0)
 ;;=Z83.511^^39^402^23
 ;;^UTILITY(U,$J,358.3,8836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8836,1,3,0)
 ;;=3^Family Hx of Glaucoma
 ;;^UTILITY(U,$J,358.3,8836,1,4,0)
 ;;=4^Z83.511
 ;;^UTILITY(U,$J,358.3,8836,2)
 ;;=^5063382
 ;;^UTILITY(U,$J,358.3,8837,0)
 ;;=Z80.52^^39^402^26
 ;;^UTILITY(U,$J,358.3,8837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8837,1,3,0)
 ;;=3^Family Hx of Malig Neop of Baldder
 ;;^UTILITY(U,$J,358.3,8837,1,4,0)
 ;;=4^Z80.52
 ;;^UTILITY(U,$J,358.3,8837,2)
 ;;=^5063352
 ;;^UTILITY(U,$J,358.3,8838,0)
 ;;=Z80.51^^39^402^29
 ;;^UTILITY(U,$J,358.3,8838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8838,1,3,0)
 ;;=3^Family Hx of Malig Neop of Kidney
 ;;^UTILITY(U,$J,358.3,8838,1,4,0)
 ;;=4^Z80.51
 ;;^UTILITY(U,$J,358.3,8838,2)
 ;;=^321159
