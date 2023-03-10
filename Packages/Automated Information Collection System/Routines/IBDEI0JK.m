IBDEI0JK ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8801,1,3,0)
 ;;=3^Underdose of Med Regiment d/t Age-Related Debility
 ;;^UTILITY(U,$J,358.3,8801,1,4,0)
 ;;=4^Z91.130
 ;;^UTILITY(U,$J,358.3,8801,2)
 ;;=^5063614
 ;;^UTILITY(U,$J,358.3,8802,0)
 ;;=Z91.138^^39^402^153
 ;;^UTILITY(U,$J,358.3,8802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8802,1,3,0)
 ;;=3^Underdose of Med Regiment for Other Reason
 ;;^UTILITY(U,$J,358.3,8802,1,4,0)
 ;;=4^Z91.138
 ;;^UTILITY(U,$J,358.3,8802,2)
 ;;=^5063615
 ;;^UTILITY(U,$J,358.3,8803,0)
 ;;=Z91.14^^39^402^64
 ;;^UTILITY(U,$J,358.3,8803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8803,1,3,0)
 ;;=3^Noncompliance w/ Medication Regimen
 ;;^UTILITY(U,$J,358.3,8803,1,4,0)
 ;;=4^Z91.14
 ;;^UTILITY(U,$J,358.3,8803,2)
 ;;=^5063616
 ;;^UTILITY(U,$J,358.3,8804,0)
 ;;=Z91.19^^39^402^63
 ;;^UTILITY(U,$J,358.3,8804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8804,1,3,0)
 ;;=3^Noncompliance w/ Medical Treatment & Regimen
 ;;^UTILITY(U,$J,358.3,8804,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,8804,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,8805,0)
 ;;=Z93.1^^39^402^45
 ;;^UTILITY(U,$J,358.3,8805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8805,1,3,0)
 ;;=3^Gastrostomy Status
 ;;^UTILITY(U,$J,358.3,8805,1,4,0)
 ;;=4^Z93.1
 ;;^UTILITY(U,$J,358.3,8805,2)
 ;;=^5063643
 ;;^UTILITY(U,$J,358.3,8806,0)
 ;;=Z93.2^^39^402^51
 ;;^UTILITY(U,$J,358.3,8806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8806,1,3,0)
 ;;=3^Ileostomy Status
 ;;^UTILITY(U,$J,358.3,8806,1,4,0)
 ;;=4^Z93.2
 ;;^UTILITY(U,$J,358.3,8806,2)
 ;;=^5063644
 ;;^UTILITY(U,$J,358.3,8807,0)
 ;;=Z93.3^^39^402^7
 ;;^UTILITY(U,$J,358.3,8807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8807,1,3,0)
 ;;=3^Colostomy Status
 ;;^UTILITY(U,$J,358.3,8807,1,4,0)
 ;;=4^Z93.3
 ;;^UTILITY(U,$J,358.3,8807,2)
 ;;=^5063645
 ;;^UTILITY(U,$J,358.3,8808,0)
 ;;=Z94.0^^39^402^56
 ;;^UTILITY(U,$J,358.3,8808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8808,1,3,0)
 ;;=3^Kidney Transplant Status
 ;;^UTILITY(U,$J,358.3,8808,1,4,0)
 ;;=4^Z94.0
 ;;^UTILITY(U,$J,358.3,8808,2)
 ;;=^5063654
 ;;^UTILITY(U,$J,358.3,8809,0)
 ;;=Z94.1^^39^402^49
 ;;^UTILITY(U,$J,358.3,8809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8809,1,3,0)
 ;;=3^Heart Transplant Status
 ;;^UTILITY(U,$J,358.3,8809,1,4,0)
 ;;=4^Z94.1
 ;;^UTILITY(U,$J,358.3,8809,2)
 ;;=^5063655
 ;;^UTILITY(U,$J,358.3,8810,0)
 ;;=Z94.2^^39^402^59
 ;;^UTILITY(U,$J,358.3,8810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8810,1,3,0)
 ;;=3^Lung Transplant Status
 ;;^UTILITY(U,$J,358.3,8810,1,4,0)
 ;;=4^Z94.2
 ;;^UTILITY(U,$J,358.3,8810,2)
 ;;=^5063656
 ;;^UTILITY(U,$J,358.3,8811,0)
 ;;=Z94.3^^39^402^48
 ;;^UTILITY(U,$J,358.3,8811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8811,1,3,0)
 ;;=3^Heart & Lungs Transplant Status
 ;;^UTILITY(U,$J,358.3,8811,1,4,0)
 ;;=4^Z94.3
 ;;^UTILITY(U,$J,358.3,8811,2)
 ;;=^5063657
 ;;^UTILITY(U,$J,358.3,8812,0)
 ;;=Z94.4^^39^402^58
 ;;^UTILITY(U,$J,358.3,8812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8812,1,3,0)
 ;;=3^Liver Transplant Status
 ;;^UTILITY(U,$J,358.3,8812,1,4,0)
 ;;=4^Z94.4
 ;;^UTILITY(U,$J,358.3,8812,2)
 ;;=^5063658
 ;;^UTILITY(U,$J,358.3,8813,0)
 ;;=Z94.84^^39^402^149
 ;;^UTILITY(U,$J,358.3,8813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8813,1,3,0)
 ;;=3^Stem Cell Transplant Status
 ;;^UTILITY(U,$J,358.3,8813,1,4,0)
 ;;=4^Z94.84
 ;;^UTILITY(U,$J,358.3,8813,2)
 ;;=^5063665
