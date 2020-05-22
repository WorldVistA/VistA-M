IBDEI1DI ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21948,0)
 ;;=M48.04^^99^1117^17
 ;;^UTILITY(U,$J,358.3,21948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21948,1,3,0)
 ;;=3^Spinal stenosis, thoracic region
 ;;^UTILITY(U,$J,358.3,21948,1,4,0)
 ;;=4^M48.04
 ;;^UTILITY(U,$J,358.3,21948,2)
 ;;=^5012091
 ;;^UTILITY(U,$J,358.3,21949,0)
 ;;=M48.00^^99^1117^16
 ;;^UTILITY(U,$J,358.3,21949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21949,1,3,0)
 ;;=3^Spinal stenosis, site unspecified
 ;;^UTILITY(U,$J,358.3,21949,1,4,0)
 ;;=4^M48.00
 ;;^UTILITY(U,$J,358.3,21949,2)
 ;;=^5012087
 ;;^UTILITY(U,$J,358.3,21950,0)
 ;;=S14.109S^^99^1117^2
 ;;^UTILITY(U,$J,358.3,21950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21950,1,3,0)
 ;;=3^Sequela of Unspec Injury of Cervical Spinal Cord
 ;;^UTILITY(U,$J,358.3,21950,1,4,0)
 ;;=4^S14.109S
 ;;^UTILITY(U,$J,358.3,21950,2)
 ;;=^5134243
 ;;^UTILITY(U,$J,358.3,21951,0)
 ;;=S24.109S^^99^1117^4
 ;;^UTILITY(U,$J,358.3,21951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21951,1,3,0)
 ;;=3^Sequela of Unspec Injury of Thoracic Spinal Cord
 ;;^UTILITY(U,$J,358.3,21951,1,4,0)
 ;;=4^S24.109S
 ;;^UTILITY(U,$J,358.3,21951,2)
 ;;=^5134384
 ;;^UTILITY(U,$J,358.3,21952,0)
 ;;=S34.109S^^99^1117^3
 ;;^UTILITY(U,$J,358.3,21952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21952,1,3,0)
 ;;=3^Sequela of Unspec Injury of Lumbar Spinal Cord
 ;;^UTILITY(U,$J,358.3,21952,1,4,0)
 ;;=4^S34.109S
 ;;^UTILITY(U,$J,358.3,21952,2)
 ;;=^5134570
 ;;^UTILITY(U,$J,358.3,21953,0)
 ;;=I69.328^^99^1117^11
 ;;^UTILITY(U,$J,358.3,21953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21953,1,3,0)
 ;;=3^Speech/Lang Deficits following Cerebvasc Infarc
 ;;^UTILITY(U,$J,358.3,21953,1,4,0)
 ;;=4^I69.328
 ;;^UTILITY(U,$J,358.3,21953,2)
 ;;=^5007495
 ;;^UTILITY(U,$J,358.3,21954,0)
 ;;=G12.25^^99^1117^12
 ;;^UTILITY(U,$J,358.3,21954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21954,1,3,0)
 ;;=3^Spinal Muscle Atrophy,Progressive
 ;;^UTILITY(U,$J,358.3,21954,1,4,0)
 ;;=4^G12.25
 ;;^UTILITY(U,$J,358.3,21954,2)
 ;;=^5151310
 ;;^UTILITY(U,$J,358.3,21955,0)
 ;;=M48.062^^99^1117^13
 ;;^UTILITY(U,$J,358.3,21955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21955,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/ Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,21955,1,4,0)
 ;;=4^M48.062
 ;;^UTILITY(U,$J,358.3,21955,2)
 ;;=^5151514
 ;;^UTILITY(U,$J,358.3,21956,0)
 ;;=M48.061^^99^1117^14
 ;;^UTILITY(U,$J,358.3,21956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21956,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/o Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,21956,1,4,0)
 ;;=4^M48.061
 ;;^UTILITY(U,$J,358.3,21956,2)
 ;;=^5151513
 ;;^UTILITY(U,$J,358.3,21957,0)
 ;;=F20.2^^99^1118^3
 ;;^UTILITY(U,$J,358.3,21957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21957,1,3,0)
 ;;=3^Schizophrenia, catatonic
 ;;^UTILITY(U,$J,358.3,21957,1,4,0)
 ;;=4^F20.2
 ;;^UTILITY(U,$J,358.3,21957,2)
 ;;=^5003471
 ;;^UTILITY(U,$J,358.3,21958,0)
 ;;=F20.1^^99^1118^4
 ;;^UTILITY(U,$J,358.3,21958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21958,1,3,0)
 ;;=3^Schizophrenia, disorganized
 ;;^UTILITY(U,$J,358.3,21958,1,4,0)
 ;;=4^F20.1
 ;;^UTILITY(U,$J,358.3,21958,2)
 ;;=^5003470
 ;;^UTILITY(U,$J,358.3,21959,0)
 ;;=F20.0^^99^1118^5
 ;;^UTILITY(U,$J,358.3,21959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21959,1,3,0)
 ;;=3^Schizophrenia, paranoid
 ;;^UTILITY(U,$J,358.3,21959,1,4,0)
 ;;=4^F20.0
 ;;^UTILITY(U,$J,358.3,21959,2)
 ;;=^5003469
