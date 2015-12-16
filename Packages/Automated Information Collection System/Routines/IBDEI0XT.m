IBDEI0XT ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16462,1,4,0)
 ;;=4^Aspriation Pneumonitia/Pneumonia
 ;;^UTILITY(U,$J,358.3,16462,2)
 ;;=Aspriation Pneumonitia/Pneumonia^95581
 ;;^UTILITY(U,$J,358.3,16463,0)
 ;;=495.2^^84^983^2
 ;;^UTILITY(U,$J,358.3,16463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16463,1,3,0)
 ;;=3^495.2
 ;;^UTILITY(U,$J,358.3,16463,1,4,0)
 ;;=4^Bird Fanciers Lung
 ;;^UTILITY(U,$J,358.3,16463,2)
 ;;=Bird Fanciers Lung^14840
 ;;^UTILITY(U,$J,358.3,16464,0)
 ;;=506.4^^84^983^7
 ;;^UTILITY(U,$J,358.3,16464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16464,1,3,0)
 ;;=3^506.4
 ;;^UTILITY(U,$J,358.3,16464,1,4,0)
 ;;=4^Interstitial Lung Disease, Chemical
 ;;^UTILITY(U,$J,358.3,16464,2)
 ;;=Interstitial Lung Disease, Chemical^269978
 ;;^UTILITY(U,$J,358.3,16465,0)
 ;;=515.^^84^983^6
 ;;^UTILITY(U,$J,358.3,16465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16465,1,3,0)
 ;;=3^515.
 ;;^UTILITY(U,$J,358.3,16465,1,4,0)
 ;;=4^Interstital Lung Disease, Unspec
 ;;^UTILITY(U,$J,358.3,16465,2)
 ;;=Interstital Lung Disease, Unspec^101072
 ;;^UTILITY(U,$J,358.3,16466,0)
 ;;=495.9^^84^983^4
 ;;^UTILITY(U,$J,358.3,16466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16466,1,3,0)
 ;;=3^495.9
 ;;^UTILITY(U,$J,358.3,16466,1,4,0)
 ;;=4^Hypersensitivity Pneumonitis
 ;;^UTILITY(U,$J,358.3,16466,2)
 ;;=Hypersensitivity Pneumonitis^5656
 ;;^UTILITY(U,$J,358.3,16467,0)
 ;;=495.0^^84^983^3
 ;;^UTILITY(U,$J,358.3,16467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16467,1,3,0)
 ;;=3^495.0
 ;;^UTILITY(U,$J,358.3,16467,1,4,0)
 ;;=4^Farmer's Lung
 ;;^UTILITY(U,$J,358.3,16467,2)
 ;;=Farmer's Lung^44970
 ;;^UTILITY(U,$J,358.3,16468,0)
 ;;=507.1^^84^983^8
 ;;^UTILITY(U,$J,358.3,16468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16468,1,3,0)
 ;;=3^507.1
 ;;^UTILITY(U,$J,358.3,16468,1,4,0)
 ;;=4^Lipoid Pneumonia
 ;;^UTILITY(U,$J,358.3,16468,2)
 ;;=Lipoid Pneumonia^95664
 ;;^UTILITY(U,$J,358.3,16469,0)
 ;;=710.0^^84^983^9
 ;;^UTILITY(U,$J,358.3,16469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16469,1,3,0)
 ;;=3^710.0
 ;;^UTILITY(U,$J,358.3,16469,1,4,0)
 ;;=4^Lupus Pneumonitis
 ;;^UTILITY(U,$J,358.3,16469,2)
 ;;=Lupus Pneumonitis^72159^517.8
 ;;^UTILITY(U,$J,358.3,16470,0)
 ;;=516.0^^84^983^10
 ;;^UTILITY(U,$J,358.3,16470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16470,1,3,0)
 ;;=3^516.0
 ;;^UTILITY(U,$J,358.3,16470,1,4,0)
 ;;=4^Pulmonary Alveolar Proteinosis
 ;;^UTILITY(U,$J,358.3,16470,2)
 ;;=Pulmonary Alveolar Proteinosis^100985
 ;;^UTILITY(U,$J,358.3,16471,0)
 ;;=135.^^84^983^11
 ;;^UTILITY(U,$J,358.3,16471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16471,1,3,0)
 ;;=3^135.
 ;;^UTILITY(U,$J,358.3,16471,1,4,0)
 ;;=4^Pulmonary Sarcoidosis
 ;;^UTILITY(U,$J,358.3,16471,2)
 ;;=Pulmonary Sarcoidosis^107916^517.8
 ;;^UTILITY(U,$J,358.3,16472,0)
 ;;=714.81^^84^983^12
 ;;^UTILITY(U,$J,358.3,16472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16472,1,3,0)
 ;;=3^714.81
 ;;^UTILITY(U,$J,358.3,16472,1,4,0)
 ;;=4^Rheumatoid Lung
 ;;^UTILITY(U,$J,358.3,16472,2)
 ;;=Rheumatoid Lung^106037
 ;;^UTILITY(U,$J,358.3,16473,0)
 ;;=710.1^^84^983^13
 ;;^UTILITY(U,$J,358.3,16473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16473,1,3,0)
 ;;=3^710.1
 ;;^UTILITY(U,$J,358.3,16473,1,4,0)
 ;;=4^Scleroderma/Systemic Sclerosis
 ;;^UTILITY(U,$J,358.3,16473,2)
 ;;=Scleroderma/Systemic Sclerosis^108590^517.8
 ;;^UTILITY(U,$J,358.3,16474,0)
 ;;=710.2^^84^983^14
 ;;^UTILITY(U,$J,358.3,16474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16474,1,3,0)
 ;;=3^710.2
 ;;^UTILITY(U,$J,358.3,16474,1,4,0)
 ;;=4^Sjogren's Syndrome
 ;;^UTILITY(U,$J,358.3,16474,2)
 ;;=Sjogren's Syndrome^192145^517.8
