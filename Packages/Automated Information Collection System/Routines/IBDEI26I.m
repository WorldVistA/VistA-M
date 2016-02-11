IBDEI26I ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36586,1,4,0)
 ;;=4^D59.5
 ;;^UTILITY(U,$J,358.3,36586,2)
 ;;=^5002327
 ;;^UTILITY(U,$J,358.3,36587,0)
 ;;=D59.6^^169^1850^24
 ;;^UTILITY(U,$J,358.3,36587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36587,1,3,0)
 ;;=3^Hemoglobinuria due to hemolysis from other external causes
 ;;^UTILITY(U,$J,358.3,36587,1,4,0)
 ;;=4^D59.6
 ;;^UTILITY(U,$J,358.3,36587,2)
 ;;=^5002328
 ;;^UTILITY(U,$J,358.3,36588,0)
 ;;=D59.8^^169^1850^2
 ;;^UTILITY(U,$J,358.3,36588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36588,1,3,0)
 ;;=3^Acquired hemolytic anemias NEC
 ;;^UTILITY(U,$J,358.3,36588,1,4,0)
 ;;=4^D59.8
 ;;^UTILITY(U,$J,358.3,36588,2)
 ;;=^5002329
 ;;^UTILITY(U,$J,358.3,36589,0)
 ;;=D59.9^^169^1850^1
 ;;^UTILITY(U,$J,358.3,36589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36589,1,3,0)
 ;;=3^Acquired hemolytic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,36589,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,36589,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,36590,0)
 ;;=D61.810^^169^1850^13
 ;;^UTILITY(U,$J,358.3,36590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36590,1,3,0)
 ;;=3^Antineoplastic chemotherapy induced pancytopenia
 ;;^UTILITY(U,$J,358.3,36590,1,4,0)
 ;;=4^D61.810
 ;;^UTILITY(U,$J,358.3,36590,2)
 ;;=^5002339
 ;;^UTILITY(U,$J,358.3,36591,0)
 ;;=D61.811^^169^1850^20
 ;;^UTILITY(U,$J,358.3,36591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36591,1,3,0)
 ;;=3^Drug-induced pancytopenia NEC
 ;;^UTILITY(U,$J,358.3,36591,1,4,0)
 ;;=4^D61.811
 ;;^UTILITY(U,$J,358.3,36591,2)
 ;;=^5002340
 ;;^UTILITY(U,$J,358.3,36592,0)
 ;;=D61.818^^169^1850^36
 ;;^UTILITY(U,$J,358.3,36592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36592,1,3,0)
 ;;=3^Pancytopenia NEC
 ;;^UTILITY(U,$J,358.3,36592,1,4,0)
 ;;=4^D61.818
 ;;^UTILITY(U,$J,358.3,36592,2)
 ;;=^340501
 ;;^UTILITY(U,$J,358.3,36593,0)
 ;;=D61.82^^169^1850^32
 ;;^UTILITY(U,$J,358.3,36593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36593,1,3,0)
 ;;=3^Myelophthisis
 ;;^UTILITY(U,$J,358.3,36593,1,4,0)
 ;;=4^D61.82
 ;;^UTILITY(U,$J,358.3,36593,2)
 ;;=^334037
 ;;^UTILITY(U,$J,358.3,36594,0)
 ;;=D61.9^^169^1850^14
 ;;^UTILITY(U,$J,358.3,36594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36594,1,3,0)
 ;;=3^Aplastic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,36594,1,4,0)
 ;;=4^D61.9
 ;;^UTILITY(U,$J,358.3,36594,2)
 ;;=^5002342
 ;;^UTILITY(U,$J,358.3,36595,0)
 ;;=D62.^^169^1850^3
 ;;^UTILITY(U,$J,358.3,36595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36595,1,3,0)
 ;;=3^Acute posthemorrhagic anemia
 ;;^UTILITY(U,$J,358.3,36595,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,36595,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,36596,0)
 ;;=D63.1^^169^1850^7
 ;;^UTILITY(U,$J,358.3,36596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36596,1,3,0)
 ;;=3^Anemia in chronic kidney disease
 ;;^UTILITY(U,$J,358.3,36596,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,36596,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,36597,0)
 ;;=D63.0^^169^1850^8
 ;;^UTILITY(U,$J,358.3,36597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36597,1,3,0)
 ;;=3^Anemia in neoplastic disease
 ;;^UTILITY(U,$J,358.3,36597,1,4,0)
 ;;=4^D63.0
 ;;^UTILITY(U,$J,358.3,36597,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,36598,0)
 ;;=D63.8^^169^1850^9
 ;;^UTILITY(U,$J,358.3,36598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36598,1,3,0)
 ;;=3^Anemia in other chronic diseases classified elsewhere
 ;;^UTILITY(U,$J,358.3,36598,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,36598,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,36599,0)
 ;;=D64.81^^169^1850^4
 ;;^UTILITY(U,$J,358.3,36599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36599,1,3,0)
 ;;=3^Anemia due to antineoplastic chemotherapy
