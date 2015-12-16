IBDEI0EG ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6592,1,4,0)
 ;;=4^283.0
 ;;^UTILITY(U,$J,358.3,6592,1,5,0)
 ;;=5^Hemolytic Anemia,Autoimmune
 ;;^UTILITY(U,$J,358.3,6592,2)
 ;;=^7079
 ;;^UTILITY(U,$J,358.3,6593,0)
 ;;=282.9^^31^412^78
 ;;^UTILITY(U,$J,358.3,6593,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6593,1,4,0)
 ;;=4^282.9
 ;;^UTILITY(U,$J,358.3,6593,1,5,0)
 ;;=5^Hemolytic Anemia,Hereditary
 ;;^UTILITY(U,$J,358.3,6593,2)
 ;;=^56578
 ;;^UTILITY(U,$J,358.3,6594,0)
 ;;=283.19^^31^412^79
 ;;^UTILITY(U,$J,358.3,6594,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6594,1,4,0)
 ;;=4^283.19
 ;;^UTILITY(U,$J,358.3,6594,1,5,0)
 ;;=5^Hemolytic Anemia,Microang
 ;;^UTILITY(U,$J,358.3,6594,2)
 ;;=^293664
 ;;^UTILITY(U,$J,358.3,6595,0)
 ;;=280.9^^31^412^83
 ;;^UTILITY(U,$J,358.3,6595,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6595,1,4,0)
 ;;=4^280.9
 ;;^UTILITY(U,$J,358.3,6595,1,5,0)
 ;;=5^Iron Defic Anemia(Unspecified)
 ;;^UTILITY(U,$J,358.3,6595,2)
 ;;=^276946
 ;;^UTILITY(U,$J,358.3,6596,0)
 ;;=285.1^^31^412^81
 ;;^UTILITY(U,$J,358.3,6596,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6596,1,4,0)
 ;;=4^285.1
 ;;^UTILITY(U,$J,358.3,6596,1,5,0)
 ;;=5^Iron Defic Anemia Due To Acute Blood Loss
 ;;^UTILITY(U,$J,358.3,6596,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,6597,0)
 ;;=280.0^^31^412^82
 ;;^UTILITY(U,$J,358.3,6597,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6597,1,4,0)
 ;;=4^280.0
 ;;^UTILITY(U,$J,358.3,6597,1,5,0)
 ;;=5^Iron Defic Anemia Due To Chronic Blood Loss
 ;;^UTILITY(U,$J,358.3,6597,2)
 ;;=^267971
 ;;^UTILITY(U,$J,358.3,6598,0)
 ;;=281.9^^31^412^106
 ;;^UTILITY(U,$J,358.3,6598,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6598,1,4,0)
 ;;=4^281.9
 ;;^UTILITY(U,$J,358.3,6598,1,5,0)
 ;;=5^Nutritional Anemia
 ;;^UTILITY(U,$J,358.3,6598,2)
 ;;=^123801
 ;;^UTILITY(U,$J,358.3,6599,0)
 ;;=281.0^^31^412^120
 ;;^UTILITY(U,$J,358.3,6599,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6599,1,4,0)
 ;;=4^281.0
 ;;^UTILITY(U,$J,358.3,6599,1,5,0)
 ;;=5^Vit B12 Deficiency (Pernicious Anemia)
 ;;^UTILITY(U,$J,358.3,6599,2)
 ;;=^7161
 ;;^UTILITY(U,$J,358.3,6600,0)
 ;;=282.60^^31^412^110
 ;;^UTILITY(U,$J,358.3,6600,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6600,1,4,0)
 ;;=4^282.60
 ;;^UTILITY(U,$J,358.3,6600,1,5,0)
 ;;=5^Sickle-Cell Anemia
 ;;^UTILITY(U,$J,358.3,6600,2)
 ;;=^7188
 ;;^UTILITY(U,$J,358.3,6601,0)
 ;;=282.62^^31^412^111
 ;;^UTILITY(U,$J,358.3,6601,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6601,1,4,0)
 ;;=4^282.62
 ;;^UTILITY(U,$J,358.3,6601,1,5,0)
 ;;=5^Sickle-Cell With Crisis
 ;;^UTILITY(U,$J,358.3,6601,2)
 ;;=^267982
 ;;^UTILITY(U,$J,358.3,6602,0)
 ;;=281.1^^31^412^121
 ;;^UTILITY(U,$J,358.3,6602,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6602,1,4,0)
 ;;=4^281.1
 ;;^UTILITY(U,$J,358.3,6602,1,5,0)
 ;;=5^Vit B12 Deficiency(Dietary)
 ;;^UTILITY(U,$J,358.3,6602,2)
 ;;=^267974
 ;;^UTILITY(U,$J,358.3,6603,0)
 ;;=286.7^^31^412^52
 ;;^UTILITY(U,$J,358.3,6603,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6603,1,4,0)
 ;;=4^286.7
 ;;^UTILITY(U,$J,358.3,6603,1,5,0)
 ;;=5^Coagulation Defect(Any),Acquired
 ;;^UTILITY(U,$J,358.3,6603,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,6604,0)
 ;;=289.9^^31^412^117
 ;;^UTILITY(U,$J,358.3,6604,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6604,1,4,0)
 ;;=4^289.9
 ;;^UTILITY(U,$J,358.3,6604,1,5,0)
 ;;=5^Thrombocytosis, Essential
 ;;^UTILITY(U,$J,358.3,6604,2)
 ;;=^55344
 ;;^UTILITY(U,$J,358.3,6605,0)
 ;;=451.9^^31^412^118
 ;;^UTILITY(U,$J,358.3,6605,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6605,1,4,0)
 ;;=4^451.9
 ;;^UTILITY(U,$J,358.3,6605,1,5,0)
 ;;=5^Thrombophlebitis 
 ;;^UTILITY(U,$J,358.3,6605,2)
 ;;=^93357
