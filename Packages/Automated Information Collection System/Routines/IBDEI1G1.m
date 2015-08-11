IBDEI1G1 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25887,1,3,0)
 ;;=3^710.0
 ;;^UTILITY(U,$J,358.3,25887,1,4,0)
 ;;=4^Lupus Pneumonitis
 ;;^UTILITY(U,$J,358.3,25887,2)
 ;;=Lupus Pneumonitis^72159^517.8
 ;;^UTILITY(U,$J,358.3,25888,0)
 ;;=516.0^^148^1570^10
 ;;^UTILITY(U,$J,358.3,25888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25888,1,3,0)
 ;;=3^516.0
 ;;^UTILITY(U,$J,358.3,25888,1,4,0)
 ;;=4^Pulmonary Alveolar Proteinosis
 ;;^UTILITY(U,$J,358.3,25888,2)
 ;;=Pulmonary Alveolar Proteinosis^100985
 ;;^UTILITY(U,$J,358.3,25889,0)
 ;;=135.^^148^1570^11
 ;;^UTILITY(U,$J,358.3,25889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25889,1,3,0)
 ;;=3^135.
 ;;^UTILITY(U,$J,358.3,25889,1,4,0)
 ;;=4^Pulmonary Sarcoidosis
 ;;^UTILITY(U,$J,358.3,25889,2)
 ;;=Pulmonary Sarcoidosis^107916^517.8
 ;;^UTILITY(U,$J,358.3,25890,0)
 ;;=714.81^^148^1570^12
 ;;^UTILITY(U,$J,358.3,25890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25890,1,3,0)
 ;;=3^714.81
 ;;^UTILITY(U,$J,358.3,25890,1,4,0)
 ;;=4^Rheumatoid Lung
 ;;^UTILITY(U,$J,358.3,25890,2)
 ;;=Rheumatoid Lung^106037
 ;;^UTILITY(U,$J,358.3,25891,0)
 ;;=710.1^^148^1570^13
 ;;^UTILITY(U,$J,358.3,25891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25891,1,3,0)
 ;;=3^710.1
 ;;^UTILITY(U,$J,358.3,25891,1,4,0)
 ;;=4^Scleroderma/Systemic Sclerosis
 ;;^UTILITY(U,$J,358.3,25891,2)
 ;;=Scleroderma/Systemic Sclerosis^108590^517.8
 ;;^UTILITY(U,$J,358.3,25892,0)
 ;;=710.2^^148^1570^14
 ;;^UTILITY(U,$J,358.3,25892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25892,1,3,0)
 ;;=3^710.2
 ;;^UTILITY(U,$J,358.3,25892,1,4,0)
 ;;=4^Sjogren's Syndrome
 ;;^UTILITY(U,$J,358.3,25892,2)
 ;;=Sjogren's Syndrome^192145^517.8
 ;;^UTILITY(U,$J,358.3,25893,0)
 ;;=516.30^^148^1570^5
 ;;^UTILITY(U,$J,358.3,25893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25893,1,3,0)
 ;;=3^516.30
 ;;^UTILITY(U,$J,358.3,25893,1,4,0)
 ;;=4^Idiopathic Pulmonary Fibrosis
 ;;^UTILITY(U,$J,358.3,25893,2)
 ;;=^340610
 ;;^UTILITY(U,$J,358.3,25894,0)
 ;;=501.^^148^1571^1
 ;;^UTILITY(U,$J,358.3,25894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25894,1,3,0)
 ;;=3^501.
 ;;^UTILITY(U,$J,358.3,25894,1,4,0)
 ;;=4^Asbestosis
 ;;^UTILITY(U,$J,358.3,25895,0)
 ;;=502.^^148^1571^4
 ;;^UTILITY(U,$J,358.3,25895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25895,1,3,0)
 ;;=3^502.
 ;;^UTILITY(U,$J,358.3,25895,1,4,0)
 ;;=4^Silicosis
 ;;^UTILITY(U,$J,358.3,25895,2)
 ;;=Silicosis^110600
 ;;^UTILITY(U,$J,358.3,25896,0)
 ;;=505.^^148^1571^3
 ;;^UTILITY(U,$J,358.3,25896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25896,1,3,0)
 ;;=3^505.
 ;;^UTILITY(U,$J,358.3,25896,1,4,0)
 ;;=4^Pneumoconiosis NEC
 ;;^UTILITY(U,$J,358.3,25896,2)
 ;;=^95539
 ;;^UTILITY(U,$J,358.3,25897,0)
 ;;=500.^^148^1571^2
 ;;^UTILITY(U,$J,358.3,25897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25897,1,3,0)
 ;;=3^500.
 ;;^UTILITY(U,$J,358.3,25897,1,4,0)
 ;;=4^Coal Workers Pheumonoconiosis
 ;;^UTILITY(U,$J,358.3,25897,2)
 ;;=Coal Workers Pheumonoconiosis^8060
 ;;^UTILITY(U,$J,358.3,25898,0)
 ;;=508.0^^148^1572^13
 ;;^UTILITY(U,$J,358.3,25898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25898,1,3,0)
 ;;=3^508.0
 ;;^UTILITY(U,$J,358.3,25898,1,4,0)
 ;;=4^Radiation Pneumonit
 ;;^UTILITY(U,$J,358.3,25899,0)
 ;;=518.3^^148^1572^5
 ;;^UTILITY(U,$J,358.3,25899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25899,1,3,0)
 ;;=3^518.3
 ;;^UTILITY(U,$J,358.3,25899,1,4,0)
 ;;=4^Eosinophil Pneumonia
 ;;^UTILITY(U,$J,358.3,25900,0)
 ;;=507.0^^148^1572^2
 ;;^UTILITY(U,$J,358.3,25900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25900,1,3,0)
 ;;=3^507.0
 ;;^UTILITY(U,$J,358.3,25900,1,4,0)
 ;;=4^Aspiration Pneumonia
