IBDEI0BW ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5637,1,5,0)
 ;;=5^Hemolytic Anemia,Acquired
 ;;^UTILITY(U,$J,358.3,5637,2)
 ;;=^7071
 ;;^UTILITY(U,$J,358.3,5638,0)
 ;;=283.0^^41^488^80
 ;;^UTILITY(U,$J,358.3,5638,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5638,1,4,0)
 ;;=4^283.0
 ;;^UTILITY(U,$J,358.3,5638,1,5,0)
 ;;=5^Hemolytic Anemia,Autoimmune
 ;;^UTILITY(U,$J,358.3,5638,2)
 ;;=^7079
 ;;^UTILITY(U,$J,358.3,5639,0)
 ;;=282.9^^41^488^81
 ;;^UTILITY(U,$J,358.3,5639,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5639,1,4,0)
 ;;=4^282.9
 ;;^UTILITY(U,$J,358.3,5639,1,5,0)
 ;;=5^Hemolytic Anemia,Hereditary
 ;;^UTILITY(U,$J,358.3,5639,2)
 ;;=^56578
 ;;^UTILITY(U,$J,358.3,5640,0)
 ;;=283.19^^41^488^82
 ;;^UTILITY(U,$J,358.3,5640,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5640,1,4,0)
 ;;=4^283.19
 ;;^UTILITY(U,$J,358.3,5640,1,5,0)
 ;;=5^Hemolytic Anemia,Microang
 ;;^UTILITY(U,$J,358.3,5640,2)
 ;;=^293664
 ;;^UTILITY(U,$J,358.3,5641,0)
 ;;=280.9^^41^488^86
 ;;^UTILITY(U,$J,358.3,5641,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5641,1,4,0)
 ;;=4^280.9
 ;;^UTILITY(U,$J,358.3,5641,1,5,0)
 ;;=5^Iron Defic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,5641,2)
 ;;=^276946
 ;;^UTILITY(U,$J,358.3,5642,0)
 ;;=285.1^^41^488^84
 ;;^UTILITY(U,$J,358.3,5642,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5642,1,4,0)
 ;;=4^285.1
 ;;^UTILITY(U,$J,358.3,5642,1,5,0)
 ;;=5^Iron Defic Anemia d/t Acute Blood Loss
 ;;^UTILITY(U,$J,358.3,5642,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,5643,0)
 ;;=280.0^^41^488^85
 ;;^UTILITY(U,$J,358.3,5643,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5643,1,4,0)
 ;;=4^280.0
 ;;^UTILITY(U,$J,358.3,5643,1,5,0)
 ;;=5^Iron Defic Anemia d/t Chronic Blood Loss
 ;;^UTILITY(U,$J,358.3,5643,2)
 ;;=^267971
 ;;^UTILITY(U,$J,358.3,5644,0)
 ;;=281.9^^41^488^107
 ;;^UTILITY(U,$J,358.3,5644,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5644,1,4,0)
 ;;=4^281.9
 ;;^UTILITY(U,$J,358.3,5644,1,5,0)
 ;;=5^Nutritional Anemia
 ;;^UTILITY(U,$J,358.3,5644,2)
 ;;=^123801
 ;;^UTILITY(U,$J,358.3,5645,0)
 ;;=281.0^^41^488^123
 ;;^UTILITY(U,$J,358.3,5645,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5645,1,4,0)
 ;;=4^281.0
 ;;^UTILITY(U,$J,358.3,5645,1,5,0)
 ;;=5^Vit B12 Deficiency (Pernicious Anemia)
 ;;^UTILITY(U,$J,358.3,5645,2)
 ;;=^7161
 ;;^UTILITY(U,$J,358.3,5646,0)
 ;;=282.60^^41^488^111
 ;;^UTILITY(U,$J,358.3,5646,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5646,1,4,0)
 ;;=4^282.60
 ;;^UTILITY(U,$J,358.3,5646,1,5,0)
 ;;=5^Sickle-Cell Anemia
 ;;^UTILITY(U,$J,358.3,5646,2)
 ;;=^7188
 ;;^UTILITY(U,$J,358.3,5647,0)
 ;;=282.62^^41^488^112
 ;;^UTILITY(U,$J,358.3,5647,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5647,1,4,0)
 ;;=4^282.62
 ;;^UTILITY(U,$J,358.3,5647,1,5,0)
 ;;=5^Sickle-Cell With Crisis
 ;;^UTILITY(U,$J,358.3,5647,2)
 ;;=^267982
 ;;^UTILITY(U,$J,358.3,5648,0)
 ;;=281.1^^41^488^124
 ;;^UTILITY(U,$J,358.3,5648,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5648,1,4,0)
 ;;=4^281.1
 ;;^UTILITY(U,$J,358.3,5648,1,5,0)
 ;;=5^Vit B12 Deficiency(Dietary)
 ;;^UTILITY(U,$J,358.3,5648,2)
 ;;=^267974
 ;;^UTILITY(U,$J,358.3,5649,0)
 ;;=286.7^^41^488^54
 ;;^UTILITY(U,$J,358.3,5649,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5649,1,4,0)
 ;;=4^286.7
 ;;^UTILITY(U,$J,358.3,5649,1,5,0)
 ;;=5^Coagulation Defect(Any),Acquired
 ;;^UTILITY(U,$J,358.3,5649,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,5650,0)
 ;;=289.9^^41^488^120
 ;;^UTILITY(U,$J,358.3,5650,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5650,1,4,0)
 ;;=4^289.9
 ;;^UTILITY(U,$J,358.3,5650,1,5,0)
 ;;=5^Thrombocytosis, Essential
 ;;^UTILITY(U,$J,358.3,5650,2)
 ;;=^55344
 ;;^UTILITY(U,$J,358.3,5651,0)
 ;;=451.9^^41^488^121
