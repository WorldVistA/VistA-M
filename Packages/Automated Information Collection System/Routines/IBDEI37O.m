IBDEI37O ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,53945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53945,1,3,0)
 ;;=3^Lung transplant infection
 ;;^UTILITY(U,$J,358.3,53945,1,4,0)
 ;;=4^T86.812
 ;;^UTILITY(U,$J,358.3,53945,2)
 ;;=^5055732
 ;;^UTILITY(U,$J,358.3,53946,0)
 ;;=T86.818^^253^2728^45
 ;;^UTILITY(U,$J,358.3,53946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53946,1,3,0)
 ;;=3^Lung transplant complications, other
 ;;^UTILITY(U,$J,358.3,53946,1,4,0)
 ;;=4^T86.818
 ;;^UTILITY(U,$J,358.3,53946,2)
 ;;=^5055733
 ;;^UTILITY(U,$J,358.3,53947,0)
 ;;=T86.890^^253^2728^58
 ;;^UTILITY(U,$J,358.3,53947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53947,1,3,0)
 ;;=3^Tissue transplant rejection, other
 ;;^UTILITY(U,$J,358.3,53947,1,4,0)
 ;;=4^T86.890
 ;;^UTILITY(U,$J,358.3,53947,2)
 ;;=^5055754
 ;;^UTILITY(U,$J,358.3,53948,0)
 ;;=T86.891^^253^2728^56
 ;;^UTILITY(U,$J,358.3,53948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53948,1,3,0)
 ;;=3^Tissue transplant failure, other
 ;;^UTILITY(U,$J,358.3,53948,1,4,0)
 ;;=4^T86.891
 ;;^UTILITY(U,$J,358.3,53948,2)
 ;;=^5055755
 ;;^UTILITY(U,$J,358.3,53949,0)
 ;;=T86.892^^253^2728^57
 ;;^UTILITY(U,$J,358.3,53949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53949,1,3,0)
 ;;=3^Tissue transplant infection, other
 ;;^UTILITY(U,$J,358.3,53949,1,4,0)
 ;;=4^T86.892
 ;;^UTILITY(U,$J,358.3,53949,2)
 ;;=^5055756
 ;;^UTILITY(U,$J,358.3,53950,0)
 ;;=T86.898^^253^2728^55
 ;;^UTILITY(U,$J,358.3,53950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53950,1,3,0)
 ;;=3^Tissue transplant complications, other
 ;;^UTILITY(U,$J,358.3,53950,1,4,0)
 ;;=4^T86.898
 ;;^UTILITY(U,$J,358.3,53950,2)
 ;;=^5055757
 ;;^UTILITY(U,$J,358.3,53951,0)
 ;;=D89.810^^253^2728^1
 ;;^UTILITY(U,$J,358.3,53951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53951,1,3,0)
 ;;=3^Acute graft-versus-host disease
 ;;^UTILITY(U,$J,358.3,53951,1,4,0)
 ;;=4^D89.810
 ;;^UTILITY(U,$J,358.3,53951,2)
 ;;=^336539
 ;;^UTILITY(U,$J,358.3,53952,0)
 ;;=D89.811^^253^2728^13
 ;;^UTILITY(U,$J,358.3,53952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53952,1,3,0)
 ;;=3^Chronic graft-versus-host disease
 ;;^UTILITY(U,$J,358.3,53952,1,4,0)
 ;;=4^D89.811
 ;;^UTILITY(U,$J,358.3,53952,2)
 ;;=^336540
 ;;^UTILITY(U,$J,358.3,53953,0)
 ;;=D89.812^^253^2728^2
 ;;^UTILITY(U,$J,358.3,53953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53953,1,3,0)
 ;;=3^Acute on chronic graft-versus-host disease
 ;;^UTILITY(U,$J,358.3,53953,1,4,0)
 ;;=4^D89.812
 ;;^UTILITY(U,$J,358.3,53953,2)
 ;;=^336541
 ;;^UTILITY(U,$J,358.3,53954,0)
 ;;=C80.2^^253^2728^49
 ;;^UTILITY(U,$J,358.3,53954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53954,1,3,0)
 ;;=3^Malignant neoplasm associated with transplanted organ
 ;;^UTILITY(U,$J,358.3,53954,1,4,0)
 ;;=4^C80.2
 ;;^UTILITY(U,$J,358.3,53954,2)
 ;;=^5001390
 ;;^UTILITY(U,$J,358.3,53955,0)
 ;;=Z91.11^^253^2728^51
 ;;^UTILITY(U,$J,358.3,53955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53955,1,3,0)
 ;;=3^Patient's noncompliance with dietary regimen
 ;;^UTILITY(U,$J,358.3,53955,1,4,0)
 ;;=4^Z91.11
 ;;^UTILITY(U,$J,358.3,53955,2)
 ;;=^5063611
 ;;^UTILITY(U,$J,358.3,53956,0)
 ;;=Z91.15^^253^2728^52
 ;;^UTILITY(U,$J,358.3,53956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53956,1,3,0)
 ;;=3^Patient's noncompliance with renal dialysis
 ;;^UTILITY(U,$J,358.3,53956,1,4,0)
 ;;=4^Z91.15
 ;;^UTILITY(U,$J,358.3,53956,2)
 ;;=^5063617
 ;;^UTILITY(U,$J,358.3,53957,0)
 ;;=Z91.14^^253^2728^53
 ;;^UTILITY(U,$J,358.3,53957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53957,1,3,0)
 ;;=3^Patient's other noncompliance with medication regimen
 ;;^UTILITY(U,$J,358.3,53957,1,4,0)
 ;;=4^Z91.14
